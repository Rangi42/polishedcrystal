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


SECTION "Delta Note Streams", ROMX

INCLUDE "audio/decode_delta_note.asm"
INCLUDE "macros/scripts/delta_notes.asm"
DEF _delta_note_previous_frequency = 0
INCLUDE "audio/delta_note_streams.asm"
PURGE _delta_note_previous_frequency
