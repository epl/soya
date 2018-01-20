#!/bin/bash
#
car_json=$(cat "${fixtures_dir}/car.json")
car_yaml=$(cat "${fixtures_dir}/car.yaml")

actual=$("${SOYA}" "${fixtures_dir}/car.json")
if [ "${actual}" != "${car_yaml}" ]; then
  echo "error with simple ingestion" 1>&2
  exit 1
fi

actual=$("${SOYA}" -f json "${fixtures_dir}/car.json")
if [ "${actual}" != "${car_yaml}" ]; then
  echo "error with -f json" 1>&2
  echo "failed"
  exit 1
fi

actual=$("${SOYA}" -f yaml "${fixtures_dir}/car.json")
if [ "${actual}" != "${car_yaml}" ]; then
  echo "error with -f yaml" 1>&2
  exit 1
fi

actual=$("${SOYA}" -t json "${fixtures_dir}/car.json")
if [ "${actual}" != "${car_json}" ]; then
  echo "error with -t json" 1>&2
  exit 1
fi

actual=$("${SOYA}" -t yaml "${fixtures_dir}/car.json")
if [ "${actual}" != "${car_yaml}" ]; then
  echo "error with -t yaml" 1>&2
  exit 1
fi

exit 0
