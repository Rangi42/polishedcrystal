; pc themes (see data/bills_pc_theme_names.asm)
	const_def
	const THEME_STANDARD
	const THEME_PRO
	const THEME_MOBILE
	const THEME_CLASSIC
	const THEME_BLISS
	const THEME_CONTRAST
	const THEME_NATURE
	const THEME_HEART
	const THEME_SOUL
	const THEME_TRUTH
	const THEME_IDEALS
	const THEME_LIGHT
	const THEME_DARKNESS
	const THEME_MATTE
	const THEME_MATRIX
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
DEF NUM_BILLS_PC_THEMES EQU const_value

; BillsPC_CanReleaseMon constants
	const_def
	const RELEASE_OK
	const RELEASE_LAST_HEALTHY
	const RELEASE_EGG
	const RELEASE_HM
	const RELEASE_EMPTY

	const_def
	; SwapStorageBoxSlots return values
	const PCSWAP_OK
	const PCSWAP_SAVE_REQUIRED
	const PCSWAP_PARTY_FULL
	const PCSWAP_BOX_FULL
	const PCSWAP_LAST_HEALTHY
	const PCSWAP_HOLDING_MAIL

	; an extension to the above for items in BillsPC_SwapStorage
	const PCSWAP_CANT_STORE_MAIL
	const PCSWAP_EGGS_CANT_HOLD
	const PCSWAP_CANT_POCKET_MAIL
	const PCSWAP_PACK_FULL

; sprite animation parameters
DEF PCANIM_STATIC      EQU  0 ; used when holding stuff, we don't want to bop then
DEF PCANIM_ANIMATE     EQU 90 ; baseline
DEF PCANIM_PICKUP      EQU 91 ; we're picking up/placing down something
DEF PCANIM_PICKUP_NEXT EQU 98 ; cursor is at the bottom, ready for pickup
DEF PCANIM_QUICKFRAMES EQU  9
