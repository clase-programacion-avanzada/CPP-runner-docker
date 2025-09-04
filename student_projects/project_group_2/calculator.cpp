#include "calculator.h"
#include <iostream>

// Calculator class implementations
int Calculator::add(int a, int b) {
    return a + b;
}

int Calculator::subtract(int a, int b) {
    return a - b;
}

int Calculator::multiply(int a, int b) {
    return a * b;
}

double Calculator::divide(int a, int b) {
    if (b == 0) {
        std::cout << "Error: Division by zero!" << std::endl;
        return 0.0;
    }
    return static_cast<double>(a) / b;
}

// Standalone function implementations
void printWelcome() {
    std::cout << "=== Calculator Test Program ===" << std::endl;
    std::cout << "Testing multiple .cpp/.h files compilation" << std::endl;
    std::cout << "This validates the g++ multi-file compilation fix" << std::endl;
    std::cout << std::endl;
}

void printResult(const char* operation, int a, int b, double result) {
    std::cout << a << " " << operation << " " << b << " = " << result << std::endl;
}
