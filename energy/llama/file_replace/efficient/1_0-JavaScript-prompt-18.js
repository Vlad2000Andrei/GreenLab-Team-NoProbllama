
const fs = require('fs');

// Read the file and split it into lines
const fileContent = fs.readFileSync(process.argv[2], 'utf8').split('\n');

// Replace all occurrences of the first string with the second string
const replacedContent = fileContent.map(line => line.replace(process.argv[3], process.argv[4]));

// Write the replaced content to a new file
fs.writeFileSync('out.txt', replacedContent.join('\n'));
