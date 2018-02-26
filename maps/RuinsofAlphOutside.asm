RuinsofAlphOutside_MapScriptHeader:
	db 1 ; scene scripts
	scene_script RuinsofAlphOutsideTrigger0

	db 2 ; callbacks
	callback MAPCALLBACK_TILES, RuinsofAlphOutsideTileScript
	callback MAPCALLBACK_OBJECTS, UnknownScript_0x5800f

	db 12 ; warp events
	warp_event  4, 23, RUINS_OF_ALPH_HO_OH_CHAMBER, 1
	warp_event 16, 13, RUINS_OF_ALPH_KABUTO_CHAMBER, 1
	warp_event  4, 35, RUINS_OF_ALPH_OMANYTE_CHAMBER, 1
	warp_event 18, 39, RUINS_OF_ALPH_AERODACTYL_CHAMBER, 1
	warp_event 12, 19, RUINS_OF_ALPH_ENTRANCE_CHAMBER, 1
	warp_event 19, 17, RUINS_OF_ALPH_RESEARCH_CENTER, 1
	warp_event  8, 25, UNION_CAVE_B1F_NORTH, 1
	warp_event  8, 33, UNION_CAVE_B1F_NORTH, 2
	warp_event  3,  5, ROUTE_36_RUINS_OF_ALPH_GATE, 3
	warp_event 15, 26, ROUTE_32_RUINS_OF_ALPH_GATE, 1
	warp_event 15, 27, ROUTE_32_RUINS_OF_ALPH_GATE, 2
	warp_event 10,  9, RUINS_OF_ALPH_SINJOH_CHAMBER, 1

	db 2 ; coord events
	coord_event 13, 20, 1, UnknownScript_0x58031
	coord_event 12, 21, 1, UnknownScript_0x58031

	db 5 ; bg events
	bg_event 18, 14, SIGNPOST_JUMPTEXT, UnknownText_0x58325
	bg_event 14, 22, SIGNPOST_JUMPTEXT, UnknownText_0x58342
	bg_event 20, 18, SIGNPOST_JUMPTEXT, UnknownText_0x58362
	bg_event 10,  9, SIGNPOST_IFNOTSET, MapRuinsofAlphOutsideSealedCaveSign
	bg_event  4, 13, SIGNPOST_ITEM + RARE_CANDY, EVENT_RUINS_OF_ALPH_OUTSIDE_HIDDEN_RARE_CANDY

	db 13 ; object events
	object_event 13, 21, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ScientistScript_0x58043, EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	object_event 18, 18, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST_CLIMAX
	object_event  6, 26, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerPsychicNathan, -1
	object_event  5, 37, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerSuperNerdStan, -1
	object_event 15, 23, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, FisherScript_0x58061, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	object_event 14, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x5807e, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	object_event 16, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, YoungsterScript_0x58076, EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	smashrock_event  7, 10
	smashrock_event  8, 10
	smashrock_event  4, 12
	smashrock_event  5, 13
	smashrock_event  7, 13
	smashrock_event  8, 15

	const_def 1 ; object constants
	const RUINSOFALPHOUTSIDE_SCIENTIST1
	const RUINSOFALPHOUTSIDE_SCIENTIST2

RuinsofAlphOutsideTrigger0:
	checkevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	iffalse .End
	showtext RuinsofAlphScientistClimax1Text
	follow RUINSOFALPHOUTSIDE_SCIENTIST2, PLAYER
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST2, RuinsofAlphScientistClimaxApproachMovementData
	stopfollow
	showemote EMOTE_SHOCK, RUINSOFALPHOUTSIDE_SCIENTIST2, 15
	turnobject RUINSOFALPHOUTSIDE_SCIENTIST2, DOWN
	showtext RuinsofAlphScientistClimax2Text
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST2, RuinsofAlphScientistClimaxLeaveMovementData
	disappear RUINSOFALPHOUTSIDE_SCIENTIST2
	clearevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	clearevent EVENT_DO_RUINS_OF_ALPH_CLIMAX
	setevent EVENT_RUINS_OF_ALPH_CLIMAX_DONE
.End
	end

RuinsofAlphOutsideTileScript:
	checkevent EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	iffalse .locked
	changeblock 10, 8, $9f
.locked
	return

UnknownScript_0x5800f:
	checkflag ENGINE_UNOWN_DEX
	iftrue UnknownScript_0x5802c
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue UnknownScript_0x5801e
	jump UnknownScript_0x5802c

UnknownScript_0x5801e:
	checkcode VAR_UNOWNCOUNT
	ifgreater $0, UnknownScript_0x58027
	jump UnknownScript_0x5802c

UnknownScript_0x58027:
	appear RUINSOFALPHOUTSIDE_SCIENTIST1
	setscene $1
	return

UnknownScript_0x5802c:
	disappear RUINSOFALPHOUTSIDE_SCIENTIST1
	setscene $0
	return

UnknownScript_0x58031:
	faceobject RUINSOFALPHOUTSIDE_SCIENTIST1, PLAYER
	faceobject PLAYER, RUINSOFALPHOUTSIDE_SCIENTIST1
ScientistScript_0x58043:
	showtext UnknownText_0x580c7
	playmusic MUSIC_SHOW_ME_AROUND
	follow RUINSOFALPHOUTSIDE_SCIENTIST1, PLAYER
	applymovement RUINSOFALPHOUTSIDE_SCIENTIST1, MovementData_0x580ba
	disappear RUINSOFALPHOUTSIDE_SCIENTIST1
	stopfollow
	applyonemovement PLAYER, step_up
	setmapscene RUINS_OF_ALPH_RESEARCH_CENTER, $1
	warpcheck
	end

FisherScript_0x58061:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_RUINS_COWARD
	iftrue_jumpopenedtext UnknownText_0x58420
	setevent EVENT_TALKED_TO_RUINS_COWARD
	writetext UnknownText_0x583a4
	buttonsound
	thisopenedtext

UnknownText_0x58420:
	text "The ruins hide a"
	line "huge secret!"

	para "…I think…"
	done

YoungsterScript_0x58076:
	faceplayer
	jumptext UnknownText_0x58449

YoungsterScript_0x5807e:
	showtextfaceplayer UnknownText_0x5848e
	turnobject LAST_TALKED, UP
	end

GenericTrainerPsychicNathan:
	generictrainer PSYCHIC_T, NATHAN, EVENT_BEAT_PSYCHIC_NATHAN, PsychicNathanSeenText, PsychicNathanBeatenText

	text "I like thinking"
	line "here."
	done

GenericTrainerSuperNerdStan:
	generictrainer SUPER_NERD, STAN, EVENT_BEAT_SUPER_NERD_STAN, UnknownText_0x581e5, UnknownText_0x58217

	text "The ruins are from"
	line "about 1,500 years"
	cont "ago."

	para "Nobody knows who"
	line "built them."

	para "It's also not"
	line "known if the #-"
	cont "mon statues have"
	cont "any meaning."

	para "It's all one big"
	line "mystery…"
	done

MovementData_0x580ba:
	step_right
	step_right
	step_right
	step_right
	step_up
	step_up
	step_right
	step_right
	step_up
	step_up
	step_end

RuinsofAlphScientistClimaxApproachMovementData:
	step_left
	step_up
	step_up
	step_up
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_up
	step_up
	step_end

RuinsofAlphScientistClimaxLeaveMovementData:
	step_right
	step_down
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end

UnknownText_0x580c7:
	text "Hm? That's a #-"
	line "dex, isn't it?"
	cont "May I see it?"

	para "There are so many"
	line "kinds of #mon."

	para "Hm? What's this?"

	para "What is this"
	line "#mon?"

	para "It looks like the"
	line "strange writing on"

	para "the walls of the"
	line "ruins."

	para "If those drawings"
	line "are really #-"
	cont "mon, there should"
	cont "be many more."

	para "I know! Let me up-"
	line "grade your #-"
	cont "dex. Follow me."
	done

UnknownText_0x581e5:
	text "What do you want?"
	line "I'm studying--"
	cont "don't disturb me!"
	done

UnknownText_0x58217:
	text "Sorry…"
	line "I'm frustrated by"

	para "our lack of real"
	line "understanding…"
	done

PsychicNathanSeenText:
	text "Hmmm… This is a"
	line "strange place."
	done

PsychicNathanBeatenText:
	text "…"
	done

UnknownText_0x58325:
	text "Mystery Stone"
	line "Panel Chamber"
	done

UnknownText_0x58342:
	text "Ruins of Alph"
	line "Visitors Welcome"
	done

UnknownText_0x58362:
	text "Ruins of Alph"
	line "Research Center"

	para "The Authority On"
	line "The Ruins of Alph"
	done

MapRuinsofAlphOutsideSealedCaveSign:
	dw EVENT_DOOR_OPENED_IN_RUINS_OF_ALPH
	thistext

	text "There's a door-"
	line "shaped groove in"
	cont "the rock."
	done

UnknownText_0x583a4:
	text "While exploring"
	line "the ruins, we"

	para "suddenly noticed"
	line "an odd presence."

	para "We all got scared"
	line "and ran away."

	para "You should be"
	line "careful too."
	done

UnknownText_0x58449:
	text "There are many"
	line "kinds of Unown, so"

	para "we use them for"
	line "our secret codes."
	done

UnknownText_0x5848e:
	text "A… H… E… A… D…"
	line "Hmm…"

	para "What?"

	para "I'm decoding this"
	line "message!"
	done

RuinsofAlphScientistClimax1Text:
	text "That sounded like"
	line "it came from over"
	cont "here…"
	done

RuinsofAlphScientistClimax2Text:
	text "Incredible!"

	para "Another chamber"
	line "was hidden here"
	cont "all this time!"

	para "We could spend"
	line "years studying it!"

	para "…Although, that"
	line "was quite a loud"
	cont "earthquake."

	para "Could there be"
	line "more than one"
	cont "hidden chamber?"

	para "Anyway, I'll go"
	line "tell my colleagues"
	cont "about this."
	done
