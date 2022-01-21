CeladonHotelPool_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 10,  7, CELADON_HOTEL_1F, 4
	warp_event 11,  7, CELADON_HOTEL_1F, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotelPoolPokefanMText, -1
	object_event  4,  6, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonHotelPoolChildText, -1
	object_event  5,  3, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SWIM_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, CeladonHotelPoolSwimmerMScript, -1

CeladonHotelPoolSwimmerMScript:
	checkevent EVENT_GOT_SAFE_GOGGLES_FROM_CELADON
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem SAFE_GOGGLES
	iffalse_endtext
	setevent EVENT_GOT_SAFE_GOGGLES_FROM_CELADON
	jumpthisopenedtext

.Text2:
	text "This is quite a"
	line "relaxing swim…"
	done

.Text1:
	text "For a slow back-"
	line "stroke, I don't"
	cont "need my goggles."

	para "You can have them."
	done

CeladonHotelPoolPokefanMText:
	text "Well, color me"
	line "impressed."

	para "This hotel's"
	line "facilities are"
	cont "second-to-none!"
	done

CeladonHotelPoolChildText:
	text "Whee!"
	done
