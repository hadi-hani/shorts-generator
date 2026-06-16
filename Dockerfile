# Stage 1: install node dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json .
RUN npm install --production

# Stage 2: final image
FROM node:20-alpine

# Install nginx, ffmpeg, supervisor, fonts
RUN apk add --no-cache nginx ffmpeg ttf-dejavu fontconfig supervisor && fc-cache -fv

WORKDIR /app

# Copy backend
COPY --from=deps /app/node_modules ./node_modules
COPY server.js .
COPY services/ ./services/
RUN mkdir -p output temp

# Copy frontend static files
COPY frontend/ /usr/share/nginx/html/

# Copy configs
COPY nginx.conf /etc/nginx/http.d/default.conf
COPY supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
