# homebrew-teamsly

Homebrew tap for [Teamsly](https://github.com/mayurrawte/teamsly) — an open-source modern client for Microsoft Teams.

## Install

```bash
brew tap mayurrawte/teamsly
brew install --cask teamsly
```

Homebrew handles the macOS Gatekeeper quarantine attribute automatically, so the unsigned build installs without the "Apple could not verify…" warning.

## Update

```bash
brew upgrade --cask teamsly
```

Or let the in-app auto-updater handle it on next launch.

## Uninstall

```bash
brew uninstall --cask teamsly
```

`--zap` also removes preferences, logs, and saved state.

## Source

The Cask formula tracks releases at <https://github.com/mayurrawte/teamsly/releases>. SHAs and versions are bumped in this tap each time a new desktop release ships.

## License

The Cask formula in this repository is published under the [BSD 2-Clause License](LICENSE) for consistency with Homebrew tap conventions. The Teamsly app itself is AGPL-3.0; see <https://github.com/mayurrawte/teamsly/blob/main/LICENSE>.
