# 76GiB
CUDA_VISIBLE_DEVICES=0 \
swift sft \
    --model Qwen/Qwen2.5-VL-3B-Instruct \
    --train_type full \
    --dataset ORD_MAX_train.jsonl \
    --val_dataset ORD_MAX_test.jsonl \
    --freeze_vit false \
    --freeze_aligner false \
    --freeze_llm false \
    --torch_dtype bfloat16 \
    --num_train_epochs 1 \
    --per_device_train_batch_size 16 \
    --per_device_eval_batch_size 16 \
    --learning_rate 5e-6 \
    --lr_scheduler_type cosine \
    --gradient_accumulation_steps 16 \
    --eval_steps 300 \
    --save_steps 300 \
    --save_total_limit 3 \
    --logging_steps 5 \
    --max_length 2048 \
    --output_dir .../ckp \
    --system 'You are a helpful assistant.' \
    --warmup_ratio 0.05 \
    --dataloader_num_workers 4 \
    --model_author swift \
    --model_name swift-robot