#!/bin/bash

spacectl_command="preview"

if [ "$1" = "true" ]; then
  spacectl_command="deploy"
fi

body=""

# Use jq to extract the spacelift_stack values and iterate through them
for spacelift_stack in $(jq -r '.[].spacelift_stack' < "affected-stacks.json" | grep -v null); do
  body="$body\n/spacelift $spacectl_command $spacelift_stack"
done

echo "$body"
