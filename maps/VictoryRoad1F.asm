VictoryRoad1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 11, 21, ROUTE_23, 3
	warp_event  3,  3, VICTORY_ROAD_2F, 2

	db 0 ; coord events

	db 1 ; bg events
	bg_event  5, 19, SIGNPOST_ITEM + FULL_HEAL, EVENT_VICTORY_ROAD_1F_HIDDEN_FULL_HEAL

	db 3 ; object events
	object_event 12,  6, SPRITE_VETERAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerVeteranmMatt, -1
	itemball_event 14,  2, MAX_REVIVE, 1, EVENT_VICTORY_ROAD_1F_MAX_REVIVE
	itemball_event 17,  2, FULL_HEAL, 1, EVENT_VICTORY_ROAD_1F_FULL_HEAL

TrainerVeteranmMatt:
	trainer VETERANM, MATT, EVENT_BEAT_VETERANM_MATT, VeteranmMattSeenText, VeteranmMattBeatenText, 0, VeteranmMattScript

VeteranmMattScript:
	end_if_just_battled
	jumptextfaceplayer VeteranmMattAfterText

VeteranmMattSeenText:
	text "I can see you're"
	line "good! Let me see"
	cont "exactly how good!"
	done

VeteranmMattBeatenText:
	text "I had a chance…"
	done

VeteranmMattAfterText:
	text "I concede, you're"
	line "better than me!"
	done
