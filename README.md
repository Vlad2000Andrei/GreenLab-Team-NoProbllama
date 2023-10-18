# Energy Efficient Code Generation with Code Llama

This repository contains the code used to generate the results for the paper "Energy Efficient Code Generation with Code Llama" by the GreenLab team NoProbllama.

- [Energy Efficient Code Generation with Code Llama](#energy-efficient-code-generation-with-code-llama)
  - [Setup](#setup)
    - [Install Dependencies](#install-dependencies)
  - [Running the Sampling Server](#running-the-sampling-server)
  - [Running the tests on a RPi](#running-the-tests-on-a-rpi)
- [Running one instruction](#running-one-instruction)
- [Bulk-Running Instructions](#bulk-running-instructions)


## Setup

### Install Dependencies

Ensure you have [poetry](https://python-poetry.org/docs/) installed. If you do not, you can install it with:
```
curl -sSL https://install.python-poetry.org | python3 -
```

Be sure to follow the instructions in the link above to add poetry to your path and optionally enable auto-completion.

Then, install the dependencies with:
```
poetry install
```

If you're new to poetry, the [documentation](https://python-poetry.org/docs/basic-usage/) is a great place to start. The virtual environment must be activated before running any scripts. This can be done with:
```
poetry shell
```

## Running the Sampling Server

The sampling server is a web server written in Flask for receiving requests to start and stop the experiment sampling. It is located in the `server/` directory. To run the server, execute:
```
make run
```

This starts a dev server, which is sufficient for our needs. The server will be running on `localhost:8080` by default.

The server has two endpoints:

- `/start/<filename>` - Starts the experiment sampling and creates a csv file with the specified filename.
- `/stop` - Stops the experiment sampling. This will stop the experiment and save the results to the CSV.


## Running the tests on a RPi

With the RPi setup and a terminal connected via SSH, the following commands can be used to run the tests.

```
python ./energy/utils/c_compile.py
./run-experiments.sh
```

-------------

# Running one instruction

Requesting a single piece of code can be done using the `run-instruction.sh` wrapper script. Usage is as follows:

```
./run-instruction.sh <path-to-model-directory> <Temperature> <Programming-Language> <Prompt>
```

For example, this will ask Code Llama to write Hello World in Java, using a model temperature of 0.75:
```
./run-instruction.sh ./codellama-7b-instruct/ 0.75 Java "Write hello world."
```

# Bulk-Running Instructions

Instructions can be run in bulk using the `run-all.py` wrapper script. The output can be printed to the terminal or to files. The files are generated under `./answers/`.

The prompts are provided in a file where each line is a separate request. The structure of a line is:
```
<Language> <Temperature> <Prompt>
```

For example, this file would ask for a hello world program in Python with a temperature of 0.75 and in Java with a temperature of 0.8:
```
Python 0.75 Write a Hello World program.
Java 0.8 Write a Hello World program.
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