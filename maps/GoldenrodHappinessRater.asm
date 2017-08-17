GoldenrodHappinessRater_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

GoldenrodHappinessRater_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 3, GOLDENROD_CITY
	warp_def 7, 3, 3, GOLDENROD_CITY

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 7, SIGNPOST_JUMPSTD, radio2

.PersonEvents: db 3
	person_event SPRITE_TEACHER, 4, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeacherScript_0x54953, -1
	person_event SPRITE_POKEFAN_M, 3, 5, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x54b04, -1
	person_event SPRITE_TWIN, 6, 5, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x54b67, -1

TeacherScript_0x54953:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext UnknownText_0x549a3
	buttonsound
	if_greater_than $f9, UnknownScript_0x54973
	if_greater_than $c7, UnknownScript_0x54979
	if_greater_than $95, UnknownScript_0x5497f
	if_greater_than $63, UnknownScript_0x54985
	if_greater_than $31, UnknownScript_0x5498b
	jump UnknownScript_0x54991

UnknownScript_0x54973:
	jumpopenedtext UnknownText_0x549fc

UnknownScript_0x54979:
	jumpopenedtext UnknownText_0x54a2c

UnknownScript_0x5497f:
	jumpopenedtext UnknownText_0x54a5a

UnknownScript_0x54985:
	jumpopenedtext UnknownText_0x54a8e

UnknownScript_0x5498b:
	jumpopenedtext UnknownText_0x54a9f

UnknownScript_0x54991:
	jumpopenedtext UnknownText_0x54ad1

UnknownText_0x549a3:
	text "If you treat your"
	line "#mon nicely,"

	para "they will love you"
	line "in return."

	para "Oh? Let me see"
	line "your @"
	text_from_ram StringBuffer3
	text "…"
	done

UnknownText_0x549fc:
	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
	done

UnknownText_0x54a2c:
	text "I get the feeling"
	line "that it really"
	cont "trusts you."
	done

UnknownText_0x54a5a:
	text "It's friendly to-"
	line "ward you. It looks"
	cont "sort of happy."
	done

UnknownText_0x54a8e:
	text "It's quite cute."
	done

UnknownText_0x54a9f:
	text "You should treat"
	line "it better. It's"
	cont "not used to you."
	done

UnknownText_0x54ad1:
	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
	done

UnknownText_0x54b04:
	text "I keep losing in"
	line "battles, and my"

	para "#mon end up"
	line "fainting…"

	para "Maybe that's why"
	line "my #mon don't"
	cont "like me much…"
	done

UnknownText_0x54b67:
	text "When I use an item"
	line "on my #mon, it"
	cont "acts really glad!"
	done
