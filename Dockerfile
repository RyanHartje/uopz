FROM php:7.2-cli

RUN mkdir -p /usr/local/src/uopz
COPY . /usr/local/src/uopz

WORKDIR /usr/local/src/uopz
RUN phpize && \
    ./configure && \
    make && \
    make test && \
    make install && \
    echo ";priority=5" > /usr/local/etc/php/conf.d/uopz.ini && \
    echo "extension=uopz.so" >> /usr/local/etc/php/conf.d/uopz.ini

CMD make test