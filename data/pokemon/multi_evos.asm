; Used for Lyra to describe multiple evolutions (see engine/phone/scripts/lyra.asm)

MACRO multi_evo
; mon, EVOLVE_* value
	if _NARG == 1
		dp \1, PLAIN_FORM
		db EVOLVE_\1
	elif _NARG == 2
		dp \1
		db \2
	else
		dp \1, \2
		db \3
	endc
ENDM

MultipleEvolutions:
	multi_evo PIKACHU
	multi_evo PIKACHU, PIKACHU_FLY_FORM, EVOLVE_PIKACHU
	multi_evo PIKACHU, PIKACHU_SURF_FORM, EVOLVE_PIKACHU
	multi_evo GLOOM
	multi_evo POLIWHIRL
	multi_evo SLOWPOKE
	multi_evo SLOWPOKE, GALARIAN_FORM, EVOLVE_SLOWPOKE_GALARIAN
	multi_evo MAGNETON
	multi_evo EXEGGCUTE
	multi_evo KOFFING
	multi_evo CUBONE
	multi_evo SCYTHER
	multi_evo EEVEE
	multi_evo MIME_JR_
	multi_evo URSARING
	multi_evo STANTLER
	multi_evo DUNSPARCE, DUDUNSPARCE_TWO_SEGMENT_FORM, EVOLVE_DUNSPARCE
	multi_evo DUNSPARCE, DUDUNSPARCE_THREE_SEGMENT_FORM, EVOLVE_DUNSPARCE
	dw -1
