FROM centos:7
MAINTAINER KAZUHISA MINABE


#
# 環境設定
#

# APP URL
ENV APP_URL example.com

# APP PATH
ENV APP_PATH_MASTER /var/www/html/master/
ENV APP_PATH_STAGING /var/www/html/staging/
ENV APP_PATH_DEVELOPMENT /var/www/html/development/


#
# 以下変更必要なし
#

# update yum
RUN yum update -y

# epel repo
RUN yum -y install epel-release

# remi repo
RUN yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# httpd
RUN yum install -y httpd

# php
RUN yum -y --enablerepo=epel,remi,remi-php70 install php php-cli php-common php-devel
RUN yum -y --enablerepo=epel,remi,remi-php70 install php-mysql php-mcrypt php-mbstring php-fpm php-gd php-intl php-json php-mysqlnd php-pdo php-pecl-imagick php-pecl-imagick-devel php-pecl-mysql php-pecl-zip

# git
RUN yum -y install git

# node npm
RUN yum -y --enablerepo=epel install nodejs npm

# sudo 
RUN yum -y install sudo

RUN yum clean all

# apache
RUN mkdir /etc/httpd/user_conf.d
RUN chmod 755 /etc/httpd/user_conf.d
RUN echo IncludeOptional user_conf.d/*.conf >> /etc/httpd/conf/httpd.conf

# ADD php.ini and apache conf and sudoers
ADD php/user.ini /etc/php.d/
ADD httpd/user.conf /etc/httpd/user_conf.d/
ADD /etc/sudoers.d/deployer /etc/sudoers.d/

# Configure apache
RUN adduser deployer
RUN chown -R deployer:deployer /var/www

# linux date
RUN \cp -f /usr/share/zoneinfo/Japan /etc/localtime

# deployer
RUN mkdir /home/deployer/.ssh
ADD /deployer/.ssh/config /home/deployer/.ssh/
RUN chown -R deployer:deployer /home/deployer/

# start service
ADD /shell/startService.sh /
RUN chmod 755 /startService.sh

EXPOSE 80 443

ENTRYPOINT ["/startService.sh"]

CMD ["/sbin/init"]