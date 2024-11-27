#!/usr/bin/env bash

set -e

mkdir -p /tmp/numba-cache
export NUMBA_CACHE_DIR=/tmp/numba-cache

# Activate the Conda environment
source /opt/conda/etc/profile.d/conda.sh
conda activate cascadia_env

exec "$@"
