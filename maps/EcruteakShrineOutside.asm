const_value set 2
	const ECRUTEAKSHRINEOUTSIDE_TWIN
	const ECRUTEAKSHRINEOUTSIDE_HOOTHOOT
	const ECRUTEAKSHRINEOUTSIDE_SAGE

EcruteakShrineOutside_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

EcruteakShrineOutsideTwinScript:
	jumptextfaceplayer EcruteakShrineOutsideTwinText

EcruteakShrineOutsideHoothootScript:
	opentext
	writetext EcruteakShrineOutsideHoothootText
	cry HOOTHOOT
	waitbutton
	closetext
	end

EcruteakShrineOutsideSageScript:
	jumptextfaceplayer EcruteakShrineOutsideSageText

EcruteakShrineOutsideStatueScript:
	jumptext EcruteakShrineOutsideStatueText

EcruteakShrineOutsideTwinText:
	text "My Hoothoot's"
	line "Foresight helps"
	cont "shoo away ghosts."
	done

EcruteakShrineOutsideHoothootText:
	text "Hoothoot: Hoot!"
	done

EcruteakShrineOutsideSageText:
	text "On New Year's Eve,"
	line "people visit this"

	para "shrine and make"
	line "wishes for their"
	cont "future."
	done

EcruteakShrineOutsideStatueText:
	text "A #mon statue…"

	para "It looks very"
	line "serene."
	done

EcruteakShrineOutside_MapEventHeader:
.Warps:
	db 5
	warp_def $3, $5, 1, ECRUTEAK_SHRINE_INSIDE
	warp_def $b, $4, 4, ECRUTEAK_CITY
	warp_def $b, $5, 4, ECRUTEAK_CITY
	warp_def $b, $6, 5, ECRUTEAK_CITY
	warp_def $b, $7, 5, ECRUTEAK_CITY

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 8, 3, SIGNPOST_READ, EcruteakShrineOutsideStatueScript
	signpost 8, 8, SIGNPOST_READ, EcruteakShrineOutsideStatueScript

.PersonEvents:
	db 3
	person_event SPRITE_TWIN, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineOutsideTwinScript, -1
	person_event SPRITE_HOOTHOOT, 4, 9, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EcruteakShrineOutsideHoothootScript, -1
	person_event SPRITE_SAGE, 10, 2, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineOutsideSageScript, -1
