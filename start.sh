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
conda init bash
echo "conda activate privategpt" >> ~/.bashrc
source /root/.bashrc
# python /ludwig_finetune.py
echo "Start script(s) finished, pod is ready to use."
sleep infinity