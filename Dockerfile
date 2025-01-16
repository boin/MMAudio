FROM python:3.12.8-alpine3.20

RUN apk update && apk add --no-cache tzdata && apk upgrade

WORKDIR /app

#mount requirements.txt for best cache result
RUN --mount=type=bind,source=pyproject.toml,target=./pyproject.toml \
    pip install --no-cache-dir -e . \
    pip install torchvision torchaudio

# 复制项目文件
COPY . .

# 设置默认命令
CMD ["python", "gradio_demo.py"]