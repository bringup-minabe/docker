FROM php:7.0.17-apache

#
# 環境設定
#

# APP URL
ENV APP_URL example.com

# APP PATH
ENV APP_PATH /var/www/html

#
# 以下変更必要なし
#

# apt-get annd PHP modules install
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ vim wget git \
        libmagickwand-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql mysqli mbstring mcrypt

# ADD php.ini and apache conf
ADD php/php.ini /usr/local/etc/php/
ADD apache2/example.com.conf /etc/apache2/sites-available/

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN a2ensite ${APP_URL}

# RUN service apache2 reload

# ImageMagick
# RUN apt-get install imagemagick
# RUN pecl install imagick-beta

RUN mkdir /var/log/php/

EXPOSE 80 443

#VOLUME /Applications/MAMP/htdocs/docker/htdocs:/var/www/html