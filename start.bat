@echo off
REM Spusteni Voice RAG na Windows: dvojklik na start.bat
cd /d "%~dp0"

if not exist ".venv" (
  echo Prvni spusteni: vytvarim prostredi a instaluji knihovny...
  py -3 -m venv .venv || (echo Chybi Python 3 - nainstaluj ho z python.org & pause & exit /b 1)
  .venv\Scripts\python -m pip install --upgrade pip
  .venv\Scripts\pip install -r requirements.txt
)

if not exist ".env" (
  copy .env.example .env >nul
  echo Vytvoril jsem soubor .env - dopln do nej klice a spust znovu.
  notepad .env
  exit /b 0
)

.venv\Scripts\streamlit run rag_voice.py
pause
