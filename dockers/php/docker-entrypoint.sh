#!/bin/bash
if [ ! -f /var/www/app/composer.json ]
then
    # Create new symfony app and configure database_host
    symfony new /tmp/app "$SYMFONY_VERSION" \
        && cp -R /tmp/app /var/www \
        && sed -i "s/database_host:.*/database_host: mysqldb/g" /var/www/app/app/config/parameters.yml.dist \
        && sed -i "s/database_host:.*/database_host: mysqldb/g" /var/www/app/app/config/parameters.yml \
        && echo "New symfony app installed!"
    rm -rf /tmp/app
else
    echo "Symfony app is already here!"
fi

# xdebug config
if [ -f /usr/local/etc/php/conf.d/xdebug.ini ]
then
    # if XDEBUG_HOST is manually set
    HOST="$XDEBUG_HOST"

    # else if check if is Docker for Mac
    if [ -z "$HOST" ]; then
        HOST=`getent hosts docker.for.mac.localhost | awk '{ print $1 }'`
    fi

    # else get host ip
    if [ -z "$HOST" ]; then
        HOST=`/sbin/ip route|awk '/default/ { print $3 }'`
    fi

    sed -i "s/xdebug\.remote_host \=.*/xdebug\.remote_host\=$HOST/g" /usr/local/etc/php/conf.d/xdebug.ini
fi

# Fix cache/logs/session permission based on symfony version
# Symfony 3.x+
if [ -f bin/console ]; then
    chmod -R 777 var/cache var/logs var/sessions
else
#Symfony 2.x
    chmod -R 777 app/cache app/logs
fi

exec $@
