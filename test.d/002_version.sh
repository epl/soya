#!/bin/bash
#
expected=$(cat "${fixtures_dir}/version.txt")

actual=$("${SOYA}" -V 2>&1)
if [ "${actual}" != "${expected}" ]; then
  echo "error with -V" 1>&2
  exit 1
fi

actual=$("${SOYA}" --version 2>&1)
if [ "${actual}" != "${expected}" ]; then
  echo "error with --version" 1>&2
  exit 1
fi

exit 0