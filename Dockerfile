FROM nginx:alpine
ADD index.htm /usr/share/nginx/html/index.html
EXPOSE 80