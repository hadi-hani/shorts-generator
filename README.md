# 🎬 Shorts Generator

AI-powered Arabic YouTube Shorts generator — runs as a **single Docker container** (nginx + Node.js + ffmpeg).

## Features
- 🤖 Gemini AI generates Arabic script
- 🖼️ Pexels fetches background images
- 🔊 Google TTS generates Arabic voiceover
- 🎥 FFmpeg renders the final video with Ken Burns effect

## Stack
| Service | Role |
|---|---|
| nginx | Serves frontend + proxies `/api/` to Node |
| Node.js 20 | Backend API (Express) |
| ffmpeg | Video rendering |
| Supervisor | Manages both processes in one container |

## Quick Start

### Using Docker Hub
```bash
docker run -d \
  --name shorts-generator \
  --restart unless-stopped \
  -p 8282:80 \
  -e GEMINI_API_KEY=your_key \
  -e GOOGLE_TTS_KEY=your_key \
  -e PEXELS_API_KEY=your_key \
  hadihani/shorts-generator:latest
```
Open `http://localhost:8282`

### Build from source
```bash
git clone https://github.com/hadi-hani/shorts-generator
cd shorts-generator
docker build -t shorts-generator .
docker run -d --name shorts -p 8282:80 --env-file .env shorts-generator
```

## Environment Variables
| Variable | Description |
|---|---|
| `GEMINI_API_KEY` | Google Gemini API key |
| `GOOGLE_TTS_KEY` | Google Text-to-Speech API key |
| `PEXELS_API_KEY` | Pexels API key |

## API Endpoints
```
GET  /api/health          — Health check
POST /api/generate        — Start async job → returns jobId
GET  /api/status/:jobId   — Poll job status
POST /api/generate-sync   — Generate + download directly
```
