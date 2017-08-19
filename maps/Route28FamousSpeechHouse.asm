Route28FamousSpeechHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route28FamousSpeechHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, ROUTE_28
	warp_def 7, 3, 1, ROUTE_28

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Celebrity, -1
	person_event SPRITE_SKARMORY, 5, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_POKEMON, SKARMORY, CelebritysSkarmoryText, -1

Celebrity:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM47_STEEL_WING
	iftrue .AlreadyGotItem
	writetext CelebrityText1
	buttonsound
	verbosegivetmhm TM_STEEL_WING
	setevent EVENT_GOT_TM47_STEEL_WING
	endtext
.AlreadyGotItem:
	jumpopenedtext CelebrityText2

CelebrityText1:
	text "Oh, dear."
	line "You've found me."

	para "Please don't tell"
	line "anyone about me."

	para "I'll give you this"
	line "for keeping my"
	cont "secret. Please?"
	done

CelebrityText2:
	text "It's tough being a"
	line "top celebrity."

	para "Everywhere I go,"
	line "people chase me."

	para "I just want to be"
	line "left alone…"
	done

CelebritysSkarmoryText:
	text "Skarmory: Scree!"
	done
