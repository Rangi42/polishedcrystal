ShamoutiTunnel_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ShamoutiTunnel_MapEventHeader:

.Warps: db 2
	warp_def 9, 33, 3, SHAMOUTI_ISLAND
	warp_def 17, 5, 2, WARM_BEACH

.XYTriggers: db 0

.Signposts: db 2
	signpost 5, 21, SIGNPOST_ITEM + NUGGET, EVENT_SHAMOUTI_TUNNEL_HIDDEN_NUGGET
	signpost 4, 32, SIGNPOST_ITEM + LEAF_STONE, EVENT_SHAMOUTI_TUNNEL_HIDDEN_LEAF_STONE

.PersonEvents: db 7
	person_event SPRITE_SUPER_NERD, 17, 15, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, OreManiacScript, -1
	person_event SPRITE_COOLTRAINER_M, 14, 24, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerTamerOswald, -1
	person_event SPRITE_FISHER, 5, 24, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerFirebreatherTala, -1
	person_event SPRITE_LADY, 7, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSightseerfNoelle, -1
	person_event SPRITE_SIGHTSEER_M, 16, 3, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSightseermChester, -1
	itemball_event 4, 3, X_SPEED, 1, EVENT_SHAMOUTI_TUNNEL_X_SPEED
	itemball_event 17, 12, SMOOTH_ROCK, 1, EVENT_SHAMOUTI_TUNNEL_SMOOTH_ROCK

OreManiacScript:
	faceplayer
	opentext
	writetext .GreetingText
	buttonsound
	special Special_ChooseItem
	iffalse .NoItem
	special GetOreManiacPrice
	iffalse .WrongItem
	writetext .OfferText
	special PlaceMoneyTopRight
	yesorno
	iffalse .NoItem
	copybytetovar CurItem
	takeitem ITEM_FROM_MEM
	waitsfx
	playsound SFX_TRANSACTION
	special Give_hMoneyTemp
	special PlaceMoneyTopRight
	jumpopenedtext .ThankYouText

.NoItem:
	jumpopenedtext .NoItemText

.WrongItem:
	jumpopenedtext .WrongItemText

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
	line "for ¥@"
	deciram hMoneyTemp, 3, 7
	text "?"
	done

.ThankYouText:
	text "The deal is done!"
	line "I've scored an ore"
	cont "I can adore!"
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

TrainerTamerOswald:
	trainer EVENT_BEAT_TAMER_OSWALD, TAMER, OSWALD, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "I'm a Tamer now,"
	line "but when I first"

	para "started out in"
	line "the circus I was"

	para "in the #mon"
	line "trapeze act."
	done

TrainerFirebreatherTala:
	trainer EVENT_BEAT_FIREBREATHER_TALA, FIREBREATHER, TALA, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "My fire-breathing"
	line "act is really"

	para "popular with the"
	line "tourists."

	para "Some even leave"
	line "donations!"
	done

TrainerSightseerfNoelle:
	trainer EVENT_BEAT_SIGHTSEERF_NOELLE, SIGHTSEERF, NOELLE, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "I'm making a photo"
	line "album to show my"
	cont "parents."

	para "Hey, don't look!"
	line "It's private!"
	done

TrainerSightseermChester:
	trainer EVENT_BEAT_SIGHTSEERM_CHESTER, SIGHTSEERM, CHESTER, .SeenText, .BeatenText, 0, .Script

.Script:
	end_if_just_battled
	jumptextfaceplayer .AfterText

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

.AfterText:
	text "So you're from"
	line "Johto? I haven't"
	cont "been there!"

	para "Maybe I'll see"
	line "you in the Battle"
	cont "Tower."
	done
