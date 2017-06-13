const_value set 2
	const SAFFRONORRESPEECHHOUSE_SILPH_EMPLOYEE
	const SAFFRONORRESPEECHHOUSE_COOLTRAINER_M

SaffronOrreSpeechHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SaffronOrreSpeechHouseSilphEmployeeScript:
	jumptextfaceplayer SaffronOrreSpeechHouseSilphEmployeeText

SaffronOrreSpeechHouseCooltrainerMScript:
	jumptextfaceplayer SaffronOrreSpeechHouseCooltrainerMText

SaffronOrreSpeechHouseSilphEmployeeText:
	text "I heard about a"
	line "method to seal off"
	cont "a #mon's heart"

	para "and force them to"
	line "attack people."

	para "How could anyone"
	line "do such a horrible"
	cont "thing to #mon?!"
	done

SaffronOrreSpeechHouseCooltrainerMText:
	text "We just got back"
	line "from seeing a"

	para "friend in another"
	line "region."

	para "They had a lot of"
	line "trouble from two"
	cont "criminal gangs,"

	para "but a talented"
	line "trainer stepped up"
	cont "to save them."
	done

SaffronOrreSpeechHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 17, SAFFRON_CITY
	warp_def $7, $3, 17, SAFFRON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_SILPH_EMPLOYEE, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SaffronOrreSpeechHouseSilphEmployeeScript, -1
	person_event SPRITE_COOLTRAINER_M, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SaffronOrreSpeechHouseCooltrainerMScript, -1
