OlivineLighthouse4F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 13,  3, OLIVINE_LIGHTHOUSE_3F, 1
	warp_event  3,  5, OLIVINE_LIGHTHOUSE_5F, 2
	warp_event  9,  7, OLIVINE_LIGHTHOUSE_5F, 3
	warp_event  9,  5, OLIVINE_LIGHTHOUSE_3F, 3
	warp_event 16,  9, OLIVINE_LIGHTHOUSE_3F, 6
	warp_event 17,  9, OLIVINE_LIGHTHOUSE_3F, 7
	warp_event  8,  3, OLIVINE_LIGHTHOUSE_3F, 8
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_3F, 9
	warp_event 16,  7, OLIVINE_LIGHTHOUSE_5F, 4
	warp_event 17,  7, OLIVINE_LIGHTHOUSE_5F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7, 14, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerSailorKent, -1
	object_event 11,  2, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerLassConnie, EVENT_OLIVINE_LIGHTHOUSE_JASMINE

GenericTrainerLassConnie:
	generictrainer LASS, CONNIE, EVENT_BEAT_LASS_CONNIE, LassConnieSeenText, LassConnieBeatenText

	text "Right. Anybody"
	line "would be worried"

	para "if their own #-"
	line "mon were hurt."

	para "I'll pray for the"
	line "#mon here, so"

	para "Jasmine can come"
	line "back to the Gym."
	done

TrainerSailorKent:
	trainer SAILOR, KENT, EVENT_BEAT_SAILOR_KENT, SailorKentSeenText, SailorKentBeatenText, 0, SailorKentScript

SailorKentScript:
	endifjustbattled
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer SailorKentFinalText
	jumptextfaceplayer SailorKentAfterBattleText

SailorKentSeenText:
	text "Jasmine must be"
	line "worried sick about"
	cont "the #mon here."

	para "She won't even"
	line "smile these days."
	done

SailorKentBeatenText:
	text "I can't manage a"
	line "smile either…"
	done

SailorKentAfterBattleText:
	text "Speaking of sick,"
	line "I've heard there's"

	para "a good Pharmacy in"
	line "Cianwood."
	done

SailorKentFinalText:
	text "The #mon here"
	line "is well again."

	para "Cianwood Pharmacy"
	line "lived up to its"
	cont "reputation!"
	done

LassConnieSeenText:
	text "Jasmine is this"
	line "city's Gym Leader."

	para "I mean to bring"
	line "her back with me."

	para "Nobody had better"
	line "get in my way!"
	done

LassConnieBeatenText:
	text "Aaack! My #mon!"
	done

