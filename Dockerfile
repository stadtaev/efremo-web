FROM node:latest AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY  . .
RUN npm run build --prod

FROM nginx:1.17.1-alpine
COPY --from=build /usr/src/app/dist/efremo /usr/share/nginx/html

