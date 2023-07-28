#!/bin/bash
#Check if your ISP implements BGP securly

VALID_URL=https://valid.rpki.isbgpsafeyet.com
INVALID_URL=https://invalid.rpki.isbgpsafeyet.com
TIMEOUT=10

echo "Checking connections..."

curl --connect-timeout $TIMEOUT -s $VALID_URL > /dev/null
response_valid=$?

curl --connect-timeout $TIMEOUT -s $INVALID_URL > /dev/null
response_invalid=$?

if [ $response_valid -ne 0 ]; then
  echo "Valid check could not be performed. Cannot provide answer."
  exit 1
fi

if [[ $response_valid -eq 0 && $response_invalid -ne 0 ]]; then
  echo "Your ISP implements BGP safely."
  exit 0
fi

if [[ $response_valid -eq 0 && $response_invalid -eq 0 ]]; then
  echo "Your ISP does not implement BGP safely. Find out more: https://isbgpsafeyet.com/"
  exit 0
fi

