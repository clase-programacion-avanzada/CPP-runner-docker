# This script compiles and runs a single C++ project in an interactive Docker container.
# It takes one argument: the name of the project directory.
# Optional environment variables:
#   PROJECTS_BASE_DIR - Base directory for projects (default: "student_projects")
#   MAIN_SOURCE_FILE - Main source file name (default: "main.cpp")

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectName
)

# --- Configuration ---
$ProjectsBaseDir = if ($env:PROJECTS_BASE_DIR) { $env:PROJECTS_BASE_DIR } else { "student_projects" }
$MainSourceFile = if ($env:MAIN_SOURCE_FILE) { $env:MAIN_SOURCE_FILE } else { "main.cpp" }
$DockerImage = "cpp-runner-env"

# --- Input Validation ---
$ProjectPath = Join-Path $ProjectsBaseDir $ProjectName

if (-not (Test-Path $ProjectPath -PathType Container)) {
    Write-Error "Error: Project directory '$ProjectPath' not found."
    Write-Host "Using PROJECTS_BASE_DIR: $ProjectsBaseDir" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Usage examples:" -ForegroundColor Cyan
    Write-Host "  .\run_interactive.ps1 project_group_1" -ForegroundColor White
    Write-Host "  `$env:PROJECTS_BASE_DIR='my_projects'; .\run_interactive.ps1 project_group_1" -ForegroundColor White
    Write-Host "  `$env:MAIN_SOURCE_FILE='app.cpp'; .\run_interactive.ps1 project_group_1" -ForegroundColor White
    exit 1
}

$MainSourcePath = Join-Path $ProjectPath $MainSourceFile
if (-not (Test-Path $MainSourcePath -PathType Leaf)) {
    Write-Warning "Main source file '$MainSourceFile' not found in '$ProjectPath'."
    Write-Host "Using MAIN_SOURCE_FILE: $MainSourceFile" -ForegroundColor Yellow
    Write-Host "The container will attempt to compile anyway..." -ForegroundColor Yellow
}

Write-Host "==================================================" -ForegroundColor Green
Write-Host "Launching interactive session for: $ProjectName" -ForegroundColor Green
Write-Host "Projects base directory: $ProjectsBaseDir" -ForegroundColor Green
Write-Host "Main source file: $MainSourceFile" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host "Compiling and running... you will be connected to the program."
Write-Host "Press Ctrl+C to exit the program if it hangs."
Write-Host ""

# --- Docker Execution ---
# Get current directory and convert to Unix-style path for Docker
$CurrentDir = Get-Location
$UnixPath = $CurrentDir.Path -replace '\\', '/' -replace '^([A-Za-z]):', '/$1'

try {
    docker run `
        -it `
        --rm `
        --name "$ProjectName-interactive-runner" `
        --cpus="1.0" `
        --memory="2g" `
        -v "${CurrentDir}/${ProjectPath}:/app" `
        $DockerImage $MainSourceFile
}
catch {
    Write-Error "Failed to run Docker container: $_"
    exit 1
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "Session for $ProjectName has ended." -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
