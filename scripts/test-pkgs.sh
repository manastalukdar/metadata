#!/usr/bin/env bash
# Self-check for the pkgs/*.txt lists and the parsing setup-fedora.sh does on
# them. Run with: bash scripts/test-pkgs.sh
set -uo pipefail

PKGS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/pkgs"
STRIP='{sub(/#.*/, "")} NF'
fails=0
fail() { echo "FAIL: $*" >&2; ((fails++)); }

# The stripping expression: drops comments (whole-line and trailing) and blanks.
got="$(printf '# comment\n\n  \nfoo\nbar   # trailing\n' | awk "$STRIP" | xargs)"
[[ "$got" == "foo bar" ]] || fail "comment/blank stripping: got '$got', want 'foo bar'"

for f in "$PKGS"/*.txt; do
    name="$(basename "$f")"
    pkgs="$(awk "$STRIP" "$f")"

    [[ -n "$pkgs" ]] || fail "$name parses to nothing"

    # xargs applies its own quote and backslash parsing, so a package name
    # containing shell-ish characters would either error or silently mangle.
    while read -r pkg; do
        [[ "$pkg" =~ ^[A-Za-z0-9@/._+:-]+$ ]] \
            || fail "$name: '$pkg' is not xargs-safe"
    done < <(xargs -n1 <<<"$pkgs")

    # Duplicates within a list are harmless but always a mistake.
    dupes="$(xargs -n1 <<<"$pkgs" | sort | uniq -d)"
    [[ -z "$dupes" ]] || fail "$name: duplicate entries: $(xargs <<<"$dupes")"
done

# A tool listed in two tiers gets installed twice, from two sources, and the
# one that wins depends on PATH order. Catch it here instead of at 3am.
overlap="$(for f in "$PKGS"/{dnf,brew,mise,snap}.txt; do
    awk "$STRIP" "$f" | sed 's/@.*//' | sort -u
done | sort | uniq -d)"
[[ -z "$overlap" ]] || fail "same tool in multiple tiers: $(xargs <<<"$overlap")"

if ((fails)); then echo "$fails check(s) failed"; exit 1; fi
echo "OK: all package lists parse cleanly"
