# Start with a base image that has Conda installed.
FROM continuumio/miniconda3

# Update and install some basic packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    mercurial \
    subversion
    
# Update Conda
RUN conda update conda

# Create a new Conda environment
RUN conda create -y --name privategpt python=3.10

# Initialize Conda for shell interaction
RUN conda init bash

# Activate the Conda environment in the same shell
SHELL ["conda", "run", "-n", "privategpt", "/bin/bash", "-c"]

# Install your packages
RUN conda install -y -n privategpt pip
RUN pip install --upgrade pip

# Run your application
# CMD ["conda", "run", "-n", "privategpt", "python", "your_script.py"]