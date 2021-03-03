#!/bin/sh -l

OLD_SCHEMA=$1; shift
NEW_SCHEMA=$1; shift
CHANGES_OUTPUT=$1; shift

state=$(
  java -jar /app/openapi-diff.jar \
  --markdown "${{ github.workspace }}/${CHANGES_OUTPUT}" \
  --state \
  "${OLD_SCHEMA}" \
  "${{ github.workspace }}/${NEW_SCHEMA}"
)
echo "::set-output name=state::${state}"
echo "::debug::API Schema status: ${state}"
