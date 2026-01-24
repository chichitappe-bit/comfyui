apt update
#apt install python3.10 python3.10-venv git -y


cd /workspace
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

cd /workspace/stable-diffusion-webui
#python3.10 -m venv sd_env
#source sd_env/bin/activate
pip install --upgrade pip
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
pip install -r requirements.txt
pip install xformers==0.0.30

#deactivate

# Inpaint anything
cd /workspace/stable-diffusion-webui/extensions/
git clone https://github.com/Uminosachi/sd-webui-inpaint-anything.git
cd sd-webui-inpaint-anything/models/sam
wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth
cd /workspace/stable-diffusion-webui/extensions/sd-webui-inpaint-anything
python /workspace/stable-diffusion-webui/extensions/sd-webui-inpaint-anything/install.py

# ReActor
cd /workspace/stable-diffusion-webui/extensions/
git clone https://github.com/Gourieff/sd-webui-reactor-sfw
cd sd-webui-reactor-sfw/
pip install -r requirements.txt 
pip uninstall -y onnx opencv-python-headless numpy protobuf
pip install numpy==1.26.4 protobuf==3.20.3 onnx==1.14.1 opencv-python-headless==4.8.1.78
pip install albumentations==1.3.0
cp /workspace/runpod/start/reactor_sfw.py /workspace/stable-diffusion-webui/extensions/sd-webui-reactor-sfw/scripts

# Infinite image browsing
cd /workspace/stable-diffusion-webui/extensions
git clone https://github.com/zanllp/sd-webui-infinite-image-browsing.git
pip install -r ./sd-webui-infinite-image-browsing/requirements.txt
cp /workspace/runpod/start/env_infinite_image_browsing /workspace/stable-diffusion-webui/extensions/sd-webui-infinite-image-browsing/.env


# Canvas zoom
cd /workspace/stable-diffusion-webui/extensions
git clone https://github.com/richrobber2/canvas-zoom



# Modèle Juggernaut
echo "https://civitai.com/api/download/models/1759168?type=Model&format=SafeTensor&size=full&fp=fp16&token=__CIVITAI__,/workspace/stable-diffusion-webui/models/Stable-diffusion/juggernaut_xl.safetensors" > /workspace/runpod/start/downloads.csv
cd /workspace/runpod/start
./runpod.sh 44b7511be23bc7e52f8380e63401f682 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




# Styles
cp /workspace/runpod/start/styles.csv /workspace/stable-diffusion-webui/

