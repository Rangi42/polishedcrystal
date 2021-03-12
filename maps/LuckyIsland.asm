LuckyIsland_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, Script_ChangeLuckyIslandMap

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 27, 18, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LuckyIslandLuckyEgg, EVENT_LUCKY_ISLAND_LUCKY_EGG
	object_event 29,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherHall, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 21, 16, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBakerMargaret, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 32, 23, SPRITE_BAKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBakerOlga, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 20, 21, SPRITE_ARTIST, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerArtistReina, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 36, 16, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerArtistAlina, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 23, 11, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSightseersLiandsu1, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 23, 12, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerSightseersLiandsu2, EVENT_LUCKY_ISLAND_CIVILIANS
	fruittree_event 25, 16, FRUITTREE_LUCKY_ISLAND, LIECHI_BERRY, PAL_NPC_RED, EVENT_LUCKY_ISLAND_CIVILIANS

	object_const_def
	const LUCKYISLAND_POKE_BALL

Script_ChangeLuckyIslandMap:
	special CheckIfTrendyPhraseIsLucky
	iftrue .show
	changemapblocks LuckyIslandHidden_BlockData
	setevent EVENT_LUCKY_ISLAND_CIVILIANS
.hide_poke_ball
	setevent EVENT_LUCKY_ISLAND_LUCKY_EGG
	endcallback

.show
	changemapblocks LuckyIsland_BlockData
	clearevent EVENT_LUCKY_ISLAND_CIVILIANS
	checkevent EVENT_GOT_LUCKY_EGG_FROM_LUCKY_ISLAND
	iftrue .hide_poke_ball
	clearevent EVENT_LUCKY_ISLAND_LUCKY_EGG
	endcallback

GenericTrainerFisherHall:
	generictrainer FISHER, HALL, EVENT_BEAT_FISHER_HALL, .SeenText, .BeatenText

	text "You just don't"
	line "appreciate my"
	cont "sense of humor."
	done

.SeenText:
	text "Dopefish lives!"
	done

.BeatenText:
	text "Swim swim hungry,"
	line "swim swim hungry!"
	done

GenericTrainerBakerMargaret:
	generictrainer BAKER, MARGARET, EVENT_BEAT_BAKER_MARGARET, .SeenText, .BeatenText

	text "I'm eggs-hausted."
	done

.SeenText:
	text "If an egg tumbles"
	line "downhill, does"

	para "that make it an"
	line "eggroll?"
	done

.BeatenText:
	text "Guess I'm the"
	line "eggroll now."
	done

GenericTrainerBakerOlga:
	generictrainer BAKER, OLGA, EVENT_BEAT_BAKER_OLGA, .SeenText, .BeatenText

	text "The first step to"
	line "healthy living is"

	para "to eat a good"
	line "breakfast."
	done

.SeenText:
	text "Hey, you!"
	line "Do you eat a good"
	cont "breakfast every"
	cont "day?"
	done

.BeatenText:
	text "Wow! Looks like"
	line "you do."
	done

GenericTrainerArtistReina:
	generictrainer ARTIST, REINA, EVENT_BEAT_ARTIST_REINA, .SeenText, .BeatenText

	text "I'll add a happy"
	line "little tree to"
	cont "cover that up."
	done

.SeenText:
	text "This sunny meadow"
	line "will make a lovely"
	cont "painting!"
	done

.BeatenText:
	text "My brush slipped!"
	done

GenericTrainerArtistAlina:
	generictrainer ARTIST, ALINA, EVENT_BEAT_ARTIST_ALINA, .SeenText, .BeatenText

	text "I wonder what"
	line "caused this island"
	cont "to appear?"
	done

.SeenText:
	text "This island hardly"
	line "ever appears."

	para "I was so lucky to"
	line "find it!"
	done

.BeatenText:
	text "My luck ran out…"
	done

GenericTrainerSightseersLiandsu1:
	generictrainer SIGHTSEERS, LIANDSU1, EVENT_BEAT_SIGHTSEERS_LI_AND_SU, .SeenText, .BeatenText

	text "Li: Su and I keep"
	line "arguing about"
	cont "this."
	done

.SeenText:
	text "Li: What came"
	line "first?"

	para "The #mon or"
	line "the Egg?"
	done

.BeatenText:
	text "Li: I say it's the"
	line "#mon!"
	done

GenericTrainerSightseersLiandsu2:
	generictrainer SIGHTSEERS, LIANDSU2, EVENT_BEAT_SIGHTSEERS_LI_AND_SU, .SeenText, .BeatenText

	text "Su: Are there any"
	line "#mon that don't"
	cont "come from Eggs?"
	done

.SeenText:
	text "Su: What came"
	line "first?"

	para "The #mon or"
	line "the Egg?"
	done

.BeatenText:
	text "Su: I think the"
	line "Egg came first!"
	done

LuckyIslandLuckyEgg:
	giveitem LUCKY_EGG
	iffalse .NoRoom
	disappear LUCKYISLAND_POKE_BALL
	setevent EVENT_GOT_LUCKY_EGG_FROM_LUCKY_ISLAND
	opentext
	writetext .Text
	playsound SFX_ITEM
	pause 60
	itemnotify
	endtext

.NoRoom:
	opentext
	writetext .Text
	waitbutton
	pocketisfull
	endtext

.Text:
	text "<PLAYER> found"
	line "Lucky Egg!"
	done
