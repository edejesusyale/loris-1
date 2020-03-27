#!/bin/bash
# Ask the user for login details
dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -p 'accesskey: ' accesskey
read -p 'secretkey: ' secretkey
echo

sed -i  "s user_access_key ${accesskey}/g" ${dirname}/loris/s3resolver.py
sed -i  "s user_secret_key ${secretkey}/g" ${dirname}/loris/s3resolver.py

python3.6 ${dirname}/loris/webapp.py