#!/bin/bash
set -euo pipefail

echo "==> cloning/updating upstream repo..."
python3 updater.py

if [ ! -d bot-code ]; then
  echo "bot-code directory not found!"
  exit 1
fi

if [ -f bot-code/requirements.txt ]; then
  echo "==> installing/upgrading bot-code requirements..."
  python3 -m pip install --upgrade --no-cache-dir -r bot-code/requirements.txt
  echo "==> requirements install completed."
else
  echo "==> bot-code/requirements.txt not found — skipping install."
fi

echo "==> showing installed packages (top 40):"
python3 -m pip list --disable-pip-version-check | head -n 40

cd bot-code
python3 web.py &
exec python3 main.py
