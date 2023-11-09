#!/bin/sh
for file in "$@"; do
  if grep -qw "$ANSIBLE_VAULT;1:1;AES256" "$file"; then
    echo "good to go"
  else
    echo "Error: You must encrypt YML first!"
    exit 1
  fi
done
