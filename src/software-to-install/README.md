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

## Where does a tool go? (routing rule)

- **`common/` is a tool's home.** If a tool runs on more than one OS, it belongs in the matching `common/` category, with its canonical cross-platform install method (Homebrew, SDKman, npm, etc.). Short per-OS install snippets may be nested as sub-bullets under the tool.
- **An OS directory holds OS-*exclusive* software** (e.g. PowerToys on Windows, Rectangle on macOS) **and genuinely OS-specific install recipes** that differ materially from the cross-platform path (e.g. Fedora `dnf`/`copr` repo setups). Prefer linking back to `common/` over duplicating a tool's description.
- **`packages.md`** = things you install. **`post-install.md`** = OS/system configuration after install. Self-contained topics get their own file (e.g. Fedora's `nvidia.md`, `onedrive.md`).

## Section conventions

- Every install list (`common/*.md` and each OS `packages.md`) leads with a `## Mandatory` section, then a `## Optional` section — Mandatory first, Optional second, always.
- If a list has no optional entries, omit the empty `## Optional` heading rather than leaving it hollow.
- Multi-topic files (e.g. an OS `packages.md`, or `dev-tools.md`) may nest `###` sub-sections (by category) inside Mandatory/Optional.
- `post-install.md`, `nvidia.md`, and `onedrive.md` are task-oriented setup guides and do not use the Mandatory/Optional split.
