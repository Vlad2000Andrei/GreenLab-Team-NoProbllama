#!/bin/bash

cp -r ./energy experiment_runner/experiment_runner

# Run the experiment
poetry shell
python experiment_runner/experiment-runner experiment_runner/experiment-runner/energy/RunnerConfig.py