FROM ubuntu:18.04

RUN mkdir -p /usr/local/src/uopz
COPY . /usr/local/src/uopz

WORKDIR /usr/local/src/uopz
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y gdb \
        vim \
        gcc \
        wget \
        php7.2-dev && \
    wget http://launchpadlibrarian.net/388242196/php7.2-cli-dbgsym_7.2.10-0ubuntu0.18.04.1_amd64.ddeb && \
    dpkg -i ./php7.2-cli-dbgsym_7.2.10-0ubuntu0.18.04.1_amd64.ddeb && \
    sed -i 's|ptrace_scope = 1|ptrace_scope = 0|g' /etc/sysctl.d/10-ptrace.conf && \
    phpize && \
    ./configure --enable-debug && \
    make && \
    make test && \
    make install && \
    echo ";priority=5" > /etc/php/7.2/mods-available/uopz.ini && \
    echo "extension=uopz.so" >> /etc/php/7.2/mods-available/uopz.ini && \
    cp /etc/php/7.2/mods-available/uopz.ini /etc/php/7.2/cli/conf.d/

CMD sleep 3600
