MAX_PIXELS=1003520 \
CUDA_VISIBLE_DEVICES=3 \
swift sft \
    --model Qwen/Qwen2.5-VL-3B-Instruct \
    --dataset ORD_Lite_train.jsonl \
    --val_dataset  ORD_Lite_test.jsonl \
    --train_type lora \
    --freeze_vit false \
    --freeze_aligner false \
    --freeze_llm false \
    --torch_dtype bfloat16 \
    --num_train_epochs 1 \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 16 \
    --learning_rate 1e-4 \
    --lora_rank 8 \
    --lora_alpha 32 \
    --target_modules all-linear \
    --gradient_accumulation_steps 16 \
    --eval_steps 150 \
    --save_steps 150 \
    --save_total_limit 2 \
    --logging_steps 5 \
    --max_length 2048 \
    --output_dir .../ckp \
    --warmup_ratio 0.05 \
    --dataloader_num_workers 4
