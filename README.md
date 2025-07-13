# comfy
comfy




mkdir -p persistent/checkpoints persistent/vae persistent/controlnet persistent/output

docker build -t comfyui-all .


docker run --rm -p 7860:7860 comfyui-all --cpu
docker run --rm --gpus all -p 7860:7860 comfyui

docker run --rm -p 7861:7860 \
  -v "$PWD/persistent/checkpoints:/app/ComfyUI/models/checkpoints:Z" \
  -v "$PWD/persistent/output:/app/ComfyUI/output:Z" \
  comfyui-all --cpu


docker run --rm -p 7861:7860 -v "$PWD/persistent/checkpoints:/app/ComfyUI/models/checkpoints:Z" -v "$PWD/persistent/output:/app/ComfyUI/output:Z" comfyui-all --cpu
