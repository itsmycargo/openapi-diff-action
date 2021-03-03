#!/usr/bin/env bash
set -Eeuo pipefail

BASE_SCHEMA=$1
REVISION_SCHEMA=$2

STATE=$(
  java -jar /app/openapi-diff.jar \
    --text changes.txt \
    --markdown changes.md \
    --state \
    "${BASE_SCHEMA}" \
    "${REVISION_SCHEMA}"
)


echo "::group::API Changes"
cat changes.txt
echo ""
echo "::endgroup::"

CHANGES=$(cat changes.md)
CHANGES="${CHANGES//'%'/'%25'}"
CHANGES="${CHANGES//$'\n'/'%0A'}"
CHANGES="${CHANGES//$'\r'/'%0D'}"

VERDICT=""
case "${STATE}" in
  no_changes )
    VERDICT=":white_check_mark: No Changes."
    ;;
  incompatible )
    VERDICT=":bangbang: Incompatible Changes :bangbang:"
    ;;
  compatible )
    VERDICT=":white_check_mark: Only compatible changes."
    ;;
esac

echo "::set-output name=changes::${CHANGES}"
echo "::set-output name=state::${STATE}"
echo "::set-output name=verdict::${VERDICT}"
