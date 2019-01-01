SoulHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  4,  9, LAVENDER_TOWN, 6
	warp_event  5,  9, LAVENDER_TOWN, 6
	warp_event  4,  2, SOUL_HOUSE_B1F, 1

	db 0 ; coord events

	db 0 ; bg events

	db 5 ; object events
	object_event  9,  7, SPRITE_AGATHA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AgathaScript, -1
	object_event  5,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, MrFujiText, EVENT_SOUL_HOUSE_MR_FUJI
	object_event  7,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7ed4d, -1
	object_event  2,  7, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7edb1, -1
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7eddb, -1

	const_def 1 ; object constants
	const SOULHOUSE_AGATHA

AgathaScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_AGATHA
	iftrue AgathaAfterScript
	writetext AgathaSeenText
	waitbutton
	closetext
	winlosstext AgathaBeatenText, 0
	setlasttalked SOULHOUSE_AGATHA
	loadtrainer AGATHA, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_AGATHA
	opentext
	writetext AgathaRewardText
	buttonsound
	verbosegivetmhm TM_SHADOW_CLAW
	setevent EVENT_GOT_TM65_SHADOW_CLAW_FROM_AGATHA
AgathaAfterScript:
	jumpopenedtext AgathaAfterText

MrFujiText:
	text "Mr.Fuji: Welcome."

	para "Hmm… You appear to"
	line "be raising your"

	para "#mon in a kind"
	line "and loving manner."

	para "#mon lovers"
	line "come here to pay"

	para "their respects to"
	line "departed #mon."

	para "Please offer con-"
	line "dolences for the"

	para "souls of the de-"
	line "parted #mon."

	para "I'm sure that will"
	line "make them happy."
	done

UnknownText_0x7ed4d:
	text "There are other"
	line "graves of #mon"
	cont "here, I think."

	para "There are many"
	line "chambers that only"
	cont "Mr.Fuji may enter."
	done

UnknownText_0x7edb1:
	text "I came with my mom"
	line "to visit #mon"
	cont "graves…"
	done

UnknownText_0x7eddb:
	text "The #mon that"
	line "lived with me…"

	para "I loved them like"
	line "my grandchildren…"
	done

AgathaSeenText:
	text "Agatha: Hello,"
	line "child."

	para "My name is"
	line "Agatha."

	para "I fought for years"
	line "as a member of"
	cont "the Elite Four."

	para "…………"

	para "Have you come to"
	line "mourn a #mon?"

	para "It might not be"
	line "here any longer."

	para "Mr.Fuji kept many"
	line "of the graves"
	cont "elsewhere after"

	para "the radio company"
	line "took over."

	para "…………"

	para "He could have"
	line "fought to preserve"
	cont "the tower! But he"

	para "wouldn't get"
	line "involved. Too"

	para "scared of abusing"
	line "his influence."

	para "That old fool…"

	para "Power is meant to"
	line "be used!"

	para "You clearly"
	line "understand me."

	para "I'll show you"
	line "what a powerful"
	cont "trainer can do!"
	done

AgathaBeatenText
	text "Oh, my!"
	done

AgathaRewardText:
	text "You're quite"
	line "something, child."

	para "A strong trainer"
	line "with a deep"

	para "connection to"
	line "your #mon."

	para "Here, take this"
	line "TM!"
	done

AgathaAfterText:
	text "I expect great"
	line "things from you,"
	cont "if you will them."
	done
