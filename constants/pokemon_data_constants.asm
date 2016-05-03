; growth rate
	const_def
	const MEDIUM_FAST
	const SLIGHTLY_FAST
	const SLIGHTLY_SLOW
	const MEDIUM_SLOW
	const SLOW
	const FAST

; egg group constants
const_value SET 1
	const MONSTER      ; 1
	const AMPHIBIAN    ; 2
	const INSECT       ; 3
	const AVIAN        ; 4
	const FIELD        ; 5
	const FAERY        ; 6
	const PLANT        ; 7
	const HUMANSHAPE   ; 8
	const INVERTEBRATE ; 9
	const INANIMATE    ; a
	const AMORPHOUS    ; b
	const FISH         ; c
	const LADIES_MAN   ; d
	const REPTILE      ; e
	const NO_EGGS      ; f


; menu sprites
const_value SET 1
	const ICON_POLIWAG
	const ICON_JIGGLYPUFF
	const ICON_DIGLETT
	const ICON_PIKACHU
	const ICON_STARYU
	const ICON_FISH
	const ICON_BIRD
	const ICON_MONSTER
	const ICON_CLEFAIRY
	const ICON_ODDISH
	const ICON_BUG
	const ICON_GHOST
	const ICON_LAPRAS
	const ICON_HUMANSHAPE
	const ICON_FOX
	const ICON_EQUINE
	const ICON_SHELL
	const ICON_BLOB
	const ICON_SERPENT
	const ICON_VOLTORB
	const ICON_SQUIRTLE
	const ICON_BULBASAUR
	const ICON_CHARMANDER
	const ICON_CATERPILLAR
	const ICON_UNOWN
	const ICON_GEODUDE
	const ICON_FIGHTER
	const ICON_EGG
	const ICON_JELLYFISH
	const ICON_MOTH
	const ICON_BAT
	const ICON_SNORLAX
	const ICON_HO_OH
	const ICON_LUGIA
	const ICON_GYARADOS
	const ICON_SLOWPOKE
	const ICON_SUDOWOODO
	const ICON_BIGMON
	const ICON_POLIWAG2
	const ICON_JIGGLYPUFF2
	const ICON_DIGLETT2
	const ICON_PIKACHU2
	const ICON_STARYU2
	const ICON_FISH2
	const ICON_BIRD2
	const ICON_MONSTER2
	const ICON_CLEFAIRY2
	const ICON_ODDISH2
	const ICON_BUG2
	const ICON_GHOST2
	const ICON_LAPRAS2
	const ICON_HUMANSHAPE2
	const ICON_FOX2
	const ICON_EQUINE2
	const ICON_SHELL2
	const ICON_BLOB2
	const ICON_SERPENT2
	const ICON_VOLTORB2
	const ICON_SQUIRTLE2
	const ICON_BULBASAUR2
	const ICON_CHARMANDER2
	const ICON_CATERPILLAR2
	const ICON_UNOWN2
	const ICON_GEODUDE2
	const ICON_FIGHTER2
	const ICON_EGG2
	const ICON_JELLYFISH2
	const ICON_MOTH2
	const ICON_BAT2
	const ICON_SNORLAX2
	const ICON_HO_OH2
	const ICON_LUGIA2
	const ICON_GYARADOS2
	const ICON_SLOWPOKE2
	const ICON_SUDOWOODO2
	const ICON_BIGMON2

; evolution types
const_value SET 1
	const EVOLVE_LEVEL
	const EVOLVE_ITEM
	const EVOLVE_TRADE
	const EVOLVE_HAPPINESS
	const EVOLVE_STAT


BASE_HAPPINESS        EQU 70
FRIEND_BALL_HAPPINESS EQU 200

; happiness evolution triggers
HAPPINESS_TO_EVOLVE EQU 220
const_value SET 1
	const TR_ANYTIME
	const TR_MORNDAY
	const TR_NITE


; stat evolution triggers
const_value SET 1
	const ATK_GT_DEF
	const ATK_LT_DEF
	const ATK_EQ_DEF

NUM_GRASSMON EQU 7
NUM_WATERMON EQU 3

GRASS_WILDDATA_LENGTH EQU (NUM_GRASSMON * 2 + 1) * 3 + 2
WATER_WILDDATA_LENGTH EQU (NUM_WATERMON * 2 + 1) * 1 + 2
