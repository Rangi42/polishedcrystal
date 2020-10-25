GoldenrodBikeShop_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 2
	warp_event  3,  7, GOLDENROD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  3, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  3, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  5, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  5, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  6, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  6, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  6,  6, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  7,  6, BGEVENT_JUMPTEXT, UnknownText_0x548ed
	bg_event  3,  0, BGEVENT_JUMPTEXT, UnknownText_0x548c0

	def_object_events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ClerkScript_0x54750, -1

ClerkScript_0x54750:
	checkevent EVENT_GOT_BICYCLE
	iftrue_jumptextfaceplayer UnknownText_0x5485f
	faceplayer
	opentext
	writetext UnknownText_0x54787
	yesorno
	iffalse_jumpopenedtext UnknownText_0x54898
	writetext UnknownText_0x547f8
	buttonsound
	waitsfx
	verbosegivekeyitem BICYCLE
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
	jumpthisopenedtext

UnknownText_0x5485f:
	text "My Bicycles are"
	line "first-rate! You"

	para "can ride them"
	line "anywhere."
	done

UnknownText_0x54787:
	text "…sigh… I opened"
	line "a branch here,"

	para "but I can't sell"
	line "my Bicycles."
	cont "Why is that?"

	para "Could you ride a"
	line "Bicycle and adver-"
	cont "tise for me?"
	done

UnknownText_0x547f8:
	text "Really? Great!"

	para "Give me your name"
	line "and phone number,"

	para "and I'll loan you"
	line "a Bicycle."
	done

UnknownText_0x54898:
	text "…sigh… Oh, for"
	line "the kindness of"
	cont "people…"
	done

UnknownText_0x548ed:
	text "It's a shiny new"
	line "Bicycle!"
	done

UnknownText_0x548c0:
	text "Just released!"

	para "First-rate compact"
	line "Bicycles!"
	done
