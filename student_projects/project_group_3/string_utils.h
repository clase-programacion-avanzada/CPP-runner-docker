#ifndef STRING_UTILS_H
#define STRING_UTILS_H

#include <string>
#include <vector>

namespace StringUtils {
    std::string toUpper(const std::string& str);
    std::string toLower(const std::string& str);
    std::vector<std::string> split(const std::string& str, char delimiter);
    std::string join(const std::vector<std::string>& strings, const std::string& separator);
    bool isPalindrome(const std::string& str);
}

#endif // STRING_UTILS_H
