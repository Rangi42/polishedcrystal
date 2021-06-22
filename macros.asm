INCLUDE "macros/asserts.asm"
INCLUDE "macros/const.asm"
INCLUDE "macros/predef.asm"
INCLUDE "macros/rst.asm"
INCLUDE "macros/data.asm"
INCLUDE "macros/code.asm"
INCLUDE "macros/gfx.asm"
INCLUDE "macros/coords.asm"

INCLUDE "macros/scripts/audio.asm"
INCLUDE "macros/scripts/maps.asm"
INCLUDE "macros/scripts/events.asm"
INCLUDE "macros/scripts/text.asm"
INCLUDE "macros/scripts/movement.asm"
INCLUDE "macros/scripts/battle_anims.asm"
INCLUDE "macros/scripts/trade_anims.asm"
INCLUDE "macros/scripts/gfx_anims.asm"

if DEF(MONOCHROME)
INCLUDE "macros/monochrome.asm"
endc
