FROM --platform=linux/x86_64/v8 centos:7

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

# php install ver 56, 70, 71, 72, 73 74
# https://qiita.com/bezeklik/items/860ba080bf4c664cd8e9

RUN for v in 56 70 71 72 73 74 80 ; do yum -y install php$v php$v-php-{cli,common,devel,mysql,mcrypt,mbstring,fpm,gd,intl,json,mysqlnd,pdo,pecl-imagick,pecl-imagick-devel,pecl-mysql,pecl-zip,opcache,pecl-apcu,pecl-memcached,xml,pgsql} ; done

RUN for v in 56 70 71 72 73 74 80 ; do yum -y install php$v-php-fpm ; done
RUN for v in 56 ; do sed -i '/pm = /s/dynamic/ondemand/' /opt/remi/php$v/root/etc/php-fpm.d/www.conf ; done
RUN for v in 70 71 72 73 74 80 ; do sed -i '/pm = /s/dynamic/ondemand/' /etc/opt/remi/php$v/php-fpm.d/www.conf ; done
RUN for v in 56 ; do sed -i "s/9000/90$v/" /opt/remi/php$v/root/etc/php-fpm.d/www.conf ; done
RUN for v in 70 71 72 73 74 80 ; do sed -i "s/9000/90$v/" /etc/opt/remi/php$v/php-fpm.d/www.conf ; done
RUN for v in 56 70 71 72 73 74 80 ; do systemctl start php$v-php-fpm ; systemctl enable php$v-php-fpm ; done

# modules
RUN yum -y install environment-modules
RUN source /etc/profile.d/modules.sh

# git
RUN yum -y install git

# node npm
RUN yum -y --enablerepo=epel install nodejs npm

# n install
RUN npm install -g n

# unzip
RUN yum -y install unzip

# python 3.5
# RUN yum install -y https://centos7.iuscommunity.org/ius-release.rpm
# RUN yum install -y python35u python35u-libs python35u-devel python35u-pip
# RUN /bin/python3.5 -m pip install chardet
# RUN /bin/python3.5 -m pip install pandas
# RUN /bin/python3.5 -m pip install numpy==1.14.4

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
ADD php/user.ini /etc/opt/remi/php80/php.d/
ADD php/user.ini /etc/opt/remi/php74/php.d/
ADD php/user.ini /etc/opt/remi/php73/php.d/
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

EXPOSE 80 443 3000

ENTRYPOINT ["/startService.sh"]

CMD ["/sbin/init"]
