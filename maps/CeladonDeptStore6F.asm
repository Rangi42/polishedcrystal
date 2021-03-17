CeladonDeptStore6F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15,  0, CELADON_DEPT_STORE_5F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_JUMPTEXT, CeladonDeptStore6FDirectoryText

	def_object_events
	object_event  9,  2, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore6FSuperNerdText, -1
	object_event 12,  5, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, CeladonDeptStore6FYoungsterText, -1
	object_event  5,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FGameboyKid1Script, -1
	object_event  6,  1, SPRITE_GAMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore3FGameboyKid2Script, -1

CeladonDeptStore3FGameboyKid1Script:
	showtextfaceplayer CeladonDeptStore3FGameboyKid1Text
	turnobject LAST_TALKED, DOWN
	end

CeladonDeptStore3FGameboyKid2Script:
	showtextfaceplayer CeladonDeptStore3FGameboyKid2Text
	turnobject LAST_TALKED, DOWN
	end

CeladonDeptStore6FSuperNerdText:
	text "A vending machine"
	line "with a prize rou-"
	cont "lette…"

	para "You never see"
	line "those anymore."
	done

CeladonDeptStore6FYoungsterText:
	text "I can play games"
	line "on the third"
	cont "floor, then come"

	para "here when I get"
	line "thirsty!"

	para "This store is"
	line "great!"
	done

CeladonDeptStore3FGameboyKid1Text:
	text "I traded my"
	line "#mon while"

	para "it was holding"
	line "an Up-Grade."
	done

CeladonDeptStore3FGameboyKid2Text:
	text "Yay! I'm finally"
	line "getting a Porygon!"

	para "I'm no good at the"
	line "slots, so I could"

	para "never get enough"
	line "coins…"

	para "I'll raise it with"
	line "an Up-Grade to"
	cont "make it evolve!"
	done

CeladonDeptStore6FDirectoryText:
	text "6F: Rooftop Atrium"
	line "Vending Machines"
	done
