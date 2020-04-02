#!/bin/bash
# Ask the user for login details
dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -z "$BUCKET" ]
then
      echo "\$BUCKET is empty"
      exit 1
fi
if [ -z "$AWS_ACCESS_KEY_ID" ]
then
      echo "\$AWS_ACCESS_KEY_ID is empty"
      exit 1
fi
if [ -z "$AWS_SECRET_ACCESS_KEY" ]
then
      echo "\$AWS_SECRET_ACCESS_KEY is empty"
      exit 1
fi


echo

sed -i  "s user_access_key ${AWS_ACCESS_KEY_ID} g" ${dirname}/loris/s3resolver.py
sed -i  "s user_secret_key ${AWS_SECRET_ACCESS_KEY} g" ${dirname}/loris/s3resolver.py
sed -i  "s bucket_name ${BUCKET} g" ${dirname}/etc/loris.conf

python3.6 ${dirname}/loris/webapp.py