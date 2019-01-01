; sprite types
	const_def 1
	const WALKING_SPRITE
	const STANDING_SPRITE
	const STILL_SPRITE
	const MON_SPRITE
	const BIG_GYARADOS_SPRITE

; sprite header fields
	const_def
	const SPRITEHEADER_ADDR_LO
	const SPRITEHEADER_ADDR_HI
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

; for object_events
	const_def (1 << 3)
	const PAL_NPC_RED    ; 8
	const PAL_NPC_BLUE   ; 9
	const PAL_NPC_GREEN  ; a
	const PAL_NPC_BROWN  ; b
	const PAL_NPC_PURPLE ; c
	const PAL_NPC_SILVER ; d
	const PAL_NPC_TREE   ; e
	const PAL_NPC_ROCK   ; f

; for party menu icons
	const_def PAL_OW_SILVER
	const PAL_OW_GRAY   ; 5
	const PAL_OW_PINK   ; 6
	const PAL_OW_TEAL   ; 7
