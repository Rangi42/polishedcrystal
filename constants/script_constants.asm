; object constants
PLAYER      EQU  0
LAST_TALKED EQU -2

; string buffer constants
	const_def
	const STRING_BUFFER_3 ; use wStringBuffer3
	const STRING_BUFFER_4 ; use wStringBuffer4
	const STRING_BUFFER_5 ; use wStringBuffer5
NUM_STRING_BUFFERS EQU const_value

STRING_BUFFER_LENGTH EQU 19

; checkmoney/takemoney accounts
	const_def
	const YOUR_MONEY ; 0
	const MOMS_MONEY ; 1

; checkmoney/checkcoins return values
	const_def
	const HAVE_MORE   ; 0
	const HAVE_AMOUNT ; 1
	const HAVE_LESS   ; 2

; checkpokemail return values
	const_def
	const POKEMAIL_WRONG_MAIL ; 0
	const POKEMAIL_CORRECT    ; 1
	const POKEMAIL_REFUSED    ; 2
	const POKEMAIL_NO_MAIL    ; 3
	const POKEMAIL_LAST_MON   ; 4

; askforphonenumber return values
	const_def
	const PHONE_CONTACT_GOT     ; 0
	const PHONE_CONTACTS_FULL   ; 1
	const PHONE_CONTACT_REFUSED ; 2

; trainertext arguments
	const_def
	const TRAINERTEXT_SEEN
	const TRAINERTEXT_WIN
	const TRAINERTEXT_LOSS

; readvar/writevar/loadvar arguments
; VarActionTable indexes (see engine/overworld/variables.asm)
	const_def
	const VAR_STRINGBUFFER2    ; 00
	const VAR_PARTYCOUNT       ; 01
	const VAR_BATTLERESULT     ; 02
	const VAR_BATTLETYPE       ; 03
	const VAR_TIMEOFDAY        ; 04
	const VAR_DEXCAUGHT        ; 05
	const VAR_DEXSEEN          ; 06
	const VAR_BADGES           ; 07
	const VAR_MOVEMENT         ; 08
	const VAR_FACING           ; 09
	const VAR_HOUR             ; 0a
	const VAR_WEEKDAY          ; 0b
	const VAR_MAPGROUP         ; 0c
	const VAR_MAPNUMBER        ; 0d
	const VAR_UNOWNCOUNT       ; 0e
	const VAR_ENVIRONMENT      ; 0f
	const VAR_BOXSPACE         ; 10
	const VAR_CONTESTMINUTES   ; 11
	const VAR_XCOORD           ; 12
	const VAR_YCOORD           ; 13
	const VAR_SPECIALPHONECALL ; 14
	const VAR_KURT_APRICORNS   ; 15
	const VAR_CALLERID         ; 16
	const VAR_BLUECARDBALANCE  ; 17
	const VAR_BUENASPASSWORD   ; 18
	const VAR_KENJI_BREAK      ; 19
	const VAR_PKMN_JOURNALS    ; 1a
	const VAR_TRAINER_STARS    ; 1b
NUM_VARS EQU const_value           ; 1c

; variable action types
RETVAR_STRBUF2 EQU 0 << 6
RETVAR_ADDR_DE EQU 1 << 6
RETVAR_EXECUTE EQU 2 << 6

; PlayerEventScriptPointers indexes (see engine/overworld/events.asm)
	const_def -1
	const PLAYEREVENT_MAPSCRIPT
	const PLAYEREVENT_NONE
	const PLAYEREVENT_SEENBYTRAINER
	const PLAYEREVENT_TALKTOTRAINER
	const PLAYEREVENT_ITEMBALL
	const PLAYEREVENT_CONNECTION
	const PLAYEREVENT_WARP
	const PLAYEREVENT_FALL
	const PLAYEREVENT_WHITEOUT
	const PLAYEREVENT_HATCH
	const PLAYEREVENT_JOYCHANGEFACING
	const PLAYEREVENT_TMHMBALL
	const PLAYEREVENT_KEYITEMBALL
NUM_PLAYER_EVENTS EQU const_value

; PlayerMovementPointers indexes (see engine/overworld/events.asm)
	const_def
	const PLAYERMOVEMENT_NORMAL
	const PLAYERMOVEMENT_WARP
	const PLAYERMOVEMENT_TURN
	const PLAYERMOVEMENT_FORCE_TURN
	const PLAYERMOVEMENT_FINISH
	const PLAYERMOVEMENT_CONTINUE
	const PLAYERMOVEMENT_EXIT_WATER
	const PLAYERMOVEMENT_JUMP
NUM_PLAYER_MOVEMENTS EQU const_value

; script data sizes (see macros/scripts/maps.asm)
SCENE_SCRIPT_SIZE EQU  2 ; scene_script
CALLBACK_SIZE     EQU  3 ; callback
WARP_EVENT_SIZE   EQU  5 ; warp_event
COORD_EVENT_SIZE  EQU  5 ; coord_event
BG_EVENT_SIZE     EQU  5 ; bg_event
OBJECT_EVENT_SIZE EQU 13 ; object_event

; bg_event types
; TryBGEvent arguments (see engine/overworld/events.asm)
	const_def
	const BGEVENT_READ
	const BGEVENT_UP
	const BGEVENT_DOWN
	const BGEVENT_RIGHT
	const BGEVENT_LEFT
	const BGEVENT_IFSET
	const BGEVENT_IFNOTSET
	const BGEVENT_JUMPTEXT
	const BGEVENT_JUMPSTD
	const BGEVENT_GROTTOITEM
NUM_BGEVENTS EQU const_value

; BGEVENT_ITEM has to be the last BG event type, since hidden item BG events
; use type BGEVENT_ITEM + (item id) to save space.
; Note that this requires BGEVENT_ITEM + (item id) <= $ff, so currently most
; of the mail items cannot be hidden.
BGEVENT_ITEM EQU NUM_BGEVENTS

; object_event types
; ObjectEventTypeArray indexes (see engine/overworld/events.asm)
	const_def
	const OBJECTTYPE_SCRIPT
	const OBJECTTYPE_ITEMBALL
	const OBJECTTYPE_TRAINER
	const OBJECTTYPE_GENERICTRAINER
	const OBJECTTYPE_POKEMON
	const OBJECTTYPE_COMMAND
NUM_OBJECT_TYPES EQU const_value

; elevfloor macro values
; ElevatorFloorNames indexes (see data/events/elevator_floors.asm)
	const_def
	const FLOOR_B4F
	const FLOOR_B3F
	const FLOOR_B2F
	const FLOOR_B1F
	const FLOOR_1F
	const FLOOR_2F
	const FLOOR_3F
	const FLOOR_4F
	const FLOOR_5F
	const FLOOR_6F
	const FLOOR_7F
	const FLOOR_8F
	const FLOOR_9F
	const FLOOR_10F
	const FLOOR_11F
	const FLOOR_ROOF
NUM_FLOORS EQU const_value

; showemote arguments
; Emotes indexes (see data/sprites/emotes.asm)
	const_def
	const EMOTE_SHOCK
	const EMOTE_QUESTION
	const EMOTE_HAPPY
	const EMOTE_SAD
	const EMOTE_HEART
	const EMOTE_BOLT
	const EMOTE_SLEEP
	const EMOTE_FISH
NUM_EMOTES EQU const_value
EMOTE_FROM_MEM EQU -1

; fruittree arguments
; FruitTreeItems indexes (see data/items/fruit_trees.asm)
	const_def 1
; Apricorn trees come first, then Berry trees
	const FRUITTREE_AZALEA_TOWN     ; 01
	const FRUITTREE_ROUTE_37_1      ; 02
	const FRUITTREE_ROUTE_37_2      ; 03
	const FRUITTREE_ROUTE_37_3      ; 04
	const FRUITTREE_ROUTE_42_1      ; 05
	const FRUITTREE_ROUTE_42_2      ; 06
	const FRUITTREE_ROUTE_42_3      ; 07
FIRST_BERRY_TREE EQU const_value
	const FRUITTREE_ROUTE_29        ; 08
	const FRUITTREE_ROUTE_30_1      ; 09
	const FRUITTREE_ROUTE_30_2      ; 0a
	const FRUITTREE_ROUTE_31        ; 0b
	const FRUITTREE_VIOLET_CITY     ; 0c
	const FRUITTREE_ROUTE_32_COAST  ; 0d
	const FRUITTREE_ROUTE_33        ; 0e
	const FRUITTREE_ROUTE_35        ; 0f
	const FRUITTREE_ROUTE_36        ; 10
	const FRUITTREE_ROUTE_38        ; 11
	const FRUITTREE_ROUTE_39        ; 12
	const FRUITTREE_ROUTE_43        ; 13
	const FRUITTREE_ROUTE_44        ; 14
	const FRUITTREE_ROUTE_45        ; 15
	const FRUITTREE_ROUTE_46_1      ; 16
	const FRUITTREE_ROUTE_46_2      ; 17
	const FRUITTREE_ROUTE_27        ; 18
	const FRUITTREE_ROUTE_26        ; 19
	const FRUITTREE_ROUTE_8         ; 1a
	const FRUITTREE_ROUTE_11        ; 1b
	const FRUITTREE_FUCHSIA_CITY    ; 1c
	const FRUITTREE_PEWTER_CITY_1   ; 1d
	const FRUITTREE_PEWTER_CITY_2   ; 1e
	const FRUITTREE_ROUTE_2         ; 1f
	const FRUITTREE_ROUTE_1         ; 20
	const FRUITTREE_LUCKY_ISLAND    ; 21
	const FRUITTREE_SHAMOUTI_ISLAND ; 22
	const FRUITTREE_ROUTE_49        ; 23
NUM_FRUIT_TREES EQU const_value - 1

; hidden grottoes
; HiddenGrottoData indexes (see data/events/hidden_grottoes/grottoes.asm)
	const_def 1
	const HIDDENGROTTO_ROUTE_32           ; 01
	const HIDDENGROTTO_ILEX_FOREST        ; 02
	const HIDDENGROTTO_ROUTE_35           ; 03
	const HIDDENGROTTO_LAKE_OF_RAGE       ; 04
	const HIDDENGROTTO_05                 ; 05
	const HIDDENGROTTO_06                 ; 06
	const HIDDENGROTTO_07                 ; 07
	const HIDDENGROTTO_08                 ; 08
	const HIDDENGROTTO_09                 ; 09
	const HIDDENGROTTO_0A                 ; 0a
	const HIDDENGROTTO_0B                 ; 0b
	const HIDDENGROTTO_0C                 ; 0c
	const HIDDENGROTTO_0D                 ; 0d
	const HIDDENGROTTO_0E                 ; 0e
	const HIDDENGROTTO_0F                 ; 0f
	const HIDDENGROTTO_10                 ; 10
	const HIDDENGROTTO_11                 ; 11
	const HIDDENGROTTO_12                 ; 12
	const HIDDENGROTTO_13                 ; 13
	const HIDDENGROTTO_14                 ; 14
	const HIDDENGROTTO_15                 ; 15
	const HIDDENGROTTO_16                 ; 16
	const HIDDENGROTTO_17                 ; 17
NUM_HIDDEN_GROTTOES EQU const_value - 1

; describedecoration arguments
; DescribeDecoration.JumpTable indexes (see engine/overworld/decorations.asm)
	const_def
	const DECODESC_POSTER     ; 0
	const DECODESC_LEFT_DOLL  ; 1
	const DECODESC_RIGHT_DOLL ; 2
	const DECODESC_BIG_DOLL   ; 3
	const DECODESC_CONSOLE    ; 4
NUM_DECODESCS EQU const_value

; swarm arguments
; StoreSwarmMapIndices arguments
	const_def
	const SWARM_DUNSPARCE ; 0
	const SWARM_YANMA     ; 1

; ActivateFishingSwarm setval arguments
	const_def
	const FISHSWARM_NONE     ; 0
	const FISHSWARM_QWILFISH ; 1
	const FISHSWARM_REMORAID ; 2

; CheckMagikarpLength return values
	const_def
	const MAGIKARPLENGTH_NOT_MAGIKARP ; 0
	const MAGIKARPLENGTH_REFUSED      ; 1
	const MAGIKARPLENGTH_TOO_SHORT    ; 2
	const MAGIKARPLENGTH_BEAT_RECORD  ; 3

; ReturnShuckie return values
	const_def
	const SHUCKIE_WRONG_MON ; 0
	const SHUCKIE_REFUSED   ; 1
	const SHUCKIE_RETURNED  ; 2
	const SHUCKIE_HAPPY     ; 3
	const SHUCKIE_FAINTED   ; 4

; CheckPartyFullAfterContest return values
	const_def
	const BUGCONTEST_CAUGHT_MON ; 0
	const BUGCONTEST_BOXED_MON  ; 1
	const BUGCONTEST_NO_CATCH   ; 2

; Bug-Catching Contest values
BUG_CONTEST_BALLS EQU 20
if DEF(NO_RTC)
BUG_CONTEST_MINUTES EQU 20 * NO_RTC_SPEEDUP
else
BUG_CONTEST_MINUTES EQU 20
endc
BUG_CONTEST_SECONDS EQU 0
BUG_CONTEST_PLAYER EQU 1
NUM_BUG_CONTESTANTS EQU 10 ; not counting the player
BUG_CONTESTANT_SIZE EQU 4

; HealMachineAnim setval arguments
; HealMachineAnim.Pointers indexes (see engine/events/heal_machine_anim.asm)
	const_def
	const HEALMACHINE_POKECENTER   ; 0
	const HEALMACHINE_ELMS_LAB     ; 1
	const HEALMACHINE_HALL_OF_FAME ; 2

; UnownPuzzle setval arguments
; LoadUnownPuzzlePiecesGFX.LZPointers indexes (see engine/games/unown_puzzle.asm)
	const_def
	const UNOWNPUZZLE_KABUTO     ; 0
	const UNOWNPUZZLE_OMANYTE    ; 1
	const UNOWNPUZZLE_AERODACTYL ; 2
	const UNOWNPUZZLE_HO_OH      ; 3
NUM_UNOWN_PUZZLES EQU const_value

; DisplayUnownWords setval arguments
; UnownWalls and MenuHeaders_UnownWalls indexes (see data/events/unown_walls.asm)
	const_def
	const UNOWNWORDS_ESCAPE ; 0
	const UNOWNWORDS_LIGHT  ; 1
	const UNOWNWORDS_WATER  ; 2
	const UNOWNWORDS_HO_OH  ; 3

; paintingpic arguments
; PaintingPicPointers indexes (see data/events/paintings/pic_pointers.asm)
; PaintingPalettes indexes (see data/events/paintings/palettes.asm)
	const_def
	const HO_OH_PAINTING
	const LUGIA_PAINTING
	const BELL_TOWER_PAINTING
	const KABUTO_PUZZLE
	const OMANYTE_PUZZLE
	const AERODACTYL_PUZZLE
	const HO_OH_PUZZLE
NUM_PAINTINGS EQU const_value
