
with open('./experiment-runner/energy/smallnumbers.txt', 'r') as f:
    arr = [int(x) for x in f.read().split()]

# Find the smallest absolute difference between any two elements of arr
smallest_diff = float('inf')
for i in range(len(arr)):
    for j in range(i+1, len(arr)):
        diff = abs(arr[i] - arr[j])
        if diff < smallest_diff:
            smallest_diff = diff

# Return a list of tuples, only the pairs of elements of arr that have a difference equal to the smallest difference
result = []
for i in range(len(arr)):
    for j in range(i+1, len(arr)):
        if abs(arr[i] - arr[j]) == smallest_diff:
            result.append((arr[i], arr[j]))


