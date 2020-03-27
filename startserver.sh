#!/bin/bash
# Ask the user for login details
dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -p 'accesskey: ' accesskey
read -p 'secretkey: ' secretkey
echo

awk '{gsub("user_secret_key_key", "${secretkey}", $0); print}'
awk '{gsub("user_access_key", "${accesskey}", $0); print}' ${dirname}/loris/s3resolver.py
awk '{gsub("user_secret_key_key", "${secretkey}", $0); print}' ${dirname}/loris/s3resolver.py
python3.6 ${dirname}/loris/webapp.py