# If you are using the validation set for inference, add the parameter `--load_data_args true`.
CUDA_VISIBLE_DEVICES=0 \
MAX_PIXELS=1003520 \
FPS_MAX_FRAMES=12 \
swift infer \
    --model STORM \
    --temperature 0 \
    --load_data_args true \
    --infer_backend pt \
    --max_new_tokens 512 \
    --val_dataset ORD_Lite_test.jsonl  \
    --result_path ORD_Lite_test_answer.jsonl