Route19_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, Route19ClearRocks

Route19_MapEventHeader:

.Warps: db 2
	warp_def $1, $7, 3, ROUTE_19_FUCHSIA_GATE
	warp_def $d, $5, 1, ROUTE_19_BEACH_HOUSE

.XYTriggers: db 0

.Signposts: db 6
	signpost 15, 11, SIGNPOST_JUMPTEXT, Route19SignText
	signpost -1, 11, SIGNPOST_JUMPTEXT, CarefulSwimmingSignText
	signpost 3, 5, SIGNPOST_ITEM, Route19HiddenRevive
	signpost 11, 3, SIGNPOST_ITEM, Route19HiddenMaxRevive
	signpost 15, 5, SIGNPOST_ITEM, Route19HiddenPearl1
	signpost 13, 13, SIGNPOST_ITEM, Route19HiddenPearl2

.PersonEvents: db 13
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 4, 11, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 3, 6, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 11, 4, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 13, 12, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, smashrock, -1
	person_event SPRITE_ROCK_BOULDER_FOSSIL, 14, 13, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, PERSONTYPE_JUMPSTD, 0, smashrock, -1
	person_event SPRITE_SWIMMER_GIRL, 34, 8, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfDawn, -1
	person_event SPRITE_SWIMMER_GUY, 34, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 2, TrainerSwimmermTucker, -1
	person_event SPRITE_SWIMMER_GUY, 20, 11, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermJerome, -1
	person_event SPRITE_SWIMMER_GUY, 43, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermHarold, -1
	person_event SPRITE_COSPLAYER, 51, 13, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCosplayerBrooke, -1
	person_event SPRITE_ENGINEER, 3, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, EngineerScript_0x19ea4d, -1
	person_event SPRITE_ENGINEER, 3, 11, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, EngineerScript_0x19ea61, -1
	person_event SPRITE_BALL_CUT_FRUIT, 52, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, BIG_PEARL, 1, EVENT_ROUTE_19_BIG_PEARL

const_value set 2
	const ROUTE19_ROCK1

Route19ClearRocks:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .Done
	changeblock $6, $4, $7a
	changeblock $8, $4, $7a
	changeblock $a, $4, $7a
	changeblock $6, $6, $7a
	changeblock $c, $6, $7a
	changeblock $8, $8, $7a
	disappear ROUTE19_ROCK1
.Done:
	return

TrainerSwimmerfDawn:
	trainer EVENT_BEAT_SWIMMERF_DAWN, SWIMMERF, DAWN, SwimmerfDawnSeenText, SwimmerfDawnBeatenText, 0, SwimmerfDawnScript

SwimmerfDawnScript:
	end_if_just_battled
	jumptext UnknownText_0x19ebad

TrainerSwimmermTucker:
	trainer EVENT_BEAT_SWIMMERM_TUCKER, SWIMMERM, TUCKER, SwimmermTuckerSeenText, SwimmermTuckerBeatenText, 0, SwimmermTuckerScript

SwimmermTuckerScript:
	end_if_just_battled
	jumptext UnknownText_0x19eb3b

TrainerSwimmermJerome:
	trainer EVENT_BEAT_SWIMMERM_JEROME, SWIMMERM, JEROME, SwimmermJeromeSeenText, SwimmermJeromeBeatenText, 0, SwimmermJeromeScript

SwimmermJeromeScript:
	end_if_just_battled
	jumptext UnknownText_0x19ec7e

TrainerSwimmermHarold:
	trainer EVENT_BEAT_SWIMMERM_HAROLD, SWIMMERM, HAROLD, SwimmermHaroldSeenText, SwimmermHaroldBeatenText, 0, SwimmermHaroldScript

SwimmermHaroldScript:
	end_if_just_battled
	jumptext UnknownText_0x19eab4

TrainerCosplayerBrooke:
	trainer EVENT_BEAT_COSPLAYER_BROOKE, COSPLAYER, BROOKE, CosplayerBrookeSeenText, CosplayerBrookeBeatenText, 0, CosplayerBrookeScript

CosplayerBrookeScript:
	end_if_just_battled
	jumptext CosplayerBrookeAfterText

EngineerScript_0x19ea4d:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	jumptextfaceplayer_iftrue UnknownText_0x19ecaf
	jumptextfaceplayer UnknownText_0x19ed24

EngineerScript_0x19ea61:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	jumptextfaceplayer_iftrue Route19EngineerText2
	jumptextfaceplayer Route19EngineerText1

Route19HiddenRevive:
	dwb EVENT_ROUTE_19_HIDDEN_REVIVE, REVIVE

Route19HiddenMaxRevive:
	dwb EVENT_ROUTE_19_HIDDEN_MAX_REVIVE, MAX_REVIVE

Route19HiddenPearl1:
	dwb EVENT_ROUTE_19_HIDDEN_PEARL_1, PEARL

Route19HiddenPearl2:
	dwb EVENT_ROUTE_19_HIDDEN_PEARL_2, PEARL

SwimmerfDawnSeenText:
	text "I'm disgusted by"
	line "wimpy people!"
	done

SwimmerfDawnBeatenText:
	text "I could beat you"
	line "at swimming…"
	done

UnknownText_0x19ebad:
	text "It's a quick swim"
	line "between Fuchsia"

	para "and Seafoam Is-"
	line "lands…"

	para "Sheesh, some big"
	line "man my boyfriend"
	cont "is! What a wimp!"
	done

SwimmermTuckerSeenText:
	text "Pant, pant…"
	line "Just… a little…"

	para "farther… to…"
	line "Fuchsia…"
	done

SwimmermTuckerBeatenText:
	text "I'm drowning!"
	done

UnknownText_0x19eb3b:
	text "I… asked my girl-"
	line "friend to swim to"
	cont "Fuchsia… Gasp…"
	done

SwimmermJeromeSeenText:
	text "Swimming?"
	line "I'm lousy at it."

	para "I'm just splashing"
	line "around in these"
	cont "shallow waters."
	done

SwimmermJeromeBeatenText:
	text "I thought I could"
	line "win."
	done

UnknownText_0x19ec7e:
	text "I might be bad at"
	line "swimming, but I"
	cont "love the sea."
	done

SwimmermHaroldSeenText:
	text "Have you ever gone"
	line "swimming in the"
	cont "sea at night?"
	done

SwimmermHaroldBeatenText:
	text "Glub…"
	done

UnknownText_0x19eab4:
	text "At night, the sea"
	line "turns black. It"

	para "feels like it will"
	line "swallow you up."
	done

CosplayerBrookeSeenText:
	text "Dressing up is"
	line "such fun!"
	done

CosplayerBrookeBeatenText:
	text "You'd better not"
	line "have damaged my"
	cont "costume!"
	done

CosplayerBrookeAfterText:
	text "I made this outfit"
	line "for a fancy dress"
	cont "party, but I love"

	para "it so much that I"
	line "wear it elsewhere"
	cont "too."
	done

UnknownText_0x19ecaf:
	text "Sorry. This road"
	line "is closed for"
	cont "construction."

	para "If you want to get"
	line "to Cinnabar, you'd"

	para "better go south"
	line "from Pallet Town."
	done

UnknownText_0x19ed24:
	text "I'm all sweaty."
	line "Time for a swim!"
	done

Route19EngineerText1:
	text "Who knows how long"
	line "it would take to"
	cont "move this boulder…"
	done

Route19EngineerText2:
	text "The roadwork is"
	line "finally finished."

	para "Now I can go"
	line "fishing again."
	done

Route19SignText:
	text "Route 19"

	para "Fuchsia City -"
	line "Seafoam Islands"
	done

CarefulSwimmingSignText:
	text "Please be careful"
	line "if you are swim-"
	cont "ming to Seafoam"
	cont "Islands."

	para "Fuchsia Police"
	done
