FROM pytorch/pytorch:2.5.1-cuda12.1-cudnn9-devel

ENV DEBIAN_FRONTEND=noninteractive
ENV PIP_NO_CACHE_DIR=1
ENV TZ=Asia/Shanghai
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir -e . \
    && pip install torchvision torchaudio \
    && pip install --no-cache-dir 'ttd_fastapi_utils>=0.2.4' --extra-index-url http://pypi-server/simple/ --trusted-host pypi-server

# Create gradio output directory to avoid FileNotFoundError
RUN mkdir -p /app/output/gradio

CMD ["python", "gradio_demo.py"]