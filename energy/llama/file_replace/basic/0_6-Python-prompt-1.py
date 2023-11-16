
import sys

# Open the input file and read it line by line
with open(sys.argv[1], "r") as f:
    lines = f.readlines()

# Replace all occurrences of the first string with the second string
for i, line in enumerate(lines):
    lines[i] = line.replace(sys.argv[2], sys.argv[3])

# Open the output file and write the resulting text
with open("out.txt", "w") as f:
    f.writelines(lines)

