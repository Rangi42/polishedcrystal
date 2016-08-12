const_value set 2
	const ECRUTEAKSHRINEOUTSIDE_TWIN
	const ECRUTEAKSHRINEOUTSIDE_HOOTHOOT

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

EcruteakShrineOutsideTwinText:
	text "My Hoothoot's"
	line "Foresight helps"
	cont "shoo away ghosts."
	done

EcruteakShrineOutsideHoothootText:
	text "Hoothoot: Hoot!"
	done

EcruteakShrineOutside_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $3, $5, 1, ECRUTEAK_SHRINE_INSIDE
	warp_def $9, $4, 4, ECRUTEAK_CITY
	warp_def $9, $5, 4, ECRUTEAK_CITY
	warp_def $9, $6, 5, ECRUTEAK_CITY
	warp_def $9, $7, 5, ECRUTEAK_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_TWIN, 4, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, EcruteakShrineOutsideTwinScript, -1
	person_event SPRITE_HOOTHOOT, 4, 9, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, EcruteakShrineOutsideHoothootScript, -1
