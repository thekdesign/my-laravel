FROM richarvey/nginx-php-fpm

RUN rm index.php

RUN apk update && \
    apk add vim && \
    apk add npm && \
    apk add nodejs && \
    npm i -g npm && \
    npm i -g yarn && \
    composer global require hirak/prestissimo

ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf
ADD conf/nginx-site-ssl.conf /etc/nginx/sites-available/default-ssl.conf

RUN mkdir -p /var/www/html/app/public

ADD src/index.php /var/www/html/app/public

RUN chmod 755 /var/www/html/app

WORKDIR /var/www/html/app

EXPOSE 443 80