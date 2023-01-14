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
	ow_npc_pal_const SILVER            ; 05
	ow_npc_pal_const TREE              ; 06
	ow_npc_pal_const ROCK              ; 07
	ow_npc_pal_const GRAY              ; 08
	ow_npc_pal_const PINK              ; 09
	ow_npc_pal_const TEAL              ; 0a
	ow_npc_pal_const EMOTE_BLACK       ; 0b
	ow_npc_pal_const EMOTE_GREEN       ; 0c
	ow_npc_pal_const EMOTE_PURPLE      ; 0d
	ow_npc_pal_const EMOTE_RED         ; 0e
	ow_npc_pal_const EMOTE_ORANGE      ; 0f
	ow_npc_pal_const EMOTE_BLUE        ; 10
	ow_npc_pal_const MARLON            ; 11
	ow_npc_pal_const ELECTRIC_FENCE    ; 12
	ow_npc_pal_const LIGHTNING_CRYSTAL ; 13
DEF NUM_OW_STD_PALS EQU const_value
	ow_npc_pal_const COPY_BG_GREEN     ; 14
	ow_npc_pal_const COPY_BG_BROWN     ; 15
DEF NUM_OW_PALS EQU const_value
	assert NUM_OW_PALS < 32 ; PAL_NPC_* must fit in 5 bits
