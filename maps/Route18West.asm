Route18West_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route18WestAlwaysOnBike

	db 2 ; warp events
	warp_event 19,  6, ROUTE_18_GATE, 1
	warp_event 19,  7, ROUTE_18_GATE, 2

	db 1 ; coord events
	coord_event 12,  0, 0, Route18WestBikeCheckScript

	db 0 ; bg events

	db 1 ; object events
	object_event  6,  2, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_GENERICTRAINER, 4, GenericTrainerBikerCharles, -1

Route18WestAlwaysOnBike:
	setflag ENGINE_ALWAYS_ON_BIKE
	return

Route18WestBikeCheckScript:
	callasm .CheckPlayerState
	if_equal PLAYER_BIKE, .done
	showtext Route18WestBikeWarningText
	applyonemovement PLAYER, step_down
.done
	end

.CheckPlayerState:
	ld a, [PlayerState]
	ld [ScriptVar], a
	ret

GenericTrainerBikerCharles:
	generictrainer BIKER, CHARLES, EVENT_BEAT_BIKER_CHARLES, BikerCharlesSeenText, BikerCharlesBeatenText

	text "Reckless driving"
	line "causes accidents!"
	cont "Take it easy!"
	done

BikerCharlesSeenText:
	text "We're fearless"
	line "highway stars!"
	done

BikerCharlesBeatenText:
	text "Arrrgh! Crash and"
	line "burn!"
	done

Route18WestBikeWarningText:
	text "You have to be on"
	line "a Bicycle to go"
	cont "on Cycling Road!"
	done
