; pc themes (see data/bills_pc_theme_names.asm)
	const_def
	const THEME_STANDARD
	const THEME_PRO
	const THEME_MOBILE
	const THEME_CLASSIC
	const THEME_BLISS
	const THEME_CONTRAST
	const THEME_NATURE
	const THEME_TRUTH
	const THEME_IDEALS
	const THEME_LIGHT
	const THEME_DARKNESS
	const THEME_MATTE
	const THEME_NORMAL
	const THEME_FIGHTING
	const THEME_FLYING
	const THEME_POISON
	const THEME_GROUND
	const THEME_ROCK
	const THEME_BUG
	const THEME_GHOST
	const THEME_STEEL
	const THEME_FIRE
	const THEME_WATER
	const THEME_GRASS
	const THEME_ELECTRIC
	const THEME_PSYCHIC
	const THEME_ICE
	const THEME_DRAGON
	const THEME_DARK
	const THEME_FAIRY
NUM_BILLS_PC_THEMES EQU const_value

; sprite animation parameters
PCANIM_STATIC      EQU  0 ; used when holding stuff, we don't want to bop then
PCANIM_ANIMATE     EQU 90 ; baseline
PCANIM_PICKUP      EQU 91 ; we're picking up/placing down something
PCANIM_PICKUP_NEXT EQU 98 ; cursor is at the bottom, ready for pickup
PCANIM_QUICKFRAMES EQU  9
