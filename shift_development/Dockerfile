FROM centos:centos7

# update yum
RUN yum -y update

# install wget
RUN yum install -y wget

# install sudo
RUN yum install -y sudo

# install vim
RUN yum install -y vim

# install curl
RUN yum install -y curl

# install EPEL
RUN yum install -y epel-release

# install REMI
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

# install Apache
RUN sudo yum -y install httpd

# install ImageMagick
RUN yum install -y ImageMagick
RUN yum install -y ImageMagick-devel

# install php7.4
RUN yum remove -y php-*
# RUN yum -y --enablerepo=epel install libedit
RUN yum install -y --enablerepo=epel,remi,remi-safe,remi-php74 php
RUN yum install -y --enablerepo=epel,remi,remi-safe,remi-php74 php-common php-imagick php-pear php-bcmath php-bz2 php-cli php-common php-curl php-dba php-dev php-gd php-json php-mbstring php-mysql php-opcache php-readline php-soap php-xml php-xmlrpc php-zip php-intl

# install mysql
RUN yum localinstall -y http://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
RUN yum install -y mysql-community-server
COPY mysql/my.cnf /etc/

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"

# Add php.ini
ADD php/php.ini /etc/

# start service
ADD /shell/startService.sh /
RUN chmod 755 /startService.sh

# install openssl
RUN yum install -y zlib-devel perl-core make gcc
RUN curl https://www.openssl.org/source/openssl-1.1.1.tar.gz -o /usr/local/src/openssl-1.1.1.tar.gz
RUN tar xvzf /usr/local/src/openssl-1.1.1.tar.gz
RUN openssl-1.1.1/config --prefix=/usr/local/openssl-1.1.1 shared zlib
RUN cd openssl-1.1.1/
RUN make depend
RUN make
RUN make test
RUN make install
RUN echo /usr/local/openssl-1.1.1/lib > /etc/ld.so.conf.d/openssl-1.1.1.conf
RUN sudo ldconfig
RUN yum install -y openssl

ENTRYPOINT ["/startService.sh"]

CMD ["bash"]