#!/bin/bash
if [ ! -f /var/www/app/composer.json ]
then
    # Create new symfony app and configure database_host
    symfony new /tmp/app \
        && cp -R /tmp/app /var/www \
        && sed -i "s/database_host:.*/database_host: mysqldb/g" /var/www/app/app/config/parameters.yml.dist \
        && sed -i "s/database_host:.*/database_host: mysqldb/g" /var/www/app/app/config/parameters.yml \
        && echo "New symfony app installed!"
    rm -rf /tmp/app
else
    echo "Symfony app is already here!"
fi

# xdebug config
# sed -i "s/xdebug\.default_enable \=.*/xdebug\.default_enable\=$XDEBUG_ENABLED/g" /usr/local/etc/php/conf.d/xdebug.ini
sed -i "s/xdebug\.remote_host \=.*/xdebug\.remote_host\=$XDEBUG_HOST/g" /usr/local/etc/php/conf.d/xdebug.ini

# Fix cache permission
chmod -R 777 var/cache

exec $@