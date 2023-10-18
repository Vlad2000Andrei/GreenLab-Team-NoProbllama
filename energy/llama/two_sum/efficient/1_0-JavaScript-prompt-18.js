
function findTwoElements(arr, k) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] + arr[j] == k) {
        console.log(`Indices of x and y: ${i}, ${j}`);
        return;
      }
    }
  }
  console.log("No elements found that add up to k");
}

// Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
(() => {
  const fs = require('fs');
  const data = fs.readFileSync('../../../bignumbers.txt', 'utf8');
  const numbers = data.split('\n').map(Number);
  const k = 123456;
  findTwoElements(numbers, k);
})();