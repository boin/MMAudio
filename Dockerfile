FROM condaforge/miniforge3

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# 复制项目文件
COPY . .

# 创建并激活 conda 环境
RUN conda create -n mmaudio python=3.12 -y
SHELL ["conda", "run", "-n", "mmaudio", "/bin/bash", "-c"]

# 安装 PyTorch 和其他依赖
RUN pip install -e .
RUN pip install torchvision torchaudio


# 设置默认命令
CMD ["conda", "run", "-n", "mmaudio", "python", "gradio_demo.py"]
