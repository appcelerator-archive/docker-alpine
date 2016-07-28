#!/bin/bash

echo -n "Test python version...    "
pv=$(python -V 2>&1)
if [[ $? -ne 0 || -z "$pv" ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-20s[OK]\n" "($pv)"

echo -n "Test jq version...        "
jqv=$(jq --version)
if [[ $? -ne 0 || -z "$jqv" ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-20s[OK]\n" "($jqv)"

echo -n "Test envtpl...            "
envtpl -h >/dev/null
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-20s[OK]\n" "ready"

echo -n "Test gosu                 "
test -x /usr/bin/gosu
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-20s[OK]\n" "ready"

echo "All tests passed successfully"
exit 0
