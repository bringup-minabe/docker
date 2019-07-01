#!/bin/bash

systemctl start httpd.service
systemctl enable httpd.service

module load php73

exec "$@"