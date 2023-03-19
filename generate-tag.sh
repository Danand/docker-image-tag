#!/bin/bash
#
# Generates a nice Docker image tag for GitHub container registry.

set -e

product_name="$1"
service_suffix="$2"
input_version="$3"
repository="$4"
ref_type="$5"
ref_name="$6"
sha="$7"
git_tag_last="$8"

tag="ghcr.io/${repository}/${product_name}"

if [ ! -z "${service_suffix}" ]; then
  tag+="-${service_suffix}"
fi

tag="$(echo "${tag}" | tr "[:upper:]" "[:lower:]")"

tag+=":"

if [ ! -z "${input_version}" ]; then
  tag+="${input_version}"
elif [ "${ref_type}" == "tag" ]; then
  tag+="${ref_name}"
else
  sha_short="$(echo "${sha}" | head -q -c 8)"
  if [ ! -z "${git_tag_last}" ]; then
    tag+="${git_tag_last}-${sha_short}"
  else
    tag+="${sha_short}"
  fi
fi

echo "${tag}"

exit 0
