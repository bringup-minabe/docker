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

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# Add php.ini
ADD php/php.ini /etc/

CMD ["/bin/bash"]