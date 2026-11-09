FROM node:24-bookworm-slim

WORKDIR /app

COPY package*.json ./
RUN npm install --no-audit --no-fund

COPY . .
RUN npm run check && npm run build

ENV NODE_ENV=production
ENV WRANGLER_SEND_METRICS=false
ENV PORT=10000

RUN mkdir -p /data

EXPOSE 10000

CMD ["node", "scripts/render-entry.mjs"]
