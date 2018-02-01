LuckyIsland_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, Script_ChangeLuckyIslandMap

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 9 ; object events
	object_event 27, 18, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LuckyIslandLuckyEgg, EVENT_LUCKY_ISLAND_LUCKY_EGG
	object_event 29, 6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherHall, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 21, 16, SPRITE_BAKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBakerMargaret, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 32, 23, SPRITE_BAKER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBakerOlga, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 20, 21, SPRITE_ARTIST, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerArtistReina, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 36, 16, SPRITE_ARTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerArtistAlina, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 23, 11, SPRITE_SIGHTSEER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersLiandsu1, EVENT_LUCKY_ISLAND_CIVILIANS
	object_event 23, 12, SPRITE_LADY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersLiandsu2, EVENT_LUCKY_ISLAND_CIVILIANS
	fruittree_event 25, 16, FRUITTREE_LUCKY_ISLAND, LIECHI_BERRY, EVENT_LUCKY_ISLAND_CIVILIANS

	const_def 1 ; object constants
	const LUCKYISLAND_POKE_BALL

Script_ChangeLuckyIslandMap:
	special CheckIfTrendyPhraseIsLucky
	iftrue .show
	changemap LuckyIslandHidden_BlockData
	setevent EVENT_LUCKY_ISLAND_CIVILIANS
.hide_poke_ball
	setevent EVENT_LUCKY_ISLAND_LUCKY_EGG
	return

.show
	changemap LuckyIsland_BlockData
	clearevent EVENT_LUCKY_ISLAND_CIVILIANS
	checkevent EVENT_GOT_LUCKY_EGG_FROM_LUCKY_ISLAND
	iftrue .hide_poke_ball
	clearevent EVENT_LUCKY_ISLAND_LUCKY_EGG
	return

TrainerFisherHall:
	trainer FISHER, HALL, EVENT_BEAT_FISHER_HALL, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "Dopefish lives!"
	done

.BeatenText:
	text "Swim swim hungry,"
	line "swim swim hungry!"
	done

.AfterText:
	text "You just don't"
	line "appreciate my"
	cont "sense of humor."
	done

TrainerBakerMargaret:
	trainer BAKER, MARGARET, EVENT_BEAT_BAKER_MARGARET, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "I'm eggs-hausted."
	done

TrainerBakerOlga:
	trainer BAKER, OLGA, EVENT_BEAT_BAKER_OLGA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "The first step to"
	line "healthy living is"

	para "to eat a good"
	line "breakfast."
	done

TrainerArtistReina:
	trainer ARTIST, REINA, EVENT_BEAT_ARTIST_REINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "This sunny meadow"
	line "will make a lovely"
	cont "painting!"
	done

.BeatenText:
	text "My brush slipped!"
	done

.AfterText:
	text "I'll add a happy"
	line "little tree to"
	cont "cover that up."
	done

TrainerArtistAlina:
	trainer ARTIST, ALINA, EVENT_BEAT_ARTIST_ALINA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

.SeenText:
	text "This island hardly"
	line "ever appears."

	para "I was so lucky to"
	line "find it!"
	done

.BeatenText:
	text "My luck ran out…"
	done

.AfterText:
	text "I wonder what"
	line "caused this island"
	cont "to appear?"
	done

TrainerSightseersLiandsu1:
	trainer SIGHTSEERS, LIANDSU1, EVENT_BEAT_SIGHTSEERS_LI_AND_SU, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "Li: Su and I keep"
	line "arguing about"
	cont "this."
	done

TrainerSightseersLiandsu2:
	trainer SIGHTSEERS, LIANDSU2, EVENT_BEAT_SIGHTSEERS_LI_AND_SU, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "Su: Are there any"
	line "#mon that don't"
	cont "come from Eggs?"
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
