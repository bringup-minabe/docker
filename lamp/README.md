# Docker LAMP

## 構成

* CentOS7
* Apache2
* PHP7.2
* git
* node
* npm
* composer

## PHPバージョン切り替え

    $ docker exec -it lamp_httpd_1 bash
    $ vi /etc/httpd/user_conf.d/user.conf

    SetHandler "proxy:fcgi://127.0.0.1:9072"
    の「90**」を希望バージョンに書き換え

    $ systemctl restart httpd