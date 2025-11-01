FROM node:18-alpine AS build

RUN apk add --no-cache libc6-compat python3 make g++

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps && \
    npm rebuild esbuild@0.21.5 --platform=linux --arch=x64 --force && \
    npm cache clean --force

COPY . .

# ✅ Build admin panel
RUN npm run build

FROM node:18-alpine

WORKDIR /app

COPY --from=build /app /app

RUN addgroup -g 1001 -S nodejs && adduser -S strapi -u 1001
RUN chown -R strapi:nodejs /app
USER strapi

EXPOSE 1337
ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=1337


CMD ["npm", "start"]
