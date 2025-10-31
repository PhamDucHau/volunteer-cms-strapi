FROM node:20-alpine AS build

WORKDIR /srv/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm install esbuild@0.25.11 && npm rebuild esbuild && npm cache clean --force
RUN npm run build

# Production
FROM node:20-alpine

WORKDIR /srv/app

# Copy tất cả từ build stage
COPY --from=build /srv/app ./

EXPOSE 1337
ENV NODE_ENV=production

CMD ["npm", "start"]