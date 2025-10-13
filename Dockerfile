FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build

FROM node:20-alpine AS final
WORKDIR /app
COPY --from=builder ./app/dist ./dist
COPY package.json .
# COPY .env .
COPY yarn.lock .
RUN yarn install --production
VOLUME ["/data"]
EXPOSE 8080
CMD [ "node", "dist/index.js" ]