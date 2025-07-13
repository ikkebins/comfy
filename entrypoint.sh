#!/bin/bash
cd /app/ComfyUI
source /app/venv/bin/activate

# Deine festen Standard-Argumente
DEFAULT_ARGS="--preview-method auto --listen --port 7860"

echo "Starte ComfyUI mit: $DEFAULT_ARGS $@"
exec python main.py $DEFAULT_ARGS "$@"
