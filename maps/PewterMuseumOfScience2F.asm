PewterMuseumOfScience2F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

PewterMuseumOfScience2F_MapEventHeader:

.Warps: db 1
	warp_def 7, 7, 5, PEWTER_MUSEUM_OF_SCIENCE_1F

.XYTriggers: db 0

.Signposts: db 2
	signpost 6, 3, SIGNPOST_READ, Museum2FMoonStoneSignpostScript
	signpost 2, 11, SIGNPOST_JUMPTEXT, Museum2FSpaceShuttleSignpostText

.PersonEvents: db 5
	person_event SPRITE_SCIENTIST, 5, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, Museum2FScientistText, -1
	person_event SPRITE_CHILD, 7, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Museum2FChildText, -1
	person_event SPRITE_TEACHER, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Museum2FTeacherText, -1
	person_event SPRITE_LASS, 1, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, Museum2FLassText, -1
	person_event SPRITE_POKEFAN_M, 5, 12, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum2FPokefanMScript, -1

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
	jumpopenedtext Text_Museum2FTutorRefused

.NoSilverLeaf
	jumpopenedtext Text_Museum2FTutorNoSilverLeaf

.TeachMove
	takeitem SILVER_LEAF
	jumpopenedtext Text_Museum2FTutorTaught

Museum2FMoonStoneSignpostScript:
	refreshscreen
	trainerpic METEORITE
	waitbutton
	closepokepic
	jumptext Museum2FMoonStoneSignpostText

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

Museum2FChildText:
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
