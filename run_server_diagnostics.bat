@echo off
rem Diagnostic launch: captures detailed server logs to the Desktop for freeze analysis.
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
  echo Python environment missing. Run run_server.bat once to install the server.
  pause
  exit /b 1
)
set "LOG=%USERPROFILE%\Desktop\Guadeloupe-Earth-diagnostic.log"
echo Starting Guadeloupe Earth with diagnostics.
echo Log file: "%LOG%"
echo Reproduce a freeze, then close the server with Ctrl+C.
echo.
".venv\Scripts\python.exe" start.py -- --verbose > "%LOG%" 2>&1
echo.
echo Diagnostic log saved to "%LOG%"
pause
