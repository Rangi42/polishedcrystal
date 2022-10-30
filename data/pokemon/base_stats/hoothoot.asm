	db  60,  30,  30,  50,  36,  56 ; 262 BST
	;   hp  atk  def  spe  sat  sdf

	db NORMAL, FLYING ; type
	db 255 ; catch rate
	db 58 ; base exp
	db NO_ITEM, NO_ITEM ; held items
	dn GENDER_F50, HATCH_FAST ; gender ratio, step cycles to hatch

	abilities_for HOOTHOOT, INSOMNIA, KEEN_EYE, TINTED_LENS
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	ev_yield 1 HP

	; tm/hm learnset
	tmhm CURSE, CALM_MIND, TOXIC, HIDDEN_POWER, SUNNY_DAY, PROTECT, RAIN_DANCE, RETURN, PSYCHIC, SHADOW_BALL, DOUBLE_TEAM, REFLECT, SWIFT, AERIAL_ACE, SUBSTITUTE, FACADE, REST, ATTRACT, THIEF, STEEL_WING, ROOST, FLASH, FLY, DOUBLE_EDGE, DREAM_EATER, ENDURE, HYPER_VOICE, SLEEP_TALK, SWAGGER, ZEN_HEADBUTT
	; end
