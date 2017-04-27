const_value set 2
	const PSYCHICINVERSHOUSE_HEX_MANIAC
	const PSYCHICINVERSHOUSE_INVER

PsychicInversHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

PsychicInversHouseHexManiacScript:
	jumptext PsychicInversHouseHexManiacText

;PsychicInverScript:
;	end

;PsychicInverGreetingText:
;	text "Oh. I wasn't ex-"
;	line "pecting a vistor"
;	cont "here. Hmm…"
;
;	para "Shall we have a"
;	line "rather strange"
;	cont "battle?"
;
;	para "I call this an"
;	line "Inverse Battle!"
;	done
;
;PsychicInverChallengeText:
;	text "What do you think?"
;	line "Would you care to"
;	cont "try an Inverse"
;	cont "Battle?"
;	done
;
;PsychicInverNoText:
;	text "Oh, I see… That's"
;	line "too bad."
;
;	para "If you change your"
;	line "mind, come again."
;	done
;
;PsychicInverYesText:
;	text "Super-effective"
;	line "moves will not be"
;	cont "very effective,"
;	cont "and vice-versa."
;	done
;
;PsychicInverBeatenText:
;	text "That battle may"
;	line "have tired me out"
;
;	para "even more than my"
;	line "#mon…"
;	done
;
;InverseBattle0PointRewardText:
;	text "I'm not sure if"
;	line "you understand"
;	cont "Inverse Battles…"
;	done
;
;InverseBattle1_3PointRewardText:
;	text "You understand"
;	line "Inverse Battles…"
;	done
;
;InverseBattle4_6PointRewardText:
;	text "You understand"
;	line "Inverse Battles"
;	cont "pretty well."
;	done
;
;InverseBattle7_9PointRewardText:
;	text "You understand"
;	line "Inverse Battles"
;	cont "perfectly!"
;	done
;
;InverseBattle10PointRewardText:
;	text "You're an expert at"
;	line "Inverse Battles."
;
;	para "I'm no match for"
;	line "you."
;	done

;PsychicInverTomorrowText:
;	text "This strange power"
;	line "that reverses type"
;	cont "matchups…"
;
;	para "I can't use it very"
;	line "often."
;
;	para "Please come back"
;	line "tomorrow."
;	done

PsychicInversHouseHexManiacText:
	text "My brother has a"
	line "mysterious power!"

	para "He can reverse"
	line "type matchups!"
	cont "It's really crazy!"

	para "Super-effective"
	line "and not very eff-"
	cont "moves get swapped!"

	para "But he's away"
	line "right now…"
	done

PsychicInversHouseBookshelf:
	jumpstd difficultbookshelf

PsychicInversHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 1, ROUTE_16_WEST
	warp_def $7, $3, 1, ROUTE_16_WEST

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_READ, PsychicInversHouseBookshelf

.PersonEvents:
	db 1
	person_event SPRITE_HEX_MANIAC, 3, 6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, PsychicInversHouseHexManiacScript, -1
;	person_event SPRITE_INVER, 2, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, PsychicInverScript, -1
