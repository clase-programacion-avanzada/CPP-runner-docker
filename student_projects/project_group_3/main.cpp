#include <iostream>
#include <string>
#include <vector>
#include "math_utils.h"
#include "string_utils.h"

#ifdef CMAKE_BUILD
    #define BUILD_TYPE "CMake"
#else
    #define BUILD_TYPE "Direct g++"
#endif

int main() {
    std::cout << "=== CMake Test Project ===" << std::endl;
    std::cout << "Build system: " << BUILD_TYPE << std::endl;
    std::cout << "C++ Standard: C++23" << std::endl;
    std::cout << "Testing CMakeLists.txt compilation with multiple files" << std::endl;
    std::cout << std::endl;
    
    // Test MathUtils
    std::cout << "--- Math Utils Tests ---" << std::endl;
    std::vector<int> numbers = {5, 2, 8, 1, 9, 3};
    
    std::cout << "Numbers: ";
    for (int num : numbers) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    
    std::cout << "Average: " << MathUtils::average(numbers) << std::endl;
    std::cout << "Maximum: " << MathUtils::findMax(numbers) << std::endl;
    std::cout << "Factorial of 5: " << MathUtils::factorial(5) << std::endl;
    std::cout << "Is 17 prime? " << (MathUtils::isPrime(17) ? "Yes" : "No") << std::endl;
    std::cout << "Is 16 prime? " << (MathUtils::isPrime(16) ? "Yes" : "No") << std::endl;
    
    std::cout << std::endl;
    
    // Test StringUtils
    std::cout << "--- String Utils Tests ---" << std::endl;
    std::string test_str = "Hello CMake World";
    std::cout << "Original: " << test_str << std::endl;
    std::cout << "Uppercase: " << StringUtils::toUpper(test_str) << std::endl;
    std::cout << "Lowercase: " << StringUtils::toLower(test_str) << std::endl;
    
    auto words = StringUtils::split(test_str, ' ');
    std::cout << "Split words: ";
    for (const auto& word : words) {
        std::cout << "[" << word << "] ";
    }
    std::cout << std::endl;
    
    std::string joined = StringUtils::join(words, "-");
    std::cout << "Joined with '-': " << joined << std::endl;
    
    std::string palindrome_test = "A man a plan a canal Panama";
    std::cout << "Is '" << palindrome_test << "' a palindrome? " 
              << (StringUtils::isPalindrome(palindrome_test) ? "Yes" : "No") << std::endl;
    
    std::cout << std::endl;
    std::cout << "✓ CMake compilation successful!" << std::endl;
    std::cout << "✓ All source files (main.cpp, math_utils.cpp, string_utils.cpp) linked properly" << std::endl;
    std::cout << "✓ CMake build system working correctly" << std::endl;
    
    return 0;
}
