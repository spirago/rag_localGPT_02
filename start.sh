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

source ~/.bashrc  # Adjust this path based on where Miniconda is installed
conda activate privategpt
python /ingest.py --device_type cpu
sleep infinity