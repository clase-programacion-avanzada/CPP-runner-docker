#ifndef MATH_UTILS_H
#define MATH_UTILS_H

#include <vector>

namespace MathUtils {
    int factorial(int n);
    double average(const std::vector<int>& numbers);
    int findMax(const std::vector<int>& numbers);
    bool isPrime(int n);
}

#endif // MATH_UTILS_H
