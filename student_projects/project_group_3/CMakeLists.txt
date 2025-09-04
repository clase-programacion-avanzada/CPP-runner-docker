cmake_minimum_required(VERSION 3.22)
project(CMakeTestProject)

# Set C++ standard to C++23 (matching the g++ compilation)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Create an executable with multiple source files
add_executable(cmake_test_program 
    main.cpp 
    math_utils.cpp 
    string_utils.cpp
)

# Optional: Add some compile definitions for testing
target_compile_definitions(cmake_test_program PRIVATE CMAKE_BUILD=1)

# Optional: Set some compiler flags
target_compile_options(cmake_test_program PRIVATE -Wall -Wextra)

# Print some information during configuration
message(STATUS "Building CMake test project with C++${CMAKE_CXX_STANDARD}")
message(STATUS "Source files: main.cpp, math_utils.cpp, string_utils.cpp")
message(STATUS "Target executable: cmake_test_program")
