
const fs = require('fs');

// Read the file and split it into an array of lines
const file = fs.readFileSync('input.txt', 'utf8');
const lines = file.split('\n');

// Replace all occurrences of the first string with the second string
const newLines = lines.map(line => line.replace(firstString, secondString));

// Write the new lines to a new file
fs.writeFileSync('out.txt', newLines.join('\n'));
