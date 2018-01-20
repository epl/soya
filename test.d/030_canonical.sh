#!/bin/bash
#
expected=$(cat << _EOF_
---
brand: Hyundai
engine:
  capacity: 1.8
  type: Nu
model: i30
options:
  camera: true
  gps: false
service_history:
- cost: 0.0
  datetime: '2018-07-10T03:12:51Z'
  odometer: 2952
- cost: 199.95
  datetime: '2019-04-21T23:41:03Z'
  odometer: 10937
year: 2018

_EOF_
)
actual=$("${SOYA}" -C "${fixtures_dir}/car.yaml")
if [ "${actual}" != "${expected}" ]; then
  echo "error with simple merge" 1>&2
  exit 1
fi

exit 0
