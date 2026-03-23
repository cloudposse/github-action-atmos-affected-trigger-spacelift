#!/bin/bash

spacectl_command="preview"

if [ "$1" = "true" ]; then
  spacectl_command="deploy"
fi

# Build jq filter based on whether workspace_enabled filtering is enabled
jq_filter='.[] | select(.spacelift_stack != null)'
if [ "${FILTER_BY_WORKSPACE_ENABLED}" = "true" ]; then
  jq_filter="${jq_filter} | select((.settings.spacelift.workspace_enabled // true) != false)"
fi
jq_filter="${jq_filter} | .spacelift_stack"

# Use jq to extract the spacelift_stack values and iterate through them
stack_count=0
for spacelift_stack in $(jq -r "${jq_filter}" < "affected-stacks.json"); do
  printf "/spacelift %s %s\n" "$spacelift_stack" "$spacectl_command" >> "comment-body.txt"
  stack_count=$((stack_count+1))
done

# Wrap the contents in a collapsible details block
if [[ $stack_count -gt 0 ]]; then
  sed -i "1 i\/spacelift summary\n\n<details><summary>Spacelift Triggered Stacks ($stack_count)</summary>\n\n" comment-body.txt
  printf "</details>\n" >> "comment-body.txt"
fi
