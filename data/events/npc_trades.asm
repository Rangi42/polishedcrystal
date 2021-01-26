NPCTrades:
; OT names have 3 characters less padding so the total struct is 32 bytes
; TRADE_WITH_MIKE_FOR_MACHOP in Goldenrod City
	rawchar 0, ABRA,       MACHOP,     "Muscle@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | ADAMANT, FEMALE, LEVEL_BALL,   SITRUS_BERRY
	dw 37460
	rawchar "Mike@@@@", $00
; TRADE_WITH_KYLE_FOR_VOLTORB in Violet City
	rawchar 0, POLIWAG,    VOLTORB,    "Mimic@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | HASTY,   MALE,   PREMIER_BALL, PERSIM_BERRY
	dw 48926
	rawchar "Kyle@@@@", $00
; TRADE_WITH_TIM_FOR_KANGASKHAN in Olivine City
	rawchar 1, STEELIX,    KANGASKHAN, "Joey@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | BRAVE,   MALE,   HEAVY_BALL,   SILK_SCARF
	dw 29189
	rawchar "Tim@@@@@", $00
; TRADE_WITH_EMY_FOR_MR__MIME in Blackthorn City
	rawchar 3, JYNX,       MR__MIME,   "Doris@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | TIMID,   FEMALE, LOVE_BALL,    PINK_BOW
	dw 00283
	rawchar "Emy@@@@@", $00
; TRADE_WITH_CHRIS_FOR_HERACROSS in Pewter City
	rawchar 2, PINSIR,     HERACROSS,  "Paul@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | JOLLY,   MALE,   PARK_BALL,    SILVERPOWDER
	dw 15616
	rawchar "Chris@@@", $00
; TRADE_WITH_KIM_FOR_CHANSEY in Route 14
	rawchar 3, WOBBUFFET,  CHANSEY,    "Chance@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | CALM,    FEMALE, HEAL_BALL,    LUCKY_EGG
	dw 26491
	rawchar "Kim@@@@@", $00
; TRADE_WITH_JACQUES_FOR_GRIMER in Goldenrod Harbor
	rawchar 1, TENTACOOL,  GRIMER,     "Gail@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | CAREFUL, FEMALE, LURE_BALL,    EVIOLITE
	dw 50082
	rawchar "Jacques@", $00
; TRADE_WITH_HARI_FOR_DODUO in Ecruteak City
	rawchar 0, FARFETCH_D, DODUO,      "Clarence@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | HASTY,   MALE,   FAST_BALL,    GOLD_LEAF
	dw 43972
	rawchar "Hari@@@@", $00
