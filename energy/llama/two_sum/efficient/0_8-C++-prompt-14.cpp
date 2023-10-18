
#include <iostream>
#include <vector>

using namespace std;

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
    int k = 10;

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

