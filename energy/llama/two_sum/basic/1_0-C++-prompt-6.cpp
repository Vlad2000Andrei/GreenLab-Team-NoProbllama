
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
    vector<int> arr = {1, 2, 3, 4, 5, 6};
    find_indices(arr, 7);
    return 0;
}

