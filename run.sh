#!/bin/sh

export PATH="$PATH:$HOME/.composer/vendor/bin"

/usr/bin/mysqld &
MYSQL_PID=$!

while [ ! -e /tmp/mysql.sock ]
do
  sleep 1
done

cd /var/www/html

for sql in $(ls /tmp/*sql)
do
    drush sql-drop --yes;
    drush sql-cli < $sql;
    drush sql-sanitize --yes;
    drush sql-dump > ${sql%.*}-sanitized.sql
done;

### To ensure no leftovers
kill $MYSQL_PID
