MODEL_FOLDER=$1


# run the model
torchrun --nproc_per_node 1 $MODEL_FOLDER/example_instructions.py \
    --ckpt_dir $MODEL_FOLDER/CodeLlama-7b-Instruct/ \
    --tokenizer_path $MODEL_FOLDER/CodeLlama-7b-Instruct/tokenizer.model \
    --max_seq_len 512 --max_batch_size 4