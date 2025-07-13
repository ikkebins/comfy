FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Systempakete
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    libgl1 \
    mc \
    && rm -rf /var/lib/apt/lists/*

# ComfyUI + Manager klonen
RUN git clone https://github.com/comfyanonymous/ComfyUI
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager /app/ComfyUI/custom_nodes/comfyui-manager

# Venv & Python-Abhängigkeiten
RUN python -m venv /app/venv && \
    /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install \
        torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121 && \
    /app/venv/bin/pip install -r /app/ComfyUI/requirements.txt && \
    /app/venv/bin/pip install -r /app/ComfyUI/custom_nodes/comfyui-manager/requirements.txt

# Entrypoint-Skript
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponierter Port
EXPOSE 7860

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--preview-method", "auto", "--listen", "--port", "7860"]
