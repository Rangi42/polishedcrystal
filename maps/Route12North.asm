Route12North_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 10, 15, 1, ROUTE_12_GATE
	warp_event 11, 15, 2, ROUTE_12_GATE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 13, 13, SIGNPOST_JUMPTEXT, FishingSpotSignText

	db 1 ; object events
	object_event 6, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherKyle, -1

TrainerFisherKyle:
	trainer FISHER, KYLE, EVENT_BEAT_FISHER_KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, FisherKyleScript

FisherKyleScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a7238

	jumpopenedtext UnknownText_0x1a70d4

FisherKyleSeenText:
	text "Do you remember?"
	done

FisherKyleBeatenText:
	text "You do remember?"
	done

UnknownText_0x1a7238:
	text "The tug you feel"
	line "on the Rod when"

	para "you hook a #-"
	line "mon…"
	done

FishingSpotSignText:
	text "Fishing Spot"
	done
