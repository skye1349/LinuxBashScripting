#!/bin/sh

# Get a list of all staged .yml files
STAGED_FILES=$(git diff --cached --name-only -- '/group_vars/*.yml')

# Check each staged .yml file for the presence of "ANSIBLE"
for file in $STAGED_FILES; do
  if ! grep -q "ANSIBLE" "$file"; then
    echo "Error: Must Encrypt Yml First!"
    exit 1
  fi
done

# If we reach this point, all files contain "ANSIBLE"
exit 0

