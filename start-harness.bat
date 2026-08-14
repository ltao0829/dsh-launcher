@echo off
setlocal EnableDelayedExpansion
rem ============================================================
rem  DSH Web universal launcher (Windows)
rem  Starts "dsh web" and opens the browser automatically.
rem
rem  Usage:
rem    double-click it, or run from a terminal
rem    optional: pass a port number, e.g.  start-harness.bat 8080
rem
rem  dsh is located automatically in this order:
rem    1. dsh.cmd on PATH               (global install)
rem    2. %APPDATA%\npm\dsh.cmd          (default npm global prefix)
rem    3. any npx cache directory       (auto-detects the hash folder)
rem    4. %USERPROFILE%\.npm-global\bin (alternate global prefix)
rem    5. npx                            (auto-installs dsh on first run)
rem
rem  Stop the service by closing the "DSH Web Server" window.
rem ============================================================

set "PORT=%~1"
if "%PORT%"=="" set "PORT=3080"
set "URL=http://127.0.0.1:%PORT%"

rem ---- 1. If already listening, just open the browser ----
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>nul
if not errorlevel 1 (
    echo [DSH] Server already running at %URL% - opening browser.
    start "" "%URL%"
    exit /b 0
)

rem ---- 2. Locate the dsh command ----
set "DSH_CMD="

where dsh.cmd >nul 2>nul && set "DSH_CMD=dsh.cmd"

if not defined DSH_CMD (
    if exist "%APPDATA%\npm\dsh.cmd" set "DSH_CMD=%APPDATA%\npm\dsh.cmd"
)

if not defined DSH_CMD (
    for /d %%d in ("%LOCALAPPDATA%\npm-cache\_npx\*") do (
        if exist "%%d\node_modules\.bin\dsh.cmd" (
            set "DSH_CMD=%%d\node_modules\.bin\dsh.cmd"
            goto :found
        )
    )
)
:found

if not defined DSH_CMD (
    if exist "%USERPROFILE%\.npm-global\bin\dsh.cmd" set "DSH_CMD=%USERPROFILE%\.npm-global\bin\dsh.cmd"
)

if not defined DSH_CMD (
    where npx.cmd >nul 2>nul && set "DSH_CMD=npx.cmd --yes @deepseek-ai/dsh"
)

if not defined DSH_CMD (
    echo [DSH] ERROR: dsh is not installed and no Node.js/npx was found.
    echo [DSH] Install Node.js from https://nodejs.org first, then either:
    echo [DSH]   npm install -g @deepseek-ai/dsh
    echo [DSH] or just re-run this launcher.
    pause
    exit /b 1
)

echo [DSH] Starting: !DSH_CMD! web --port %PORT%
start "DSH Web Server" cmd /k "!DSH_CMD! web --port %PORT%"

rem ---- 3. Wait for the server, then open the browser ----
echo [DSH] Waiting for %URL% ...
set /a TRIES=0
:wait
ping -n 2 127.0.0.1 >nul
netstat -ano | findstr ":%PORT% " | findstr "LISTENING" >nul 2>nul
if not errorlevel 1 goto open
set /a TRIES+=1
if !TRIES! lss 60 goto wait
echo [DSH] Timed out after ~60s; opening browser anyway.

:open
start "" "%URL%"
echo [DSH] Opened %URL%
echo [DSH] Close the "DSH Web Server" window to stop the service.
endlocal
exit /b 0
