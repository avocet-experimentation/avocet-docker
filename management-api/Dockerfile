FROM node:20-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git \
    && git clone --depth=1 https://github.com/avocet-experimentation/management-api.git . \
    && npm ci

COPY .env .env

RUN npm run build

FROM node:20-alpine AS production

WORKDIR /app

# We need all packages (including dev) in order to run the MongoDB initialization files
COPY --from=builder /app/node_modules ./node_modules

COPY --from=builder /app/package.json ./
COPY --from=builder /app/package-lock.json ./
COPY --from=builder /app/tsconfig.json ./

COPY --from=builder /app/src ./src
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/.env ./.env

COPY --from=builder /app/mongodb/initialize-mongo-indexes.ts ./mongodb/
COPY --from=builder /app/mongodb/insert-initial-data.ts ./mongodb/

USER node

CMD ["npm", "run", "start"]