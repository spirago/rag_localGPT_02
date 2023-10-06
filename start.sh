#!/bin/bash

echo "pod started"

if [[ $PUBLIC_KEY ]]
then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    cd ~/.ssh
    echo $PUBLIC_KEY >> authorized_keys
    chmod 700 -R ~/.ssh
    cd /
    service ssh start
fi

source /root/miniconda3/etc/profile.d/conda.sh  # Adjust this path based on where Miniconda is installed
conda activate privategpt
pip install peft

# Natural Language Processing
pip install langchain==0.0.267
pip install chromadb==0.4.6
pip install pdfminer.six==20221105
pip install InstructorEmbedding
pip install sentence-transformers
pip install faiss-cpu
pip install huggingface_hub
pip install transformers
pip install protobuf==3.20.0; sys_platform != 'darwin'
pip install protobuf==3.20.0; sys_platform == 'darwin' and platform_machine != 'arm64'
pip install protobuf==3.20.3; sys_platform == 'darwin' and platform_machine == 'arm64'
pip install auto-gptq==0.2.2
pip install docx2txt
pip install unstructured
pip install unstructured[pdf]

# Utilities
pip install urllib3==1.26.6
pip install accelerate
pip install bitsandbytes ; sys_platform != 'win32'
pip install bitsandbytes-windows ; sys_platform == 'win32'
pip install click
pip install flask
pip install requests

# Streamlit related
pip install streamlit
pip install Streamlit-extras

# Excel File Manipulation
pip install openpyxl

# python /ludwig_finetune.py
sleep infinity 