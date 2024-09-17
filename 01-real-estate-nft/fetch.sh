#!/bin/bash

source .env
echo $PINATAJWT_TOKEN
# curl --request GET --url https://api.pinata.cloud/data/testAuthentication \
#   --header 'accept: application/json' \
#   --header "authorization: Bearer $PINATAJWT_TOKEN"

curl --request GET \
  --url https://api.pinata.cloud/data/pinList \
  --header "Authorization: Bearer $PINATAJWT_TOKEN"