FROM nginx:latest
ADD . /app
COPY nginx.conf /etc/nginx/nginx.conf
COPY fullchain.pem /etc/nginx/certs/thegagali.pem
COPY privkey.pem /etc/nginx/certs/thegagali-key.pem
EXPOSE 443 80 587 25