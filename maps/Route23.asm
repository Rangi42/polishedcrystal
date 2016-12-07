Route23_MapScriptHeader:
.MapTriggers:
	db 6

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1
	maptrigger .Trigger2
	maptrigger .Trigger3
	maptrigger .Trigger4
	maptrigger .Trigger5

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	end

.Trigger2:
	end

.Trigger3:
	end

.Trigger4:
	end

.Trigger5:
	end

Route23ZephyrBadgeTriggerScript:
	stringtotext .ZephyrBadgeText, 0
	opentext
	writetext Route23GuardNeedBadgeText
	waitbutton
	checkflag ENGINE_ZEPHYRBADGE
	iffalse Route23GuardNoBadgeScript
	writetext Route23GuardHaveBadgeText
	waitbutton
	writetext Route23GuardGoAheadText
	waitbutton
	closetext
	dotrigger $1
	end

.ZephyrBadgeText:
	db "Zephyr Badge@"

Route23HiveBadgeTriggerScript:
	stringtotext .HiveBadgeText, 0
	opentext
	writetext Route23GuardNeedBadgeText
	waitbutton
	checkflag ENGINE_HIVEBADGE
	iffalse Route23GuardNoBadgeScript
	writetext Route23GuardHaveBadgeText
	waitbutton
	writetext Route23GuardGoAheadText
	waitbutton
	closetext
	dotrigger $2
	end

.HiveBadgeText:
	db "Hive Badge@"

Route23PlainBadgeTriggerScript:
	stringtotext .PlainBadgeText, 0
	opentext
	writetext Route23GuardNeedBadgeText
	waitbutton
	checkflag ENGINE_PLAINBADGE
	iffalse Route23GuardNoBadgeScript
	writetext Route23GuardHaveBadgeText
	waitbutton
	writetext Route23GuardGoAheadText
	waitbutton
	closetext
	dotrigger $3
	end

.PlainBadgeText:
	db "Plain Badge@"

Route23FogBadgeTriggerScript:
	stringtotext .FogBadgeText, 0
	opentext
	writetext Route23GuardNeedBadgeText
	waitbutton
	checkflag ENGINE_FOGBADGE
	iffalse Route23GuardNoBadgeScript
	writetext Route23GuardHaveBadgeText
	waitbutton
	writetext Route23GuardGoAheadText
	waitbutton
	closetext
	dotrigger $4
	end

.FogBadgeText:
	db "Fog Badge@"

Route23StormBadgeTriggerScript:
	stringtotext .StormBadgeText, 0
	opentext
	writetext Route23GuardNeedBadgeText
	waitbutton
	checkflag ENGINE_STORMBADGE
	iffalse Route23GuardNoBadgeScript
	writetext Route23GuardHaveBadgeText
	waitbutton
	writetext Route23GuardGoAheadText
	waitbutton
	closetext
	dotrigger $4
	end

.StormBadgeText:
	db "Storm Badge@"

Route23GuardNoBadgeScript:
	writetext Route23GuardNoBadgeText
	waitbutton
	closetext
	end

VictoryRoadSign:
	jumptext VictoryRoadSignText

Route23GuardNeedBadgeText:
	text "You can pass here"
	line "only if you have"
	cont "the @"
	text_from_ram StringBuffer3
	text "."
	done

Route23GuardNoBadgeText:
	text "You don't have the"
	line "@"
	text_from_ram StringBuffer3
	text " yet!"

	para "You have to have"
	line "it to get to the"
	cont "#mon League!@"
	done

Route23GuardHaveBadgeText:
	text "Oh! That is the"
	line "@"
	text_from_ram StringBuffer3
	text "!@"
	sound_dex_fanfare_50_79
	db "@@"

Route23GuardGoAheadText:
	text "OK then! Please,"
	line "go right ahead!"
	done

VictoryRoadSignText:
	text "Victory Road"
	done

Route23_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $87, $7, 5, VICTORY_ROAD_GATE
	warp_def $87, $8, 6, VICTORY_ROAD_GATE
	warp_def $1f, $4, 1, VICTORY_ROAD
	warp_def $1f, $e, 10, VICTORY_ROAD

.XYTriggers:
	db 15
	xy_trigger 0, $83, $e, $0, Route23ZephyrBadgeTriggerScript, $0, $0
	xy_trigger 1, $7b, $9, $0, Route23HiveBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $b, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $c, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $d, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $e, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $f, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $8, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $9, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $a, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $c, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $d, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $4, $0, Route23StormBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $6, $0, Route23StormBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $7, $0, Route23StormBadgeTriggerScript, $0, $0

.Signposts:
	db 1
	signpost 32, 3, SIGNPOST_READ, VictoryRoadSign

.PersonEvents:
	db 0
