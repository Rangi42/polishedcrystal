PsychicInversHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, ROUTE_16_WEST, 1
	warp_event  3,  7, ROUTE_16_WEST, 1

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, difficultbookshelf

	def_object_events
	object_event  2,  2, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PsychicInverScript, -1
	object_event  6,  3, SPRITE_HEX_MANIAC, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, PsychicInversHouseHexManiacText, -1

	object_const_def
	const PSYCHICINVERSHOUSE_INVER

PsychicInverScript:
	checkflag ENGINE_FOUGHT_PSYCHIC_INVER
	iftrue_jumptextfaceplayer PsychicInverTomorrowText
	faceplayer
	opentext
	writetext PsychicInverGreetingText
	yesorno
	iffalse_jumpopenedtext PsychicInverNoText
	writetext PsychicInverYesText
	waitbutton
	closetext
	setflag ENGINE_FOUGHT_PSYCHIC_INVER
	winlosstext PsychicInverBeatenText, 0
	setlasttalked PSYCHICINVERSHOUSE_INVER
; TODO: pick six random Pokémon from a larger pool
	loadtrainer INVER, 1
	loadvar VAR_BATTLETYPE, BATTLETYPE_INVERSE
	startbattle
	reloadmapafterbattle
	opentext
	readmem wInverseBattleScore
	ifequal 0, .Score0
	ifgreater 127, .Score0 ; negative
	ifless 4, .Score1_3
	ifless 7, .Score4_6
	ifless 10, .Score7_9
	writetext InverseBattle10PointRewardText
	setval RARE_CANDY
.Reward
	waitbutton
	writetext PsychicInverRewardText
.GiveReward
	promptbutton
	verbosegiveitem ITEM_FROM_MEM
	endtext

.Score0
	writetext InverseBattle0PointRewardText
	waitbutton
	writetext PsychicInverZeroRewardText
	setval ORAN_BERRY
	sjump .GiveReward

.Score1_3
	writetext InverseBattle1_3PointRewardText
	setval SITRUS_BERRY
	sjump .Reward

.Score4_6
	writetext InverseBattle4_6PointRewardText
	random MARANGABERRY - LUM_BERRY + 1
	addval LUM_BERRY
	sjump .Reward

.Score7_9
	writetext InverseBattle7_9PointRewardText
	random EVERSTONE - LEAF_STONE + 1
	addval LEAF_STONE
	sjump .Reward

PsychicInverGreetingText:
	text "Oh. I wasn't ex-"
	line "pecting a vistor"
	cont "here. Hmm…"

	para "Shall we have a"
	line "rather strange"
	cont "battle?"

	para "I call this an"
	line "Inverse Battle!"

	para "What do you think?"
	line "Would you care to"
	cont "try an Inverse"
	cont "Battle?"
	done

PsychicInverNoText:
	text "Oh, I see… That's"
	line "too bad."

	para "If you change your"
	line "mind, come again."
	done

PsychicInverYesText:
	text "Super effective"
	line "moves will not be"
	cont "very effective,"
	cont "and vice-versa."
	done

PsychicInverBeatenText:
	text "That battle may"
	line "have tired me out"

	para "even more than my"
	line "#mon…"
	done

InverseBattle0PointRewardText:
	text "I'm not sure if"
	line "you understand"
	cont "Inverse Battles…"
	done

InverseBattle1_3PointRewardText:
	text "You understand"
	line "Inverse Battles…"
	done

InverseBattle4_6PointRewardText:
	text "You understand"
	line "Inverse Battles"
	cont "pretty well."
	done

InverseBattle7_9PointRewardText:
	text "You understand"
	line "Inverse Battles"
	cont "perfectly!"
	done

InverseBattle10PointRewardText:
	text "You're an expert at"
	line "Inverse Battles."

	para "I'm no match for"
	line "you."
	done

PsychicInverZeroRewardText:
	text "Still, I'll give"
	line "you a little some-"
	cont "thing, so be sure"
	cont "to come try again!"
	done

PsychicInverRewardText:
	text "I've got a little"
	line "something for an"
	cont "opponent like you!"

	para "Here! Take it!"
	done

PsychicInverTomorrowText:
	text "This strange power"
	line "that reverses type"
	cont "matchups…"

	para "I can't use it very"
	line "often."

	para "Please come back"
	line "tomorrow."
	done

PsychicInversHouseHexManiacText:
	text "My brother has a"
	line "mysterious power!"

	para "He can reverse"
	line "type matchups!"
	cont "It's really crazy!"

	para "Super effective"
	line "and not very eff-"
	cont "moves get swapped!"
	done
