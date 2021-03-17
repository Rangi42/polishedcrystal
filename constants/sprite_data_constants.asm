; overworld_sprite struct members (see data/sprites/sprites.asm)
rsreset
SPRITEDATA_ADDR    rw ; 0
SPRITEDATA_BANK    rb ; 2
SPRITEDATA_TYPE    rb ; 3
SPRITEDATA_PALETTE rb ; 4
NUM_SPRITEDATA_FIELDS EQU _RS

; sprite types
	const_def 1
	const WALKING_SPRITE      ; 1
	const STANDING_SPRITE     ; 2
	const MON_SPRITE          ; 3
	const BIG_GYARADOS_SPRITE ; 4

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
	const_def PAL_OW_SILVER
	const PAL_OW_GRAY   ; 5
	const PAL_OW_PINK   ; 6
	const PAL_OW_TEAL   ; 7

; object_events set bit 3 so as not to use the sprite's default palette
; MapObjectPals indexes (see gfx/overworld/npc_sprites.pal)
	const_def 1 << 3
	const PAL_NPC_RED    ; 8
	const PAL_NPC_BLUE   ; 9
	const PAL_NPC_GREEN  ; a
	const PAL_NPC_BROWN  ; b
	const PAL_NPC_PURPLE ; c
	const PAL_NPC_SILVER ; d
	const PAL_NPC_TREE   ; e
	const PAL_NPC_ROCK   ; f
