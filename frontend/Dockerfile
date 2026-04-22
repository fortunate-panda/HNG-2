# Stage 1: Build the React/Node app
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Serve it
FROM node:18-alpine
WORKDIR /app
# Node alpine images come with a 'node' user built-in
USER node 
# (You would copy the build output here and use a lightweight server like 'serve' or Nginx)
# ...
HEALTHCHECK --interval=30s --timeout=5s CMD wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1