#ifndef CALCULATOR_H
#define CALCULATOR_H

// Calculator class declaration
class Calculator {
public:
    int add(int a, int b);
    int subtract(int a, int b);
    int multiply(int a, int b);
    double divide(int a, int b);
};

// Standalone function declarations
void printWelcome();
void printResult(const char* operation, int a, int b, double result);

#endif // CALCULATOR_H
