#!/bin/bash
# Spuštění Voice RAG na Macu: ./start.sh
cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
  echo "První spuštění: vytvářím prostředí a instaluji knihovny (pár minut)..."
  python3 -m venv .venv || { echo "Chybí Python 3 – nainstaluj ho z python.org"; exit 1; }
  .venv/bin/pip install --upgrade pip
  .venv/bin/pip install -r requirements.txt
fi

if [ ! -f ".env" ]; then
  cp .env.example .env
  echo "Vytvořil jsem soubor .env – doplň do něj klíče a spusť znovu."
  open -e .env 2>/dev/null
  exit 0
fi

.venv/bin/streamlit run rag_voice.py
