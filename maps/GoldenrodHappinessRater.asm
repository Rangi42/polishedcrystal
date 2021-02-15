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
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterTeacherScript, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHappinessRaterPokefanMText, -1
	object_event  5,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHappinessRaterTwinText, -1

GoldenrodHappinessRaterTeacherScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext GoldenrodHappinessRaterTeacherText
	buttonsound
	ifgreater $f9, .LovesYouALot
	ifgreater $c7, .ReallyTrustsYou
	ifgreater $95, .SortOfHappy
	ifgreater $63, .QuiteCute
	ifgreater $31, .NotUsedToYou
	jumpthisopenedtext

	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
	done

.LovesYouALot:
	jumpthisopenedtext

	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
	done

.ReallyTrustsYou:
	jumpthisopenedtext

	text "I get the feeling"
	line "that it really"
	cont "trusts you."
	done

.SortOfHappy:
	jumpthisopenedtext

	text "It's friendly to-"
	line "ward you. It looks"
	cont "sort of happy."
	done

.QuiteCute:
	jumpthisopenedtext

	text "It's quite cute."
	done

.NotUsedToYou:
	jumpthisopenedtext

	text "You should treat"
	line "it better. It's"
	cont "not used to you."
	done

GoldenrodHappinessRaterTeacherText:
	text "If you treat your"
	line "#mon nicely,"

	para "they will love you"
	line "in return."

	para "Oh? Let me see"
	line "your "
	text_from_ram wStringBuffer3
	text "…"
	done

GoldenrodHappinessRaterPokefanMText:
	text "I keep losing in"
	line "battles, and my"

	para "#mon end up"
	line "fainting…"

	para "Maybe that's why"
	line "my #mon don't"
	cont "like me much…"
	done

GoldenrodHappinessRaterTwinText:
	text "When I use an item"
	line "on my #mon, it"
	cont "acts really glad!"
	done
