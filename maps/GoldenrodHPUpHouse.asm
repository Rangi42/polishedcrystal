GoldenrodHPUpHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 21
	warp_event  3,  7, GOLDENROD_CITY, 21

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodHPUpHousePokefanMScript, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHPUpHousePokefanFText, -1
	pokemon_event  6,  3, PIKACHU, -1, -1, PAL_NPC_RED, GoldenrodHPUpHousePikachuText, -1

GoldenrodHPUpHousePokefanMScript:
	checkevent EVENT_GOT_HP_UP_FROM_GOLDENROD
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem HP_UP
	iffalse_endtext
	setevent EVENT_GOT_HP_UP_FROM_GOLDENROD
	jumpthisopenedtext

.Text2:
	text "The Haircut Bro-"
	line "thers sure know"

	para "how to make"
	line "#mon happy."
	done

.Text1:
	text "If your #mon"
	line "gets a haircut, it"

	para "seems to become"
	line "happier."

	para "But this works"
	line "too!"
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
