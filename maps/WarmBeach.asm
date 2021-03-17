WarmBeach_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 15, 13, WARM_BEACH_SHACK, 1
	warp_event  8,  5, SHAMOUTI_TUNNEL, 2
	warp_event  3,  8, WARM_BEACH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 14, BGEVENT_JUMPTEXT, WarmBeachShackSignText
	bg_event 18, 20, BGEVENT_JUMPTEXT, WarmBeachShrineText
	bg_event 19, 20, BGEVENT_JUMPTEXT, WarmBeachShrineText
	bg_event  6, 20, BGEVENT_ITEM + PEARL, EVENT_WARM_BEACH_HIDDEN_PEARL

	def_object_events
	object_event 11,  8, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermGareth, -1
	object_event  4, 12, SPRITE_AROMA_LADY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerAromaLadyHolly, -1
	object_event 11, 14, SPRITE_COOL_DUDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachCooltrainermText, -1
	object_event 22, 20, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachCooltrainerfText, -1
	object_event 17, 21, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, SLOWKING, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, WarmBeachSlowkingScript, -1
	object_event 11, 20, SPRITE_PICNICKER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WarmBeachLassScript, -1
	object_event  6, 23, SPRITE_LADY, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, WarmBeachLadyText, -1

GenericTrainerSightseermGareth:
	generictrainer SIGHTSEERM, GARETH, EVENT_BEAT_SIGHTSEERM_GARETH, .SeenText, .BeatenText

	text "Even outside of"
	line "battle, these"

	para "items make memor-"
	line "able souvenirs."
	done

.SeenText:
	text "I just picked up"
	line "some useful items"

	para "from the outdoor"
	line "market!"
	done

.BeatenText:
	text "My items weren't"
	line "enough…"
	done

GenericTrainerAromaLadyHolly:
	generictrainer AROMA_LADY, HOLLY, EVENT_BEAT_AROMA_LADY_HOLLY, .SeenText, .BeatenText

	text "The sense of smell"
	line "is vital to living"
	cont "in nature."
	done

.SeenText:
	text "I am at one with"
	line "the aromas of"
	cont "nature."
	done

.BeatenText:
	text "Defeat has its"
	line "own scent…"
	done

WarmBeachCooltrainermText:
	text "There's a #mon"
	line "here that talks!"

	para "I would never be-"
	line "lieve it if I"

	para "hadn't seen it for"
	line "myself!"
	done

WarmBeachCooltrainerfText:
	text "I've been selected"
	line "as the festival"
	cont "maiden this year,"

	para "so I have to play"
	line "the melody of the"
	cont "Chosen One."

	para "I'm pretty nervous,"
	line "so I came here to"
	cont "practice."
	done

WarmBeachSlowkingScript:
	jumpthistext

	text "I could use"
	line "pants…"
	done

WarmBeachLassScript:
	faceplayer
	opentext
	checkflag ENGINE_SEASHORE_SHELL_BELL
	iftrue_jumpopenedtext .Text3
	writetext .Text1
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .Text4
	checkmoney $0, 4000
	ifequal $2, .NotEnoughMoney
	giveitem SHELL_BELL
	iffalse_jumpopenedtext .Text6
	setflag ENGINE_SEASHORE_SHELL_BELL
	waitsfx
	playsound SFX_TRANSACTION
	takemoney $0, 4000
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "One Shell Bell,"
	line "just for you!"
	done

.NotEnoughMoney:
	jumpthisopenedtext

	text "You don't have"
	line "enough money…"
	done

.Text1:
	text "I collect shells"
	line "off the beach and"

	para "turn them into"
	line "Shell Bells."

	para "People say their"
	line "chime is healing."

	para "They're ¥4000"
	line "each. Want one?"
	done

.Text3:
	text "I only made one"
	line "Shell Bell today…"
	done

.Text4:
	text "That's OK!"
	done

.Text6:
	text "You don't have"
	line "enough room…"
	done

WarmBeachLadyText:
	text "Those islands"
	line "across the water"

	para "are known as the"
	line "temples of Fire,"

	para "Ice, and Light-"
	line "ning."

	para "That's what this"
	line "brochure says,"

	para "but what are they"
	line "for?"
	done

WarmBeachShackSignText:
	text "Beach Shack"
	done

WarmBeachShrineText:
	text "It's a shrine"
	line "dedicated to the"

	para "Guardian of the"
	line "Seas."
	done
