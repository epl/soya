#!/bin/bash
#

expected='---
brand: Hyundai
model: i30
year: 2018
engine:
  type: Nu
  capacity: 1.8'

actual=$("${SOYA}" -d options "${fixtures_dir}/car_base.yaml")
if [ "${actual}" !=  "${expected}" ]; then
  echo "$actual"
  echo "error with insertion" 1>&2
  exit 1
fi

exit 0
