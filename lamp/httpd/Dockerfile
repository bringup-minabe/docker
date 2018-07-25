FROM centos:7

# linux date
RUN \cp -f /usr/share/zoneinfo/Japan /etc/localtime

# update yum
RUN yum update -y

# epel repo
RUN yum -y install epel-release

# remi repo
RUN yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install -y yum-utils
RUN yum-config-manager --enable remi

# httpd
RUN yum install -y httpd

# ssmtp mailutils
RUN yum install -y ssmtp mailutils

# php install ver 56, 70, 71, 72
# https://qiita.com/bezeklik/items/860ba080bf4c664cd8e9

RUN for v in 56 70 71 72 ; do yum -y install php$v php$v-php-{cli,common,devel,mysql,mcrypt,mbstring,fpm,gd,intl,json,mysqlnd,pdo,pecl-imagick,pecl-imagick-devel,pecl-mysql,pecl-zip,opcache,pecl-apcu,pecl-memcached,xml} ; done

RUN for v in 56 70 71 72 ; do yum -y install php$v-php-fpm ; done
RUN for v in 56 ; do sed -i '/pm = /s/dynamic/ondemand/' /opt/remi/php$v/root/etc/php-fpm.d/www.conf ; done
RUN for v in 70 71 72 ; do sed -i '/pm = /s/dynamic/ondemand/' /etc/opt/remi/php$v/php-fpm.d/www.conf ; done
RUN for v in 56 ; do sed -i "s/9000/90$v/" /opt/remi/php$v/root/etc/php-fpm.d/www.conf ; done
RUN for v in 70 71 72 ; do sed -i "s/9000/90$v/" /etc/opt/remi/php$v/php-fpm.d/www.conf ; done
RUN for v in 56 70 71 72 ; do systemctl start php$v-php-fpm ; systemctl enable php$v-php-fpm ; done

# modules
RUN yum -y install environment-modules

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
ADD user.conf /etc/httpd/user_conf.d/

# ADD php.ini and apache conf
ADD php/user.ini /etc/php.d/
ADD php/user.ini /etc/opt/remi/php72/php.d/
ADD php/user.ini /etc/opt/remi/php71/php.d/
ADD php/user.ini /etc/opt/remi/php70/php.d/
ADD php/user.ini /opt/remi/php56/root/etc/php.d/

# Change ssmtp.conf
RUN echo mailhub=smtp:1025 >> /etc/ssmtp/ssmtp.conf
RUN echo FromLineOverride=YES >> /etc/ssmtp/ssmtp.conf

# start service
ADD /shell/startService.sh /
RUN chmod 755 /startService.sh

EXPOSE 80 443

ENTRYPOINT ["/startService.sh"]

CMD ["/sbin/init"]
