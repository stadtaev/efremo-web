### STAGE 1: Build ###
FROM node:latest AS build
#USER node
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY  . .
RUN npm install -g @angular/cli@14.2.1
RUN npm run build --omit=dev
### STAGE 2: Run ###
FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
