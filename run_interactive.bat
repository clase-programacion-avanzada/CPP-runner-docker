@echo off
REM This script compiles and runs a single C++ project in an interactive Docker container.
REM It takes one argument: the name of the project directory.
REM Optional environment variables:
REM   PROJECTS_BASE_DIR - Base directory for projects (default: "student_projects")
REM   MAIN_SOURCE_FILE - Main source file name (default: "main.cpp")

REM --- Configuration ---
if "%PROJECTS_BASE_DIR%"=="" set PROJECTS_BASE_DIR=student_projects
if "%MAIN_SOURCE_FILE%"=="" set MAIN_SOURCE_FILE=main.cpp
set DOCKER_IMAGE=cpp-runner-env

REM --- Input Validation ---
if "%1"=="" (
    echo Error: You must provide the project name as an argument.
    echo Usage: run_interactive.bat ^<project_name^>
    echo        set PROJECTS_BASE_DIR=^<custom_base_dir^> ^&^& run_interactive.bat ^<project_name^>
    echo        set MAIN_SOURCE_FILE=^<custom_main_file^> ^&^& run_interactive.bat ^<project_name^>
    echo Example: run_interactive.bat project_group_1
    echo          set PROJECTS_BASE_DIR=my_projects ^&^& run_interactive.bat project_group_1
    echo          set MAIN_SOURCE_FILE=app.cpp ^&^& run_interactive.bat project_group_1
    exit /b 1
)

set PROJECT_NAME=%1
set PROJECT_PATH=%PROJECTS_BASE_DIR%\%PROJECT_NAME%

if not exist "%PROJECT_PATH%" (
    echo Error: Project directory '%PROJECT_PATH%' not found.
    echo Using PROJECTS_BASE_DIR: %PROJECTS_BASE_DIR%
    exit /b 1
)

if not exist "%PROJECT_PATH%\%MAIN_SOURCE_FILE%" (
    echo Warning: Main source file '%MAIN_SOURCE_FILE%' not found in '%PROJECT_PATH%'.
    echo Using MAIN_SOURCE_FILE: %MAIN_SOURCE_FILE%
    echo The container will attempt to compile anyway...
)

echo ==================================================
echo Launching interactive session for: %PROJECT_NAME%
echo Projects base directory: %PROJECTS_BASE_DIR%
echo Main source file: %MAIN_SOURCE_FILE%
echo ==================================================
echo Compiling and running... you will be connected to the program.
echo Press Ctrl+C to exit the program if it hangs.
echo.

REM --- Docker Execution ---
REM Convert Windows path to Unix-style path for Docker volume mounting
set "CURRENT_DIR=%CD%"
set "UNIX_PATH=/%CURRENT_DIR::=%"
set "UNIX_PATH=%UNIX_PATH:\=/%"

docker run ^
    -it ^
    --rm ^
    --name "%PROJECT_NAME%-interactive-runner" ^
    --cpus="1.0" ^
    --memory="2g" ^
    -v "%CURRENT_DIR%/%PROJECT_PATH%":/app ^
    "%DOCKER_IMAGE%" "%MAIN_SOURCE_FILE%"

echo.
echo ==================================================
echo Session for %PROJECT_NAME% has ended.
echo ==================================================
