LavRadioTower1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, LavRadioTower1FUpstairsScript

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7
	warp_event 15,  0, LAV_RADIO_TOWER_2F, 255

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_JUMPTEXT, LavRadioTower1FDirectoryText
	bg_event  5,  0, BGEVENT_JUMPTEXT, LavRadioTower1FPokeFluteSignText

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FReceptionistText, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FOfficerText, -1
	object_event  1,  3, SPRITE_POKEMANIAC, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, LavRadioTower1FSuperNerd1Text, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1

LavRadioTower1FUpstairsScript:
	checkevent EVENT_EXORCISED_LAV_RADIO_TOWER
	iftrue .Exorcised
	warpmod 1, HAUNTED_RADIO_TOWER_2F
	return

.Exorcised:
	warpmod 1, LAV_RADIO_TOWER_2F
	return

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue_jumpopenedtext .UnknownText_0x7f141
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .UnknownScript_0x7ee80
	jumpopenedtext LavRadioTower1FGentlemanText

.UnknownScript_0x7ee80:
	writetext LavRadioTower1FGentlemanText_ReturnedMachinePart
	buttonsound
	stringtotext .expncardname, $1
	callstd receiveitem
	setflag ENGINE_EXPN_CARD
	jumpthisopenedtext

.UnknownText_0x7f141:
	text "With that thing,"
	line "you can tune into"

	para "the radio programs"
	line "here in Kanto."

	para "Gahahahaha!"
	done

.expncardname
	db "Expn.Card@"

LavRadioTower1FSuperNerd2Script:
	checkflag ENGINE_EXPN_CARD
	iftrue_jumptextfaceplayer LavRadioTower1FSuperNerd2Text_GotExpnCard
	jumpthistextfaceplayer

	text "Hey there!"

	para "I am the super"
	line "Music Director!"

	para "Huh? Your #gear"
	line "can't tune into my"

	para "music programs."
	line "How unfortunate!"

	para "If you get a Expn."
	line "Card upgrade, you"

	para "can tune in. You'd"
	line "better get one!"
	done

LavRadioTower1FReceptionistText:
	text "Welcome!"
	line "Feel free to look"

	para "around anywhere on"
	line "this floor."
	done

LavRadioTower1FOfficerText:
	text "Sorry, but you can"
	line "only tour the"
	cont "ground floor."

	para "Ever since Johto's"
	line "Radio Tower was"

	para "taken over by a"
	line "criminal gang, we"

	para "have had to step"
	line "up our security."
	done

LavRadioTower1FSuperNerd1Text:
	text "Many people are"
	line "hard at work here"

	para "in the Radio"
	line "Tower."

	para "They must be doing"
	line "their best to put"
	cont "on good shows."
	done

LavRadioTower1FGentlemanText:
	text "Oh, no, no, no!"

	para "We've been off the"
	line "air ever since the"

	para "Power Plant shut"
	line "down."

	para "All my efforts to"
	line "start this station"

	para "would be wasted if"
	line "I can't broadcast."

	para "I'll be ruined!"
	done

LavRadioTower1FGentlemanText_ReturnedMachinePart:
	text "Ah! So you're the"
	line "<PLAYER> who solved"

	para "the Power Plant's"
	line "problem?"

	para "Thanks to you, I"
	line "never lost my job."

	para "I tell you, you're"
	line "a real lifesaver!"

	para "Please take this"
	line "as my thanks."
	done

LavRadioTower1FSuperNerd2Text_GotExpnCard:
	text "Hey there!"

	para "I am the super"
	line "Music Director!"

	para "I'm responsible"
	line "for the gorgeous"

	para "melodies that go"
	line "out over the air."

	para "Don't be square."
	line "Grab your music"
	cont "off the air!"
	done

LavRadioTower1FDirectoryText:
	text "1F Reception"
	line "2F Sales"

	para "3F Personnel"
	line "4F Production"

	para "5F Director's"
	line "   Office"
	done

LavRadioTower1FPokeFluteSignText:
	text "Perk Up #mon"
	line "with Mellow Sounds"

	para "of the # Flute"
	line "on Channel 20"
	done

; TODO: use this text
LavRadioTower1FReferenceLibraryText:
	text "Wow! A full rack"
	line "of #mon CDs and"
	cont "videos."

	para "This must be the"
	line "reference library."
	done
