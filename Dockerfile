FROM nginx:latest
ADD . /app
COPY nginx.conf /etc/nginx/nginx.conf
COPY /etc/letsencrypt/live/thegagali.com/fullchain.pem /etc/nginx/certs/thegagali.pem
COPY /etc/letsencrypt/live/thegagali.com/privkey.pem /etc/nginx/certs/thegagali-key.pem
EXPOSE 443 80 587 25