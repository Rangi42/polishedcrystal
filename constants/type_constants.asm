; TypeNames indexes (see data/types/names.asm)
; also used in:
; - PokedexTypeSearchConversionTable (see data/types/search_types.asm)
; - PokedexTypeSearchStrings (see data/types/search_strings.asm)
; - TypeMatchups (see data/types/type_matchups.asm)
; - InverseTypeMatchups (see data/types/type_matchups.asm)
	const_def
	; Type order matters for Hidden Power and non-PSS category
	const NORMAL    ; 00
	const FIGHTING  ; 01
	const FLYING    ; 02
	const POISON    ; 03
	const GROUND    ; 04
	const ROCK      ; 05
	const BUG       ; 06
	const GHOST     ; 07
	const STEEL     ; 08
SPECIAL_TYPES EQU const_value
	const FIRE      ; 09
	const WATER     ; 0a
	const GRASS     ; 0b
	const ELECTRIC  ; 0c
	const PSYCHIC   ; 0d
	const ICE       ; 0e
	const DRAGON    ; 0f
	const DARK      ; 10
	const FAIRY     ; 11
	const UNKNOWN_T ; 12
NUM_TYPES EQU const_value

; categories
	const_def
	const PHYSICAL
	const SPECIAL
	const STATUS

POKEDEX_TYPE_STRING_LENGTH EQU 9
