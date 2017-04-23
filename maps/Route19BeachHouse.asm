const_value set 2
	const ROUTE19BEACHHOUSE_FISHER
	const ROUTE19BEACHHOUSE_SURFING_PIKACHU

Route19BeachHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route19BeachHouseFisherScript:
	jumptextfaceplayer Route19BeachHouseFisherText

Route19BeachHouseSurfingPikachuScript:
	faceplayer
	opentext
	writetext Route19BeachHouseSurfingPikachuText
	cry PIKACHU
	waitbutton
	closetext
	end

Route19BeachHouseFisherText:
	text "Hey there, friend!"
	line "The name's Victor."

	para "I love to Surf,"
	line "and so does Puka."
	cont "That's my Pikachu!"

	para "You can do it,"
	line "too!"

	para "I hear some Pika-"
	line "chu in Johto"

	para "taught themselves"
	line "to Surf!"
	done

Route19BeachHouseSurfingPikachuText:
	text "Puka: Pi-kaa!"
	done

Route19BeachHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, ROUTE_19
	warp_def $7, $3, 2, ROUTE_19

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_FISHER, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route19BeachHouseFisherScript, -1
	person_event SPRITE_SURFING_PIKACHU, 4, 6, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route19BeachHouseSurfingPikachuScript, -1
