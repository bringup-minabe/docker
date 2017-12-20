FROM centos:7

# linux date
RUN \cp -f /usr/share/zoneinfo/Japan /etc/localtime

# update yum
RUN yum update -y

# epel repo
RUN yum -y install epel-release

# remi repo
RUN yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# httpd
RUN yum install -y httpd

# php
RUN yum -y --enablerepo=epel,remi,remi-php72 install php php-cli php-common php-devel
RUN yum -y --enablerepo=epel,remi,remi-php72 install \ 
    php-mysql \
    php-mcrypt \
    php-mbstring \
    php-fpm \
    php-gd \
    php-intl \
    php-json \
    php-mysqlnd \
    php-pdo \
    php-pecl-imagick \
    php-pecl-imagick-devel \
    php-pecl-mysql \
    php-pecl-zip

# git
RUN yum -y install git

# node npm
RUN yum -y --enablerepo=epel install nodejs npm

# sudo 
RUN yum -y install sudo

RUN yum clean all

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# apache
RUN mkdir /etc/httpd/user_conf.d
RUN chmod 755 /etc/httpd/user_conf.d
RUN echo IncludeOptional user_conf.d/*.conf >> /etc/httpd/conf/httpd.conf
ADD user.conf /etc/httpd/user_conf.d/

# ADD php.ini and apache conf
ADD php/user.ini /etc/php.d/

# start service
ADD /shell/startService.sh /
RUN chmod 755 /startService.sh

EXPOSE 80 443

ENTRYPOINT ["/startService.sh"]

CMD ["/sbin/init"]
