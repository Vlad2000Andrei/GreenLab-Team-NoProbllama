#include <climits>
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    // Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
    ifstream infile("./experiment-runner/energy/smallnumbers.txt");
    vector<int> arr;
    int num;
    int n = 0;
    while (infile >> num) {
        arr.push_back(num);
        n++;
    }

    // find the smallest absolute difference between any two elements of arr
    int smallest_diff = INT_MAX;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int diff = abs(arr[i] - arr[j]);
            if (diff < smallest_diff) {
                smallest_diff = diff;
            }
        }
    }

    // return a list of tuples, only the pairs of elements of arr that have a difference equal to the smallest difference
    vector<pair<int, int>> pairs;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (abs(arr[i] - arr[j]) == smallest_diff) {
                pairs.push_back(make_pair(arr[i], arr[j]));
            }
        }
    }

    // return pairs;
}


