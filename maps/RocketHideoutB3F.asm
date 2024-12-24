RocketHideoutB3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17,  2, ROCKET_HIDEOUT_B2F, 2
	warp_event 11, 14, ROCKET_HIDEOUT_B4F, 1

	def_coord_events

	def_bg_events
	bg_event 19, 13, BGEVENT_ITEM + RARE_CANDY, EVENT_ROCKET_HIDEOUT_B3F_HIDDEN_RARE_CANDY ; TODO: pick a better item

	def_object_events
	object_event 18,  8, SPRITE_COSPLAYER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB3FCosplayerAaron, -1
	object_event  2, 18, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, RocketHideoutB3FCoolDudeGideon, -1
	itemball_event 12, 10, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_1_FROM_ROCKET_HIDEOUT_B3F ; TODO: pick a better item
	itemball_event 18, 13, RARE_CANDY, 1, EVENT_PICKED_UP_RARE_CANDY_2_FROM_ROCKET_HIDEOUT_B3F ; TODO: pick a better item

RocketHideoutB3FCosplayerAaron:
	generictrainer COSPLAYER, AARON2, EVENT_BEAT_COSPLAYER_AARON, .SeenText, .BeatenText

	text "Spark's energy"
	line "is on point!"

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
	text "Fast moves, sharp"
	line "instincts. You've"
	cont "got it all!"
	done

RocketHideoutB3FCoolDudeGideon:
	generictrainer COOLTRAINERM, GIDEON2, EVENT_BEAT_COOL_DUDE_GIDEON, .SeenText, .BeatenText

	text "Blanche expects"
	line "the best from"
	cont "trainers."

	para "Stay sharp if you"
	line "plan to face them."
	done

.SeenText:
	text "Mystic thrives on"
	line "data and logic."

	para "Emotions cloud"
	line "judgement. Let's"
	cont "see your focus."
	done

.BeatenText:
	text "You've shown you"
	line "can think clearly."

	para "Keep using that"
	line "sharp mind."
	done