from os import system, path, remove
from sys import argv
from shutil import copyfile
from time import sleep

MODEL_FOLDER = argv[1]
TEMPERATURE = argv[2]
LANGUAGE = argv[3]
PROMPT = argv[4]
SCRIPT_NAME = "instruction-runner.py"

SCRIPT_PATH = path.join(MODEL_FOLDER, SCRIPT_NAME)
PROMPT_TAG = "<PROMPT>"
LANGUAGE_TAG = "<LANG>"
TEMPERATURE_TAG = "<TEMP>"
TMPOUT_FILE = "./tmpout.txt"

# For the torch command
MODEL_TYPE_FOLDER = "CodeLlama-7b-Instruct" ### Change to correct model you want
TORCH_CHKPT_DIR = path.join(MODEL_FOLDER, MODEL_TYPE_FOLDER)
TOKENIZER = path.join(MODEL_FOLDER, MODEL_TYPE_FOLDER, "tokenizer.model")
MAX_SEQ = 512
MAX_BATCH_SIZE = 4

def replace_in_file(filepath: str, replacements: list):
    with open(filepath, "r+") as f:
        content = f.read()
        for (old, new) in replacements:
            content = content.replace(old, new)
        f.seek(0)
        f.write(content)
        f.truncate()


# Make the temp file
with open(TMPOUT_FILE, "w") as f:
    f.close()

# Move runner script into model folder so it can access the Llama Python modules
copyfile(path.join(path.curdir, SCRIPT_NAME), SCRIPT_PATH)

# Fill prompt into script (this is cursed but oh well)
replacements = [
    (PROMPT_TAG, PROMPT),
    (LANGUAGE_TAG, LANGUAGE),
    (TEMPERATURE_TAG, TEMPERATURE)
]
replace_in_file(SCRIPT_PATH, replacements)

# run model with script
system(f"python3 -m torch.distributed.run --nproc_per_node 1 {SCRIPT_PATH} \
    --ckpt_dir {TORCH_CHKPT_DIR} \
    --tokenizer_path {TOKENIZER} \
    --max_seq_len {MAX_SEQ} --max_batch_size {MAX_BATCH_SIZE}")

# Clean up
remove(SCRIPT_PATH)
remove(TMPOUT_FILE)
