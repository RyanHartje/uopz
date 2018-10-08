FROM ubuntu:18.04

RUN mkdir -p /usr/local/src/uopz
COPY . /usr/local/src/uopz

WORKDIR /usr/local/src/uopz
RUN apt update && \
    apt install -y gdb \
        vim \
        ascii \
        gpg \
        gcc \
        software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y php7.2 \
        php7.2-dev \
        php7.2-phpdbg && \
    phpize && \
    ./configure && \
    make && \
    make test && \
    make install && \
    echo ";priority=5" > /etc/php/7.2/mods-available/uopz.ini && \
    echo "extension=uopz.so" >> /etc/php/7.2/mods-available/uopz.ini && \
    pecl install xdebug-2.6.0 && \
    echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20170718/xdebug.so" >> /etc/php/7.2/cli/php.ini

CMD sleep 3600
