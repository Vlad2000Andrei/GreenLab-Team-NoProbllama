
#include <iostream>
#include <vector>

using namespace std;

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int k = 10;

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

