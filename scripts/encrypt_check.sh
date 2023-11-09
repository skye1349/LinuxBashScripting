#!/bin/sh
for file in "$@"; do
  if grep -q "\$ANSIBLE_VAULT;1:1;AES256" "$file"; then
    echo "good to go$file"
  else
    echo "Error: You must encrypt $file first!"
    exit 1
  fi
done
