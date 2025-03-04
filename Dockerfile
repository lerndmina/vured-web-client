# Stage 1: Build the Angular application
FROM node:14 as build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the application with Nginx
FROM nginx:1.19.0-alpine as prod
COPY --from=build /app/dist/vured-web-client /usr/share/nginx/html
COPY ./nginx-custom.conf /etc/nginx/conf.d/default.conf
