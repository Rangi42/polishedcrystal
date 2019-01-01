SafariZoneWardensHome_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, FUCHSIA_CITY, 5
	warp_event  3,  7, FUCHSIA_CITY, 5

	db 0 ; coord events

	db 3 ; bg events
	bg_event  0,  1, SIGNPOST_JUMPSTD, picturebookshelf
	bg_event  7,  0, SIGNPOST_JUMPTEXT, WardenPhotoText
	bg_event  9,  0, SIGNPOST_JUMPTEXT, SafariZonePhotoText

	db 1 ; object events
	object_event  2,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, PERSONTYPE_SCRIPT, 0, WardensGranddaughter, -1

WardensGranddaughter:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	iftrue .AlreadyMet
	writetext WardensGranddaughterText1
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	end
.AlreadyMet:
	jumpopenedtext WardensGranddaughterText2

WardensGranddaughterText1:
	text "My grandpa is the"
	line "Safari Zone War-"
	cont "den."

	para "At least he was…"

	para "He decided to go"
	line "on a vacation and"

	para "took off overseas"
	line "all by himself."

	para "He quit running"
	line "Safari Zone just"
	cont "like that."
	done

WardensGranddaughterText2:
	text "Many people were"
	line "disappointed that"

	para "Safari Zone closed"
	line "down, but Grandpa"
	cont "is so stubborn…"
	done

WardenPhotoText:
	text "It's a photo of a"
	line "grinning old man"

	para "who's surrounded"
	line "by #mon."
	done

SafariZonePhotoText:
	text "It's a photo of a"
	line "huge grassy plain"

	para "with rare #mon"
	line "frolicking in it."
	done
