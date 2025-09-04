#include "math_utils.h"
#include <algorithm>

namespace MathUtils {
    int factorial(int n) {
        if (n <= 1) return 1;
        return n * factorial(n - 1);
    }
    
    double average(const std::vector<int>& numbers) {
        if (numbers.empty()) return 0.0;
        
        int sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        return static_cast<double>(sum) / numbers.size();
    }
    
    int findMax(const std::vector<int>& numbers) {
        if (numbers.empty()) return 0;
        return *std::max_element(numbers.begin(), numbers.end());
    }
    
    bool isPrime(int n) {
        if (n < 2) return false;
        if (n == 2) return true;
        if (n % 2 == 0) return false;
        
        for (int i = 3; i * i <= n; i += 2) {
            if (n % i == 0) return false;
        }
        return true;
    }
}
