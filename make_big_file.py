from sys import argv

# Text is the string to repeat 
TEXT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
output = ""

TARGET = 1_500_000_000 # String length target

count = TARGET // len(TEXT)
output = TEXT * count

if len(argv) > 1:
    filename = f'./{argv[1]}'
else:
    filename = "./bigfile.txt"

with open(filename, "wb") as f:
    f.write(output.encode("utf-8"))
