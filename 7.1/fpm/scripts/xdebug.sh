#!/usr/bin/env bash

if `ls /etc/php/7.1/fpm/conf.d | grep -q xdebug`
then
    phpdismod xdebug
    service php7.1-fpm reload
    echo "xdebug disabled"
else
    phpenmod xdebug
    service php7.1-fpm reload
    echo "xdebug enabled"
fi
