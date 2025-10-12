#!/usr/bin/env bash
# Usage: collision_asm2bin.sh collision.asm collision.bin

set -euo pipefail

cat <<EOF | ${RGBASM} -o - - | ${RGBLINK} -x -o "$2" -
INCLUDE "constants/collision_constants.asm"
INCLUDE "macros/collision.asm"
SECTION "", ROM0[0]
INCLUDE "$1"
EOF
