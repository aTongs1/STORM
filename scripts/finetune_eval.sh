CUDA_VISIBLE_DEVICES=0 \
swift eval \
    --model Qwen/Qwen2.5-0.5B-Instruct \
    --eval_backend Native \
    --infer_backend pt \
    --eval_dataset general_qa \
    --dataset_args '{"general_qa": {"local_path": "/path/to/qa", "subset_list": ["example"]}}'