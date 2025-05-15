# checkpoint-5568-merged  融合会生成这样一个文件夹，和Qwen2.5-vl-7b的使用方式完全相同 
# 这里`--adapters`需要替换生成训练生成的最后一个检查点文件夹。 由于adapters文件夹中包含了训练的参数文件因此，不需要额外指定`--model`：
CUDA_VISIBLE_DEVICES=0 swift export \
      --adapters  .../STORM_lora \
      --merge_lora true             
