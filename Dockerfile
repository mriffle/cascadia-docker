# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Avoid timezone prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables for Matplotlib and Fontconfig
ENV MPLCONFIGDIR=/tmp/matplotlib_cache
ENV HOME=/tmp/home

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    libxrender1 \
    libxext6 \
    libx11-6 \
    libexpat1 \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/conda \
    && rm miniconda.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate cascadia_env" >> ~/.bashrc

# Add conda to path
ENV PATH=/opt/conda/bin:$PATH

# Create conda environment and install cascadia
RUN conda create -n cascadia_env python=3.10 -y

SHELL ["/bin/bash", "--login", "-c"]

RUN conda activate cascadia_env \
    && pip install cascadia

# Add the checkpoint file (cascadia weights)
COPY cascadia.ckpt /usr/local/bin/

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
