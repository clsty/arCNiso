#!/bin/bash
set -e
function try { "$@" || sleep 0; }
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"

aaa ./prepare-sweet.sh
aaa ./prepare-icon-git.sh
