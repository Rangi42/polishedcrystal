#!/bin/sh
# Usage: collision_asm2bin.sh collision.asm collision.bin

TEMP_ASM=$(mktemp collision.asm.XXXXXX)
TEMP_O=$(mktemp collision.o.XXXXXX)

echo 'INCLUDE "constants/collision_constants.asm"' > "$TEMP_ASM"
echo 'INCLUDE "macros/collision.asm"' >> "$TEMP_ASM"
echo 'SECTION "C", ROM0[$0]' >> "$TEMP_ASM"
echo "INCLUDE \"$1\"" >> "$TEMP_ASM"

${RGBDS_DIR}rgbasm -o "$TEMP_O" "$TEMP_ASM"
${RGBDS_DIR}rgblink -x -o "$2" "$TEMP_O"
rm -f "$TEMP_ASM" "$TEMP_O"
