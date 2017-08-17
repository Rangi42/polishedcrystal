Route41_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route41_MapEventHeader:

.Warps: db 4
	warp_def 17, 13, 1, WHIRL_ISLAND_NW
	warp_def 19, 37, 1, WHIRL_ISLAND_NE
	warp_def 37, 13, 1, WHIRL_ISLAND_SW
	warp_def 45, 37, 1, WHIRL_ISLAND_SE

.XYTriggers: db 0

.Signposts: db 1
	signpost 35, 9, SIGNPOST_ITEM + MAX_ETHER, EVENT_ROUTE_41_HIDDEN_MAX_ETHER

.PersonEvents: db 11
	person_event SPRITE_SWIMMER_GUY, 6, 32, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermCharlie, -1
	person_event SPRITE_SWIMMER_GUY, 8, 46, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermGeorge, -1
	person_event SPRITE_SWIMMER_GUY, 26, 20, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermBerke, -1
	person_event SPRITE_SWIMMER_GUY, 30, 32, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermKirk, -1
	person_event SPRITE_SWIMMER_GUY, 46, 19, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermMathew, -1
	person_event SPRITE_SWIMMER_GUY, 24, 57, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSwimmermLewis, -1
	person_event SPRITE_SWIMMER_GIRL, 4, 17, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfKaylee, -1
	person_event SPRITE_SWIMMER_GIRL, 19, 23, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfSusie, -1
	person_event SPRITE_SWIMMER_GIRL, 34, 27, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerSwimmerfDenise, -1
	person_event SPRITE_SWIMMER_GIRL, 28, 44, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 4, TrainerSwimmerfKara, -1
	person_event SPRITE_SWIMMER_GIRL, 50, 9, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 2, TrainerSwimmerfWendy, -1

TrainerSwimmerfKaylee:
	trainer EVENT_BEAT_SWIMMERF_KAYLEE, SWIMMERF, KAYLEE, SwimmerfKayleeSeenText, SwimmerfKayleeBeatenText, 0, SwimmerfKayleeScript

SwimmerfKayleeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6c7f

TrainerSwimmerfSusie:
	trainer EVENT_BEAT_SWIMMERF_SUSIE, SWIMMERF, SUSIE, SwimmerfSusieSeenText, SwimmerfSusieBeatenText, 0, SwimmerfSusieScript

SwimmerfSusieScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6d11

TrainerSwimmerfDenise:
	trainer EVENT_BEAT_SWIMMERF_DENISE, SWIMMERF, DENISE, SwimmerfDeniseSeenText, SwimmerfDeniseBeatenText, 0, SwimmerfDeniseScript

SwimmerfDeniseScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6d79

TrainerSwimmerfKara:
	trainer EVENT_BEAT_SWIMMERF_KARA, SWIMMERF, KARA, SwimmerfKaraSeenText, SwimmerfKaraBeatenText, 0, SwimmerfKaraScript

SwimmerfKaraScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6e58

TrainerSwimmerfWendy:
	trainer EVENT_BEAT_SWIMMERF_WENDY, SWIMMERF, WENDY, SwimmerfWendySeenText, SwimmerfWendyBeatenText, 0, SwimmerfWendyScript

SwimmerfWendyScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6ec2

TrainerSwimmermCharlie:
	trainer EVENT_BEAT_SWIMMERM_CHARLIE, SWIMMERM, CHARLIE, SwimmermCharlieSeenText, SwimmermCharlieBeatenText, 0, SwimmermCharlieScript

SwimmermCharlieScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a696e

TrainerSwimmermGeorge:
	trainer EVENT_BEAT_SWIMMERM_GEORGE, SWIMMERM, GEORGE, SwimmermGeorgeSeenText, SwimmermGeorgeBeatenText, 0, SwimmermGeorgeScript

SwimmermGeorgeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a69d4

TrainerSwimmermBerke:
	trainer EVENT_BEAT_SWIMMERM_BERKE, SWIMMERM, BERKE, SwimmermBerkeSeenText, SwimmermBerkeBeatenText, 0, SwimmermBerkeScript

SwimmermBerkeScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6aa4

TrainerSwimmermKirk:
	trainer EVENT_BEAT_SWIMMERM_KIRK, SWIMMERM, KIRK, SwimmermKirkSeenText, SwimmermKirkBeatenText, 0, SwimmermKirkScript

SwimmermKirkScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6b6c

TrainerSwimmermMathew:
	trainer EVENT_BEAT_SWIMMERM_MATHEW, SWIMMERM, MATHEW, SwimmermMathewSeenText, SwimmermMathewBeatenText, 0, SwimmermMathewScript

SwimmermMathewScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a6bed

TrainerSwimmermLewis:
	trainer EVENT_BEAT_SWIMMERM_LEWIS, SWIMMERM, LEWIS, SwimmermLewisSeenText, SwimmermLewisBeatenText, 0, SwimmermLewisScript

SwimmermLewisScript:
	end_if_just_battled
	jumptextfaceplayer SwimmermLewisAfterText

SwimmermCharlieSeenText:
	text "The water's warm"
	line "here. I'm loose"
	cont "and limber."

	para "Sure, I'll take"
	line "you on!"
	done

SwimmermCharlieBeatenText:
	text "Yikes! I've got"
	line "prune skin!"
	done

UnknownText_0x1a696e:
	text "Isn't it relaxing"
	line "just floating like"
	cont "this?"
	done

SwimmermGeorgeSeenText:
	text "I'm a bit tired."
	line "If I win, lend me"
	cont "your #mon."
	done

SwimmermGeorgeBeatenText:
	text "Pant, pant…"
	done

UnknownText_0x1a69d4:
	text "It's so far to"
	line "Cianwood."

	para "But it's no easy"
	line "return trip to"
	cont "Olivine either."

	para "What should I do?"
	done

SwimmermBerkeSeenText:
	text "See those islands"
	line "that are blocked"
	cont "by whirlpools?"

	para "There just has to"
	line "be a secret!"
	done

SwimmermBerkeBeatenText:
	text "What's the secret"
	line "to your strength?"
	done

UnknownText_0x1a6aa4:
	text "It was a dark and"
	line "stormy night…"

	para "I saw this giant"
	line "#mon flying"
	cont "from the islands."

	para "It was scattering"
	line "feathers from its"
	cont "silver wings."
	done

SwimmermKirkSeenText:
	text "The waves are wild"
	line "here."

	para "They tire you out"
	line "while you swim."
	done

SwimmermKirkBeatenText:
	text "I'm beat!"
	done

UnknownText_0x1a6b6c:
	text "The currents keep"
	line "me from reaching"
	cont "that island."
	done

SwimmermMathewSeenText:
	text "Are you seeking"
	line "the secrets of"
	cont "Whirl Islands?"
	done

SwimmermMathewBeatenText:
	text "Ooh, you've got"
	line "great endurance!"
	done

UnknownText_0x1a6bed:
	text "A secret about"
	line "Whirl Islands…"

	para "It's pitch-black"
	line "inside!"
	done

SwimmermLewisSeenText:
	text "I feel right at"
	line "home in the sea!"
	done

SwimmermLewisBeatenText:
	text "Beaten in my own"
	line "home?"
	done

SwimmermLewisAfterText:
	text "It takes knowledge"
	line "and experience"

	para "to not get lost"
	line "in the water."
	done

SwimmerfKayleeSeenText:
	text "I'm on my way to"
	line "Whirl Islands."

	para "I'm going explor-"
	line "ing with friends."
	done

SwimmerfKayleeBeatenText:
	text "Is that how you do"
	line "it?"
	done

UnknownText_0x1a6c7f:
	text "There's supposed"
	line "to be a big #-"
	cont "mon deep beneath"
	cont "Whirl Islands."

	para "I wonder what it"
	line "could be?"
	done

SwimmerfSusieSeenText:
	text "You look so ele-"
	line "gant, riding your"
	cont "#mon."
	done

SwimmerfSusieBeatenText:
	text "I'm crushed…"
	done

UnknownText_0x1a6d11:
	text "Wasn't there a hit"
	line "song about a boy"
	cont "riding a Lapras?"
	done

SwimmerfDeniseSeenText:
	text "The weather is so"
	line "beautiful, I'm in"
	cont "a daze!"
	done

SwimmerfDeniseBeatenText:
	text "Ohhh!"
	done

UnknownText_0x1a6d79:
	text "A sunburn is the"
	line "worst for skin."

	para "But I don't use a"
	line "sunblock."

	para "I won't pollute"
	line "the water."
	done

SwimmerfKaraSeenText:
	text "If you need to"
	line "rest, just tread"
	cont "water."

	para "You'll get your"
	line "wind back, so you"

	para "can keep on going"
	line "strong."
	done

SwimmerfKaraBeatenText:
	text "Oh! You have more"
	line "energy than I do."
	done

UnknownText_0x1a6e58:
	text "I heard roars from"
	line "deep inside the"
	cont "Islands."
	done

SwimmerfWendySeenText:
	text "At night, Staryu"
	line "gather near the"
	cont "water's surface."
	done

SwimmerfWendyBeatenText:
	text "Oh, dear…"
	done

UnknownText_0x1a6ec2:
	text "The clusters of"
	line "Staryu light up"
	cont "at the same time."

	para "It's so beautiful,"
	line "it's scary."
	done
