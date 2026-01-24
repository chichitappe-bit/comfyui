#!/bin/bash
cd /workspace/kohya_ss || exit

source kohya_ss_env/bin/activate

python -m pip install --upgrade pip
pip install -r requirements_linux.txt

apt-get update
apt-get install -y python3-tk
pip install easygui==0.98.3


nohup python kohya_gui.py --listen 0.0.0.0 --server_port 3051 --headless > nohup_kohya.out 2>&1 &


echo "🚀 Kohya_ss lancé sur le port 3051 !"

tail -f nohup_kohya.out
