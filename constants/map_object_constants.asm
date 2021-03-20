; object_struct members (see macros/wram.asm)
rsreset
OBJECT_SPRITE              rb ; 00
OBJECT_MAP_OBJECT_INDEX    rb ; 01
OBJECT_SPRITE_TILE         rb ; 02
OBJECT_MOVEMENTTYPE        rb ; 03
OBJECT_FLAGS1              rb ; 04
OBJECT_FLAGS2              rb ; 05
OBJECT_PALETTE             rb ; 06
OBJECT_DIRECTION_WALKING   rb ; 07
OBJECT_FACING              rb ; 08
OBJECT_STEP_TYPE           rb ; 09
OBJECT_STEP_DURATION       rb ; 0a
OBJECT_ACTION              rb ; 0b
OBJECT_STEP_FRAME          rb ; 0c
OBJECT_FACING_STEP         rb ; 0d
OBJECT_NEXT_TILE           rb ; 0e
OBJECT_STANDING_TILE       rb ; 0f
OBJECT_NEXT_MAP_X          rb ; 10
OBJECT_NEXT_MAP_Y          rb ; 11
OBJECT_MAP_X               rb ; 12
OBJECT_MAP_Y               rb ; 13
OBJECT_INIT_X              rb ; 14
OBJECT_INIT_Y              rb ; 15
OBJECT_RADIUS              rb ; 16
OBJECT_SPRITE_X            rb ; 17
OBJECT_SPRITE_Y            rb ; 18
OBJECT_SPRITE_X_OFFSET     rb ; 19
OBJECT_SPRITE_Y_OFFSET     rb ; 1a
OBJECT_MOVEMENT_BYTE_INDEX rb ; 1b
OBJECT_1C                  rb ; 1c
OBJECT_1D                  rb ; 1d
OBJECT_1E                  rb ; 1e
OBJECT_1F                  rb ; 1f
OBJECT_RANGE               rb ; 20
OBJECT_LENGTH EQU _RS
NUM_OBJECT_STRUCTS EQU 13 ; see wObjectStructs
FIRST_VRAM1_OBJECT_STRUCT EQU 8

; object_struct OBJECT_FACING values
OW_DOWN  EQU DOWN  << 2
OW_UP    EQU UP    << 2
OW_LEFT  EQU LEFT  << 2
OW_RIGHT EQU RIGHT << 2

; object_struct OBJECT_FLAGS1 bit flags
	const_def
	const INVISIBLE_F     ; 0
	const WONT_DELETE_F   ; 1
	const FIXED_FACING_F  ; 2
	const SLIDING_F       ; 3
	const NOCLIP_TILES_F  ; 4
	const MOVE_ANYWHERE_F ; 5
	const NOCLIP_OBJS_F   ; 6
	const EMOTE_OBJECT_F  ; 7

INVISIBLE     EQU 1 << INVISIBLE_F
WONT_DELETE   EQU 1 << WONT_DELETE_F
FIXED_FACING  EQU 1 << FIXED_FACING_F
SLIDING       EQU 1 << SLIDING_F
NOCLIP_TILES  EQU 1 << NOCLIP_TILES_F
MOVE_ANYWHERE EQU 1 << MOVE_ANYWHERE_F
NOCLIP_OBJS   EQU 1 << NOCLIP_OBJS_F
EMOTE_OBJECT  EQU 1 << EMOTE_OBJECT_F

; object_struct OBJECT_FLAGS2 bit flags
	const_def
	const LOW_PRIORITY_F  ; 0
	const HIGH_PRIORITY_F ; 1
	const OBJ_FLAGS2_2    ; 2
	const OVERHEAD_F      ; 3
	const USE_OBP1_F      ; 4
	const FROZEN_F        ; 5
	const OBJ_FLAGS2_6    ; 6
	const OBJ_FLAGS2_7    ; 7

LOW_PRIORITY  EQU 1 << LOW_PRIORITY_F
HIGH_PRIORITY EQU 1 << HIGH_PRIORITY_F
OVERHEAD      EQU 1 << OVERHEAD_F
USE_OBP1      EQU 1 << USE_OBP1_F

; object_struct OBJECT_PALETTE bit flags
	const_def 5
	const SWIMMING_F         ; 5
	const STRENGTH_BOULDER_F ; 6
	const BIG_OBJECT_F       ; 7

SWIMMING         EQU 1 << SWIMMING_F
STRENGTH_BOULDER EQU 1 << STRENGTH_BOULDER_F
BIG_OBJECT       EQU 1 << BIG_OBJECT_F

; facing attribute bit flags
RELATIVE_ATTRIBUTES_F EQU 1
ABSOLUTE_TILE_ID_F    EQU 2

RELATIVE_ATTRIBUTES EQU 1 << RELATIVE_ATTRIBUTES_F
ABSOLUTE_TILE_ID    EQU 1 << ABSOLUTE_TILE_ID_F

; map_object struct members (see macros/wram.asm)
rsreset
MAPOBJECT_OBJECT_STRUCT_ID rb ; 0
MAPOBJECT_SPRITE           rb ; 1
MAPOBJECT_Y_COORD          rb ; 2
MAPOBJECT_X_COORD          rb ; 3
MAPOBJECT_MOVEMENT         rb ; 4
MAPOBJECT_RADIUS           rb ; 5
MAPOBJECT_HOUR             rb ; 6
MAPOBJECT_TIMEOFDAY        rb ; 7
MAPOBJECT_COLOR            rb ; 8
MAPOBJECT_RANGE            rb ; 9
MAPOBJECT_SCRIPT_POINTER   rw ; a
MAPOBJECT_EVENT_FLAG       rw ; c
MAPOBJECT_LENGTH EQU _RS
NUM_OBJECTS EQU $15
PLAYER_OBJECT EQU 0

; SpriteMovementData struct members (see data/sprites/map_objects.asm)
rsreset
SPRITEMOVEATTR_MOVEMENT rb ; 0
SPRITEMOVEATTR_FACING   rb ; 1
SPRITEMOVEATTR_ACTION   rb ; 2
SPRITEMOVEATTR_FLAGS1   rb ; 3
SPRITEMOVEATTR_FLAGS2   rb ; 4
SPRITEMOVEATTR_PALFLAGS rb ; 5
NUM_SPRITEMOVEDATA_FIELDS EQU _RS

MAPOBJECT_SCREEN_WIDTH  EQU (SCREEN_WIDTH / 2) + 2
MAPOBJECT_SCREEN_HEIGHT EQU (SCREEN_HEIGHT / 2) + 2

; SpriteMovementData indexes (see data/sprites/map_objects.asm)
	const_def
	const SPRITEMOVEDATA_00                   ; 00
	const SPRITEMOVEDATA_STILL                ; 01
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
	const SPRITEMOVEDATA_FRUIT                ; 21
	const SPRITEMOVEDATA_BIG_GYARADOS         ; 22
	const SPRITEMOVEDATA_STANDING_DOWN_FLIP   ; 23
	const SPRITEMOVEDATA_STANDING_UP_FLIP     ; 24
	const SPRITEMOVEDATA_POKECOM_NEWS         ; 25
	const SPRITEMOVEDATA_ARCH_TREE_DOWN       ; 26
	const SPRITEMOVEDATA_ARCH_TREE_UP         ; 27
	const SPRITEMOVEDATA_ARCH_TREE_LEFT       ; 28
	const SPRITEMOVEDATA_ARCH_TREE_RIGHT      ; 29
	const SPRITEMOVEDATA_SAILBOAT_TOP         ; 2a
	const SPRITEMOVEDATA_SAILBOAT_BOTTOM      ; 2b
NUM_SPRITEMOVEDATA EQU const_value

; StepFunction_FromMovement.Pointers indexes (see engine/overworld/map_objects.asm)
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
	const SPRITEMOVEFN_CUT_TREE              ; 16
	const SPRITEMOVEFN_FRUIT                 ; 17
	const SPRITEMOVEFN_BIG_GYARADOS          ; 18
	const SPRITEMOVEFN_STANDING_FLIP         ; 19
	const SPRITEMOVEFN_POKECOM_NEWS          ; 1a
	const SPRITEMOVEFN_ARCH_TREE             ; 1b
	const SPRITEMOVEFN_SAILBOAT_TOP          ; 1c
	const SPRITEMOVEFN_SAILBOAT_BOTTOM       ; 1d
NUM_SPRITEMOVEFN EQU const_value

; StepTypesJumptable indexes (see engine/overworld/map_objects.asm)
	const_def
	const STEP_TYPE_RESET            ; 00
	const STEP_TYPE_FROM_MOVEMENT    ; 01
	const STEP_TYPE_NPC_WALK         ; 02
	const STEP_TYPE_SLEEP            ; 03
	const STEP_TYPE_STANDING         ; 04
	const STEP_TYPE_RESTORE          ; 05
	const STEP_TYPE_PLAYER_WALK      ; 06
	const STEP_TYPE_CONTINUE_WALK    ; 07
	const STEP_TYPE_NPC_JUMP         ; 08
	const STEP_TYPE_PLAYER_JUMP      ; 09
	const STEP_TYPE_TURN             ; 0a
	const STEP_TYPE_BUMP             ; 0b
	const STEP_TYPE_TELEPORT_FROM    ; 0c
	const STEP_TYPE_TELEPORT_TO      ; 0d
	const STEP_TYPE_SKYFALL          ; 0e
	const STEP_TYPE_STRENGTH_BOULDER ; 0f
	const STEP_TYPE_GOT_BITE         ; 10
	const STEP_TYPE_ROCK_SMASH       ; 11
	const STEP_TYPE_RETURN_DIG       ; 12
	const STEP_TYPE_TRACKING_OBJECT  ; 13
	const STEP_TYPE_SCREENSHAKE      ; 14
	const STEP_TYPE_SKYFALL_TOP      ; 15
	const STEP_TYPE_NPC_STAIRS       ; 16
	const STEP_TYPE_PLAYER_STAIRS    ; 17
NUM_STEP_TYPES EQU const_value

; ObjectActionPairPointers indexes (see engine/overworld/map_object_action.asm)
	const_def
	const OBJECT_ACTION_00              ; 00
	const OBJECT_ACTION_STAND           ; 01
	const OBJECT_ACTION_STEP            ; 02
	const OBJECT_ACTION_BUMP            ; 03
	const OBJECT_ACTION_SPIN            ; 04
	const OBJECT_ACTION_SPIN_FLICKER    ; 05
	const OBJECT_ACTION_FISHING         ; 06
	const OBJECT_ACTION_SHADOW          ; 07
	const OBJECT_ACTION_EMOTE           ; 08
	const OBJECT_ACTION_BIG_SNORLAX     ; 09
	const OBJECT_ACTION_BOUNCE          ; 0a
	const OBJECT_ACTION_WEIRD_TREE      ; 0b
	const OBJECT_ACTION_BIG_DOLL        ; 0c
	const OBJECT_ACTION_BOULDER_DUST    ; 0d
	const OBJECT_ACTION_GRASS_SHAKE     ; 0e
	const OBJECT_ACTION_PUDDLE_SPLASH   ; 0f
	const OBJECT_ACTION_CUT_TREE        ; 10
	const OBJECT_ACTION_SKYFALL         ; 11
	const OBJECT_ACTION_FRUIT           ; 12
	const OBJECT_ACTION_BIG_GYARADOS    ; 13
	const OBJECT_ACTION_STAND_FLIP      ; 14
	const OBJECT_ACTION_POKECOM_NEWS    ; 15
	const OBJECT_ACTION_ARCH_TREE       ; 16
	const OBJECT_ACTION_RUN             ; 17
	const OBJECT_ACTION_SAILBOAT_TOP    ; 18
	const OBJECT_ACTION_SAILBOAT_BOTTOM ; 19
NUM_OBJECT_ACTIONS EQU const_value

; Facings indexes (see data/sprites/facings.asm)
	const_def
	const FACING_STEP_DOWN_0     ; 00
	const FACING_STEP_DOWN_1     ; 01
	const FACING_STEP_DOWN_2     ; 02
	const FACING_STEP_DOWN_3     ; 03
	const FACING_STEP_UP_0       ; 04
	const FACING_STEP_UP_1       ; 05
	const FACING_STEP_UP_2       ; 06
	const FACING_STEP_UP_3       ; 07
	const FACING_STEP_LEFT_0     ; 08
	const FACING_STEP_LEFT_1     ; 09
	const FACING_STEP_LEFT_2     ; 0a
	const FACING_STEP_LEFT_3     ; 0b
	const FACING_STEP_RIGHT_0    ; 0c
	const FACING_STEP_RIGHT_1    ; 0d
	const FACING_STEP_RIGHT_2    ; 0e
	const FACING_STEP_RIGHT_3    ; 0f
	const FACING_FISH_DOWN       ; 10
	const FACING_FISH_UP         ; 11
	const FACING_FISH_LEFT       ; 12
	const FACING_FISH_RIGHT      ; 13
	const FACING_EMOTE           ; 14
	const FACING_SHADOW          ; 15
	const FACING_BIG_DOLL_ASYM   ; 16
	const FACING_BIG_DOLL_SYM    ; 17
	const FACING_WEIRD_TREE_0    ; 18
	const FACING_WEIRD_TREE_1    ; 19
	const FACING_WEIRD_TREE_2    ; 1a
	const FACING_WEIRD_TREE_3    ; 1b
	const FACING_BOULDER_DUST_1  ; 1c
	const FACING_BOULDER_DUST_2  ; 1d
	const FACING_GRASS_1         ; 1e
	const FACING_GRASS_2         ; 1f
	const FACING_SPLASH_1        ; 20
	const FACING_SPLASH_2        ; 21
	const FACING_CUT_TREE        ; 22
	const FACING_APRICORN        ; 23
	const FACING_BERRY           ; 24
	const FACING_PICKED_FRUIT    ; 25
	const FACING_BIG_GYARADOS_1  ; 26
	const FACING_BIG_GYARADOS_2  ; 27
	const FACING_STEP_DOWN_FLIP  ; 28
	const FACING_STEP_UP_FLIP    ; 29
	const FACING_POKECOM_NEWS    ; 2a
	const FACING_ARCH_TREE_DOWN  ; 2b
	const FACING_ARCH_TREE_UP    ; 2c
	const FACING_ARCH_TREE_LEFT  ; 2d
	const FACING_ARCH_TREE_RIGHT ; 2e
	const FACING_SAILBOAT_TOP    ; 2f
	const FACING_SAILBOAT_BOTTOM ; 30
NUM_FACINGS EQU const_value

; DoPlayerMovement.DoStep arguments (see engine/overworld/player_movement.asm)
	const_def
	const STEP_SLOW          ; 0
	const STEP_WALK          ; 1
	const STEP_BIKE          ; 2
	const STEP_RUN           ; 3
	const STEP_LEDGE         ; 4
	const STEP_ICE           ; 5
	const STEP_TURN          ; 6
	const STEP_BACK_LEDGE    ; 7
	const STEP_WALK_IN_PLACE ; 8
	const STEP_SPIN          ; 9
	const STEP_FAST          ; a (same as STEP_RUN but without doubling animation speed)
	const STEP_STAIRS        ; b
NUM_STEPS EQU const_value
