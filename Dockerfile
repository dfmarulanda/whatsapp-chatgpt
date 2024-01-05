FROM node:18-bullseye-slim

RUN apt update
# components for whatsapp-web.js (support no-gui systems)
RUN apt install -y gconf-service libgbm-dev libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget
RUN apt install -y chromium
RUN apt install -y ffmpeg
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*


# For transcription

## It will install latest model of OpenAI Whisper (around 6~7 GB)
## Uncomment below command if you want to use the local version of transcription module
# RUN pip install -y python pip
# RUN pip install -U openai-whisper

WORKDIR /app/

ENV OPENAI_API_KEY "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"
ENV PREFIX_ENABLED "false"

COPY package.json package-lock.json ./

RUN npm install
RUN npm install vite-node

COPY . .

CMD ["npm", "run", "start"]
