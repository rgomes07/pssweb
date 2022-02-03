
# Image  server web apache2, PHP 5.6
# Aplicação PSS
# Volume local on container

FROM debian:jessie 

RUN mkdir -p /usr/local/src/zend-loader-php5.6-linux-x86_64/
COPY /pacotes/zendGuardLoader.so /usr/local/src/zend-loader-php5.6-linux-x86_64/
COPY /pacotes/opcache.so /usr/local/src/zend-loader-php5.6-linux-x86_64/

RUN apt-get update && apt-get install -y apache2 \
apache2-doc \
apache2-utils \
php5 \
php5-gd \
php5-mysql \
libapache2-mod-php5 \
php5-cli \
php5-common \
php5-curl \
php5-dev \
php5-mcrypt \
php5-memcache \
php5-ldap \
php-pear \
libmcrypt-dev \
libmcrypt4 \
mcrypt \
php5-pgsql \
build-essential && apt-get clean ; a2enmod rewrite ; a2enmod php5

ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"

USER root 
WORKDIR /var/www/html/
COPY apache2.conf /etc/apache2/
COPY 000-default.conf /etc/apache2/sites-available/
COPY php.ini /etc/php5/apache2/
COPY info.php /var/www/html/
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

