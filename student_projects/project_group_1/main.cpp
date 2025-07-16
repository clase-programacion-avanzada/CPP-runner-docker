#include <iostream>
#include <vector>
#include <string>

int main() {
    std::vector<std::string> messages = {"Hello", "from", "the", "Docker", "container!"};
    for (const std::string& word : messages) {
        std::cout << word << " ";
    }
    std::cout << std::endl;
    std::cout << "Project Group 1: Success!" << std::endl;
    return 0;
}
