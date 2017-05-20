const_value set 2
	const VICTORYROAD1F_VETERAN_M
	const VICTORYROAD1F_POKE_BALL1
	const VICTORYROAD1F_POKE_BALL2

VictoryRoad1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

TrainerVeteranmMatt:
	trainer EVENT_BEAT_VETERANM_MATT, VETERANM, MATT, VeteranmMattSeenText, VeteranmMattBeatenText, 0, VeteranmMattScript

VeteranmMattScript:
	end_if_just_battled
	opentext
	writetext VeteranmMattAfterText
	waitbutton
	closetext
	end

VictoryRoad1FMaxRevive:
	itemball MAX_REVIVE

VictoryRoad1FFullHeal:
	itemball FULL_HEAL

VictoryRoad1FHiddenFullHeal:
	dwb EVENT_VICTORY_ROAD_1F_HIDDEN_FULL_HEAL, FULL_HEAL

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

VictoryRoad1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $15, $b, 3, ROUTE_23
	warp_def $3, $3, 2, VICTORY_ROAD_2F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 19, 5, SIGNPOST_ITEM, VictoryRoad1FHiddenFullHeal

.PersonEvents:
	db 3
	person_event SPRITE_VETERAN_M, 6, 12, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 3, TrainerVeteranmMatt, -1
	person_event SPRITE_BALL_CUT_FRUIT, 2, 14, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, VictoryRoad1FMaxRevive, EVENT_VICTORY_ROAD_1F_MAX_REVIVE
	person_event SPRITE_BALL_CUT_FRUIT, 2, 17, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_ITEMBALL, 0, VictoryRoad1FFullHeal, EVENT_VICTORY_ROAD_1F_FULL_HEAL
