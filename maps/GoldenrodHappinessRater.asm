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
	object_event  2,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodHappinessRaterTeacherScript, -1
	object_event  5,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHappinessRaterPokefanMText, -1
	object_event  5,  6, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, GoldenrodHappinessRaterTwinText, -1

GoldenrodHappinessRaterTeacherScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	writetext GoldenrodHappinessRaterTeacherText
	promptbutton
	ifequalfwd 255, .AdoresYou                            ; 255
	ifgreater AFFECTION_THRESHOLD_2 - 1, .LovesYouALot    ; 220-254
	ifgreater AFFECTION_THRESHOLD_1 - 1, .Affectionate    ; 180-219
	ifgreater HAPPINESS_THRESHOLD_2 - 1, .ReallyTrustsYou ; 160-179
		assert HAPPINESS_TO_EVOLVE == HAPPINESS_THRESHOLD_2
		assert MAX_RETURN_HAPPINESS == HAPPINESS_THRESHOLD_2
	ifgreater HAPPINESS_THRESHOLD_1 - 1, .SortOfHappy     ; 100-159
		assert FRIEND_BALL_HAPPINESS >= HAPPINESS_THRESHOLD_1 && FRIEND_BALL_HAPPINESS < HAPPINESS_THRESHOLD_2
		assert HATCHED_HAPPINESS >= HAPPINESS_THRESHOLD_1 && HATCHED_HAPPINESS < HAPPINESS_THRESHOLD_2
	ifgreater 50 - 1, .QuiteCute                          ; 50-99
		assert 50 < BASE_HAPPINESS
	ifgreater 0, .NotUsedToYou                            ; 1-49
	jumpthisopenedtext                                    ; 0

	text "It doesn't seem to"
	line "like you at all."
	cont "It looks mean."
	done

.AdoresYou:
	jumpthisopenedtext

	text "It adores you!"
	line "It can't possibly"
	cont "love you any more."

	para "I even feel happy"
	line "seeing it! ♥"
	done

.LovesYouALot:
	jumpthisopenedtext

	text "It looks really"
	line "happy! It must"
	cont "love you a lot."
	done

.Affectionate:
	jumpthisopenedtext

	text "It's quite affect-"
	line "ionate with you!"

	para "It seems to want"
	line "to be babied a"
	cont "little."
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

	text "It's warming up"
	line "to you."
	cont "It's quite cute."
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
	text_ram wStringBuffer3
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
