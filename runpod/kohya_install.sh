cd /workspace
git clone https://github.com/bmaltais/kohya_ss.git
cd /workspace/kohya_ss
git clone https://github.com/kohya-ss/sd-scripts.git

python3 -m venv kohya_ss_env
source kohya_ss_env/bin/activate
pip install --upgrade pip
pip install -r requirements_linux.txt

cd /workspace/kohya_ss/sd_scripts
pip install -r requirements.txt
pip install --upgrade huggingface-hub


deactivate


apt-get update
apt-get install -y python3-tk



