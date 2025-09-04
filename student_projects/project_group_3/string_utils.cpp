#include "string_utils.h"
#include <algorithm>
#include <cctype>
#include <sstream>

namespace StringUtils {
    std::string toUpper(const std::string& str) {
        std::string result = str;
        std::transform(result.begin(), result.end(), result.begin(), ::toupper);
        return result;
    }
    
    std::string toLower(const std::string& str) {
        std::string result = str;
        std::transform(result.begin(), result.end(), result.begin(), ::tolower);
        return result;
    }
    
    std::vector<std::string> split(const std::string& str, char delimiter) {
        std::vector<std::string> tokens;
        std::stringstream ss(str);
        std::string token;
        
        while (std::getline(ss, token, delimiter)) {
            tokens.push_back(token);
        }
        
        return tokens;
    }
    
    std::string join(const std::vector<std::string>& strings, const std::string& separator) {
        if (strings.empty()) return "";
        
        std::string result = strings[0];
        for (size_t i = 1; i < strings.size(); ++i) {
            result += separator + strings[i];
        }
        
        return result;
    }
    
    bool isPalindrome(const std::string& str) {
        std::string cleaned = toLower(str);
        // Remove non-alphanumeric characters
        cleaned.erase(std::remove_if(cleaned.begin(), cleaned.end(), 
                      [](char c) { return !std::isalnum(c); }), cleaned.end());
        
        std::string reversed = cleaned;
        std::reverse(reversed.begin(), reversed.end());
        
        return cleaned == reversed;
    }
}
