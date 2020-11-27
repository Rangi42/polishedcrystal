#!/bin/sh
# Usage: collision_asm2bin.sh collision.asm collision.bin

TEMP_ASM=$(mktemp collision.asm.XXX)
TEMP_O=$(mktemp collision.o.XXX)
OS=$(uname -s)

HEAD=head
tail=tail

if [ $OS = "Darwin" ]
then
    HEAD=ghead
    TAIL=gtail
fi

echo 'INCLUDE "constants/collision_constants.asm"' > "$TEMP_ASM"
echo 'INCLUDE "macros/collision.asm"' >> "$TEMP_ASM"
echo 'SECTION "C", ROM0[$0]' >> "$TEMP_ASM"
echo "INCLUDE \"$1\"" >> "$TEMP_ASM"

${RGBDS_DIR}rgbasm -o "$TEMP_O" "$TEMP_ASM"
$TAIL -c +37 "$TEMP_O" | $HEAD -c -8 > $2
rm -f "$TEMP_ASM" "$TEMP_O"
