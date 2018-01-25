; sprite types
const_value SET 1
	const WALKING_SPRITE
	const STANDING_SPRITE
	const STILL_SPRITE
	const MON_SPRITE
	const BIG_GYARADOS_SPRITE

; sprite header fields
	const_def
	const SPRITEHEADER_ADDR_LO
	const SPRITEHEADER_ADDR_HI
	const SPRITEHEADER_SIZE
	const SPRITEHEADER_BANK
	const SPRITEHEADER_TYPE
	const SPRITEHEADER_PALETTE
NUM_SPRITEHEADER_FIELDS EQU const_value

; sprite palettes
	const_def
	const PAL_OW_RED    ; 0
	const PAL_OW_BLUE   ; 1
	const PAL_OW_GREEN  ; 2
	const PAL_OW_BROWN  ; 3
	const PAL_OW_PURPLE ; 4
	const PAL_OW_SILVER ; 5
	const PAL_OW_TREE   ; 6
	const PAL_OW_ROCK   ; 7

; for party menu icons
const_value SET PAL_OW_SILVER
	const PAL_OW_GRAY   ; 5
	const PAL_OW_PINK   ; 6
	const PAL_OW_TEAL   ; 7

; sprite movement data table indices
; see data/map_objects.asm
	const_def
	const SPRITEMOVEDATA_00                   ; 00
	const SPRITEMOVEDATA_DOLL                 ; 01
	const SPRITEMOVEDATA_WANDER               ; 02
	const SPRITEMOVEDATA_SPINRANDOM_SLOW      ; 03
	const SPRITEMOVEDATA_WALK_UP_DOWN         ; 04
	const SPRITEMOVEDATA_WALK_LEFT_RIGHT      ; 05
	const SPRITEMOVEDATA_STANDING_DOWN        ; 06
	const SPRITEMOVEDATA_STANDING_UP          ; 07
	const SPRITEMOVEDATA_STANDING_LEFT        ; 08
	const SPRITEMOVEDATA_STANDING_RIGHT       ; 09
	const SPRITEMOVEDATA_SPINRANDOM_FAST      ; 0a
	const SPRITEMOVEDATA_PLAYER               ; 0b
	const SPRITEMOVEDATA_CUTTABLE_TREE        ; 0c
	const SPRITEMOVEDATA_FOLLOWING            ; 0d
	const SPRITEMOVEDATA_SCRIPTED             ; 0e
	const SPRITEMOVEDATA_SNORLAX              ; 0f
	const SPRITEMOVEDATA_POKEMON              ; 10
	const SPRITEMOVEDATA_SUDOWOODO            ; 11
	const SPRITEMOVEDATA_SMASHABLE_ROCK       ; 12
	const SPRITEMOVEDATA_STRENGTH_BOULDER     ; 13
	const SPRITEMOVEDATA_FOLLOWNOTEXACT       ; 14
	const SPRITEMOVEDATA_SHADOW               ; 15
	const SPRITEMOVEDATA_EMOTE                ; 16
	const SPRITEMOVEDATA_SCREENSHAKE          ; 17
	const SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE ; 18
	const SPRITEMOVEDATA_SPINCLOCKWISE        ; 19
	const SPRITEMOVEDATA_BIGDOLL              ; 1a
	const SPRITEMOVEDATA_BOULDERDUST          ; 1b
	const SPRITEMOVEDATA_GRASS                ; 1c
	const SPRITEMOVEDATA_PUDDLE               ; 1d
	const SPRITEMOVEDATA_SWIM_AROUND          ; 1e
	const SPRITEMOVEDATA_SWIM_UP_DOWN         ; 1f
	const SPRITEMOVEDATA_SWIM_LEFT_RIGHT      ; 20
	const SPRITEMOVEDATA_BIG_GYARADOS         ; 21
	const SPRITEMOVEDATA_STANDING_DOWN_FLIP   ; 22
	const SPRITEMOVEDATA_STANDING_UP_FLIP     ; 23
	const SPRITEMOVEDATA_POKECOM_NEWS         ; 24
NUM_SPRITEMOVEDATA EQU const_value
SPRITEMOVEDATA_FIELDS EQU 6

; sprite movement functions
; see engine/map_objects.asm:MapObjectMovementPattern.Pointers
	const_def
	const SPRITEMOVEFN_00                    ; 00
	const SPRITEMOVEFN_RANDOM_WALK_Y         ; 01
	const SPRITEMOVEFN_RANDOM_WALK_X         ; 02
	const SPRITEMOVEFN_RANDOM_WALK_XY        ; 03
	const SPRITEMOVEFN_SLOW_RANDOM_SPIN      ; 04
	const SPRITEMOVEFN_FAST_RANDOM_SPIN      ; 05
	const SPRITEMOVEFN_STANDING              ; 06
	const SPRITEMOVEFN_OBEY_DPAD             ; 07
	const SPRITEMOVEFN_FOLLOW                ; 08
	const SPRITEMOVEFN_SCRIPTED              ; 09
	const SPRITEMOVEFN_STRENGTH              ; 0a
	const SPRITEMOVEFN_FOLLOWNOTEXACT        ; 0b
	const SPRITEMOVEFN_SHADOW                ; 0c
	const SPRITEMOVEFN_EMOTE                 ; 0d
	const SPRITEMOVEFN_BIG_SNORLAX           ; 0e
	const SPRITEMOVEFN_BOUNCE                ; 0f
	const SPRITEMOVEFN_SCREENSHAKE           ; 10
	const SPRITEMOVEFN_SPIN_CLOCKWISE        ; 11
	const SPRITEMOVEFN_SPIN_COUNTERCLOCKWISE ; 12
	const SPRITEMOVEFN_BOULDERDUST           ; 13
	const SPRITEMOVEFN_GRASS                 ; 14
	const SPRITEMOVEFN_PUDDLE                ; 15
	const SPRITEMOVEFN_BIG_GYARADOS          ; 16
	const SPRITEMOVEFN_STANDING_FLIP         ; 17
	const SPRITEMOVEFN_POKECOM_NEWS          ; 18

; sprite step types
; see engine/map_objects.asm:StepTypesJumptable
	const_def
	const STEP_TYPE_00              ; 00
	const STEP_TYPE_SLEEP           ; 01
	const STEP_TYPE_NPC_WALK        ; 02
	const STEP_TYPE_03              ; 03
	const STEP_TYPE_04              ; 04
	const STEP_TYPE_05              ; 05
	const STEP_TYPE_PLAYER_WALK     ; 06
	const STEP_TYPE_07              ; 07
	const STEP_TYPE_NPC_JUMP        ; 08
	const STEP_TYPE_PLAYER_JUMP     ; 09
	const STEP_TYPE_HALF_STEP       ; 0a
	const STEP_TYPE_BUMP            ; 0b
	const STEP_TYPE_TELEPORT_FROM   ; 0c
	const STEP_TYPE_TELEPORT_TO     ; 0d
	const STEP_TYPE_SKYFALL         ; 0e
	const STEP_TYPE_0F              ; 0f
	const STEP_TYPE_GOT_BITE        ; 10
	const STEP_TYPE_ROCK_SMASH      ; 11
	const STEP_TYPE_RETURN_DIG      ; 12
	const STEP_TYPE_TRACKING_OBJECT ; 13
	const STEP_TYPE_14              ; 14
	const STEP_TYPE_SKYFALL_TOP     ; 15

; see engine/map_object_action.asm:Pointers445f
	const_def
	const PERSON_ACTION_00            ; 00
	const PERSON_ACTION_STAND         ; 01
	const PERSON_ACTION_STEP          ; 02
	const PERSON_ACTION_BUMP          ; 03
	const PERSON_ACTION_SPIN          ; 04
	const PERSON_ACTION_SPIN_FLICKER  ; 05
	const PERSON_ACTION_FISHING       ; 06
	const PERSON_ACTION_SHADOW        ; 07
	const PERSON_ACTION_EMOTE         ; 08
	const PERSON_ACTION_BIG_SNORLAX   ; 09
	const PERSON_ACTION_BOUNCE        ; 0a
	const PERSON_ACTION_WEIRD_TREE    ; 0b
	const PERSON_ACTION_BIG_DOLL      ; 0c
	const PERSON_ACTION_BOULDER_DUST  ; 0d
	const PERSON_ACTION_GRASS_SHAKE   ; 0e
	const PERSON_ACTION_PUDDLE_SPLASH ; 0f
	const PERSON_ACTION_SKYFALL       ; 10
	const PERSON_ACTION_BIG_GYARADOS  ; 11
	const PERSON_ACTION_STAND_FLIP    ; 12
	const PERSON_ACTION_POKECOM_NEWS  ; 13

; see engine/facings.asm:Facings
	const_def
	const FACING_STEP_DOWN_0    ; 00
	const FACING_STEP_DOWN_1    ; 01
	const FACING_STEP_DOWN_2    ; 02
	const FACING_STEP_DOWN_3    ; 03
	const FACING_STEP_UP_0      ; 04
	const FACING_STEP_UP_1      ; 05
	const FACING_STEP_UP_2      ; 06
	const FACING_STEP_UP_3      ; 07
	const FACING_STEP_LEFT_0    ; 08
	const FACING_STEP_LEFT_1    ; 09
	const FACING_STEP_LEFT_2    ; 0a
	const FACING_STEP_LEFT_3    ; 0b
	const FACING_STEP_RIGHT_0   ; 0c
	const FACING_STEP_RIGHT_1   ; 0d
	const FACING_STEP_RIGHT_2   ; 0e
	const FACING_STEP_RIGHT_3   ; 0f
	const FACING_FISH_DOWN      ; 10
	const FACING_FISH_UP        ; 11
	const FACING_FISH_LEFT      ; 12
	const FACING_FISH_RIGHT     ; 13
	const FACING_EMOTE          ; 14
	const FACING_SHADOW         ; 15
	const FACING_BIG_DOLL_ASYM  ; 16
	const FACING_BIG_DOLL_SYM   ; 17
	const FACING_WEIRD_TREE_0   ; 18
	const FACING_WEIRD_TREE_1   ; 19
	const FACING_WEIRD_TREE_2   ; 1a
	const FACING_WEIRD_TREE_3   ; 1b
	const FACING_BOULDER_DUST_1 ; 1c
	const FACING_BOULDER_DUST_2 ; 1d
	const FACING_GRASS_1        ; 1e
	const FACING_GRASS_2        ; 1f
	const FACING_SPLASH_1       ; 20
	const FACING_SPLASH_2       ; 21
	const FACING_BIG_GYARADOS_1 ; 22
	const FACING_BIG_GYARADOS_2 ; 23
	const FACING_STEP_DOWN_FLIP ; 24
	const FACING_STEP_UP_FLIP   ; 25
	const FACING_POKECOM_NEWS   ; 26
