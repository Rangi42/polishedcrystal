SafariZoneWardensHome_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SafariZoneWardensHome_MapEventHeader:
	db 2 ; warps
	warp_def 7, 2, 5, FUCHSIA_CITY
	warp_def 7, 3, 5, FUCHSIA_CITY

	db 0 ; xy triggers

	db 3 ; signposts
	signpost 1, 0, SIGNPOST_JUMPSTD, picturebookshelf
	signpost 0, 7, SIGNPOST_JUMPTEXT, WardenPhotoText
	signpost 0, 9, SIGNPOST_JUMPTEXT, SafariZonePhotoText

	db 1 ; person events
	person_event SPRITE_LASS, 4, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, WardensGranddaughter, -1

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
