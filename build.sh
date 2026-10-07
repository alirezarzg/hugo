#!/bin/sh
set -eu
rm -rf public
hugo --gc --minify "$@"
cp -R root/. public/
cp -R public/blog/support public/support
