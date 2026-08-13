# Software to Install

Installation guides organized so that cross-platform tools live in one place and OS-specific software stays with its native install recipes.

## Structure

```
software-to-install/
├── README.md
├── common/                      # cross-platform tools, organized by function
│   ├── core.md                  # base CLI essentials + typography
│   ├── languages-runtimes.md    # languages, SDKs, version managers
│   ├── editors-ides.md          # traditional editors and IDEs
│   ├── ai-tools.md              # AI coding agents and AI-first editors
│   ├── terminals-shells.md      # terminals, shells, prompts
│   ├── cli-utilities.md         # CLI and data/document processing tools
│   ├── dev-tools.md             # compilers/build, VCS, DB, API clients
│   ├── containers-virtualization.md
│   ├── media-creative.md        # audio/video/image, players
│   ├── productivity-notes.md    # notes, PKM, office, reading
│   ├── writing-publishing.md    # markdown, LaTeX, authoring, DTP
│   ├── browsers.md
│   ├── communication.md
│   ├── system-utilities.md      # file managers, monitors, capture, disk
│   └── security-privacy.md
├── linux/
│   ├── common.md                # cross-distro notes
│   ├── ubuntu/
│   │   ├── packages.md
│   │   └── post-install.md
│   └── fedora/
│       ├── packages.md
│       ├── post-install.md
│       ├── nvidia.md
│       └── onedrive.md
├── macos/
│   ├── packages.md
│   └── post-install.md
└── windows/
    ├── packages.md
    └── post-install.md
```

## Relationship to `scripts/pkgs/`

**These markdown files are the single source of truth.** [`scripts/pkgs/*.txt`](../../scripts/pkgs/) is *generated* from them by [`scripts/gen-pkgs.sh`](../../scripts/gen-pkgs.sh) — never hand-edit those files, they carry a `# GENERATED` header and your edits will be overwritten.

Tools are annotated with inline install tags naming the package manager and the exact package id:

```markdown
- Slack `flatpak:com.slack.Slack` `cask:slack`
- Pandoc `native:pandoc`
- [starship](https://starship.rs) `mise:starship@latest`
- DaVinci Resolve `manual`
```

| Tag | Meaning |
| --- | --- |
| `native:` | same package name from dnf, apt **and** brew — expands to all three |
| `dnf:` `apt:` | distro packages, for when the names differ |
| `brew-macos:` | a formula macOS needs because Linux gets it from dnf/apt |
| `brew:` | a formula every platform needs |
| `cask:` | macOS GUI app |
| `flatpak:` `snap:` | Linux GUI app |
| `mise:` | runtime or version-pinned dev CLI |
| `npm:` `uv:` | node / python CLI tool |
| `manual` | no package manager has it; collected into `pkgs/manual.txt` and printed by the setup scripts |

Repeat a tag to install several packages for one tool (`` `dnf:p7zip` `dnf:p7zip-plugins` ``).

Only `## Mandatory` sections are read — tagging an Optional entry documents the id but installs nothing.

### Workflow

```shell
# 1. add or edit a tagged entry in a Mandatory section, then:
bash scripts/gen-pkgs.sh     # regenerate; also lists untagged Mandatory entries
bash scripts/test-pkgs.sh    # verifies the lists parse and match these docs
```

`gen-pkgs.sh --check` fails if the committed lists are stale, which is how drift gets caught rather than discovered on a fresh machine. `test-pkgs.sh` runs it for you.

The OS `packages.md` files are *recipe documentation* — they describe repo setup and per-distro install commands for tools owned by `common/`, and deliberately carry no tags for those, so a package name is never written in two places. They tag only OS-exclusive software (e.g. Fedora's `moosync`).

Plumbing with no place in user-facing docs (`ca-certificates`, `build-essential`, …) lives in hand-written `pkgs/<list>.extra.txt` files that the generator appends.

### Where each list is used

Most lists are cross-platform, so a tool usually only needs adding in one place:

| List | Fedora | Ubuntu | macOS |
| --- | :-: | :-: | :-: |
| `dnf.txt` — OS/system packages | ✅ | | |
| `apt.txt` — OS/system packages | | ✅ | |
| `flatpak.txt` — GUI apps | ✅ | ✅ | |
| `brew-cask.txt` — GUI apps | | | ✅ |
| `brew-macos.txt` — CLI tools Linux gets from dnf/apt | | | ✅ |
| `snap.txt` — only what exists nowhere else | ✅ | ✅ | |
| `mise.txt` — runtimes and version-pinned dev CLIs | ✅ | ✅ | ✅ |
| `npm.txt` — node global CLIs | ✅ | ✅ | ✅ |
| `uv.txt` — python CLI tools | ✅ | ✅ | ✅ |
| `brew-common.txt` — CLI tools no other tier carries | ✅ | ✅ | ✅ |
| `manual.txt` — printed, not installed | ✅ | ✅ | ✅ |

## Where does a tool go? (routing rule)

- **`common/` is a tool's home.** If a tool runs on more than one OS, it belongs in the matching `common/` category, with its canonical cross-platform install method (Homebrew, SDKman, npm, etc.). Short per-OS install snippets may be nested as sub-bullets under the tool.
- **An OS directory holds OS-*exclusive* software** (e.g. PowerToys on Windows, Rectangle on macOS) **and genuinely OS-specific install recipes** that differ materially from the cross-platform path (e.g. Fedora `dnf`/`copr` repo setups). Prefer linking back to `common/` over duplicating a tool's description.
- **`packages.md`** = things you install. **`post-install.md`** = OS/system configuration after install. Self-contained topics get their own file (e.g. Fedora's `nvidia.md`, `onedrive.md`).

## Section conventions

- Every install list (`common/*.md` and each OS `packages.md`) leads with a `## Mandatory` section, then a `## Optional` section — Mandatory first, Optional second, always.
- If a list has no optional entries, omit the empty `## Optional` heading rather than leaving it hollow.
- Multi-topic files (e.g. an OS `packages.md`, or `dev-tools.md`) may nest `###` sub-sections (by category) inside Mandatory/Optional.
- `post-install.md`, `nvidia.md`, and `onedrive.md` are task-oriented setup guides and do not use the Mandatory/Optional split.
