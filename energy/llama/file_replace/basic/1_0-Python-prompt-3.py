
import sys

# Open the input file and the output file for writing
with open(sys.argv[1], "r") as infile, open("out.txt", "w") as outfile:
    # Read the contents of the input file
    contents = infile.read()

    # Replace all occurrences of the first string with the second string
    contents = contents.replace(sys.argv[2], sys.argv[3])

    # Write the resulting text to the output file
    outfile.write(contents)
