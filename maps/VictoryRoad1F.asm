VictoryRoad1F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 21, 11, 3, ROUTE_23
	warp_def 3, 3, 2, VICTORY_ROAD_2F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 19, 5, SIGNPOST_ITEM + FULL_HEAL, EVENT_VICTORY_ROAD_1F_HIDDEN_FULL_HEAL

	db 3 ; person events
	person_event SPRITE_VETERAN_M, 6, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerVeteranmMatt, -1
	itemball_event 2, 14, MAX_REVIVE, 1, EVENT_VICTORY_ROAD_1F_MAX_REVIVE
	itemball_event 2, 17, FULL_HEAL, 1, EVENT_VICTORY_ROAD_1F_FULL_HEAL

TrainerVeteranmMatt:
	trainer EVENT_BEAT_VETERANM_MATT, VETERANM, MATT, VeteranmMattSeenText, VeteranmMattBeatenText, 0, VeteranmMattScript

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
