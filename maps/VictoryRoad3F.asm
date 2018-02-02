VictoryRoad3F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event 2, 5, VICTORY_ROAD_2F, 3
	warp_event 15, 11, VICTORY_ROAD_2F, 4
	warp_event 19, 13, VICTORY_ROAD_2F, 5

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 11, 8, SPRITE_VETERAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerVeteranmRemy, -1
	itemball_event 16, 13, RAZOR_FANG, 1, EVENT_VICTORY_ROAD_3F_RAZOR_FANG

TrainerVeteranmRemy:
	trainer VETERANM, REMY, EVENT_BEAT_VETERANM_REMY, VeteranmRemySeenText, VeteranmRemyBeatenText, 0, VeteranmRemyScript

VeteranmRemyScript:
	end_if_just_battled
	jumptextfaceplayer VeteranmRemyAfterText

VeteranmRemySeenText:
	text "If you can get"
	line "through here, you"

	para "can challenge the"
	line "Elite Four!"
	done

VeteranmRemyBeatenText:
	text "No!"
	line "Inconceivable!"
	done

VeteranmRemyAfterText:
	text "I can beat you"
	line "when it comes to"

	para "knowledge about"
	line "#mon!"
	done
