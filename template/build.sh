#!/usr/bin/env bash

# set node path to v6.0
export PATH=/home/fis/node/v6/bin:$PATH;

npm install --production --registry=http://pnpm.baidu.com

rm -rf output

npm run build

APP_NAME="{{ name }}"

mkdir -p output/webroot/static/$APP_NAME
mkdir -p output/template/$APP_NAME

cp -r dist/template/* output/template/$APP_NAME
cp -r dist/static/* output/webroot/static/$APP_NAME

rm -rf dist

cd output

tar cvzf static-$APP_NAME.tar.gz webroot
tar cvzf $APP_NAME.tar.gz  template
rm -rf template webroot
