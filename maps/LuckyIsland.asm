LuckyIsland_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, Script_ChangeLuckyIslandMap

LuckyIsland_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 9
	person_event SPRITE_BALL_CUT_FRUIT, 18, 27, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, LuckyIslandLuckyEgg, EVENT_LUCKY_ISLAND_LUCKY_EGG
	person_event SPRITE_FISHER, 6, 29, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 1, TrainerFisherHall, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_BAKER, 16, 21, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerBakerMargaret, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_BAKER, 23, 32, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 3, TrainerBakerOlga, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_ARTIST, 21, 20, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 2, TrainerArtistReina, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_ARTIST, 16, 36, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_TRAINER, 4, TrainerArtistAlina, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_SIGHTSEER_M, 11, 23, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersLiandsu1, EVENT_LUCKY_ISLAND_CIVILIANS
	person_event SPRITE_LADY, 12, 23, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_TRAINER, 1, TrainerSightseersLiandsu2, EVENT_LUCKY_ISLAND_CIVILIANS
	fruittree_event 16, 25, FRUITTREE_LUCKY_ISLAND, LIECHI_BERRY, EVENT_LUCKY_ISLAND_CIVILIANS

const_value set 1
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
	trainer EVENT_BEAT_FISHER_HALL, FISHER, HALL, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BAKER_MARGARET, BAKER, MARGARET, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_BAKER_OLGA, BAKER, OLGA, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_ARTIST_REINA, ARTIST, REINA, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_ARTIST_ALINA, ARTIST, ALINA, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SIGHTSEERS_LI_AND_SU, SIGHTSEERS, LIANDSU1, .SeenText, .BeatenText, 0, .Script

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
	trainer EVENT_BEAT_SIGHTSEERS_LI_AND_SU, SIGHTSEERS, LIANDSU2, .SeenText, .BeatenText, 0, .Script

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
