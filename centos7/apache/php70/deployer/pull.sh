#!/bin/sh

#git pull
cd {$APP_PATH_MASTER}
git pull origin master

#remove cache
rm -f {$APP_PATH_MASTER}app/tmp/cache/models/*
rm -f {$APP_PATH_MASTER}app/tmp/cache/persistent/*
rm -f {$APP_PATH_MASTER}app/tmp/cache/views/*