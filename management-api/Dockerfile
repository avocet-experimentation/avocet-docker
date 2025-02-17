FROM node:20-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git

RUN git clone --depth=1 https://github.com/avocet-experimentation/management-api . \
    && rm -rf package-lock.json \
    && npm cache clean --force \
    && npm install

COPY .env .env

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /app

COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./

RUN npm ci --only=production

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/.env ./.env

USER node

CMD ["npm", "run", "start"]