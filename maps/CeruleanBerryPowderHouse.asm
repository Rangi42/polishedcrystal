CeruleanBerryPowderHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanBerryPowderHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 9, CERULEAN_CITY
	warp_def $7, $3, 9, CERULEAN_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_READ, CeruleanBerryPowderHouseBookshelfScript

.PersonEvents: db 1
	person_event SPRITE_GRAMPS, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeruleanBerryPowderHouseGrampsScript, -1

CeruleanBerryPowderHouseGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_CERULEAN
	iftrue .GotItem
	writetext CeruleanBerryPowderHouseGrampsText1
	buttonsound
	verbosegiveitem HP_UP
	iffalse .Done
	setevent EVENT_GOT_HP_UP_FROM_CERULEAN
.GotItem:
	writetext CeruleanBerryPowderHouseGrampsText2
	waitbutton
.Done:
	closetext
	end

CeruleanBerryPowderHouseBookshelfScript:
	jumpstd difficultbookshelf

CeruleanBerryPowderHouseGrampsText1:
	text "Berry Powder?"
	line "Sorry, kid, I'm"
	cont "retired now."

	para "I do have this"
	line "left over…"
	done

CeruleanBerryPowderHouseGrampsText2:
	text "Concocting med-"
	line "icines was a"
	cont "rewarding job,"

	para "but I deserve a"
	line "break."
	done
