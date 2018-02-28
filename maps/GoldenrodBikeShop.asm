GoldenrodBikeShop_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, GOLDENROD_CITY, 2
	warp_event  3,  7, GOLDENROD_CITY, 2

	db 0 ; coord events

	db 10 ; bg events
	bg_event  1,  2, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  3, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  3, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  5, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  5, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  0,  6, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  1,  6, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  6,  6, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  7,  6, SIGNPOST_JUMPTEXT, UnknownText_0x548ed
	bg_event  3,  0, SIGNPOST_JUMPTEXT, UnknownText_0x548c0

	db 1 ; object events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, ClerkScript_0x54750, -1

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
	giveitem BICYCLE
	writetext UnknownText_0x54848
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
	thisopenedtext

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

UnknownText_0x54848:
	text "<PLAYER> borrowed a"
	line "Bicycle."
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
