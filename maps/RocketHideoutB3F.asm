RocketHideoutB3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17,  2, ROCKET_HIDEOUT_B2F, 2
	warp_event 11, 14, ROCKET_HIDEOUT_B4F, 1

	def_coord_events

	def_bg_events
	bg_event 19, 13, BGEVENT_ITEM + FULL_HEAL, EVENT_ROCKET_HIDEOUT_B3F_HIDDEN_FULL_HEAL

	def_object_events
	object_event 18,  8, SPRITE_COSPLAYER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB3FCosplayerInstinctGrunt2, -1
	object_event  2, 18, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB3FCoolDudeMysticGrunt1, -1
	itemball_event 12, 10, CARBOS, 1, EVENT_PICKED_UP_CARBOS_FROM_ROCKET_HIDEOUT_B3F
	itemball_event 18, 13, ELIXIR, 1, EVENT_PICKED_UP_ELIXIR_FROM_ROCKET_HIDEOUT_B3F

RocketHideoutB3FCosplayerInstinctGrunt2:
	generictrainer COSPLAYER, INSTINCT_GRUNT_2, EVENT_BEAT_COSPLAYER_INSTINCT_GRUNT_2, .SeenText, .BeatenText

	text "Leader Spark's"
	line "energy is high!"

	para "Hope you're ready"
	line "for a jolt!"
	done

.SeenText:
	text "Instinct doesn't"
	line "need calculations."

	para "We just strike"
	line "fast and hard."
	done

.BeatenText:
	text "Can't keep up!"
	done

RocketHideoutB3FCoolDudeMysticGrunt1:
	generictrainer COOLTRAINERM, MYSTIC_GRUNT_1, EVENT_BEAT_COOL_DUDE_MYSTIC_GRUNT_1, .SeenText, .BeatenText

	text "Leader Blanche ex-"
	line "pects no less than"
	cont "maximum effort!"
	done

.SeenText:
	text "Emotion clouds"
	line "judgement."

	para "Let's see if your"
	cont "focus is good."
	
	done

.BeatenText:
	text "My judgement was"
	line "flawed…"
	done
