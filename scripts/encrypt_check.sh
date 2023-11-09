#!/bin/sh
for file in "$@"; do
  if grep -q "ANSIBLE" "$file"; then
    echo "File $file contains ANSIBLE"
  else
    echo "Error: Must Encrypt Yml First!"
    exit 1
  fi
done
