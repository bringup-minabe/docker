# Docker PHP7.0.17 Apache2

## 事前設定

    /apache2/example.com.conf

の「example.com」部分をサイトURLに変更

## Dockerfile

    ENV APP_URL example.com

の「example.com」部分をサイトURLに変更

    ENV APP_PATH /var/www/html

サイトファイルパスに変更があるようであれば変更