from sys import argv

if not len(argv) == 2:
    print("Incorrect number of arguments")
    exit(-1)

answer = ""
with open(argv[1]) as file:
    lines = [line for line in file]

is_answer = False
for line in lines:
    if is_answer: 
        answer += line
    if "> Assistant" in line: 
        answer += line.removeprefix("> Assistant:").lstrip()
        is_answer = True

answer = answer.rstrip().rstrip("=")

print(answer)