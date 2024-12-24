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
	bg_event 13, 15, BGEVENT_ITEM + RARE_CANDY, EVENT_ROCKET_HIDEOUT_B1F_HIDDEN_RARE_CANDY ; TODO: pick a better item

	def_object_events
	object_event 20, 18, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, RocketHideoutB1FBlackBeltKai, -1
	object_event  4,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, RocketHideoutB1FScientistLysander, -1
	object_event 18,  8, SPRITE_PICNICKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, RocketHideoutB1FPicnickerZane, -1
	object_event 10, 17, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, RocketHideoutB1FBattleGirlSasha, -1
	object_event  7, 23, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB1FLassPiper, -1
	itemball_event  1, 17, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_1_FROM_ROCKET_HIDEOUT_B1F ; TODO: pick a better item
	itemball_event  3, 14, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_2_FROM_ROCKET_HIDEOUT_B1F ; TODO: pick a better item

RocketHideoutB1FDoorScript:
	checkevent EVENT_BEAT_BLACK_BELT_KAI
	iftruefwd .DoorOpen
	changeblock 16, 16, $13
.DoorOpen
	endcallback

RocketHideoutB1FBlackBeltKai:
	trainer BLACKBELT_T, KAI2, EVENT_BEAT_BLACK_BELT_KAI, .SeenText, .AfterText, 0, .Script

.Script:
	checkevent EVENT_BEAT_BLACK_BELT_KAI
	iftruefwd .AfterScript
	jumpthistextfaceplayer

.SeenText:
	text "Strength in all"
	line "that matters."

	para "In Valor, we push"
	line "limits."

	para "No holding back-"
	line "show me your fire!"
	done

.AfterScript
	changeblock 16, 16, $0d
	endifjustbattled
	jumptextfaceplayer .AfterText
	end

.AfterText:
	text "You've got guts-I"
	line "can respect that."

	para "Maybe you belong"
	line "in Valor after all."
	done

RocketHideoutB1FScientistLysander:
	generictrainer SCIENTIST, LYSANDER, EVENT_BEAT_SCIENTIST_LYSANDER, .SeenText, .BeatenText

	text "Candela found"
	line "some old files"
	cont "on this place."

	para "She thinks if we"
	line "we stand in these"

	para "exact spots, we"
	line "are optimally"
	cont "defensible."

	para "Blanche has calc-"
	line "ulated otherwise."
	done

.SeenText:
	text "Mystic believes in"
	line "strategy."

	para "Only a calculated"
	line "mind can win here."
	done

.BeatenText:
	text "Your tactics were"
	line "flawless. Mystic"
	cont "would approve."

	para "Don't squander it."
	done

RocketHideoutB1FPicnickerZane:
	generictrainer PICNICKER, ZANE, EVENT_BEAT_PICNICKER_ZANE, .SeenText, .BeatenText

	text "Spark would say"
	line "you've got good"
	cont "instincts."

	para "Let's see if you"
	line "can keep it up!"
	done

.SeenText:
	text "Instinct teaches"
	line "us to trust out"
	cont "gut."

	para "No time for plan-"
	line "ning, just act!"
	done

.BeatenText:
	text "You've got"
	line "instincts, i'll"
	cont "give you that."

	para "Keep that spark"
	line "alive!"
	done

RocketHideoutB1FBattleGirlSasha:
	generictrainer BATTLE_GIRL, SASHA, EVENT_BEAT_BATTLE_GIRL_SASHA, .SeenText, .BeatenText

	text "You've got the"
	line "fire of Valor."

	para "But can you keep"
	line "it burning?"

	para "Candela's training"
	line "is even tougher."
	done

.SeenText:
	text "Valor is about"
	line "heat, passion, and"
	cont "taking risks."

	para "We do this to"
	line "grow."

	para "Think you can"
	line "match my"
	cont "intensity?"
	done

.BeatenText:
	text "Alright, I'll"
	line "admit your fire"
	cont "burns bright."

	para "Don't let it"
	line "go to your head."
	done

RocketHideoutB1FLassPiper:
	generictrainer LASS, PIPER2, EVENT_BEAT_LASS_PIPER, .SeenText, .BeatenText

	text "Spark's battles"
	line "are unpredictable."

	para "Thats why I mix"
	line "things up!"
	done

.SeenText:
	text "Instinct is about"
	line "following the"
	cont "flow."

	para "No overthinking-"
	line "react and win!"
	done

.BeatenText:
	text "Guess your"
	line "instincts were"
	cont "better than mine."
	done