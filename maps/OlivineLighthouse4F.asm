OlivineLighthouse4F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse4F_MapEventHeader:

.Warps: db 10
	warp_def 3, 13, 1, OLIVINE_LIGHTHOUSE_3F
	warp_def 5, 3, 2, OLIVINE_LIGHTHOUSE_5F
	warp_def 7, 9, 3, OLIVINE_LIGHTHOUSE_5F
	warp_def 5, 9, 3, OLIVINE_LIGHTHOUSE_3F
	warp_def 9, 16, 6, OLIVINE_LIGHTHOUSE_3F
	warp_def 9, 17, 7, OLIVINE_LIGHTHOUSE_3F
	warp_def 3, 8, 8, OLIVINE_LIGHTHOUSE_3F
	warp_def 3, 9, 9, OLIVINE_LIGHTHOUSE_3F
	warp_def 7, 16, 4, OLIVINE_LIGHTHOUSE_5F
	warp_def 7, 17, 5, OLIVINE_LIGHTHOUSE_5F

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_SAILOR, 14, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerSailorKent, -1
	person_event SPRITE_LASS, 2, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerLassConnie, EVENT_OLIVINE_LIGHTHOUSE_JASMINE

TrainerLassConnie:
	trainer EVENT_BEAT_LASS_CONNIE, LASS, CONNIE, LassConnieSeenText, LassConnieBeatenText, 0, LassConnieScript

LassConnieScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x5b63c

TrainerSailorKent:
	trainer EVENT_BEAT_SAILOR_KENT, SAILOR, KENT, SailorKentSeenText, SailorKentBeatenText, 0, SailorKentScript

SailorKentScript:
	end_if_just_battled
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer SailorKentFinalText
	jumptextfaceplayer UnknownText_0x5b584

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

UnknownText_0x5b584:
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

UnknownText_0x5b63c:
	text "Right. Anybody"
	line "would be worried"

	para "if their own #-"
	line "mon were hurt."

	para "I'll pray for the"
	line "#mon here, so"

	para "Jasmine can come"
	line "back to the Gym."
	done
