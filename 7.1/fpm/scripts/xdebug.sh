#!/usr/bin/env bash

if `ls /etc/php/7.1/fpm/conf.d | grep -q xdebug`
then
    phpdismod xdebug
    service php7.1-fpm reload
    echo "xdebug disabled"
else
    # Retrieve host ip
    if [ -z "$HOST_IP" ]; then
        # Allows to set HOST_IP by env variable because could be different from the one which come from ip route command
        HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')
    fi;

    sed -i "s/xdebug.remote_connect_back=.*/xdebug.remote_host=$HOST_IP/" /etc/php/7.1/mods-available/xdebug.ini

    phpenmod xdebug
    service php7.1-fpm reload
    echo "xdebug enabled"
fi
