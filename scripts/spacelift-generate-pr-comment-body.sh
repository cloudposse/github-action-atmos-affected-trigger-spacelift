#!/bin/bash

spacectl_command="preview"

if [ "$1" = "true" ]; then
  spacectl_command="deploy"
fi

# Use jq to extract the spacelift_stack values and iterate through them
stack_count=0
for spacelift_stack in $(jq -r '.[].spacelift_stack' < "affected-stacks.json" | grep -v null); do
  printf "/spacelift %s %s\n" "$spacectl_command" "$spacelift_stack" >> "comment-body.txt"
  stack_count=$((stack_count+1))
done

# Wrap the contents in a collapsible details block
if [$stack_count -gt 0]; then
  sed -i "1 i\<details><summary>Spacelift Triggered Stacks ($stack_count)</summary>\n" comment-body.txt
  printf "</details>\n" >> "comment-body.txt"
fi
