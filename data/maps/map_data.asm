SECTION "Map Headers", ROMX

INCLUDE "data/maps/maps.asm"


SECTION "Map Attributes", ROMX

INCLUDE "data/maps/attributes.asm"


INCLUDE "data/maps/blocks.asm"
; Enable the pair codec only for map script dialogue.
DEF MAP_PAIR_TEXT EQU 1
INCLUDE "macros/scripts/map_pair_text.asm"
INCLUDE "data/maps/scripts.asm"
