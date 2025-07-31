# 🌋 STORM: Stimulating Trustworthy Ordinal Regression Ability of MLLMs
*Benchmarking All-in-one Visual Rating of MLLMs with A Comprehensive Ordinal Regression Dataset.*

## Contents
- [Install](#install)
- [Train](#train)

## Install
1. Clone this repository and navigate to STORM folder
```bash
git clone https://github.com/aTongs1/STORM.git
cd STORM
```

2. Install Package
```Shell
conda create -n storm python=3.10 -y
conda activate storm
pip install --upgrade pip
pip install -r requirements.txt
```

## Train
*Below is the latest training configuration for Qwen2.5-VL-3B-Instruct.*

### Hyperparameters
All hyperparameters used in finetuning are provided below.

| Hyperparameter | Global Batch Size | Learning rate | Epochs | Max length | Weight decay | Train type |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Qwen2.5-VL-3B-Instruct | 16 | 5e-6 | 1 | 2048 | 0 | full |

### Download Qwen2.5-VL-3B-Instruct checkpoints

Our base model Qwen2.5-VL-3B-Instruct, which is an instruction-tuned chatbot, must be manually downloaded from [HuggingFace](https://huggingface.co/Qwen/Qwen2.5-VL-3B-Instruct) before running the training scripts, as it won't be downloaded automatically.

### Visual Instruction Tuning

1. Prepare data

Please download the annotation of the final mixture our instruction tuning data [STORM_train_123k.jsonl](https://huggingface.co/datasets/ttlyy/ORD/tree/main/ORD), and download the images from [constituting datasets](https://huggingface.co/datasets/ttlyy/ORD).

2. Start training!

Visual instruction tuning takes around 5 hours for Qwen2.5-VL-3B-Instruct on A100 (80G), with a memory footprint of around 30GB. 

Training script with DeepSpeed ZeRO-3: [`finetune.sh`](https://github.com/haotian-liu/LLaVA/blob/main/scripts/v1_5/finetune.sh).

If you are do not have enough GPU memory:

- Use LoRA: [`finetune_lora.sh`](https://github.com/haotian-liu/LLaVA/blob/main/scripts/v1_5/finetune_lora.sh). We are able to fit 13B training in 8-A100-40G/8-A6000, and 7B training in 8-RTX3090. Make sure `per_device_train_batch_size*gradient_accumulation_steps` is the same as the provided script for best reproducibility.
- Replace `zero3.json` with `zero3_offload.json` which offloads some parameters to CPU RAM. This slows down the training speed.

If you are interested in finetuning LLaVA model to your own task/data, please check out [`Finetune_Custom_Data.md`](https://github.com/haotian-liu/LLaVA/blob/main/docs/Finetune_Custom_Data.md)。

