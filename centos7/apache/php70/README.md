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

### ECS

* イメージOSがCenOSの場合はタスク定義（JSON）で「privileged」を「true」に設定

* 以下VOLUME設定、マウント設定

    /var/www/html

    /etc/httpd/user_conf.d/

### ES2

* マウントに必要な以下ディレクトリをES2側にも作成

     /var/www/html

     /etc/httpd/user_conf.d/