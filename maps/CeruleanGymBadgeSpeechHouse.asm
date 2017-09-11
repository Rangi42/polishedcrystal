CeruleanGymBadgeSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeruleanGymBadgeSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, CERULEAN_CITY
	warp_def 7, 3, 1, CERULEAN_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 1
	person_event SPRITE_GENTLEMAN, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeruleanGymBadgeSpeechHouseGentlemanScript, -1

CeruleanGymBadgeSpeechHouseGentlemanScript:
	checkevent EVENT_INTRODUCED_TO_CERULEAN_MAN
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	setevent EVENT_INTRODUCED_TO_CERULEAN_MAN
	thisopenedtext

.Text2:
	text "You're collecting"
	line "Kanto Gym Badges?"
	cont "Good luck!"
	done

.Text1:
	text "We had a spate of"
	line "burglaries a few"

	para "years back, so now"
	line "everyone's super-"
	cont "cautious."

	para "Who are you?"
	done
