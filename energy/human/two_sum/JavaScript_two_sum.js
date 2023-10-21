const twoSum = (nums, target) =>{
  const numToIndex = new Map(); // Create a Map to store numbers and their indices

  for (let i = 0; i < nums.length; i++) {
      const complement = target - nums[i];

      // Check if the complement exists in the Map
      if (numToIndex.has(complement)) {
          return [numToIndex.get(complement), i];
      }

      // Store the current number and its index in the Map
      numToIndex.set(nums[i], i);
  }

  throw new Error("No solution found");
};

// Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
(() => {
  const fs = require('fs');
  const data = fs.readFileSync('./experiment-runner/energy/bignumbers.txt', 'utf8');
  const numbers = data.split('\n').map(Number);
  const k = 1234;
  const indices = twoSum(numbers, k);
  console.log(indices);
})();