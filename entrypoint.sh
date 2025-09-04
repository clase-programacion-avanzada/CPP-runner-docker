#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Check if a source file argument is provided
if [ -z "$1" ]; then
    echo "Error: No source file provided."
    echo "Usage: docker run <image> <source_file.cpp>"
    exit 1
fi

SOURCE_FILE="$1"
OUTPUT_BINARY="program"

# --- Compilation Logic ---
echo "--- Compiling $SOURCE_FILE ---"

# Check for CMakeLists.txt first (CMake project)
if [ -f "CMakeLists.txt" ]; then
    echo "CMakeLists.txt found. Running cmake and make..."
    cmake -B build .
    make -C build
    # Find the executable in the build directory
    if [ -f "build/Talleres_Proyecto" ]; then
        OUTPUT_BINARY="build/Talleres_Proyecto"
    elif find build -type f -executable -name "*" | head -1 > /dev/null; then
        OUTPUT_BINARY=$(find build -type f -executable -name "*" | head -1)
    fi
# Check if a Makefile exists and use it if it does
elif [ -f "Makefile" ] || [ -f "makefile" ]; then
    echo "Makefile found. Running make..."
    make
# Otherwise, compile the single source file provided
else
    echo "No Makefile found. Compiling with g++..."
    # Find all .cpp files and compile them together
    CPP_FILES=$(find . -name "*.cpp" -type f)
    if [ -n "$CPP_FILES" ]; then
        g++ -std=c++23 -o "$OUTPUT_BINARY" $CPP_FILES
    else
        g++ -std=c++23 -o "$OUTPUT_BINARY" "$SOURCE_FILE"
    fi
fi

# Check if the compilation was successful by looking for the output binary
if [ ! -f "$OUTPUT_BINARY" ]; then
    echo "--- Compilation Failed ---"
    exit 1
fi

echo "--- Compilation Successful ---"
echo ""

# --- Execution Logic ---
echo "--- Running Program ---"
./"$OUTPUT_BINARY"
echo "--- Program Finished ---"