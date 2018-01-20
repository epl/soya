#!/bin/bash
#
expected=$(cat << _EOF_
---
brand: test brand remove before commit
model: i30
year: 2018
engine:
  type: Nu
  capacity: 1.8
options:
  camera: true
  gps: false
service_history:
- datetime: '2018-07-10T03:12:51Z'
  cost: 0.0
  odometer: 2952
- datetime: '2019-04-21T23:41:03Z'
  cost: 199.95
  odometer: 10937
_EOF_
)
actual=$("${SOYA}" "${fixtures_dir}/car_base.yaml" "${fixtures_dir}/car_service_history.yaml")
if [ "${actual}" != "${expected}" ]; then
  echo "error with simple merge" 1>&2
  exit 1
fi

expected='soya: duplicate scalar values (path: .brand): "test brand remove before commit" replacing "Hyundai"'
actual=$("${SOYA}" -s "${fixtures_dir}/car_base.yaml" "${fixtures_dir}/car_service_history.yaml" 2>&1)
if [ "${actual}" != "${expected}" ]; then
  echo "error with strict mode merge" 1>&2
  exit 1
fi

exit 0
