#include <iostream>
#include "calculator.h"

int main() {
    // Call function from calculator.cpp
    printWelcome();
    
    // Create calculator instance and test methods
    Calculator calc;
    
    int a = 15, b = 3;
    
    // Test all calculator operations
    printResult("+", a, b, calc.add(a, b));
    printResult("-", a, b, calc.subtract(a, b));
    printResult("*", a, b, calc.multiply(a, b));
    printResult("/", a, b, calc.divide(a, b));
    
    // Test division by zero
    std::cout << "\nTesting division by zero:" << std::endl;
    printResult("/", a, 0, calc.divide(a, 0));
    
    std::cout << "\n✓ Project Group 2: Multi-file compilation successful!" << std::endl;
    std::cout << "✓ All functions from calculator.h/calculator.cpp linked properly" << std::endl;
    
    return 0;
}
