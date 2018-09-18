#!/bin/sh

export PATH="$PATH:$HOME/.composer/vendor/bin"

/usr/bin/mysqld &

while [ ! -e /tmp/mysql.sock ]
do
  sleep 1
done

mysql < /root/init_db.sql

cd /var/www/html/

drush site-install --db-url=mysql://root@localhost/drupal --yes

