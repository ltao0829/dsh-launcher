# dsh-launcher

One-click launcher for the DeepSeek Harness (DSH) web UI: double-click to start `dsh web` and open the browser automatically.

## Usage

- Double-click `start-harness.bat` — uses the default port `3080`
- Specify a port from the command line: `start-harness.bat 8080`
- Close the "DSH Web Server" window to stop the service

## How it works

The script locates the `dsh` command automatically (no manual path configuration needed):

1. `dsh.cmd` on PATH (global install)
2. `%APPDATA%\npm\dsh.cmd` (npm default global prefix)
3. Any npx cache directory: `%LOCALAPPDATA%\npm-cache\_npx\*\node_modules\.bin\dsh.cmd`
4. `%USERPROFILE%\.npm-global\bin\dsh.cmd`
5. Falls back to `npx` (installs dsh on first run)

If the port is already listening, the script opens the browser without starting a second server.

## Requirements

- Windows
- Node.js (with npm/npx): <https://nodejs.org>
- Optional: global DeepSeek Harness install — `npm install -g @deepseek-ai/dsh`

## Notes

- The script only handles "start the server + open the browser"; DSH plugins (e.g. the web-ui bundle) must be configured per machine via their own profiles.
- Verified on Windows.
