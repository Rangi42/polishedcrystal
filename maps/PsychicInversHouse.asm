PsychicInversHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PsychicInversHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, ROUTE_16_WEST
	warp_def 7, 3, 1, ROUTE_16_WEST

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 2
	person_event SPRITE_YOUNGSTER, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, PsychicInverScript, -1
	person_event SPRITE_HEX_MANIAC, 3, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, PsychicInversHouseHexManiacText, -1

const_value set 1
	const PSYCHICINVERSHOUSE_INVER

PsychicInverScript:
	faceplayer
	opentext
	checkflag ENGINE_FOUGHT_PSYCHIC_INVER
	iftrue .Tomorrow
	writetext PsychicInverGreetingText
	waitbutton
	writetext PsychicInverChallengeText
	yesorno
	iffalse .No
	writetext PsychicInverYesText
	waitbutton
	closetext
	setflag ENGINE_FOUGHT_PSYCHIC_INVER
	winlosstext PsychicInverBeatenText, 0
	setlasttalked PSYCHICINVERSHOUSE_INVER
; TODO: pick six random Pokémon from a larger pool
	loadtrainer INVER, 1
	writecode VAR_BATTLETYPE, BATTLETYPE_INVERSE
	startbattle
	reloadmapafterbattle
	opentext
	copybytetovar InverseBattleScore
	if_equal 0, .Score0
	if_greater_than 127, .Score0 ; negative
	if_less_than 4, .Score1_3
	if_less_than 7, .Score4_6
	if_less_than 10, .Score7_9
	writetext InverseBattle10PointRewardText
	writebyte RARE_CANDY
.Reward
	waitbutton
	writetext PsychicInverRewardText
.GiveReward
	buttonsound
	verbosegiveitem ITEM_FROM_MEM
	endtext

.Score0
	writetext InverseBattle0PointRewardText
	waitbutton
	writetext PsychicInverZeroRewardText
	writebyte ORAN_BERRY
	jump .GiveReward

.Score1_3
	writetext InverseBattle1_3PointRewardText
	writebyte SITRUS_BERRY
	jump .Reward

.Score4_6
	writetext InverseBattle4_6PointRewardText
	callasm .RandomBerry
	jump .Reward

.Score7_9
	writetext InverseBattle7_9PointRewardText
	callasm .RandomStone
	jump .Reward

.No
	jumpopenedtext PsychicInverNoText

.Tomorrow:
	jumpopenedtext PsychicInverTomorrowText

.RandomBerry:
	ld a, APICOT_BERRY - LUM_BERRY + 1
	call RandomRange
	add LUM_BERRY
	ld [ScriptVar], a
	ret

.RandomStone:
	ld a, EVERSTONE - LEAF_STONE + 1
	call RandomRange
	add LEAF_STONE
	ld [ScriptVar], a
	ret

PsychicInverGreetingText:
	text "Oh. I wasn't ex-"
	line "pecting a vistor"
	cont "here. Hmm…"

	para "Shall we have a"
	line "rather strange"
	cont "battle?"

	para "I call this an"
	line "Inverse Battle!"
	done

PsychicInverChallengeText:
	text "What do you think?"
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
	text "Super-effective"
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

	para "Super-effective"
	line "and not very eff-"
	cont "moves get swapped!"
	done
