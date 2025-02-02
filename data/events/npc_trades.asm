NPCTrades:
	table_width NPCTRADE_STRUCT_LENGTH
; NPC_TRADE_MIKE in Goldenrod City
	db TRADE_DIALOGSET_COLLECTOR
	dp ABRA, NO_FORM  ; wants
	dp MACHOP, FEMALE ; gives
	rawchar "Muscle@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_ATK_UP_SATK_DOWN,  LEVEL_BALL,   SITRUS_BERRY
	dw 37460
	rawchar "Mike@@@@", $00
; NPC_TRADE_KYLE in Violet City
	db TRADE_DIALOGSET_COLLECTOR
	dp POLIWAG, NO_FORM ; wants
	dp VOLTORB, MALE    ; gives
	rawchar "Mimic@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SPE_UP_DEF_DOWN,   PREMIER_BALL, PERSIM_BERRY
	dw 48926
	rawchar "Kyle@@@@", $00
; NPC_TRADE_TIM in Olivine City
	db TRADE_DIALOGSET_HAPPY
	dp STEELIX, NO_FORM ; wants
	dp KANGASKHAN, MALE ; gives
	rawchar "Joey@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_ATK_UP_SPE_DOWN,   HEAVY_BALL,   SILK_SCARF
	dw 29189
	rawchar "Tim@@@@@", $00
; NPC_TRADE_EMY in Blackthorn City
	db TRADE_DIALOGSET_GIRL
	dp JYNX, NO_FORM    ; wants
	dp MR__MIME, FEMALE ; gives
	rawchar "Doris@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SPE_UP_ATK_DOWN,   LOVE_BALL,    PINK_BOW
	dw 00283
	rawchar "Emy@@@@@", $00
; NPC_TRADE_CHRIS in Pewter City
	db TRADE_DIALOGSET_NEWBIE
	dp PINSIR, NO_FORM ; wants
	dp HERACROSS, MALE ; gives
	rawchar "Paul@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SPE_UP_SATK_DOWN,  PARK_BALL,    SILVERPOWDER
	dw 15616
	rawchar "Chris@@@", $00
; NPC_TRADE_KIM in Route 14
	db TRADE_DIALOGSET_GIRL
	dp WOBBUFFET, NO_FORM ; wants
	dp CHANSEY, FEMALE    ; gives
	rawchar "Chance@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SDEF_UP_ATK_DOWN,  HEAL_BALL,    LUCKY_EGG
	dw 26491
	rawchar "Kim@@@@@", $00
; NPC_TRADE_JACQUES in Goldenrod Harbor
	db TRADE_DIALOGSET_HAPPY
	dp TENTACOOL, NO_FORM ; wants
	dp GRIMER, FEMALE     ; gives
	rawchar "Gail@@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SDEF_UP_SATK_DOWN, LURE_BALL,    EVIOLITE
	dw 50082
	rawchar "Jacques@", $00
; NPC_TRADE_HARI in Ecruteak City
	db TRADE_DIALOGSET_COLLECTOR
	dp FARFETCH_D, NO_FORM ; wants
	dp DODUO, MALE         ; gives
	rawchar "Clarence@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_SPE_UP_DEF_DOWN,   FAST_BALL,    GOLD_LEAF
	dw 43972
	rawchar "Hari@@@@", $00
; NPC_TRADE_JEEVES
	db TRADE_DIALOGSET_COLLECTOR
	dp PONYTA, NO_FORM               ; wants
	dp WEEZING, GALARIAN_FORM | MALE ; gives
	rawchar "Batty@@@@@@"
	db $EE, $EE, $EE, HIDDEN_ABILITY | NAT_DEF_UP_ATK_DOWN,   DREAM_BALL,   CHARCOAL
	dw 08922
	rawchar "Jeeves@@", $00
	assert_table_length NUM_NPC_TRADES
