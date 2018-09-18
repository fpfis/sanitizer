FROM drupal:7-fpm-alpine

### Add required dependencies
RUN apk add --no-cache mysql mysql-client 

ADD my.cnf /etc/mysql/my.cnf

### Setup the default databases
RUN /usr/bin/mysql_install_db

ADD getcomposer.sh /tmp/

RUN /bin/sh /tmp/getcomposer.sh && composer global require drush/drush "~8" 

ADD init_db.sql /root/

ADD init.sh /tmp/

RUN /bin/sh /tmp/init.sh

ADD run.sh /

RUN chmod +x /run.sh

CMD /run.sh
