VictoryRoad3F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

VictoryRoad3F_MapEventHeader:
	db 3 ; warps
	warp_def 5, 2, 3, VICTORY_ROAD_2F
	warp_def 11, 15, 4, VICTORY_ROAD_2F
	warp_def 13, 19, 5, VICTORY_ROAD_2F

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_VETERAN_M, 8, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerVeteranmRemy, -1
	itemball_event 13, 16, RAZOR_FANG, 1, EVENT_VICTORY_ROAD_3F_RAZOR_FANG

TrainerVeteranmRemy:
	trainer EVENT_BEAT_VETERANM_REMY, VETERANM, REMY, VeteranmRemySeenText, VeteranmRemyBeatenText, 0, VeteranmRemyScript

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
