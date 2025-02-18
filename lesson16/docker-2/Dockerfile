FROM debian:11
RUN apt-get update && apt-get install -y nginx
RUN mkdir -p /opt/www
RUN echo '<html><body><h1>Hello Codeby-DevOps</h1></body></html>' > /opt/www/index.html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
