; overworld_sprite struct members (see data/sprites/sprites.asm)
rsreset
DEF SPRITEDATA_ADDR     rw ; 0
DEF SPRITEDATA_BANK     rb ; 2
DEF SPRITEDATA_TYPE_PAL rb ; 3
DEF SPRITEDATA_LENGTH EQU _RS

DEF SPRITEDATA_TYPE_MASK    EQU %11000000
DEF SPRITEDATA_PALETTE_MASK EQU %00111111

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
; DarknessOBPalette indexes (see gfx/overworld/npc_sprites_darkness.pal)
; OvercastOBPalette indexes (see gfx/overworld/npc_sprites_overcast.pal)
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
	ow_npc_pal_const AZURE             ; 0a
	ow_npc_pal_const WHITE             ; 0b
	ow_npc_pal_const BLACK             ; 0c
	ow_npc_pal_const POKE_BALL         ; 0d (red)
	ow_npc_pal_const DECO_ITEM         ; 0e (blue)
	ow_npc_pal_const KEY_ITEM          ; 0f (green)
	ow_npc_pal_const MARLON            ; 10
	ow_npc_pal_const SAILBOAT          ; 11
	ow_npc_pal_const RAIN              ; 12
	ow_npc_pal_const SAND              ; 13
DEF NUM_OW_TIME_OF_DAY_PALS EQU const_value
; SingleObjectPals indexes (see gfx/overworld/npc_single_object.pal)
	ow_npc_pal_const EMOTE_GRAY        ; 14
	ow_npc_pal_const EMOTE_BLACK       ; 15
	ow_npc_pal_const EMOTE_GREEN       ; 16
	ow_npc_pal_const EMOTE_PURPLE      ; 17
	ow_npc_pal_const EMOTE_RED         ; 18
	ow_npc_pal_const EMOTE_ORANGE      ; 19
	ow_npc_pal_const EMOTE_BLUE        ; 1a
	ow_npc_pal_const ELECTRIC_FENCE    ; 1b
	ow_npc_pal_const LIGHTNING_CRYSTAL ; 1c
	ow_npc_pal_const ROCK_CRYSTAL      ; 1d
	ow_npc_pal_const N64               ; 1e
	ow_npc_pal_const POKECOM_SIGN      ; 1f
	ow_npc_pal_const RANGI             ; 20
	ow_npc_pal_const DRILL             ; 21
	ow_npc_pal_const PEARL             ; 22
	ow_npc_pal_const TINY_WINDOW       ; 23
DEF NUM_OW_INDIVIDUAL_PALS EQU const_value - NUM_OW_TIME_OF_DAY_PALS
DEF FIRST_COPY_BG_PAL EQU const_value
	ow_npc_pal_const COPY_BG_GRAY      ; 24
	ow_npc_pal_const COPY_BG_RED       ; 25
	ow_npc_pal_const COPY_BG_GREEN     ; 26
	ow_npc_pal_const COPY_BG_WATER     ; 27
	ow_npc_pal_const COPY_BG_YELLOW    ; 28
	ow_npc_pal_const COPY_BG_BROWN     ; 29
	ow_npc_pal_const COPY_BG_ROOF      ; 2a
	ow_npc_pal_const COPY_BG_TEXT      ; 2b
DEF NUM_OW_BG_COPY_PALS EQU const_value - NUM_OW_INDIVIDUAL_PALS
DEF NUM_OW_PALS EQU const_value

; used by wLoadedObjPal0-7 to mark that no palette is loaded
DEF NO_PAL_LOADED EQU -1

; fixed palette indexes
DEF PAL_OW_WEATHER EQU 6
