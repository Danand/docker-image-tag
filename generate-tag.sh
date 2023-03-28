#!/bin/bash
#
# Generates a nice Docker image tag for GitHub container registry.

set -e

prefix="$1"
input_version="$2"
ref_type="$3"
ref_name="$4"
sha="$5"

tag="${prefix}"

tag+=":"

if [ ! -z "${input_version}" ]; then
  tag+="${input_version}"
elif [ "${ref_type}" == "tag" ]; then
  tag+="${ref_name}"
else
  sha_short="$(echo "${sha}" | head -q -c 8)"

  is_in_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null || echo "false")"

  if $is_in_repo; then
    tag+="$(git describe --tags --abbrev=0)-${sha_short}"
  else
    tag+="${sha_short}"
  fi
fi

echo "${tag}"

exit 0
