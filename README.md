# Running one instruction

Requesting a single piece of code can be done using the `run-instruction.sh` wrapper script. Usage is as follows:

```
./run-instruction.sh <path-to-model-directory> <Programming-Language> <Prompt>
```

For example, this will ask Code Llama to write Hello World in Java:
```
./run-instruction.sh ./codellama-7b-instruct/ Java "Write hello world."
```

# Bulk-Running Instructions

Instructions can be run in bulk using the `run-all.py` wrapper script. The output can be printed to the terminal or to files. The files are generated under `./answers/`.

The prompts are provided in a file where each line is a separate request. The structure of a line is:
```
<Language> <Prompt>
```

For example, this file would ask for a hello world program in Python and in Java:
```
Python Write a Hello World program.
Java Write a Hello World program.
```

To execute the contents of the file, the command usage is as such:
```
python3 ./run-all.py <path-to-prompts-file> <path-to-model-directory>
```

For example, using our `prompts.txt` file, we can run:
```
python3 ./run-all.py ./prompts.txt ./codellama-7b-instruct/ -f
```

***Note:*** The 3rd argument is optionally `-f` and will cause the output to be sent to files in the `./answers/` directory. Omitting `-f` will result in the output being printed to the terminal. ***Argument order is strict.***