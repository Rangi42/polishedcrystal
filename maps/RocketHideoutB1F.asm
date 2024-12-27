RocketHideoutB1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RocketHideoutB1FDoorScript

	def_warp_events
	warp_event 15,  2, ROCKET_HIDEOUT_B2F, 1
	warp_event 13,  2, CELADON_GAME_CORNER, 3
	warp_event 16, 19, ROCKET_HIDEOUT_ELEVATOR, 1
	warp_event 13, 24, ROCKET_HIDEOUT_B2F, 4
	warp_event 17, 19, ROCKET_HIDEOUT_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 13, 15, BGEVENT_ITEM + MAX_REVIVE, EVENT_ROCKET_HIDEOUT_B1F_HIDDEN_MAX_REVIVE

	def_object_events
	object_event 20, 18, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, RocketHideoutB1FBlackBeltKai, -1
	object_event  4,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, RocketHideoutB1FScientistLysander, -1
	object_event 18,  8, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, RocketHideoutB1FPicnickerZane, -1
	object_event 10, 17, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, RocketHideoutB1FBattleGirlSasha, -1
	object_event  7, 23, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB1FLassPiper, -1
	itemball_event  1, 17, MOON_STONE, 1, EVENT_PICKED_UP_MOON_STONE_FROM_ROCKET_HIDEOUT_B1F
	itemball_event  3, 14, ZINC, 1, EVENT_PICKED_UP_ZINC_FROM_ROCKET_HIDEOUT_B1F

RocketHideoutB1FDoorScript:
	checkevent EVENT_BEAT_BLACK_BELT_KAI
	iftruefwd .DoorOpen
	changeblock 16, 16, $13
.DoorOpen
	endcallback

RocketHideoutB1FBlackBeltKai:
	trainer BLACKBELT_T, KAI2, EVENT_BEAT_BLACK_BELT_KAI, .SeenText, .AfterText, 0, .BeatenText

.Script:
	checkevent EVENT_BEAT_BLACK_BELT_KAI
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.SeenText:
	text "In Valor, we push"
	line "limits."

	para "Strength in all"
	line "that matters!"
	done

.AfterScript
	changeblock 16, 16, $0d
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.AfterText:
	text "You've got guts…"

	para "Perhaps you should"
	line "join Team Valor."
	done

.BeatenText:
	text "You're strength is"
	line "superior…"
	done

RocketHideoutB1FScientistLysander:
	generictrainer SCIENTIST, LYSANDER, EVENT_BEAT_SCIENTIST_LYSANDER, .SeenText, .BeatenText

	text "Leader Blanche ex-"
	line "cels in strategy."

	para "He decides where"
	line "we are stationed."
	done

.SeenText:
	text "Mystic values"
	line "strategy."

	para "Only a strong mind"
	line "could win here."
	done

.BeatenText:
	text "You're tactics are"
	line "flawless!"
	done

RocketHideoutB1FPicnickerZane:
	generictrainer PICNICKER, ZANE, EVENT_BEAT_PICNICKER_ZANE, .SeenText, .BeatenText

	text "Spark would be"
	line "impressed."

	para "Let's see if you"
	line "can keep going!"
	done

.SeenText:
	text "Team Instinct is"
	line "all about trusting"
	cont "your gut."

	para "No time to think,"
	line "just act!"
	done

.BeatenText:
	text "You've got that"
	line "'spark', alright."

	para "Keep it alive!"
	done

RocketHideoutB1FBattleGirlSasha:
	generictrainer BATTLE_GIRL, SASHA, EVENT_BEAT_BATTLE_GIRL_SASHA, .SeenText, .BeatenText

	text "The flame of Valor"
	line "burns within you."

	para "Candela's trial"
	line "will test your"
	cont "limits."
	done

.SeenText:
	text "Team Valor's all"
	line "about passion and"
	cont "taking risks."

	para "Think you can"
	line "match my in-"
	cont "tensity?"
	done

.BeatenText:
	text "You're flame…"
	line "Too bright!"
	done

RocketHideoutB1FLassPiper:
	generictrainer LASS, PIPER2, EVENT_BEAT_LASS_PIPER, .SeenText, .BeatenText

	text "Spark's battles"
	line "are unpredictable."

	para "Thats why I mix"
	line "things up!"
	done

.SeenText:
	text "My strategy?"

	para "Pure instinct and"
	line "nothing more!"
	done

.BeatenText:
	text "I guess your in-"
	line "stinct is better"
	cont "than mine."
	done