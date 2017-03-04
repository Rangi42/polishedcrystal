const_value set 2
	const SOULHOUSE_MRFUJI
	const SOULHOUSE_TEACHER
	const SOULHOUSE_LASS
	const SOULHOUSE_GRANNY
	const SOULHOUSE_AGATHA

SoulHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

MrFuji:
	jumptextfaceplayer MrFujiText

TeacherScript_0x7ec4a:
	jumptextfaceplayer UnknownText_0x7ed4d

LassScript_0x7ec4d:
	jumptextfaceplayer UnknownText_0x7edb1

GrannyScript_0x7ec50:
	jumptextfaceplayer UnknownText_0x7eddb

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
	writetext AgathaAfterText
	waitbutton
	closetext
	end

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

SoulHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $9, $4, 6, LAVENDER_TOWN
	warp_def $9, $5, 6, LAVENDER_TOWN

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 5
	person_event SPRITE_GRAMPS, 2, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, MrFuji, -1
	person_event SPRITE_TEACHER, 3, 7, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x7ec4a, -1
	person_event SPRITE_LASS, 7, 2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, LassScript_0x7ec4d, -1
	person_event SPRITE_GRANNY, 5, 1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, GrannyScript_0x7ec50, -1
	person_event SPRITE_AGATHA, 7, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, AgathaScript, -1
