
import sys

# Open the input file and read it line by line
with open(sys.argv[1], "r") as f:
    for line in f:
        # Replace all occurrences of the first string with the second string
        line = line.replace(sys.argv[2], sys.argv[3])
        # Write the resulting line to the output file
        with open("out.txt", "a") as f_out:
            f_out.write(line)
