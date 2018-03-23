#!/bin/bash

systemctl start httpd.service
systemctl enable httpd.service

module load php72

exec "$@"