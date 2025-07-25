OlsteetonFisherHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, OLSTEETON, 17
	warp_event  3,  7, OLSTEETON, 17

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GreatRodGuru, -1

GreatRodGuru:
	faceplayer
	opentext
	checkevent EVENT_GOT_GOOD_ROD
	iftrue_jumpopenedtext HaveGreatRodText
	writetext OfferGreatRodText
	yesorno
	iffalse_jumpopenedtext DontWantGreatRodText
	writetext GiveGreatRodText
	promptbutton
	verbosegivekeyitem GOOD_ROD
	writetext GaveGreatRodText
	waitbutton
	closetext
	setevent EVENT_GOT_GOOD_ROD
	end

OfferGreatRodText:
	text "Olsteeton is on"
	line "the river!"

	para "And if it's on the"
	line "river, there are"
	cont "bound to be fish!"

	para "I've fished here"
	line "for 30 years."

	para "Would you like to"
	line "face the river"
	cont "and fish?"
	done

GiveGreatRodText:
	text "Ah, hahah!"
	line "We have ourselves"
	cont "a new angler!"
	done

GaveGreatRodText:
	text "Fish aren't found"
	line "in the river alone."

	para "They go wherever"
	line "there is water."
	done

DontWantGreatRodText:
	text "Whaaat? You don't"
	line "like to fish?!"
	cont "Incomprehensible!"
	done

HaveGreatRodText:
	text "How are things?"
	line "Land the big one?"
	done
