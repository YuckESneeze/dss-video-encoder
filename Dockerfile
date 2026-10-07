FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 https://github.com/bruvie-fr/roblox-video-player.git /opt/roblox-video-player

WORKDIR /opt/roblox-video-player/encoder

RUN pip install numpy pillow fastapi uvicorn pydantic yt-dlp

COPY videos /videos

# Your current DSS already asks for this exact Windows-looking path.
# Linux permits backslashes/colon in a filename, so create a symlink with
# that exact name so the current show mapping keeps working.
RUN ln -s /videos/GottaBeHalloween.mp4 'C:\DSS Videos\GottaBeHalloween.mp4' \
    && ln -s /videos/GottaBeHalloween.mp4 GottaBeHalloween.mp4

# Render supplies PORT automatically. Web services must listen on 0.0.0.0.
CMD ["sh", "-c", "python server.py --host 0.0.0.0 --port ${PORT:-10000} --max-seconds ${MAX_SECONDS:-1800}"]
