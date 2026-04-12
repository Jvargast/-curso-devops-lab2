FROM node:24 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:24-alpine

WORKDIR /usr/app

COPY --from=build /app/dist /usr/app/dist
COPY --from=build /app/package*.json /usr/app/

RUN npm install --omit=dev

EXPOSE 3000

CMD ["node", "dist/main.js"]