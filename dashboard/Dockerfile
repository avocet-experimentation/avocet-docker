FROM node:20-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git \
    && git clone --depth=1 https://github.com/avocet-experimentation/dashboard.git . \
    && rm -rf package-lock.json \
    && npm cache clean --force \
    && npm install

COPY .env .env.local

RUN npx vite build

FROM nginx:alpine AS production

COPY --from=builder /app/dist /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 4173

CMD ["nginx", "-g", "daemon off;"]