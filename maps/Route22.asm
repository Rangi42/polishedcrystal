const_value set 2
	const ROUTE22_COOLTRAINER_M
	const ROUTE22_COOLTRAINER_F

Route22_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Route22CooltrainermScript:
	jumptextfaceplayer Route22CooltrainermText

Route22CooltrainerfScript:
	jumptextfaceplayer Route22CooltrainerfText

VictoryRoadEntranceSign:
	jumptext VictoryRoadEntranceSignText

Route22CooltrainermText:
	text "You think you're"
	line "ready for the"
	cont "#mon League?"

	para "Bah!"

	para "…What?! You al-"
	line "ready beat them?"

	para "Well then."
	done

Route22CooltrainerfText:
	text "The name “Kanto”"
	line "means “east of the"
	cont "barrier.”"

	para "I suppose the"
	line "barrier must be"
	cont "Mt.Silver."
	done

VictoryRoadEntranceSignText:
	text "Route 22"

	para "#mon League"
	line "Reception Gate"
	done

Route22_MapEventHeader:
.Warps:
	db 1
	warp_def $5, $3, 1, POKEMON_LEAGUE_GATE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 7, 5, SIGNPOST_READ, VictoryRoadEntranceSign

.PersonEvents:
	db 2
	person_event SPRITE_COOLTRAINER_M, 2, 20, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route22CooltrainermScript, -1
	person_event SPRITE_COOLTRAINER_F, 11, 14, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, Route22CooltrainerfScript, -1
