FROM ubuntu:16.04

MAINTAINER Vitalii Sydorenko <vetal.sydo@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_XDEBUG_REMOTE_AUTOSTART 1
ENV PHP_CLI_MEMORY_LIMIT 512M
ENV PHP_FPM_MEMORY_LIMIT 512M


# install dependency
RUN apt-get update \
    && apt-get install -y software-properties-common python-software-properties \
    && apt-get install -y language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php

# install packages
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    nano \
    tree \
    curl \
    apt-transport-https \
    wget \
    git \
    supervisor \
    acl \
    iproute2 \
    wkhtmltopdf \
    mongodb \
    php7.1-fpm php7.1-cli php7.1-common php7.1-curl php7.1-gd php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt \
    php7.1-mysql php7.1-opcache php7.1-pgsql php7.1-soap php7.1-sqlite3 php7.1-xml php7.1-xmlrpc php7.1-xsl php7.1-zip \
    php7.1-mongodb php7.1-redis php7.1-imap php7.1-memcached php7.1-xdebug php7.1-exif php7.1-readline php7.1-bcmath \
    # Install composer
    && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin \
    # clear apt cache and remove unnecessary packages
    && apt-get autoclean && apt-get -y autoremove


## PHP configuration
# bakup configurations
RUN cp /etc/php/7.1/fpm/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf.bak \
    && cp /etc/php/7.1/fpm/pool.d/www.conf /etc/php/7.1/fpm/pool.d/www.conf.bak \
    && cp /etc/php/7.1/fpm/php.ini /etc/php/7.1/fpm/php.ini.bak \
    && cp /etc/php/7.1/cli/php.ini /etc/php/7.1/cli/php.ini.bak
# copy new configurations
COPY config/php/fpm/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf
COPY config/php/fpm/pool.d/www.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY config/php/fpm/php.ini /etc/php/7.1/fpm/php.ini
COPY config/php/cli/php.ini /etc/php/7.1/cli/php.ini
COPY config/php/mods-available/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini
# php7.1-fpm will not start if this directory does not exist
RUN mkdir /run/php
# mods configuration
RUN phpdismod xdebug
RUN echo "export PHP_IDE_CONFIG=\"serverName=server\"" >> ~/.bashrc

WORKDIR /var/www

COPY scripts /var/scripts

RUN mv /var/scripts/xdebug.sh /usr/local/bin/xdebug
RUN chmod +x /usr/local/bin/xdebug

RUN mv /var/scripts/start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
CMD ["start.sh"]
