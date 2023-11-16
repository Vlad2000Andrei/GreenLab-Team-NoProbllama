const fs = require('fs');
const data = fs.readFileSync('./experiment-runner/energy/smallnumbers.txt', 'utf8');

const arr = data.split(' ').map(x => parseInt(x));

const smallestDifference = Math.min(...arr.map(x => Math.abs(arr.find(y => y !== x) - x)));

return arr.filter(x => Math.abs(arr.find(y => y !== x) - x) === smallestDifference).map(x => [x, arr.find(y => y !== x)]);


