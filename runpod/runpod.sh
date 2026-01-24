#!/usr/bin/env bash

pip install aria2

# =========================================
# Paramètres
# =========================================
CSV_FILE="downloads.csv"
REFRESH=2

# =========================================
# Option DELETE
# =========================================
if [[ "$1" == "-delete" ]]; then
    echo "🗑️ Suppression des fichiers listés dans $CSV_FILE…"
    while IFS=',' read -r url dest extra; do
        [[ -z "$url" || "$url" =~ ^# ]] && continue
        dest="${dest#__HF__}"
        dest="${dest#__CIVITAI__}"
        [[ -f "$dest" ]] && rm -f "$dest" && echo "✅ Supprimé : $dest"
    done < "$CSV_FILE"
    echo "✅ Tous les fichiers listés ont été supprimés."
    exit 0
fi

# =========================================
# Vérification des tokens
# =========================================
if [[ $# -ne 2 ]]; then
    echo "Usage : $0 <token_civitai> <token_hf>"
    echo "Recuperer un token CIVITAI : https://civitai.com/user/account"
    echo "Recuperer un token HF : https://huggingface.co/settings/tokens - chichitappe@gmail.com / °8D0UW-ù_kbLs\d3"
    echo "./runpod -delete : suppression des fichiers"
   exit 1
fi

TOKEN_CIVITAI="$1"
TOKEN_HF="$2"

command -v aria2c >/dev/null 2>&1 || { echo "❌ aria2c n'est pas installé."; exit 1; }

ALL_FILES=()
PIDS=()

# =========================================
# Lecture CSV et lancement des téléchargements (parallèle fiable)
# =========================================
while IFS=',' read -r url dest extra; do
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    IFS=',' read -r -a extra_cols <<< "$extra"

    # Remplacer les placeholders
    url="${url/__CIVITAI__/$TOKEN_CIVITAI}"
    url="${url/__HF__/$TOKEN_HF}"

    folder=$(dirname "$dest")
    base=$(basename "$dest")
    mkdir -p "$folder"

    echo "⬇️ Téléchargement lancé : $dest"

    # aria2c single-stream pour fiabilité, en arrière-plan
    aria2c -c -x 1 -s 1 --file-allocation=none \
      -d "$folder" -o "$base" "$url" > "$folder/$base.log" 2>&1 &

    PIDS+=($!)
    ALL_FILES+=("$dest")
done < "$CSV_FILE"

# =========================================
# Watch intégré pour suivi
# =========================================
(
  while true; do
    clear
    echo "📡 Suivi des téléchargements (rafraîchi toutes les ${REFRESH}s)"
    for f in "${ALL_FILES[@]}"; do
      if [[ -f "$f" ]]; then
        size=$(stat -c%s "$f" 2>/dev/null)
        size_human=$(numfmt --to=iec $size)
        echo "⬆️ $f ($size_human)"
      else
        echo "… $f (en cours / en attente)"
      fi
    done
    sleep $REFRESH
  done
) &
WATCH_PID=$!
trap 'kill $WATCH_PID 2>/dev/null' EXIT

# =========================================
# Attente de fin de tous les téléchargements
# =========================================
for pid in "${PIDS[@]}"; do
    wait "$pid" 2>/dev/null || true
done

kill $WATCH_PID 2>/dev/null
trap - EXIT

# =========================================
# Résumé final
# =========================================
echo "✅ Tous les téléchargements sont terminés."
echo "📂 Fichiers téléchargés :"
for f in "${ALL_FILES[@]}"; do
    if [[ -f "$f" ]]; then
        size=$(stat -c%s "$f")
        size_human=$(numfmt --to=iec $size)
        echo "✅ $f ($size_human)"
    else
        echo "❌ $f (non téléchargé)"
    fi
done
