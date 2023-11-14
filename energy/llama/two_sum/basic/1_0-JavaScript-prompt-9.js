
function findIndices(arr, k) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = i + 1; j < arr.length; j++) {
      if (arr[i] + arr[j] === k) {
        return [i, j];
      }
    }
  }
  return [-1, -1];
}

// Open a file named bignumbers.txt and read the numbers in it. find the indicies of k in the array.
(() => {
  const fs = require('fs');
  const data = fs.readFileSync('./experiment-runner/energy/bignumbers.txt', 'utf8');
  const numbers = data.split('\n').map(Number);
  const k = 1234;
  const indices = findIndices(numbers, k);
  console.log(indices);
})();
