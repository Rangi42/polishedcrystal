npctrade: MACRO
	db \1, \2, \3, \4 ; dialog set, requested mon, offered mon, nickname
	db \5, \6, \7 ; dvs
	db \8, \9 ; personality
	shift
	db \9 ; item
	shift
	db \9 ; ball
	shift
	dw \9 ; OT ID
	shift
	db \9, 0 ; OT name
ENDM

NPCTrades:
; OT names have 3 characters less padding so the total struct is 31 bytes
; TRADE_WITH_MIKE_FOR_MACHOP in Goldenrod City
	npctrade 0, ABRA,       MACHOP,     "M","u","s","c","l","e","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | ADAMANT, MALE,   LEVEL_BALL,   SITRUS_BERRY, \
		37460, "M","i","k","e","@","@","@","@"
; TRADE_WITH_KYLE_FOR_VOLTORB in Violet City
	npctrade 0, POLIWAG,    VOLTORB,    "M","i","m","i","c","@","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | HASTY,   MALE,   PREMIER_BALL, PERSIM_BERRY, \
		48926, "K","y","l","e","@","@","@","@"
; TRADE_WITH_TIM_FOR_KANGASKHAN in Olivine City
	npctrade 1, STEELIX,    KANGASKHAN, "J","o","e","y","@","@","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | BRAVE,   MALE,   HEAVY_BALL,   SILK_SCARF,   \
		29189, "T","i","m","@","@","@","@","@"
; TRADE_WITH_EMY_FOR_MR__MIME in Blackthorn City
	npctrade 3, JYNX,       MR__MIME,   "D","o","r","i","s","@","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | TIMID,   FEMALE, LOVE_BALL,    PINK_BOW,     \
		00283, "E","m","y","@","@","@","@","@"
; TRADE_WITH_CHRIS_FOR_HERACROSS in Pewter City
	npctrade 2, PINSIR,     HERACROSS,  "P","a","u","l","@","@","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | JOLLY,   MALE,   PARK_BALL,    SILVERPOWDER, \
		15616, "C","h","r","i","s","@","@","@"
; TRADE_WITH_KIM_FOR_CHANSEY in Route 14
	npctrade 3, WOBBUFFET,  CHANSEY,    "C","h","a","n","c","e","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | CALM,    FEMALE, HEAL_BALL,    LUCKY_EGG,    \
		26491, "K","i","m","@","@","@","@","@"
; TRADE_WITH_JACQUES_FOR_GRIMER in Goldenrod Harbor
	npctrade 1, TENTACOOL,  GRIMER,     "G","a","i","l","@","@","@","@","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | CAREFUL, FEMALE, LURE_BALL,    EVIOLITE,     \
		50082, "J","a","c","q","u","e","s","@"
; TRADE_WITH_HARI_FOR_DODUO in Ecruteak City
	npctrade 0, FARFETCH_D, DODUO,      "C","l","a","r","e","n","c","e","@","@","@", \
		$EE, $EE, $EE, HIDDEN_ABILITY | HASTY,   MALE,   FAST_BALL,    GOLD_LEAF,    \
		43972, "H","a","r","i","@","@","@","@"
