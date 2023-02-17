; overworld_sprite struct members (see data/sprites/sprites.asm)
rsreset
DEF SPRITEDATA_ADDR    rw ; 0
DEF SPRITEDATA_BANK    rb ; 2
DEF SPRITEDATA_TYPE    rb ; 3
DEF SPRITEDATA_PALETTE rb ; 4
DEF NUM_SPRITEDATA_FIELDS EQU _RS

; sprite types
	const_def 1
	const WALKING_SPRITE      ; 1
	const STANDING_SPRITE     ; 2
	const MON_SPRITE          ; 3
	const BIG_GYARADOS_SPRITE ; 4

; object_events that set a pal value will override the sprite's default palette
DEF PAL_NPC_DEFAULT EQU 0

MACRO ow_npc_pal_const
	const PAL_OW_\1
	DEF PAL_NPC_\1 EQU PAL_OW_\1 + 1
ENDM

; sprite palettes
; MapObjectPals indexes (see gfx/overworld/npc_sprites.pal)
	const_def
	ow_npc_pal_const RED               ; 00
	ow_npc_pal_const BLUE              ; 01
	ow_npc_pal_const GREEN             ; 02
	ow_npc_pal_const BROWN             ; 03
	ow_npc_pal_const PURPLE            ; 04
	ow_npc_pal_const GRAY              ; 05
	ow_npc_pal_const PINK              ; 06
	ow_npc_pal_const TEAL              ; 07
	ow_npc_pal_const YELLOW            ; 08
	ow_npc_pal_const ORANGE            ; 09
	ow_npc_pal_const WHITE             ; 0a
	ow_npc_pal_const BLACK             ; 0b
	ow_npc_pal_const MARLON            ; 0c
	ow_npc_pal_const TREE              ; 0d
	ow_npc_pal_const SAILBOAT          ; 0e
DEF NUM_OW_TIME_OF_DAY_PALS EQU const_value
	ow_npc_pal_const EMOTE_GRAY        ; 0f
	ow_npc_pal_const EMOTE_BLACK       ; 10
	ow_npc_pal_const EMOTE_GREEN       ; 11
	ow_npc_pal_const EMOTE_PURPLE      ; 12
	ow_npc_pal_const EMOTE_RED         ; 13
	ow_npc_pal_const EMOTE_ORANGE      ; 14
	ow_npc_pal_const EMOTE_BLUE        ; 15
	ow_npc_pal_const ELECTRIC_FENCE    ; 16
	ow_npc_pal_const LIGHTNING_CRYSTAL ; 17
	ow_npc_pal_const ROCK_CRYSTAL      ; 18
	ow_npc_pal_const N64               ; 19
	ow_npc_pal_const POKECOM_SIGN      ; 1a
	ow_npc_pal_const RANGI             ; 1b
	ow_npc_pal_const DRILL             ; 1c
	ow_npc_pal_const PEARL             ; 1d
	ow_npc_pal_const TINY_WINDOW       ; 1e
DEF NUM_OW_INDIVIDUAL_PALS EQU const_value - NUM_OW_TIME_OF_DAY_PALS
	ow_npc_pal_const COPY_BG_GREEN     ; 1f
	ow_npc_pal_const COPY_BG_BROWN     ; 20
	ow_npc_pal_const COPY_BG_GRAY      ; 21
DEF NUM_OW_BG_COPY_PALS EQU const_value - NUM_OW_INDIVIDUAL_PALS
DEF NUM_OW_PALS EQU const_value
