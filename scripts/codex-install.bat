@echo off
REM
REM Codex Installation Script for Forge Anything (Windows)
REM
REM Installs skills from this repository to your local Codex skills directory.
REM Uses direct copy (no symlinks) for Windows compatibility.
REM
REM Usage:
REM   scripts\codex-install.bat [--all | --skill <name>]
REM
REM Options:
REM   --all             Install all skills (default)
REM   --skill <name>    Install a single skill by name
REM   --list            List available skills
REM   --help            Show this help message
REM

setlocal enabledelayedexpansion

set "CODEX_SKILLS_DIR=%USERPROFILE%\.codex\skills"
set "CODEX_SKILLS_SRC=%~dp0..\skills"

set "MODE=all"
set "SKILL_NAME="

:parse_args
if "%1"=="" goto :run_mode
if "%1"=="--all" (
    set "MODE=all"
    shift
    goto :parse_args
)
if "%1"=="--skill" (
    set "MODE=skill"
    set "SKILL_NAME=%2"
    if "!SKILL_NAME!"=="" (
        echo [ERROR] --skill option requires a skill name
        goto :show_help
    )
    shift
    shift
    goto :parse_args
)
if "%1"=="--list" (
    set "MODE=list"
    shift
    goto :parse_args
)
echo [ERROR] Unknown option: %1
goto :show_help

:run_mode
echo.
echo ========================================
echo   Forge Anything - Codex Installer
echo   (Windows Version)
echo ========================================
echo.

if "%MODE%"=="list" goto :list_skills
if "%MODE%"=="skill" goto :install_skill
if "%MODE%"=="all" goto :install_all
goto :end

:list_skills
echo Available skills:
echo.
for /d %%i in ("%CODEX_SKILLS_SRC%\*") do (
    if exist "%%i\SKILL.md" (
        echo   - %%~ni
    )
)
goto :end

:install_skill
if not exist "%CODEX_SKILLS_SRC%\%SKILL_NAME%" (
    echo [ERROR] Skill not found: %SKILL_NAME%
    goto :end
)
echo [INFO] Installing skill: %SKILL_NAME%...
mkdir "%CODEX_SKILLS_DIR%\%SKILL_NAME%" 2>nul
xcopy /E /Y /Y "%CODEX_SKILLS_SRC%\%SKILL_NAME%\*" "%CODEX_SKILLS_DIR%\%SKILL_NAME%\" >nul
if errorlevel 1 (
    echo [ERROR] Failed to install skill: %SKILL_NAME%
) else (
    echo [SUCCESS] Skill installed: %SKILL_NAME%
)
goto :end

:install_all
echo [INFO] Installing all skills...
set /a INSTALLED=0
set /a FAILED=0

for /d %%i in ("%CODEX_SKILLS_SRC%\*") do (
    if exist "%%i\SKILL.md" (
        set "CUR_SKILL=%%~ni"
        echo [INFO] Installing !CUR_SKILL!...
        mkdir "%CODEX_SKILLS_DIR%\!CUR_SKILL!" 2>nul
        xcopy /E /Y /Y "%%i\*" "%CODEX_SKILLS_DIR%\!CUR_SKILL!\" >nul
        if errorlevel 1 (
            echo [ERROR] Failed to install !CUR_SKILL!
            set /a FAILED+=1
        ) else (
            set /a INSTALLED+=1
        )
    )
)

echo.
echo [INFO] Installation complete: !INSTALLED! installed, !FAILED! failed
echo.
echo [SUCCESS] Skills installed to: %CODEX_SKILLS_DIR%
goto :end

:show_help
echo.
echo Codex Installation Script for Forge Anything (Windows)
echo.
echo Usage:
echo   scripts\codex-install.bat [--all ^| --skill ^<name^>]
echo.
echo Options:
echo   --all             Install all skills (default)
echo   --skill ^<name^>    Install a single skill by name
echo   --list            List available skills
echo   --help            Show this help message
echo.
echo Examples:
echo   scripts\codex-install.bat
echo   scripts\codex-install.bat --skill content-creator
echo   scripts\codex-install.bat --list
goto :end

:end
endlocal
