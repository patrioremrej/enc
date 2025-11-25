#!/bin/bash
set -euo pipefail

if [ -f requirements.txt ]; then
  python3 -m pip install --upgrade pip
  python3 -m pip install --no-cache-dir -r requirements.txt
fi

python3 updater.py

if [ ! -d bot-code ]; then
  echo "bot-code directory not found!"
  exit 1
fi

UPDATE_PKGS="${UPDATE_PKGS:-True}"
case "${UPDATE_PKGS,,}" in
  1|true|yes|y)
    if [ -f bot-code/requirements.txt ]; then
      echo "==> installing/upgrading bot-code requirements..."
      python3 -m pip install --upgrade pip
      python3 -m pip install --no-cache-dir -r bot-code/requirements.txt
      echo "==> requirements install completed."
    else
      echo "==> bot-code/requirements.txt not found — skipping install."
    fi
    ;;
  *)
    echo "==> UPDATE_PKGS is false — skipping bot-code requirements install."
    ;;
esac

echo "==> showing installed packages (top 40):"
python3 -m pip list --disable-pip-version-check | head -n 40

cd bot-code
if [ -f web.py ]; then
  python3 web.py &
fi

exec python3 main.py
