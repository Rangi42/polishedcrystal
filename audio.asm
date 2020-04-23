INCLUDE "constants.asm"


SECTION "Audio", ROMX

INCLUDE "audio/engine.asm"
INCLUDE "audio/music_pointers.asm"
INCLUDE "audio/sfx_pointers.asm"
INCLUDE "audio/cry_pointers.asm"
INCLUDE "data/trainers/encounter_music.asm"


INCLUDE "audio/music.asm"

INCLUDE "audio/sfx.asm"


SECTION "Cries", ROMX

INCLUDE "audio/cries.asm"
INCLUDE "data/pokemon/cries.asm"
