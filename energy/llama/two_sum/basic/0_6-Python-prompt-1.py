
def find_indices(arr, k):
    for i in range(len(arr)):
        for j in range(i+1, len(arr)):
            if arr[i] + arr[j] == k:
                return i, j
    return None

# Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
if __name__ == '__main__':
    with open('./experiment-runner/energy/bignumbers.txt', 'r') as f:
        arr = [int(x) for x in f.read().split()]
    k = 1234
    print(find_indices(arr, k))
