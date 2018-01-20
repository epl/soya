#!/bin/bash
#
expected=$(cat "${fixtures_dir}/help.txt")

actual=$("${SOYA}" -h 2>&1)
if [ "${actual}" != "${expected}" ]; then
  echo "error with -h" 1>&2
  exit 1
fi

actual=$("${SOYA}" --help 2>&1)
if [ "${actual}" != "${expected}" ]; then
  echo "error with --help" 1>&2
  exit 1
fi

exit 0
