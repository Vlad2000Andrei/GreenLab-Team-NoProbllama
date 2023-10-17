#!/bin/bash

MODEL_FOLDER=$1
TEMPERATURE=$2
LANGUAGE=$3
PROMPT=$4
SCRIPT_NAME="instruction-runner.py"

SCRIPT_PATH=$MODEL_FOLDER/$SCRIPT_NAME
PROMPT_TAG="<PROMPT>"
LANGUAGE_TAG="<LANG>"
TEMPERATURE_TAG="<TEMP>"
TMPOUT_FILE="./tmpout.txt"

# make a file for tmp output
touch $TMPOUT_FILE

# Move runner script into model folder so it can access the Llama Python modules
cp ./$SCRIPT_NAME $SCRIPT_PATH

# Fill prompt into script (this is cursed but also kinda the only automate-able way)
sed -i "s/$PROMPT_TAG/$PROMPT/gi" $SCRIPT_PATH
sed -i "s/$LANGUAGE_TAG/$LANGUAGE/gi" $SCRIPT_PATH
sed -i "s/$TEMPERATURE_TAG/$TEMPERATURE/gi" $SCRIPT_PATH

# run the model with the script
torchrun --nproc_per_node 1 $SCRIPT_PATH \
    --ckpt_dir $MODEL_FOLDER/CodeLlama-7b-Instruct/ \
    --tokenizer_path $MODEL_FOLDER/CodeLlama-7b-Instruct/tokenizer.model \
    --max_seq_len 512 --max_batch_size 4 > $TMPOUT_FILE

# Get the assistant's answer from the mess of output
python3 ./extract-response.py $TMPOUT_FILE

# remove the script and other temp files
rm $SCRIPT_PATH
rm $TMPOUT_FILE

