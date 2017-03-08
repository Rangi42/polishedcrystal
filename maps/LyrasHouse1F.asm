const_value set 2
	const LYRASHOUSE1F_DAD

LyrasHouse1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

LyrasDadScript:
	faceplayer
	opentext
	checkevent EVENT_LYRA_IN_HER_ROOM
	iffalse .LyraInside
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue .LyraTraining
	writetext LyrasDadHelpingText
	waitbutton
	closetext
	end

.LyraInside
	writetext LyrasDadInsideText
	waitbutton
	closetext
	end

.LyraTraining
	writetext LyrasDadTrainingText
	waitbutton
	closetext
	end

LyrasFridgeScript:
	jumptext LyrasFridgeText

LyrasSinkScript:
	jumptext LyrasSinkText

LyrasStoveScript:
	jumptext LyrasStoveText

LyrasTVScript:
	jumptext LyrasTVText

LyrasDadInsideText:
	text "Hi, <PLAYER>!"
	line "Lyra is upstairs."

	para "She's playing"
	line "with her #mon"
	cont "as usual."
	done

LyrasDadHelpingText:
	text "Hi, <PLAYER>!"
	line "Lyra isn't here."

	para "She's been busy"
	line "helping the prof-"
	cont "essor."
	done

LyrasDadTrainingText:
	text "Hi, <PLAYER>!"
	line "Lyra isn't here."

	para "She's collecting"
	line "Badges all over"
	cont "Johto!"
	done

LyrasFridgeText:
	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "rice balls!"
	done

LyrasSinkText:
	text "The sink is spot-"
	line "less."
	done

LyrasStoveText:
	text "Curry is simmering"
	line "on the stove."
	done

LyrasTVText:
	text "There's a movie on"
	line "TV: A girl with"

	para "her hair in pig-"
	line "tails is walking"
	cont "up a brick road."

	para "I'd better get"
	line "going too!"
	done

LyrasHouse1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $2, 4, NEW_BARK_TOWN
	warp_def $7, $3, 4, NEW_BARK_TOWN
	warp_def $0, $0, 1, LYRAS_HOUSE_2F

.XYTriggers:
	db 0

.Signposts:
	db 4
	signpost 1, 7, SIGNPOST_READ, LyrasFridgeScript
	signpost 1, 8, SIGNPOST_READ, LyrasSinkScript
	signpost 1, 9, SIGNPOST_READ, LyrasStoveScript
	signpost 1, 2, SIGNPOST_READ, LyrasTVScript

.PersonEvents:
	db 1
	person_event SPRITE_DAD, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, LyrasDadScript, -1
