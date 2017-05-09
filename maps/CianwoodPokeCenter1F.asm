const_value set 2
	const CIANWOODPOKECENTER1F_NURSE
	const CIANWOODPOKECENTER1F_LASS
	const CIANWOODPOKECENTER1F_GYM_GUY
	const CIANWOODPOKECENTER1F_SUPER_NERD
	const CIANWOODPOKECENTER1F_RICH_BOY

CianwoodPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

NurseScript_0x9dbcf:
	jumpstd pokecenternurse

LassScript_0x9dbd2:
	jumptextfaceplayer UnknownText_0x9dbed

CianwoodGymGuyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .CianwoodGymGuyWinScript
	writetext CianwoodGymGuyText
	waitbutton
	checkevent EVENT_GOT_HM04_STRENGTH
	iftrue .Done
	writetext CianwoodGymGuyStrengthText1
	buttonsound
	verbosegivetmhm HM_STRENGTH
	setevent EVENT_GOT_HM04_STRENGTH
	writetext CianwoodGymGuyStrengthText2
	waitbutton
.Done
	closetext
	end

.CianwoodGymGuyWinScript:
	writetext CianwoodGymGuyWinText
	waitbutton
	closetext
	end

SuperNerdScript_0x9dbea:
	jumptextfaceplayer UnknownText_0x9ded7

CianwoodPokeCenterRichBoyScript:
	jumptextfaceplayer CianwoodPokeCenterRichBoyText

PokemonJournalChuckScript:
	setflag ENGINE_READ_CHUCK_JOURNAL
	jumptext PokemonJournalChuckText

UnknownText_0x9dbed:
	text "Did you meet the"
	line "#Maniac?"

	para "He's always brag-"
	line "ging about his"
	cont "rare #mon."
	done

CianwoodGymGuyText:
	text "The #mon Gym"
	line "trainers here are"
	cont "macho bullies."

	para "If I stick around,"
	line "they might come"
	cont "after me."

	para "Here's some ad-"
	line "vice: the Gym"

	para "Leader uses the"
	line "Fighting-type."

	para "So you should"
	line "confound him with"
	cont "Psychic #mon."

	para "Wipe out his #-"
	line "mon before they"

	para "can use their"
	line "physical strength."

	para "And those boulders"
	line "in the middle of"
	cont "the Gym?"

	para "If you don't move"
	line "them correctly,"

	para "you won't reach"
	line "the Gym Leader."

	para "If you get stuck,"
	line "go outside."
	done

CianwoodGymGuyStrengthText1:
	text "You can't move the"
	line "boulders aside?"

	para "Here, use this"
	line "and teach your"
	cont "#mon Strength!"
	done

CianwoodGymGuyStrengthText2:
	text "Good luck!"
	done

CianwoodGymGuyWinText:
	text "<PLAYER>! You won!"
	line "I could tell by"
	cont "looking at you!"
	done

UnknownText_0x9ddf2:
	text "Don't you get the"
	line "urge to show off"

	para "your #mon to"
	line "friends?"

	para "I wish I could"
	line "show the #mon I"

	para "raised to my pal"
	line "in Violet."
	done

UnknownText_0x9ded7:
	text "I love showing off"
	line "the #mon that"

	para "I've raised."
	line "Don't you?"

	para "I'm going to get"
	line "into a bunch of"

	para "battles, and show"
	line "off my #mon!"
	done

CianwoodPokeCenterRichBoyText:
	text "There's no #"
	line "Mart in this town,"

	para "so we have to im-"
	line "port products from"
	cont "across the sea."
	done

PokemonJournalChuckText:
	text "#mon Journal"

	para "Special Feature:"
	line "Leader Chuck!"

	para "Chuck is said to"
	line "really like sweet"
	cont "desserts."

	para "However, he has"
	line "also been seen"

	para "training under a"
	line "heavy waterfall"
	cont "to work them off."
	done

CianwoodPokeCenter1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 3
	warp_def $7, $5, 3, CIANWOOD_CITY
	warp_def $7, $6, 3, CIANWOOD_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalChuckScript

.PersonEvents:
	db 5
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x9dbcf, -1
	person_event SPRITE_LASS, 5, 1, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LassScript_0x9dbd2, -1
	person_event SPRITE_GYM_GUY, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CianwoodGymGuyScript, -1
	person_event SPRITE_SUPER_NERD, 7, 9, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SuperNerdScript_0x9dbea, -1
	person_event SPRITE_RICH_BOY, 5, 11, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, CianwoodPokeCenterRichBoyScript, -1
