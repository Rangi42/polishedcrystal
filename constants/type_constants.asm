	const_def
	; Type order matters for Hidden Power and non-PSS category
	const NORMAL    ; 0
	const FIGHTING  ; 1
	const FLYING    ; 2
	const POISON    ; 3
	const GROUND    ; 4
	const ROCK      ; 5
	const BUG       ; 6
	const GHOST     ; 7
	const STEEL     ; 8
SPECIAL_TYPES EQU const_value
	const FIRE      ; 9
	const WATER     ; 10
	const GRASS     ; 11
	const ELECTRIC  ; 12
	const PSYCHIC   ; 13
	const ICE       ; 14
	const DRAGON    ; 15
	const DARK      ; 16
	const FAIRY     ; 17
	const UNKNOWN_T ; 18

	const_def
	const PHYSICAL
	const SPECIAL
	const STATUS
