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

; sprite palettes
	const_def
	const PAL_OW_RED        ; 0
	const PAL_OW_BLUE       ; 1
	const PAL_OW_GREEN      ; 2
	const PAL_OW_BROWN      ; 3
	const PAL_OW_PURPLE     ; 4
	const PAL_OW_SILVER     ; 5
	const PAL_OW_TREE       ; 6
	const PAL_OW_ROCK       ; 7
	const PAL_OW_GRAY       ; 8
	const PAL_OW_PINK       ; 9
	const PAL_OW_TEAL       ; a
	const PAL_OW_EMOTE_WWBB ; b
	const PAL_OW_EMOTE_WWGB ; c
	const PAL_OW_EMOTE_WWPB ; d
	const PAL_OW_EMOTE_WWRB ; e
	const PAL_OW_EMOTE_WWOB ; f
	const PAL_OW_EMOTE_WWUB ; 10
DEF NUM_OW_PALS EQU const_value

; object_events that set a pal value will override the sprite's default palette.
; MapObjectPals indexes (see gfx/overworld/npc_sprites.pal)
	const_def
	const PAL_OW_DEFAULT     ; 0
	const PAL_NPC_RED        ; 1
	const PAL_NPC_BLUE       ; 2
	const PAL_NPC_GREEN      ; 3
	const PAL_NPC_BROWN      ; 4
	const PAL_NPC_PURPLE     ; 5
	const PAL_NPC_SILVER     ; 6
	const PAL_NPC_TREE       ; 7
	const PAL_NPC_ROCK       ; 8
	const PAL_NPC_GRAY       ; 9
	const PAL_NPC_PINK       ; a
	const PAL_NPC_TEAL       ; b
	const PAL_NPC_EMOTE_WWBB ; c
	const PAL_NPC_EMOTE_WWGB ; d
	const PAL_NPC_EMOTE_WWPB ; e
	const PAL_NPC_EMOTE_WWRB ; f
	const PAL_NPC_EMOTE_WWOB ; 10
	const PAL_NPC_EMOTE_WWUB ; 11
	assert const_value == NUM_OW_PALS + 1
	assert const_value < 32
