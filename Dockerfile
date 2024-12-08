# Use the official PyTorch runtime image with CUDA 12.4 and cuDNN 9
FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime

# Set environment variables to avoid Python bytecode generation and buffering issues
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install additional system dependencies for building Python packages and Visual Studio Code
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    wget \
    gpg \
    apt-transport-https \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container (if available locally)
COPY requirements.txt /app/requirements.txt

# Install Python dependencies using pip
RUN pip install --no-cache-dir -r /app/requirements.txt

# Install Jupyter and add a Python kernel
RUN pip install jupyter ipykernel && python -m ipykernel install --user

# Expose Visual Studio Code's default port
EXPOSE 8080

CMD ["/bin/bash"]