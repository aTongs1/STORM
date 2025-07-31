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

Our base model Qwen2.5-VL-3B-Instruct, which is an instruction-tuned chatbot, will be downloaded automatically when you run our provided training scripts. No action is needed.
