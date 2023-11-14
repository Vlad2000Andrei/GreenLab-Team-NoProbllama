#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

int main() {
    // Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
    ifstream infile("./experiment-runner/energy/bignumbers.txt");
    vector<int> arr;
    int num;
    while (infile >> num) {
        arr.push_back(num);
    }
    int k = 1234;

    for (int i = 0; i < sizeof(arr) / sizeof(arr[0]); i++) {
        for (int j = i + 1; j < sizeof(arr) / sizeof(arr[0]); j++) {
            if (arr[i] + arr[j] == k) {
                cout << "Indices of x and y: " << i << ", " << j << endl;
                return 0;
            }
        }
    }

    cout << "No such elements found." << endl;
    return 1;
}

