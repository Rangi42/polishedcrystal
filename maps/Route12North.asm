Route12North_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route12North_MapEventHeader:

.Warps: db 2
	warp_def 15, 10, 1, ROUTE_12_GATE
	warp_def 15, 11, 2, ROUTE_12_GATE

.XYTriggers: db 0

.Signposts: db 1
	signpost 13, 13, SIGNPOST_JUMPTEXT, FishingSpotSignText

.PersonEvents: db 1
	person_event SPRITE_FISHER, 11, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_TRAINER, 3, TrainerFisherKyle, -1

TrainerFisherKyle:
	trainer EVENT_BEAT_FISHER_KYLE, FISHER, KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, FisherKyleScript

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
