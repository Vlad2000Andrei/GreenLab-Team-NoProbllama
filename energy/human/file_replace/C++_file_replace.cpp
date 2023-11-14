#include <fstream>
#include <iostream>


using namespace std;

string replaceInString(string text, string oldStr, string newStr) {

    int pos = text.find(oldStr);

    while(pos != string::npos) {
        text = text.replace(pos, oldStr.length(), newStr);
        pos = text.find(oldStr);
    }

    return text;
}

int main(int argc, char* argv[]) {

    string filename = argv[1];
    string oldString = argv[2];
    string newString = argv[3];
    
    ifstream inFile;
    inFile.open(filename, ios::in);

    ofstream outFile;
    outFile.open("./out.txt", ios::out);

    char readString[4096];
    while (!inFile.eof()) {
        inFile.read(readString, 4096);
        string text = readString;

        string replacedText = replaceInString(readString, oldString, newString);
        outFile << replacedText;
    }
    
    inFile.close();
    outFile.close();
    return 0;
}

