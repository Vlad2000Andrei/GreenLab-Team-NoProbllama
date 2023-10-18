
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int n;
    cin >> n;
    vector<int> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }

    int smallest_diff = INT_MAX;
    vector<pair<int, int>> pairs;
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int diff = abs(arr[i] - arr[j]);
            if (diff < smallest_diff) {
                smallest_diff = diff;
                pairs.clear();
                pairs.push_back(make_pair(arr[i], arr[j]));
            } else if (diff == smallest_diff) {
                pairs.push_back(make_pair(arr[i], arr[j]));
            }
        }
    }

    for (int i = 0; i < pairs.size(); i++) {
        cout << pairs[i].first << " " << pairs[i].second << endl;
    }

    return 0;
}


