#include <iostream>
#include <string>

int main() {
    std::string name;
    std::cout << "--- Interactive C++ Program ---" << std::endl;
    std::cout << "Hello from inside the Docker container!" << std::endl;
    std::cout << "Please enter your name: ";
    
    // Read a line of input from the user
    std::getline(std::cin, name);
    
    if (name.empty()) {
        std::cout << "\nYou didn't enter a name. Goodbye!" << std::endl;
    } else {
        std::cout << "\nHello, " << name << "! Your program ran successfully." << std::endl;
    }
    
    return 0;
}
