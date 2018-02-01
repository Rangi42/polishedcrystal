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
	const_def PAL_OW_SILVER
	const PAL_OW_GRAY   ; 5
	const PAL_OW_PINK   ; 6
	const PAL_OW_TEAL   ; 7
