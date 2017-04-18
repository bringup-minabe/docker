# Docker CentOS7 Apache2 PHP7.0

## 事前設定

    /httpd/user.conf

の各値設定

## 環境変数
    
    #サイトURL
    ENV APP_URL example.com
    
    #環境毎PATH
    ENV APP_PATH_MASTER /var/www/html/master/
    ENV APP_PATH_STAGING /var/www/html/staging/
    ENV APP_PATH_DEVELOPMENT /var/www/html/development/

## Apache環境変数
    
    #CircleCi ymlで設定したsecret
    SetEnv CI_SECRET hoge

    #debugでdebugモード
    SetEnv CI_MODE normal

    #PULL対象ブランチ
    SetEnv CI_BRANCH_NAME master

    #CircleCi deploy log path
    SetEnv CI_LOG_PATH logs/

## Amazon ECS 使用時

### ES2

deployerユーザー追加 id1000指定

    $ adduser -u 1000 deployer
    $ groupmod -g 1000 deployer

マウントに必要な以下ディレクトリをES2側にも作成

    $ sudo mkdir /var/docker_volumes/www/

    $ sudo mkdir /var/docker_volumes/www/html

    $ sudo mkdir /var/docker_volumes/httpd/user_conf.d/

    $ sudo mkdir /var/docker_volumes/httpd/logs/

/home/deployer/.ssh にconfigと鍵を追加後、権限設定

    $ sudo chmod 600 /home/deployer/.ssh/keyファイル

/var/www/html/ に権限設定

    $ sudo chown -R deployer:deployer /var/docker_volumes/www/

### ECS

イメージOSがCenOSの場合はタスク定義（JSON）で「privileged」を「true」に設定

以下VOLUME設定、mountPoints設定

VOLUME

    /var/docker_volumes/www/

    /var/docker_volumes/httpd/user_conf.d/

    /var/docker_volumes/httpd/logs/

    /home/deployer/.ssh/

mountPoints

    /var/www/

    /etc/httpd/user_conf.d/

    /etc/httpd/logs/

    /home/deployer/.ssh/
