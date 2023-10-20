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

    // Find the indices of x and y
    int x_index = -1, y_index = -1;
    for (int i = 0; i < sizeof(arr) / sizeof(arr[0]); i++) {
        for (int j = i + 1; j < sizeof(arr) / sizeof(arr[0]); j++) {
            if (arr[i] + arr[j] == k) {
                x_index = i;
                y_index = j;
                break;
            }
        }
        if (x_index != -1 && y_index != -1) {
            break;
        }
    }

    // Print the indices of x and y
    if (x_index != -1 && y_index != -1) {
        cout << "x: " << x_index << ", y: " << y_index << endl;
    } else {
        cout << "No solution found" << endl;
    }

    return 0;
}

