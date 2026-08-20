# dsh-launcher

**One-click DeepSeek Harness Web launcher — part of a small suite of tooling for AI coding-agent workflows.**

[![CI](https://github.com/ltao0829/dsh-launcher/actions/workflows/ci.yml/badge.svg)](https://github.com/ltao0829/dsh-launcher/actions/workflows/ci.yml)
[![License: BSD-3-Clause](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](./LICENSE)

Start DeepSeek Harness (DSH) Web and open the browser with a single double-click. `dsh-launcher` locates your `dsh` installation automatically, so there is no PATH setup and no command to remember.

> Part of the `@ltao0829` AI coding-agent tooling suite, alongside [dsh-task-notify](https://github.com/ltao0829/dsh-task-notify) — a lifecycle notification layer for coding agents.

## Why this exists

DSH Web is a server you normally start from a terminal. For everyday use, a double-clickable launcher removes that friction: it finds the right `dsh` binary, starts the server, waits for the port, and opens the browser — and reuses an already-running server instead of starting a second one.

## Usage

- Double-click `start-harness.bat` → starts on the default port `3080` and opens the browser.
- Custom port (from a terminal): `start-harness.bat 8080`
- Stop the server by closing the "DSH Web Server" window.

## How it works

The script locates the `dsh` command automatically, in this order:

1. `dsh.cmd` on `PATH` (global install)
2. `%APPDATA%\npm\dsh.cmd` (npm's default global prefix)
3. any npx cache directory `%LOCALAPPDATA%\npm-cache\_npx\*\node_modules\.bin\dsh.cmd`
4. `%USERPROFILE%\.npm-global\bin\dsh.cmd`
5. falls back to `npx` (auto-installs dsh on first run)

If the port is already listening, the script opens the browser instead of starting a duplicate server.

## Requirements

- Windows
- Node.js (with npm/npx): <https://nodejs.org>
- Optional: a global DeepSeek Harness install — `npm install -g @deepseek-ai/dsh`

## Development

```sh
node scripts/check-launcher.cjs
```

Validates package metadata, documentation, and the batch script (including CRLF line endings).

## Roadmap

- [x] One-click launcher with automatic `dsh` detection
- [x] Port detection and reuse
- [ ] Cross-platform launcher (macOS / Linux)
- [ ] Desktop shortcut installer

## Related projects

- [dsh-task-notify](https://github.com/ltao0829/dsh-task-notify) — lifecycle notification layer for AI coding agents (DeepSeek Harness plugin).

## License

[BSD-3-Clause](./LICENSE)
