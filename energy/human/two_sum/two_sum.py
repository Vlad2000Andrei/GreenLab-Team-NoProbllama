from typing import List

def twoSum(nums: List[int], target: int) -> List[int]:
    numMap = {}
    n = len(nums)

    for i in range(n):
        complement = target - nums[i]
        if complement in numMap:
            return [numMap[complement], i]
        numMap[nums[i]] = i

    return []  # No solution found

# Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
if __name__ == '__main__':
    with open('./experiment-runner/energy/bignumbers.txt', 'r') as f:
        arr = [int(x) for x in f.read().split()]
    k = 1234
    print(twoSum(arr, k))