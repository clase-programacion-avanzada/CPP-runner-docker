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

# Check if a Makefile exists and use it if it does
if [ -f "Makefile" ] || [ -f "makefile" ]; then
    echo "Makefile found. Running make..."
    make
# Otherwise, compile the single source file provided
else
    echo "No Makefile found. Compiling with g++..."
    g++ -std=c++23 -o "$OUTPUT_BINARY" "$SOURCE_FILE"
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