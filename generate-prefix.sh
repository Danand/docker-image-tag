#!/bin/bash
#
# Generates a nice Docker image tag prefix for GitHub container registry.

set -e

product_name="$1"
service_suffix="$2"
repository="$3"

tag="ghcr.io/${repository}/${product_name}"

if [ ! -z "${service_suffix}" ]; then
  tag+="-${service_suffix}"
fi

tag="$(echo "${tag}" | tr "[:upper:]" "[:lower:]")"
