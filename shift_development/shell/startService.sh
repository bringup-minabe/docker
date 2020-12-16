#!/bin/bash

systemctl start mysqld
sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS testdb;"

exec "$@"