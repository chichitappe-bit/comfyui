# ComfyUI
cd /workspace  # ou le dossier de travail dans le container
git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
python -m venv venv
source venv/bin/activate
pip install -U pip
pip install -r requirements.txt


# ComfyUI manager
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git ComfyUI-Manager

# Insightface
cd /workspace/ComfyUI
source venv/bin/activate
pip install insightface==0.7.3


# ComfyUI-KJNodes
cd /workspace/ComfyUI
source venv/bin/activate
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/kijai/ComfyUI-KJNodes.git
cd ComfyUI-KJNodes
pip install -r requirements.txt


# ComfyUI_IPAdapter_plus_V2
cd /workspace/ComfyUI
source venv/bin/activate
cd /workspace/ComfyUI/custom_nodes
git clone https://github.com/chflame163/ComfyUI_IPAdapter_plus_V2.git
cd ComfyUI_IPAdapter_plus_V2

cd /workspace/ComfyUI
source venv/bin/activate
pip install onnxruntime-gpu==1.19.2

