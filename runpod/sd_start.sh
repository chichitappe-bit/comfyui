#!/bin/bash
fuser -k 3000/tcp
echo "🚀 Lancement de AUTOMATIC1111 (port 3000)..."

cd /workspace/stable-diffusion-webui || exit
#source sd_env/bin/activate

#nohup python launch.py --listen --port 3000 --skip-torch-cuda-test > nohup_sd.out 2>&1 &

#tail -f nohup_sd.out


python launch.py --listen --port 3000 --skip-torch-cuda-test 
