#!/bin/bash
#

expected='{
  "options": {
    "gps": true
  }
}'
actual=$("${SOYA}" -t json -Doptions.gps=true)
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with boolean/true definition" 1>&2
  exit 1
fi

expected='{
  "options": {
    "gps": false
  }
}'
actual=$("${SOYA}" -t json -Doptions.gps=false)
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with boolean/false definition" 1>&2
  exit 1
fi

expected='{
  "options": {
    "baby_seat": 2
  }
}'
actual=$("${SOYA}" -t json -Doptions.baby_seat=2)
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with integers definition" 1>&2
  exit 1
fi

expected='{
  "odometer": 13631.2
}'
actual=$("${SOYA}" -t json -Dodometer=1.36312e4)
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with floats definition" 1>&2
  exit 1
fi

expected='{
  "product": {
    "description": "foo bar"
  }
}'
actual=$("${SOYA}" -t json -Dproduct.description="foo bar")
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with strings definition" 1>&2
  exit 1
fi

expected='{
  "cups": [
    1,
    "two"
  ]
}'
actual=$("${SOYA}" -t json '-Dcups=[1,"two"]')
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with array definition" 1>&2
  exit 1
fi

exit 0
