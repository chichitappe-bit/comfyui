# Checkpoints, loras, etc. StableDiffusion et ComfyUI
#./runpod.sh

# Décompresser les poses
# cd /workspace/runpod/poses
# unzip *.zip

apt update
apt install -y vim
apt install -y ffmpeg
apt install -y aria2
pip install fuser


# Copier les modèles ControlNet stable-diffusion vers ComfyUI
cp -n /workspace/stable-diffusion-webui/extensions/sd-webui-controlnet/models/* /workspace/ComfyUI/models/controlnet/
cp -n /workspace/runpod/start/custom_subject_filewords.txt /workspace/stable-diffusion-webui/textual_inversion_templates

# Nodes Comfyui
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/yuvraj108c/ComfyUI-Dwpose-Tensorrt
cd ./ComfyUI-Dwpose-Tensorrt
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
cd ComfyUI-VideoHelperSuite
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/Fannovel16/comfyui_controlnet_aux/
cd comfyui_controlnet_aux
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/chflame163/ComfyUI_IPAdapter_plus_V2.git

cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ComfyUI-Manager
pip install -r requirements.txt

cd /workspace/ComfyUI/custom_nodes
git clone https://huggingface.co/spaces/multimodalart/flux-style-shaping/blob/0004449185fdd0b4e94934f01f6bfc4e92ab7232/custom_nodes/ComfyUI-KJNodes
cd ComfyUI-KJNodes
pip install -r requirements.txt



# Inpaint anything
cd /workspace/stable-diffusion-webui/extensions/
git clone https://github.com/Uminosachi/sd-webui-inpaint-anything.git
cd sd-webui-inpaint-anything/models/sam
wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth
cd /workspace/stable-diffusion-webui/extensions/sd-webui-inpaint-anything
python launch.py

# Reactor
cd /workspace/stable-diffusion-webui/extensions/
git clone https://github.com/Gourieff/sd-webui-reactor-sfw
cd sd-webui-reactor-sfw/
pip install -r requirements.txt 




# Hunyuan
cd /workspace/ComfyUI/
git clone https://github.com/kijai/ComfyUI-HunyuanVideoWrapper.git
cd ComfyUI-HunyuanVideoWrapper
pip install -r requirements.txt
