GoldenrodHPUpHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodHPUpHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 18, GOLDENROD_CITY
	warp_def $7, $3, 18, GOLDENROD_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_POKEFAN_M, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHPUpHousePokefanMScript, -1
	person_event SPRITE_POKEFAN_F, 4, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_COMMAND, jumptextfaceplayer, GoldenrodHPUpHousePokefanFText, -1
	person_event SPRITE_PIKACHU, 3, 6, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, GoldenrodHPUpHousePikachuScript, -1

GoldenrodHPUpHousePokefanMScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_GOLDENROD
	iftrue .GotItem
	writetext GoldenrodHPUpHousePokefanMText1
	buttonsound
	verbosegiveitem HP_UP
	iffalse .Done
	setevent EVENT_GOT_HP_UP_FROM_GOLDENROD
.GotItem:
	writetext GoldenrodHPUpHousePokefanMText2
	waitbutton
.Done:
	closetext
	end

GoldenrodHPUpHousePikachuScript:
	opentext
	writetext GoldenrodHPUpHousePikachuText
	cry PIKACHU
	waitbutton
	closetext
	end

GoldenrodHPUpHousePokefanMText1:
	text "If your #mon"
	line "gets a haircut, it"

	para "seems to become"
	line "happier."

	para "But this works"
	line "too!"
	done

GoldenrodHPUpHousePokefanMText2:
	text "The Haircut Bro-"
	line "thers sure know"

	para "how to make"
	line "#mon happy."
	done

GoldenrodHPUpHousePokefanFText:
	text "I gave my Pichu a"
	line "haircut from the"

	para "Haircut Brothers"
	line "every day."

	para "Then it went and"
	line "evolved! I didn't"
	cont "expect that!"
	done

GoldenrodHPUpHousePikachuText:
	text "Pikachu: Pika!"
	done
