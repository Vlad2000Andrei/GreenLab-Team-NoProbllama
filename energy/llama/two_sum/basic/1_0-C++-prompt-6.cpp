#include <fstream>
#include <iostream>
#include <vector>

using namespace std;

void find_indices(vector<int>& arr, int k) {
    for (int i = 0; i < arr.size(); i++) {
        for (int j = i + 1; j < arr.size(); j++) {
            if (arr[i] + arr[j] == k) {
                cout << "Indices of x and y: " << i << ", " << j << endl;
                return;
            }
        }
    }
    cout << "No indices found." << endl;
}

int main() {
    // Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
    ifstream infile("./experiment-runner/energy/bignumbers.txt");
    vector<int> arr;
    int num;
    while (infile >> num) {
        arr.push_back(num);
    }

    int k = 1234;
    find_indices(arr, k);
    return 0;
}

