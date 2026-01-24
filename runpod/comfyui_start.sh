#!/bin/bash
echo "🚀 Lancement de ComfyUI (port 3020)..."

cd /workspace/ComfyUI || exit
source venv/bin/activate

nohup python main.py --verbose --listen 0.0.0.0 --port 3020 > nohup_comfyui.out 2>&1 &

deactivate

tail -f nohup_comfyui.out
