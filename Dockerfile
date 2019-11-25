FROM php:5.6-apache
# https://github.com/docker-library/php/blob/f016f5dc420e7d360f7381eb014ac6697e247e11/5.6/apache/Dockerfile
# base es debian:jessie

LABEL maintainer=cesar.ballardini@gmail.com

COPY ./sources.list /etc/apt/sources.list
RUN echo 'Acquire::Check-Valid-Until no;' > /etc/apt/apt.conf.d/99no-check-valid-until ; \
    echo 'APT::Default-Release "jessie";' > /etc/apt/apt.conf.d/99default-release ; \
    apt-get update ; apt-get upgrade -y -t jessie --allow-downgrades

RUN apt-get install -y gnupg2 apt-transport-https --no-install-recommends

RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - ;\
    export VERSION=node_10.x ;\
    export DISTRO=jessie ; \
    echo "deb https://deb.nodesource.com/$VERSION $DISTRO main"      > /etc/apt/sources.list.d/nodesource.list ;\
    echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" >> /etc/apt/sources.list.d/nodesource.list ;\
    apt-get update

RUN apt-get install -y --allow-downgrades --no-install-suggests \
    curl wget libpng-dev libmcrypt-dev zlib1g-dev zlib1g/jessie \
    libicu-dev zip unzip freetype* nodejs libfontconfig1 libxrender1 libxext6 git 

RUN apt-get install -y --allow-downgrades --no-install-suggests \
    libmemcached-dev libsasl2-dev libsasl2-2/jessie 

RUN apt-get install -y --allow-downgrades --no-install-suggests \
    libc-client-dev libkrb5-dev libpq-dev libxml2-dev libxslt-dev  libxml2 libkrb5-dev \
    comerr-dev/jessie krb5-multidev/jessie libpam0g-dev/jessie libxml2/jessie

# imagick
RUN apt-get install -y --allow-downgrades --no-install-recommends \
      libmagickwand-dev libmagickwand-6.q16-dev/jessie libmagickcore-6.q16-dev/jessie \
      libbz2-dev/jessie libgraphviz-dev/jessie librsvg2-dev/jessie libtiff-dev \
      libexpat1-dev/jessie libglib2.0-dev/jessie libpcre3-dev/jessie liblzma-dev/jessie \
      liblzma5/jessie pkg-config/jessie
RUN apt-get install -y --allow-downgrades --no-install-recommends \
      libcurl3 xz-utils
RUN pecl install imagick

RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-freetype-dir=/usr/include/freetype2 \
    --with-png-dir=/usr/include \
    --with-jpeg-dir=/usr/include

RUN docker-php-ext-install mysqli mysql \
    calendar exif gd bcmath mcrypt \
    pcntl pdo_mysql intl \
    pdo_pgsql pgsql soap sockets zip xsl

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap
RUN pecl install memcached-2.2.0 ; pecl install memcache ; pecl install xdebug-2.5.5 ; pecl install apcu-4.0.11
RUN apt-get install -y --allow-downgrades --no-install-recommends \
    curl
RUN ( curl -s https://getcomposer.org/installer | php ) && mv composer.phar /usr/local/bin/composer

RUN apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Recreate user with correct params
RUN groupmod -g 1000 www-data && \
    usermod  -u 1000 www-data

# Symfony 1
COPY ./symfony /var/www/symfony

# Symfony 3
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony

# PDF
COPY ./wkhtmltox /opt/wkhtmltox/bin

WORKDIR /var/www/localhost/htdocs
