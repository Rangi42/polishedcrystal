; decoration types
	const_def 1
	const DECO_PLANT
	const DECO_BED
	const DECO_CARPET
	const DECO_POSTER
	const DECO_DOLL
	const DECO_BIGDOLL

; DecorationNames indexes (see data/decorations/names.asm)
	const_def 1
	const PUT_IT_AWAY
	const MAGNAPLANT
	const TROPICPLANT
	const JUMBOPLANT
	const TOWN_MAP_D
	const SUPER_NES
	const NINTENDO_64
	const GAMECUBE
	const WII
	const GOLD_TROPHY
	const SILVER_TROPHY
	const SURF_PIKA_DOLL
	const _BED
	const _CARPET
	const _POSTER
	const _DOLL
	const BIG_
	const FEATHERY_BED
	const PIKACHU_BED
	const PINK_BED
	const POLKADOT_BED
	const RED_CARPET
	const BLUE_CARPET
	const YELLOW_CARPET
	const GREEN_CARPET

; DoDecorationAction2.DecoActions indexes (see engine/overworld/decorations.asm)
	const_def 1
	const SET_UP_BED
	const PUT_AWAY_BED
	const SET_UP_CARPET
	const PUT_AWAY_CARPET
	const SET_UP_PLANT
	const PUT_AWAY_PLANT
	const SET_UP_POSTER
	const PUT_AWAY_POSTER
	const SET_UP_CONSOLE
	const PUT_AWAY_CONSOLE
	const SET_UP_BIG_DOLL
	const PUT_AWAY_BIG_DOLL
	const SET_UP_DOLL
	const PUT_AWAY_DOLL
	const SET_UP_ORNAMENT
	const PUT_AWAY_ORNAMENT

__deco_value__ = 0

deco: MACRO
	const DECO_\1
DECOFLAG_\1 EQU __deco_value__
__deco_value = __deco_value__ + 1
ENDM

; decorations:
; - DecorationAttributes (see data/decorations/attributes.asm)
; - DecorationIDs (see data/decorations/decorations.asm)
	const_def 1
; FindOwnedBeds.beds values (see engine/overworld/decorations.asm)
	const BEDS
	deco  FEATHERY_BED
	deco  PINK_BED
	deco  POLKADOT_BED
	deco  PIKACHU_BED
; FindOwnedCarpets.carpets values (see engine/overworld/decorations.asm)
	const CARPETS
	deco  RED_CARPET
	deco  BLUE_CARPET
	deco  YELLOW_CARPET
	deco  GREEN_CARPET
; FindOwnedPlants.plants values (see engine/overworld/decorations.asm)
	const PLANTS
	deco  MAGNAPLANT
	deco  TROPICPLANT
	deco  JUMBOPLANT
; FindOwnedPosters.posters values (see engine/overworld/decorations.asm)
	const POSTERS
	deco  TOWN_MAP
	deco  PIKACHU_POSTER
	deco  CLEFAIRY_POSTER
	deco  MARILL_POSTER
; FindOwnedConsoles.consoles values (see engine/overworld/decorations.asm)
	const CONSOLES
	deco  SNES
	deco  N64
	deco  GAMECUBE
	deco  WII
; FindOwnedBigDolls.big_dolls values (see engine/overworld/decorations.asm)
	const BIG_DOLLS
	deco  BIG_SNORLAX_DOLL
	deco  BIG_ONIX_DOLL
	deco  BIG_LAPRAS_DOLL
; FindOwnedOrnaments.ornaments values (see engine/overworld/decorations.asm)
	const DOLLS
	deco  PIKACHU_DOLL
	deco  RAICHU_DOLL
	deco  SURF_PIKACHU_DOLL
	deco  CLEFAIRY_DOLL
	deco  JIGGLYPUFF_DOLL
	deco  BULBASAUR_DOLL
	deco  CHARMANDER_DOLL
	deco  SQUIRTLE_DOLL
	deco  CHIKORITA_DOLL
	deco  CYNDAQUIL_DOLL
	deco  TOTODILE_DOLL
	deco  POLIWAG_DOLL
	deco  MAREEP_DOLL
	deco  TOGEPI_DOLL
	deco  MAGIKARP_DOLL
	deco  ODDISH_DOLL
	deco  GENGAR_DOLL
	deco  OCTILLERY_DOLL
	deco  DITTO_DOLL
	deco  VOLTORB_DOLL
	deco  ABRA_DOLL
	deco  UNOWN_DOLL
	deco  GEODUDE_DOLL
	deco  PINECO_DOLL
	deco  MARILL_DOLL
	deco  TEDDIURSA_DOLL
	deco  MEOWTH_DOLL
	deco  VULPIX_DOLL
	deco  GROWLITHE_DOLL
	deco  EEVEE_DOLL
NUM_NON_TROPHY_DECOS EQU __deco_value__
	deco  GOLD_TROPHY_DOLL
	deco  SILVER_TROPHY_DOLL
NUM_DECOS EQU __deco_value__
