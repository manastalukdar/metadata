#!/usr/bin/env bash
# Generate scripts/pkgs/*.txt from the install tags in src/software-to-install/.
#
#   bash scripts/gen-pkgs.sh           # regenerate the lists
#   bash scripts/gen-pkgs.sh --check   # fail if the committed lists are stale
#
# src/software-to-install/ is the single source of truth. Tools are tagged with
# inline code spans naming the package manager and the exact package id:
#
#   - Slack `flatpak:com.slack.Slack` `cask:slack`
#   - Pandoc `native:pandoc`
#   - [starship](https://starship.rs) `mise:starship@latest`
#   - DaVinci Resolve `manual`
#
# Recognized managers:
#
#   native        same package name from dnf, apt and brew (expands to all 3)
#   dnf apt       distro packages (use when the names differ)
#   brew-macos    a formula macOS needs because Linux gets it from dnf/apt
#   brew          a formula every platform needs
#   cask          macOS GUI app
#   flatpak snap  Linux GUI app
#   mise          runtime or version-pinned dev CLI
#   npm uv        node / python CLI tool
#   manual        no package manager has it; listed in pkgs/manual.txt
#
# Only `## Mandatory` sections are read. Tagging an Optional entry is harmless
# and documents the id, but nothing installs it.
#
# Plumbing that has no business in user-facing docs (ca-certificates,
# build-essential, ...) lives in a hand-written pkgs/<list>.extra.txt, which is
# appended to the generated list.

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOCS="$ROOT/src/software-to-install"
PKGS="$ROOT/scripts/pkgs"
CHECK=0
[[ "${1:-}" == "--check" ]] && CHECK=1

# manager tag -> list file(s) it feeds
declare -A TARGETS=(
    [dnf]="dnf" [apt]="apt" [flatpak]="flatpak" [snap]="snap"
    [mise]="mise" [npm]="npm" [uv]="uv" [brew]="brew-common"
    [brew-macos]="brew-macos" [cask]="brew-cask"
    [native]="dnf apt brew-macos"
    [manual]="manual"
)

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

mapfile -t SRC < <(find "$DOCS" -name '*.md' ! -name 'README.md' | sort)

# Extract "<manager>\t<value>\t<source>" triples from the Mandatory sections.
# A tag is an inline code span `manager:value` with no spaces; requiring a known
# manager is what stops URLs (https://...) and shell snippets from matching.
awk -v mgrs="$(printf '%s ' "${!TARGETS[@]}")" '
    BEGIN { n = split(mgrs, a, " "); for (i = 1; i <= n; i++) if (a[i] != "") known[a[i]] = 1 }
    FNR == 1 { mandatory = 0; src = FILENAME; sub(/.*src\/software-to-install\//, "", src) }
    /^##[[:space:]]+Mandatory/  { mandatory = 1; next }
    /^##[[:space:]]/ && !/^###/ { mandatory = 0 }
    !mandatory { next }
    # Top-level bullets only. Sub-bullets are per-OS prose for their parent, and
    # prose that merely names a tag (documenting an Optional tool, quoting an
    # example) must never become something the setup scripts install.
    /^[-*][[:space:]]/ {
        line = $0
        while (match(line, /`[a-z][a-z0-9-]*:[^`[:space:]]+`/)) {
            tag = substr(line, RSTART + 1, RLENGTH - 2)
            line = substr(line, RSTART + RLENGTH)
            colon = index(tag, ":")
            mgr = substr(tag, 1, colon - 1)
            val = substr(tag, colon + 1)
            if (mgr in known) print mgr "\t" val "\t" src
        }
        # Top-level bullets only. Sub-bullets are per-OS prose for their parent,
        # and prose that merely mentions `manual` must not become an entry.
        if ($0 ~ /`manual`/ && $0 ~ /^[-*][[:space:]]/) {
            name = $0
            sub(/^[[:space:]]*[-*][[:space:]]*/, "", name)
            gsub(/`[^`]*`/, "", name)               # drop all tags
            # Reduce "[text](url)" to "text". awk gsub has no backreferences, so
            # delete the "](url)" tail and the opening bracket instead.
            gsub(/\]\([^)]*\)/, "", name)
            gsub(/[][]/, "", name)
            gsub(/<[^>]*>/, "", name)               # bare autolinks
            gsub(/[[:space:]]+/, " ", name)
            sub(/^[[:space:]]+/, "", name)
            sub(/[[:space:]]*[-:.,]+[[:space:]]*$/, "", name)
            sub(/[[:space:]]+$/, "", name)
            if (name != "") print "manual\t" name "\t" src
        }
    }
' "${SRC[@]}" > "$TMP/tags"

[[ -s "$TMP/tags" ]] || { echo "gen-pkgs: no install tags found in $DOCS" >&2; exit 1; }

# Translate manager tags into the list files they feed. This is where `native`
# fans out to three managers, and where `brew`/`cask` become brew-common/brew-cask.
MAP=""
for mgr in "${!TARGETS[@]}"; do MAP+="$mgr=${TARGETS[$mgr]};"; done

awk -F'\t' -v OFS='\t' -v map="$MAP" '
    BEGIN {
        n = split(map, pairs, ";")
        for (i = 1; i <= n; i++) {
            if (pairs[i] == "") continue
            eq = index(pairs[i], "=")
            target[substr(pairs[i], 1, eq - 1)] = substr(pairs[i], eq + 1)
        }
    }
    !($1 in target) { next }
    {
        m = split(target[$1], lists, " ")
        for (j = 1; j <= m; j++) if (lists[j] != "") print lists[j], $2, $3
    }
' "$TMP/tags" > "$TMP/expanded"

# Build one list file: entries in document order, grouped by source file, first
# occurrence winning, then the hand-written .extra.txt appended.
build() {
    local list="$1" out="$TMP/out-$1"
    {
        echo "# GENERATED by scripts/gen-pkgs.sh — do not edit."
        echo "#"
        echo "# Add or remove tools in src/software-to-install/ (the source of truth),"
        echo "# then run: bash scripts/gen-pkgs.sh"
        if [[ -f "$PKGS/$list.extra.txt" ]]; then
            echo "# Machine-only plumbing lives in pkgs/$list.extra.txt and is appended below."
        fi
        awk -F'\t' -v want="$list" '
            $1 != want { next }
            !seen[$2]++ {
                if ($3 != prev) { print ""; print "# from " $3; prev = $3 }
                print $2
            }
        ' "$TMP/expanded"
        if [[ -f "$PKGS/$list.extra.txt" ]]; then
            echo ""
            echo "# --- from pkgs/$list.extra.txt ---"
            awk '{sub(/#.*/, "")} NF' "$PKGS/$list.extra.txt"
        fi
    } > "$out"
    echo "$out"
}

status=0

# emit <name> <generated-file> — write it, or in --check mode diff it.
emit() {
    local name="$1" generated="$2" target="$PKGS/$1.txt"
    if ((CHECK)); then
        if ! diff -q "$target" "$generated" >/dev/null 2>&1; then
            echo "STALE: pkgs/$name.txt does not match src/software-to-install/" >&2
            diff -u "$target" "$generated" | sed -n '3,$p' >&2
            status=1
        fi
    else
        cp "$generated" "$target"
        printf '  %-16s %3d entries\n' "$name.txt" \
            "$(awk '{sub(/#.*/, "")} NF' "$target" | wc -l)"
    fi
}

LISTS=(dnf apt flatpak snap mise npm uv brew-common brew-macos brew-cask manual)
for list in "${LISTS[@]}"; do
    emit "$list" "$(build "$list")"
done

# Mandatory bullets with no tag at all: probably just not annotated yet. Report
# them, but do not fail — this is the to-do list, not an error.
#
# Scoped to the files that are authoritative for what gets installed. The OS
# packages.md files are recipe documentation that deliberately re-describes
# tools owned by common/ (tagging them twice would reintroduce the drift this
# whole mechanism exists to prevent), and windows/ has no setup script.
mapfile -t UNTAGGED_SRC < <(
    find "$DOCS/common" -name '*.md' | sort
    echo "$DOCS/linux/common.md"
)

awk -v mgrs="$(printf '%s ' "${!TARGETS[@]}")" '
    BEGIN { n = split(mgrs, a, " "); for (i = 1; i <= n; i++) if (a[i] != "") known[a[i]] = 1 }
    FNR == 1 { mandatory = 0; src = FILENAME; sub(/.*src\/software-to-install\//, "", src) }
    /^##[[:space:]]+Mandatory/  { mandatory = 1; next }
    /^##[[:space:]]/ && !/^###/ { mandatory = 0 }
    !mandatory { next }
    # top-level bullets only; sub-bullets are per-OS detail for their parent
    /^[-*][[:space:]]/ {
        if ($0 ~ /`manual`/) next
        line = $0; tagged = 0
        while (match(line, /`[a-z][a-z0-9-]*:[^`[:space:]]+`/)) {
            tag = substr(line, RSTART + 1, RLENGTH - 2)
            line = substr(line, RSTART + RLENGTH)
            if (substr(tag, 1, index(tag, ":") - 1) in known) tagged = 1
        }
        if (!tagged) {
            entry = $0
            sub(/^[-*][[:space:]]*/, "", entry)
            print src ": " entry
        }
    }
' "${UNTAGGED_SRC[@]}" > "$TMP/untagged"

# Committed as pkgs/untagged.txt so the to-do list is diffable in git — a PR
# shows what got tagged, and what new Mandatory entry arrived without a tag.
{
    echo "# GENERATED by scripts/gen-pkgs.sh — do not edit."
    echo "#"
    echo "# Mandatory entries in the docs with no install tag: nothing installs these."
    echo "# Fix by adding a manager tag, or \`manual\` to acknowledge a hand install."
    echo "# An empty list below is the goal."
    echo ""
    cat "$TMP/untagged"
} > "$TMP/out-untagged"
emit untagged "$TMP/out-untagged"

if [[ -s "$TMP/untagged" ]]; then
    echo ""
    echo "Untagged Mandatory entries ($(wc -l < "$TMP/untagged")) — nothing installs these."
    echo "Add a manager tag, or \`manual\` to acknowledge a hand install:"
    sed 's/^/  /' "$TMP/untagged"
fi

if ((CHECK)); then
    ((status)) && echo "run: bash scripts/gen-pkgs.sh" >&2
    exit $status
fi
