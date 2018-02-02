IcePath1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 4 ; warp events
	warp_event  4, 19, ROUTE_44, 1
	warp_event 36, 27, BLACKTHORN_CITY, 7
	warp_event 37,  5, ICE_PATH_B1F, 1
	warp_event 37, 13, ICE_PATH_B1F, 7

	db 0 ; coord events

	db 0 ; bg events

	db 5 ; object events
	object_event 29, 10, SPRITE_SKIER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 3, TrainerSkierMaria, -1
	object_event 28,  3, SPRITE_BOARDER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBoarderStefan, -1
	tmhmball_event 31,  7, HM_WATERFALL, EVENT_GOT_HM06_WATERFALL
	itemball_event 32, 23, PP_UP, 1, EVENT_ICE_PATH_1F_PP_UP
	itemball_event 35,  9, PROTEIN, 1, EVENT_ICE_PATH_1F_PROTEIN

TrainerSkierMaria:
	trainer SKIER, MARIA, EVENT_BEAT_SKIER_MARIA, SkierMariaSeenText, SkierMariaBeatenText, 0, SkierMariaScript

SkierMariaScript:
	end_if_just_battled
	jumptextfaceplayer SkierMariaAfterText

TrainerBoarderStefan:
	trainer BOARDER, STEFAN, EVENT_BEAT_BOARDER_STEFAN, BoarderStefanSeenText, BoarderStefanBeatenText, 0, BoarderStefanScript

BoarderStefanScript:
	end_if_just_battled
	jumptextfaceplayer BoarderStefanAfterText

SkierMariaSeenText:
	text "Were you admiring"
	line "my ski technique?"
	done

SkierMariaBeatenText:
	text "Your battling"
	line "technique is"
	cont "admirable!"
	done

SkierMariaAfterText:
	text "It took me a while"
	line "to get comfortable"
	cont "on skis."
	done

BoarderStefanSeenText:
	text "Brrr… It's so"
	line "cold!"

	para "Let's warm up with"
	line "a #mon battle!"
	done

BoarderStefanBeatenText:
	text "This cold is the"
	line "shame of defeat…"
	done

BoarderStefanAfterText:
	text "I'll keep warm by"
	line "snowboarding!"
	done
