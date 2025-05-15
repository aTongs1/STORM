import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
import torch
import warnings
warnings.simplefilter("ignore")

from transformers import Qwen2_5_VLForConditionalGeneration, AutoTokenizer, AutoProcessor
from qwen_vl_utils import process_vision_info

# default: Load the model on the available device(s)
# model = Qwen2VLForConditionalGeneration.from_pretrained(
#     "/", torch_dtype="auto", device_map="auto"
# )

# We recommend enabling flash_attention_2 for better acceleration and memory saving, especially in multi-image and video scenarios.
model = Qwen2_5_VLForConditionalGeneration.from_pretrained(
    "/",
    torch_dtype=torch.bfloat16,
    attn_implementation="flash_attention_2",
    device_map="auto",
)

# default processer
processor = AutoProcessor.from_pretrained("/", use_fast=True)


import json
from tqdm import tqdm 
from itertools import islice

# def write_jsonl(data_list, filename):
#     with open(filename, 'a', encoding='utf-8') as f:
#         for item in data_list:
#             json_str = json.dumps(item, ensure_ascii=False)  
#             f.write(json_str + '\n')
def write_jsonl(data, filename):
    with open(filename, 'a', encoding='utf-8') as f:  # 使用 'a' 模式，每次追加写入
        json_str = json.dumps(data, ensure_ascii=False)  
        f.write(json_str + '\n')

file_path = 'ORD.jsonl'
output_json = "ORD_answer.jsonl"


with open(file_path, 'r') as file:
    for line in tqdm(list(file), desc="Testing"):
        raw = {}

        data = json.loads(line.strip())
        
        query = data.get('query')
        response = data.get('response')
        image_path = data.get('image_path')
        

        messages = [
            {
                "role": "user",
                "content": [
                    {
                    "type": "image",
                    "image": image_path,
                    },
                    {
                    "type": "text", 
                    "text": query},
                ],
            }
        ]

        text = processor.apply_chat_template(
            messages, tokenize=False, add_generation_prompt=True
        )
        image_inputs, video_inputs = process_vision_info(messages)
        inputs = processor(
            text=[text],
            images=image_inputs,
            videos=video_inputs,
            padding=True,
            return_tensors="pt",
        )
        inputs = inputs.to("cuda")

        generated_ids = model.generate(**inputs, max_new_tokens=512, )
        generated_ids_trimmed = [
            out_ids[len(in_ids) :] for in_ids, out_ids in zip(inputs.input_ids, generated_ids)
        ]
        output_text = processor.batch_decode(
            generated_ids_trimmed, skip_special_tokens=True, clean_up_tokenization_spaces=False
        )
        raw['label'] = response
        raw['answer'] = output_text
        # json_data.append(raw)
        write_jsonl(raw, output_json)

print(f"数据已保存为 {output_json}")