# Sepultura – Voice RAG 🎙️🤘

Nahraješ PDF dokumenty, položíš otázku a aplikace ti odpoví textem i hlasem (OpenAI TTS, 11 hlasů na výběr, odpověď jde stáhnout jako MP3).

Založeno na [Voice RAG with OpenAI SDK](https://github.com/Shubhamsaboo/awesome-llm-apps/tree/main/voice_ai_agents/voice_rag_openaisdk) z awesome-llm-apps.

## Jak to funguje
PDF → rozsekání na kousky → embeddingy (FastEmbed, běží lokálně) → uložení do Qdrantu → při dotazu se najdou nejrelevantnější kousky → GPT-4o napíše odpověď → druhý agent ji připraví pro mluvené slovo → `gpt-4o-mini-tts` ji přečte.

## 1. Klíče
**OpenAI API klíč** (placený, platí se za spotřebu – pro zkoušení stačí dobít 5 USD)
1. https://platform.openai.com → přihlas se
2. Settings → Billing → přidej kartu a dobij kredit
3. API keys → Create new secret key → zkopíruj (začíná `sk-`, ukáže se jen jednou)

**Qdrant Cloud** (vektorová databáze, free tier stačí)
1. https://cloud.qdrant.io → registrace
2. Create cluster → Free → region třeba Frankfurt
3. Zkopíruj **Cluster URL** a vytvoř **API key**

## 2. Spuštění
Potřebuješ Python 3.10+ (https://python.org).

```bash
git clone https://github.com/TomiHorvi1982/Sepultura.git
cd Sepultura
```

- **Mac:** `chmod +x start.sh && ./start.sh`
- **Windows:** dvojklik na `start.bat`

Při prvním spuštění se nainstalují knihovny a vytvoří se soubor `.env` – doplň do něj klíče a spusť znovu. Aplikace se otevře v prohlížeči na http://localhost:8501.

Klíče jdou zadat i ručně v levém panelu aplikace. Soubor `.env` je v `.gitignore`, na GitHub se nikdy nenahraje.

## Úpravy oproti originálu
- klíče se automaticky načtou ze `.env`
- doplněné chybějící knihovny (`pypdf`, `python-dotenv`, `sounddevice`, `numpy`), bez kterých nešlo nahrát PDF ani přehrát zvuk
- spouštěcí skripty pro Mac a Windows
