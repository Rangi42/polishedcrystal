GoldenrodHappinessRater_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 3
	warp_event  3,  7, GOLDENROD_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_JUMPSTD, radio2

	def_object_events
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeacherScript_0x54953, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x54b04, -1
	object_event  5,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x54b67, -1

TeacherScript_0x54953:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext UnknownText_0x549a3
	buttonsound
	ifgreater $f9, UnknownScript_0x54973
	ifgreater $c7, UnknownScript_0x54979
	ifgreater $95, UnknownScript_0x5497f
	ifgreater $63, UnknownScript_0x54985
	ifgreater $31, UnknownScript_0x5498b
	jumpthisopenedtext

	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
	done

UnknownScript_0x54973:
	jumpthisopenedtext

	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
	done

UnknownScript_0x54979:
	jumpthisopenedtext

	text "I get the feeling"
	line "that it really"
	cont "trusts you."
	done

UnknownScript_0x5497f:
	jumpthisopenedtext

	text "It's friendly to-"
	line "ward you. It looks"
	cont "sort of happy."
	done

UnknownScript_0x54985:
	jumpthisopenedtext

	text "It's quite cute."
	done

UnknownScript_0x5498b:
	jumpthisopenedtext

	text "You should treat"
	line "it better. It's"
	cont "not used to you."
	done

UnknownText_0x549a3:
	text "If you treat your"
	line "#mon nicely,"

	para "they will love you"
	line "in return."

	para "Oh? Let me see"
	line "your "
	text_from_ram wStringBuffer3
	text "…"
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
