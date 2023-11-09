#!/bin/bash
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"

./prepare-sweet.sh
./prepare-icon.sh
