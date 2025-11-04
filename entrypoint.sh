#!/usr/bin/env bash
set -e

mkdir -p /tmp/numba-cache
export NUMBA_CACHE_DIR=/tmp/numba-cache

# Activate the Conda environment
# shellcheck disable=SC1091
source /opt/conda/etc/profile.d/conda.sh
conda activate cascadia_env

# Only exec if this script is the main program, not when sourced
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  exec "$@"
fi
