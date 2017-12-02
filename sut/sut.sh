#!/bin/bash

echo -n "Check system release...   "
sv=$(cat /etc/alpine-release)
echo "$sv" | egrep -q "^[0-9]\.[0-9]\.[0-9]$"
if [[ $? -ne 0 ]]; then
  echo "failed"
  echo "$sv"
  exit 1
fi
printf "%-30s[OK]\n" "($sv)"

echo -n "Check latest update...    "
u=$(cat /etc/appcelerator-alpine-update)
echo "$u" | egrep -q " UTC 20[0-9][0-9]$"
if [[ $? -ne 0 ]]; then
  echo "failed"
  echo "$u"
  exit 1
fi
printf "%-30s[OK]\n" "($u)"

echo -n "Test envtpl...            "
envtpl -h >/dev/null
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-30s[OK]\n" "ready"

echo -n "Test gosu                 "
g=$(/usr/bin/gosu nobody bash -c 'whoami')
if [[ "x$g" != "xnobody" ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-30s[OK]\n" "ready"

echo -n "Test tini                 "
/sbin/tini --version | grep -q "tini version"
if [[ $? -ne 0 ]]; then
  echo
  echo "failed"
  exit 1
fi
printf "%-30s[OK]\n" "ready"

echo "All tests passed successfully"
exit 0
