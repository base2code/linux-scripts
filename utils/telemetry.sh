#!/bin/sh

# Basic telemtry script to report usage to me (base2code) to analyze
# demand for certain scripts / support for specific OS
#
# To disable telemtry run the following command
#          export DO_NOT_TRACK=1
#

donottrack=${DO_NOT_TRACK:-0}

if [[ $donottrack == "1" ]]; then
  echo "Do not track is activated. Do not report usage."
  exit 0
fi

scriptname=$1
release=$(lsb_release -a 2>&1)

TELEMETRY_BODY=$(jq --null-input \
  --arg script "$scriptname" \
  --arg release "$release" \
  '{"script": $script, "release": $release}')

#curl -X POST https://scripts.base2code.dev/telemetry -H "Content-Type: application/json" -d '$TELEMETRY_BODY' -m 5
curl -X POST 127.0.0.1:8787 -H "Content-Type: application/json" -d "${TELEMETRY_BODY}" -m 5
