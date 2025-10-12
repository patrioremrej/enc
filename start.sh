#!/bin/bash
set -e
python3 updater.py
if [ ! -d bot-code ]; then
  echo "bot-code directory not found!"
  exit 1
fi
cd bot-code
python3 web.py &
python3 main.py
