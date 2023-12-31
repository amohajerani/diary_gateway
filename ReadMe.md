# diary_gateway


Running flask with NGINX on docker:
https://www.youtube.com/watch?v=cjFjDXkfs6M&ab_channel=SriwWorldofCoding
https://www.youtube.com/watch?v=7isa-1VC6pY&ab_channel=AntonPutra

On AWS:

- Create ububtu instance
- Add an inbound route to port 8000
- open the terminal
- sudo apt update
- sudo apt-get install docker.io
- sudo apt install docker-compose
- [optional] sudo docker-compose up -d
- vim ssl_ke.pem and then copy and paste the content
- vim ssl_privat_ke.pem and then copy and paste the content
- sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
- curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
- echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

for setting up clientcredential for google, follow this demo: https://www.youtube.com/watch?v=Z5fjBLbVF2w&ab_channel=Webarchersofficial


Now you have the instance ready, let's run the docker container
- cd diary_gateway
- git pull
- sudo docker build -t nginx .
- sudo docker run --name nginx --restart always -d -p 80:80 -p 443:443 nginx
For any updates, start by 
- sudo docker stop nginx
- sudo docker rm nginx

## SSL certificate expiry
First, stop the docker container, if running.
When you go to the application, you may get SSL error. In this situation, follow the guide: https://dev.to/shadid12/how-to-deploy-your-node-js-app-on-aws-with-nginx-and-ssl-3p5l

In this guide, the steps are:
- sudo add-apt-repository ppa:certbot/certbot
- sudo apt-get install python3-certbot-nginx
- sudo certbot --nginx -d thegagali.com -d www.thegagali.com

If you get an error, indicating Certbot MisconfigurationError: nginx restart failed, try: 
https://stackoverflow.com/questions/55698042/certbot-misconfigurationerror-nginx-restart-failed

UPDATE:
when i added provider subdomain, I did the following:
sudo certbot certonly -d thegagali.com -d *.thegagali.com --manual --preferred-challenges=dns


In the log, it shows you where the certificates are built:
- Certificate is saved at: /etc/letsencrypt/live/thegagali.com/fullchain.pem
- Key is saved at:         /etc/letsencrypt/live/thegagali.com/privkey.pem

Move these files:
cd diary_gateway
sudo cp /etc/letsencrypt/live/thegagali.com-0001/fullchain.pem .
sudo cp /etc/letsencrypt/live/thegagali.com-0001/privkey.pem .

and make sure the dockerfile refers to the correct location.

