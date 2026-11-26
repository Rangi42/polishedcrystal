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


SECTION "Custom Cries", ROMX

INCLUDE "audio/custom-cries/wynaut.asm"
INCLUDE "audio/custom-cries/leafeon.asm"
INCLUDE "audio/custom-cries/glaceon.asm"
INCLUDE "audio/custom-cries/porygon_z.asm"
INCLUDE "audio/custom-cries/sylveon.asm"


SECTION "Siren Cries", ROMX

INCLUDE "audio/siren_decoder.asm"
INCLUDE "macros/scripts/siren.asm"
DEF _siren_previous = 0
INCLUDE "audio/siren_cries.asm"
PURGE _siren_previous
