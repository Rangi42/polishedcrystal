GoldenrodSpeechHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 2, 7, 18, GOLDENROD_CITY
	warp_event 3, 7, 18, GOLDENROD_CITY

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 2, 3, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodSpeechHouseLadyText, -1
	object_event 7, 2, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodSpeechHouseTeacherText, -1

GoldenrodSpeechHouseLadyText:
	text "The Underground is"
	line "always so filthy."

	para "Some people have"
	line "no respect for"
	cont "others."
	done

GoldenrodSpeechHouseTeacherText:
	text "DJ Mary is so"
	line "cool. I listen to"

	para "her radio show"
	line "every day."
	done
