# Start with a base image that has Conda installed.
FROM continuumio/miniconda3

# Update and install some basic packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    build-essential \
    openssl \
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

RUN conda create -n privategpt python=3.10
RUN echo "source activate privategpt" > ~/.bashrc
ENV PATH="/root/miniconda3/bin:$PATH"

# Initialize Conda for shell interaction
RUN conda init bash

# Activate the Conda environment in the same shell
SHELL ["conda", "run", "-n", "privategpt", "/bin/bash", "-c"]

# Install conda packages
RUN conda install -n privategpt pip
RUN pip install --upgrade pip

# Install pip packages
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Run python applications
COPY SOURCE_DOCUMENTS ./SOURCE_DOCUMENTS
COPY ingest.py constants.py run_localGPT.py ./

# # Set the default environment to privategpt when starting the container
ENV CONDA_DEFAULT_ENV=privategpt

# # # Set working directory
WORKDIR /

# conda init bash
# source ~/.bashrc
# conda activate ludwig

# # # The command that will be run when the container starts
ADD start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]

# CMD ["conda", "run", "-n", "privategpt", "python", "ingest.py"]