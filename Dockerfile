FROM nginx:1.15.8-alpine

EXPOSE 80
COPY ./ /usr/share/nginx/html
