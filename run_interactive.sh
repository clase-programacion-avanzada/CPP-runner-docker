# File: cpp_runner/run_interactive.sh

#!/bin/bash

# This script compiles and runs a single C++ project in an interactive Docker container.
# It takes one argument: the name of the project directory.

# --- Configuration ---
PROJECTS_BASE_DIR="student_projects"
MAIN_SOURCE_FILE="main.cpp"
DOCKER_IMAGE="cpp-runner-env" # The image we built earlier

# --- Input Validation ---
if [ -z "$1" ]; then
    echo "Error: You must provide the project name as an argument."
    echo "Usage: ./run_interactive.sh <project_name>"
    echo "Example: ./run_interactive.sh project_group_1"
    exit 1
fi

PROJECT_NAME="$1"
PROJECT_PATH="$PROJECTS_BASE_DIR/$PROJECT_NAME"

if [ ! -d "$PROJECT_PATH" ]; then
    echo "Error: Project directory '$PROJECT_PATH' not found."
    exit 1
fi

echo "=================================================="
echo "Launching interactive session for: $PROJECT_NAME"
echo "=================================================="
echo "Compiling and running... you will be connected to the program."
echo "Press Ctrl+C to exit the program if it hangs."
echo ""

# --- Docker Execution ---
# The key change is the '-it' flag for an interactive terminal.
docker run \
    -it \
    --rm \
    --name "$PROJECT_NAME-interactive-runner" \
    --cpus="1.0" \
    --memory="2g" \
    -v "$(pwd)/$PROJECT_PATH":/app \
    "$DOCKER_IMAGE" "$MAIN_SOURCE_FILE"

echo ""
echo "=================================================="
echo "Session for $PROJECT_NAME has ended."
echo "=================================================="