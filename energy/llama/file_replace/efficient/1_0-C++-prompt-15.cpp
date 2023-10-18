
#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char* argv[]) {
    if (argc != 4) {
        std::cerr << "Usage: " << argv[0] << " <file> <first string> <second string>" << std::endl;
        return 1;
    }

    std::ifstream in(argv[1], std::ios::binary);
    if (!in) {
        std::cerr << "Error: unable to open file " << argv[1] << std::endl;
        return 1;
    }

    std::string first_string(argv[2]);
    std::string second_string(argv[3]);

    std::ofstream out("out.txt", std::ios::binary);
    if (!out) {
        std::cerr << "Error: unable to open file out.txt" << std::endl;
        return 1;
    }

    std::string line;
    while (std::getline(in, line)) {
        std::size_t pos = 0;
        while ((pos = line.find(first_string, pos)) != std::string::npos) {
            line.replace(pos, first_string.length(), second_string);
            pos += second_string.length();
        }
        out << line << std::endl;
    }

    return 0;
}