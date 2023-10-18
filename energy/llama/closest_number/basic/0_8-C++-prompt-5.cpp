#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int n; // number of elements in the array
    cin >> n;

    vector<int> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
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


