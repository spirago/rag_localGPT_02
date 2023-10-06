# Start with a base image that has Conda installed.
FROM continuumio/miniconda3

# Update and install some basic packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    build-essential \
    software-properties-common \
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

# Install conda packages
RUN conda install -y -n privategpt pip
RUN pip install --upgrade pip

# Install pip packages
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Run python applications
COPY ingest.py constants.py ./

CMD ["conda", "run", "-n", "privategpt", "python", "ingest.py"]