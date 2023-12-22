FROM php:8.3-fpm

RUN apt-get update
# Install useful tools and libraries
RUN apt-get -y install libcurl4 libcurl4-openssl-dev mariadb-client libzip-dev  libicu-dev libonig-dev
RUN apt-get -y install apt-utils build-essential nano wget dialog git curl zip unzip
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN apt-get install -y nodejs npm

RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install sockets
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install opcache

RUN mkdir -p /usr/src/php/ext/apcu && curl -fsSL https://pecl.php.net/get/apcu | tar xvz -C "/usr/src/php/ext/apcu" --strip 1 && docker-php-ext-install apcu
RUN docker-php-ext-configure gd
RUN docker-php-ext-install -j$(nproc) gd

RUN pecl install ds \
    && docker-php-ext-enable ds \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && echo "apc.enable_cli=1" >> "$PHP_INI_DIR/php.ini" \
    && echo "apc.enable=1" >> "$PHP_INI_DIR/php.ini"

RUN mkdir -p /tmp/.opcache
RUN echo "opcache.enable=1;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.memory_consumption=64;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.interned_strings_buffer=8;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.max_accelerated_files=3000;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.revalidate_freq=180;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.fast_shutdown=0;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.enable_cli=0;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.revalidate_path=0;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.validate_timestamps=1;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.max_file_size=0;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.file_cache=/tmp/.opcache;" >> "$PHP_INI_DIR/php.ini" \
    && echo "opcache.file_cache_only=1;" >> "$PHP_INI_DIR/php.ini"

ARG WWWGROUP=1001
ARG WWWUSER=1000
RUN addgroup -gid 1001 www
RUN adduser -gid 1001 -uid 1000 sail
RUN mkdir /var/log/laravel
RUN touch /var/log/laravel/laravel.log
RUN chown -R sail /var/log/laravel

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
USER sail

WORKDIR /www
