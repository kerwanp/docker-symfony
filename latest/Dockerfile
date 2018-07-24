FROM php:7.2-fpm

MAINTAINER Martin PAUCOT <contact@martin-paucot.fr>

#<<<
# INSTALLING DEPENDENCIES
#<<<
RUN pecl install \
        xdebug
RUN docker-php-ext-install \
        pdo \
        pdo_mysql

#<<<
# SETTING UP XDEBUG
#<<<
ENV XDEBUG_CONFIG remote_host=172.17.0.1
RUN echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

#<<<
# INSTALLING COMPOSER
#<<<
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/tmp/.composer
COPY --from=composer:1.6 /usr/bin/composer /usr/bin/composer

#<<<
# SETTING UP ENTRYPOINT
#<<<
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["php-fpm"]