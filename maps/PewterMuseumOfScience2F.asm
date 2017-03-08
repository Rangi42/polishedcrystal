const_value set 2
	const PEWTERMUSEUMOFSCIENCE2F_SCIENTIST
	const PEWTERMUSEUMOFSCIENCE2F_BUG_CATCHER
	const PEWTERMUSEUMOFSCIENCE2F_TEACHER
	const PEWTERMUSEUMOFSCIENCE2F_LASS
	const PEWTERMUSEUMOFSCIENCE2F_POKEFAN_M

PewterMuseumOfScience2F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Museum2FScientistScript:
	jumptextfaceplayer Museum2FScientistText

Museum2FBugCatcherScript:
	jumptextfaceplayer Museum2FBugCatcherText

Museum2FTeacherScript:
	jumptextfaceplayer Museum2FTeacherText

Museum2FLassScript:
	jumptextfaceplayer Museum2FLassText

Museum2FPokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_SEISMIC_TOSS_INTRO
	iftrue Museum2FTutorSeismicTossScript
	checkunits
	iftrue .metric
	writetext Museum2FPokefanMImperialText
	jump .ok
.metric
	writetext Museum2FPokefanMMetricText
.ok
	waitbutton
	setevent EVENT_LISTENED_TO_SEISMIC_TOSS_INTRO
Museum2FTutorSeismicTossScript:
	writetext Text_Museum2FTutorSeismicToss
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writetext Text_Museum2FTutorQuestion
	yesorno
	iffalse .TutorRefused
	writebyte SEISMIC_TOSS
	writetext Text_Museum2FTutorClear
	special Special_MoveTutor
	if_equal $0, .TeachMove
.TutorRefused
	writetext Text_Museum2FTutorRefused
	waitbutton
	closetext
	end

.NoSilverLeaf
	writetext Text_Museum2FTutorNoSilverLeaf
	waitbutton
	closetext
	end

.TeachMove
	takeitem SILVER_LEAF
	writetext Text_Museum2FTutorTaught
	waitbutton
	closetext
	end

Museum2FMoonStoneSignpostScript:
	refreshscreen $0
	trainerpic METEORITE
	waitbutton
	closepokepic
	jumptext Museum2FMoonStoneSignpostText

Museum2FSpaceShuttleSignpostScript:
	jumptext Museum2FSpaceShuttleSignpostText

Museum2FScientistText:
	text "Meteorites struck"
	line "Mt.Moon near"
	cont "Pewter City."

	para "We have one"
	line "on display."

	para "It seems to emit"
	line "strange energy…"
	done



Museum2FLassText:
	text "#mon revived"
	line "from fossils are"

	para "all part Rock-"
	line "type."

	para "Were they always"
	line "that way, or is it"

	para "a result of the"
	line "fossilization"
	cont "process?"
	done

Museum2FPokefanMImperialText:
	text "This space shuttle"
	line "used to fly 160"

	para "miles above the"
	line "earth, defying"
	cont "gravity!"

	para "You know what else"
	line "can defy gravity?"

	para "Seismic Toss,"
	line "of course!"
	done

Museum2FBugCatcherText:
	text "Stuff and rocks"
	line "and rocks and"

	para "stuff. Can we go"
	line "already?"
	done

Museum2FTeacherText:
	text "Sigh… My son isn't"
	line "enjoying the mu-"

	para "seum as much as I"
	line "hoped he would."

	para "Kids, huh?"
	done

Museum2FPokefanMMetricText:
	text "This space shuttle"
	line "used to fly 250"

	para "kilometers above"
	line "the earth, defy-"
	cont "ing gravity!"

	para "You know what else"
	line "can defy gravity?"

	para "Seismic Toss,"
	line "of course!"
	done

Text_Museum2FTutorSeismicToss:
	text "I can teach your"
	line "#mon to use"

	para "Seismic Toss for"
	line "one Silver Leaf."
	done

Text_Museum2FTutorNoSilverLeaf:
	text "You don't have a"
	line "Silver Leaf!"
	done

Text_Museum2FTutorQuestion:
	text "Should I teach"
	line "your #mon"
	cont "Seismic Toss?"
	done

Text_Museum2FTutorRefused:
	text "If you say so."
	done

Text_Museum2FTutorClear:
	text ""
	done

Text_Museum2FTutorTaught:
	text "Now your #mon"
	line "knows how to use"
	cont "Seismic Toss!"
	done

Museum2FMoonStoneSignpostText:
	text "Meteorite that"
	line "fell on Mt.Moon."
	cont "(Moon Stone)"
	done

Museum2FSpaceShuttleSignpostText:
	text "Space Shuttle"
	done

PewterMuseumOfScience2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $7, $7, 5, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 6, 3, SIGNPOST_READ, Museum2FMoonStoneSignpostScript
	signpost 2, 11, SIGNPOST_READ, Museum2FSpaceShuttleSignpostScript

.PersonEvents:
	db 5
	person_event SPRITE_SCIENTIST, 5, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum2FScientistScript, -1
	person_event SPRITE_BUG_CATCHER, 7, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Museum2FBugCatcherScript, -1
	person_event SPRITE_TEACHER, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FTeacherScript, -1
	person_event SPRITE_LASS, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FLassScript, -1
	person_event SPRITE_POKEFAN_M, 5, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FPokefanMScript, -1
