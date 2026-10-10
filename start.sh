#!/bin/bash
# Spuštění Voice RAG na Macu: ./start.sh
cd "$(dirname "$0")"

# Najdi Python 3.10+ (předinstalovaný python3 v macOS bývá 3.9 = moc starý)
PY=""
for c in python3.13 python3.12 python3.11 python3.10 python3; do
  if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
    PY="$c"; break
  fi
done
if [ -z "$PY" ]; then
  echo "❌ Potřebuješ Python 3.10 nebo novější."
  echo "   Stáhni ho z https://www.python.org/downloads/macos/ , nainstaluj a spusť ./start.sh znovu."
  exit 1
fi

if [ ! -d ".venv" ]; then
  echo "🔧 První spuštění: vytvářím prostředí ($("$PY" --version)) a instaluji knihovny (pár minut)..."
  "$PY" -m venv .venv || exit 1
  .venv/bin/pip install --upgrade pip
  .venv/bin/pip install -r requirements.txt || { echo "❌ Instalace selhala – pošli Claudovi výpis výše."; exit 1; }
fi

if [ ! -f ".env" ]; then
  cp .env.example .env
  echo "📝 Vytvořil jsem soubor .env a otevírám ho v TextEditu."
  echo "   Vlož do něj své klíče, ulož (Cmd+S), zavři a spusť ./start.sh znovu."
  open -e .env 2>/dev/null
  exit 0
fi

echo "🎸 Spouštím aplikaci – otevře se v prohlížeči na http://localhost:8501"
echo "   Zastavíš ji v Terminálu klávesami Ctrl+C."
.venv/bin/streamlit run rag_voice.py
