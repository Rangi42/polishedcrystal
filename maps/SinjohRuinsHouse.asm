const_value set 2
	const SINJOHRUINSHOUSE_POKEFAN_M
	const SINJOHRUINSHOUSE_GRAMPS
	const SINJOHRUINSHOUSE_ABRA

SinjohRuinsHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

SinjohRuinsHousePokefanmScript:
	jumptextfaceplayer SinjohRuinsHousePokefanmText

SinjohRuinsHouseGrampsScript:
	faceplayer
	opentext
	writetext SinjohRuinsHouseGrampsText
	yesorno
	iffalse .No
	writetext SinjohRuinsHouseGrampsYesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, $f, $6
	end

.No:
	writetext SinjohRuinsHouseGrampsNoText
	waitbutton
	closetext
	end

SinjohRuinsHouseAbraScript:
	opentext
	writetext SinjohRuinsHouseAbraText
	cry ABRA
	waitbutton
	closetext
	end

SinjohRuinsHouseBookshelf:
	jumpstd difficultbookshelf

SinjohRuinsHousePokefanmText:
	text "A long time ago,"
	line "people used to"

	para "have closer bonds"
	line "with #mon."

	para "Myths and legends"
	line "formed about"
	cont "powerful #mon,"

	para "and those legends"
	line "were carried to"
	cont "different regions."

	para "The ruins here"
	line "have been influ-"
	cont "enced by the"

	para "ancient peoples of"
	line "Alph in Johto and"

	para "Spear Pillar in"
	line "Sinnoh."
	done

SinjohRuinsHouseGrampsText:
	text "You seem so out"
	line "of place, not even"

	para "knowing why you"
	line "are here."

	para "Do you want my"
	line "Abra to Teleport"
	cont "you back home?"
	done

SinjohRuinsHouseGrampsYesText:
	text "OK, OK. Picture"
	line "your house in your"
	cont "mind…"
	done

SinjohRuinsHouseGrampsNoText:
	text "OK, OK. The best"
	line "of luck to you!"
	done

SinjohRuinsHouseAbraText:
	text "Abra: Aabra…"
	done

SinjohRuinsHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, SINJOH_RUINS
	warp_def $7, $3, 2, SINJOH_RUINS

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 1, 0, SIGNPOST_READ, SinjohRuinsHouseBookshelf
	signpost 1, 1, SIGNPOST_READ, SinjohRuinsHouseBookshelf

.PersonEvents:
	db 3
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SinjohRuinsHousePokefanmScript, -1
	person_event SPRITE_GRAMPS, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SinjohRuinsHouseGrampsScript, -1
	person_event SPRITE_ABRA, 3, 2, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SinjohRuinsHouseAbraScript, -1
