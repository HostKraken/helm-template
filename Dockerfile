FROM registry.digitalocean.com/business-business/wordpress-base:latest
COPY wordpress/ /code
COPY database/ /database
EXPOSE 80

ENTRYPOINT /run.sh
