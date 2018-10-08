FROM php:7.2-cli

RUN mkdir -p /usr/local/src/uopz
COPY . /usr/local/src/uopz

WORKDIR /usr/local/src/uopz
RUN apt update && \
    apt install -y gdb \
        vim && \
    phpize && \
    ./configure && \
    make && \
    make test && \
    make install && \
    echo ";priority=5" > /usr/local/etc/php/conf.d/uopz.ini && \
    echo "extension=uopz.so" >> /usr/local/etc/php/conf.d/uopz.ini && \
    pecl install xdebug-2.6.0 && \
    echo "extension=xdebug.so" ?> /usr/local/etc/php/php.ini-production && \
    mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

CMD sleep 3600
