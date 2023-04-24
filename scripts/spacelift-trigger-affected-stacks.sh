#!/bin/bash

affected_stacks=$1
spacectl_command="preview"

if [ "$2" = "true" ]; then
  spacectl_command="deploy"
fi

declare -A error_stacks
success_stacks=()

# Use jq to extract the spacelift_stack values and iterate through them
for spacelift_stack in $(echo "$affected_stacks" | jq -r '.[].spacelift_stack'); do
  # Run the spacectl command, capture the error message, and store the exit status
  echo "running spacectl stack $spacectl_command --id \"$spacelift_stack\" --sha \"$TRIGGERING_SHA\""
  error_message=$(spacectl stack $spacectl_command --id "$spacelift_stack" --sha "$TRIGGERING_SHA" 2>&1)
  exit_status=$?

  if [ $exit_status -ne 0 ]; then
    # If the command failed, add the spacelift_stack and error message to the error_stacks associative array
    error_stacks["$spacelift_stack"]="$error_message"
  else
    # If the command succeeded, add the spacelift_stack to the success_stacks array
    success_stacks+=("$spacelift_stack")
  fi
done

# Output the list of successful stacks, if any
if [ ${#success_stacks[@]} -gt 0 ]; then
  printf "The following stacks triggered successfully:\n\n"
  for stack in "${success_stacks[@]}"; do
    echo "- $stack"
  done
else
  echo "No stacks triggered successfully."
fi

if [ ${#error_stacks[@]} -eq 0 ]; then
  # Exit with 0 if there are no errors
  exit 0
else
  # Output the list of spacelift_stack that had errors along with their error messages
  printf "\nThe following stacks had errors while triggering:\n\n"
  for stack in "${!error_stacks[@]}"; do
    echo "- $stack: ${error_stacks[$stack]}"
  done
  # Exit with 1 if there are any errors
  exit 1
fi
