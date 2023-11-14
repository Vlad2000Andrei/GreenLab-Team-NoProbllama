const fs = require('fs');
const data = fs.readFileSync('./experiment-runner/energy/smallnumbers.txt', 'utf8');

const arr = data.split(' ').map(x => parseInt(x));

// Find the smallest absolute difference between any two elements of arr
let smallestDiff = Infinity;
for (let i = 0; i < arr.length; i++) {
  for (let j = i + 1; j < arr.length; j++) {
    const diff = Math.abs(arr[i] - arr[j]);
    if (diff < smallestDiff) {
      smallestDiff = diff;
    }
  }
}

// Generate a list of tuples, only the pairs of elements of arr that have a difference equal to the smallest difference
const pairs = [];
for (let i = 0; i < arr.length; i++) {
  for (let j = i + 1; j < arr.length; j++) {
    if (Math.abs(arr[i] - arr[j]) === smallestDiff) {
      pairs.push([arr[i], arr[j]]);
    }
  }
}

console.log(pairs);
