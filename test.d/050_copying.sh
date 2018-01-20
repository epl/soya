#!/bin/bash
#
expected='---
brand: Hyundai
model: i30
year: 2018
engine:
  type: Nu
  capacity: 1.8
options:
  camera: true
  gps: false
extra:
  addons:
    camera: true
    gps: false'

actual=$("${SOYA}" -c extra.addons=options "${fixtures_dir}/car_base.yaml")
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with copying" 1>&2
  exit 1
fi

exit 0
