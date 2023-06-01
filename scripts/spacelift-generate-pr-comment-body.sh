#!/bin/bash

spacectl_command="preview"

if [ "$1" = "true" ]; then
  spacectl_command="deploy"
fi

# Use jq to extract the spacelift_stack values and iterate through them
for spacelift_stack in $(jq -r '.[].spacelift_stack' < "affected-stacks.json" | grep -v null); do
  printf "/spacelift %s %s" "$spacectl_command" "$spacelift_stack\n" >> "comment-body.txt"
done
