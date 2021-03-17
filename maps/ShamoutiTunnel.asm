ShamoutiTunnel_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 33,  9, SHAMOUTI_ISLAND, 3
	warp_event  5, 17, WARM_BEACH, 2

	def_coord_events

	def_bg_events
	bg_event 21,  5, BGEVENT_ITEM + NUGGET, EVENT_SHAMOUTI_TUNNEL_HIDDEN_NUGGET
	bg_event 32,  4, BGEVENT_ITEM + LEAF_STONE, EVENT_SHAMOUTI_TUNNEL_HIDDEN_LEAF_STONE

	def_object_events
	object_event 15, 17, SPRITE_POKEMANIAC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OreManiacScript, -1
	object_event 24, 14, SPRITE_TAMER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerTamerOswald, -1
	object_event 24,  5, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherTala, -1
	object_event  6,  7, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseerfNoelle, -1
	object_event  3, 16, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerSightseermChester, -1
	itemball_event  3,  4, X_SPEED, 1, EVENT_SHAMOUTI_TUNNEL_X_SPEED
	itemball_event 12, 17, SMOOTH_ROCK, 1, EVENT_SHAMOUTI_TUNNEL_SMOOTH_ROCK

OreManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	promptbutton
	special Special_ChooseItem
	iffalse_jumpopenedtext .NoItemText
	special GetOreManiacPrice
	iffalse_jumpopenedtext .WrongItemText
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse_jumpopenedtext .NoItemText
	readmem wCurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpthisopenedtext

	text "The deal is done!"
	line "I've scored an ore"
	cont "I can adore!"
	done

.GreetingText:
	text "Ore, ore, ore…"
	line "Ores that I adore!"

	para "I'll pay you well"
	line "for rare ores."

	para "Don't you have an"
	line "adorable ore that"
	cont "shakes my core?"
	done

.OfferText:
	text "That ore, it's"
	line "shaking me!"

	para "Will you sell it"
	line "for ¥"
	text_decimal hMoneyTemp, 3, 7
	text "?"
	done

.WrongItemText:
	text "Huh? What on earth"
	line "is this?"

	para "You can't shake my"
	line "core with an ore"
	cont "so poor!"
	done

.NoItemText:
	text "Hmmm. My core won't"
	line "change."

	para "I hope you sell"
	line "one to me someday."
	done

GenericTrainerTamerOswald:
	generictrainer TAMER, OSWALD, EVENT_BEAT_TAMER_OSWALD, .SeenText, .BeatenText

	text "I'm a Tamer now,"
	line "but when I first"

	para "started out in"
	line "the circus I was"

	para "in the #mon"
	line "trapeze act."
	done

.SeenText:
	text "I was born a"
	line "circus man."

	para "Now I'm also a"
	line "fierce battler."
	done

.BeatenText:
	text "I couldn't tame"
	line "your #mon…"
	done

GenericTrainerFirebreatherTala:
	generictrainer FIREBREATHER, TALA, EVENT_BEAT_FIREBREATHER_TALA, .SeenText, .BeatenText

	text "My fire-breathing"
	line "act is really"

	para "popular with the"
	line "tourists."

	para "Some even leave"
	line "donations!"
	done

.SeenText:
	text "Roll up, roll up,"
	line "for my spectacular"
	cont "fire-breathing"
	cont "extravaganza!"
	done

.BeatenText:
	text "Burned out"
	line "already!"
	done

GenericTrainerSightseerfNoelle:
	generictrainer SIGHTSEERF, NOELLE, EVENT_BEAT_SIGHTSEERF_NOELLE, .SeenText, .BeatenText

	text "I'm making a photo"
	line "album to show my"
	cont "parents."

	para "Hey, don't look!"
	line "It's private!"
	done

.SeenText:
	text "Oh my gosh!"
	line "You have #mon"

	para "that I haven't"
	line "seen before!"

	para "Can I take a"
	line "photo?"
	done

.BeatenText:
	text "Aww… I lost?"
	line "No problem!"

	para "Selfie! ♥"
	line "Click!"
	done

GenericTrainerSightseermChester:
	generictrainer SIGHTSEERM, CHESTER, EVENT_BEAT_SIGHTSEERM_CHESTER, .SeenText, .BeatenText

	text "So you're from"
	line "Johto? I haven't"
	cont "been there!"

	para "Maybe I'll see"
	line "you in the Battle"
	cont "Tower."
	done

.SeenText:
	text "I'm traveling"
	line "around the world."

	para "Which region"
	line "should I visit"
	cont "next?"
	done

.BeatenText:
	text "What a great"
	line "experience!"
	done

