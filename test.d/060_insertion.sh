#!/bin/bash
#

expected='---
lee:
  alice:
    brand: Hyundai
    model: i30
    year: 2018
    engine:
      type: Nu
      capacity: 1.8
    options:
      camera: true
      gps: false'

actual=$("${SOYA}" -i lee.alice "${fixtures_dir}/car_base.yaml")
if [ "${actual}" !=  "${expected}" ]; then
  echo "error with insertion" 1>&2
  exit 1
fi

exit 0
