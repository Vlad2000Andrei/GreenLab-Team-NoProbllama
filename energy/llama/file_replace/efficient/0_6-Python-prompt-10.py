
import sys

# Open the input file and the output file in binary mode
with open(sys.argv[1], "rb") as infile, open("out.txt", "wb") as outfile:
    # Read the input file in chunks
    while True:
        chunk = infile.read(1024)
        if not chunk:
            break
        # Replace all occurrences of the first string with the second string
        outfile.write(chunk.replace(sys.argv[2], sys.argv[3]))

