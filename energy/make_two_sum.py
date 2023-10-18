import random
from sys import argv

nums = set()
TARGET = 500_000_000 # How many numbers to generate

K = 123_456 # Number to sum to
# X + Y must add up to K
X = 123_000 
Y = 456


output = []
progress = 0

while len(output) < TARGET:
    n = random.randint(0, 2_000_000_000)
    complement = K - n
    if complement not in nums:
        nums.add(n)
        output.append(str(n))

        # Pretty printing progress every once in a while 
        curr_progress = int((len(output) / TARGET) * 100)
        if curr_progress != progress:
            progress = curr_progress
            print(f'{progress}% done')

output.append(str(X))
output.append(str(Y))
    
text_output = " ".join(output)

if len(argv) > 1:
    filename = f'./{argv[1]}'
else:
    filename = "./bignumbers.txt"

with open(filename, "wb") as f:
    f.write(text_output.encode("utf-8"))