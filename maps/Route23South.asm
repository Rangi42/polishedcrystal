Route23South_MapScriptHeader:
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

Route23SouthZephyrBadgeTriggerScript:
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

Route23SouthHiveBadgeTriggerScript:
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

Route23SouthPlainBadgeTriggerScript:
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

Route23SouthFogBadgeTriggerScript:
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

Route23SouthStormBadgeTriggerScript:
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

Route23South_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $3f, $7, 5, VICTORY_ROAD_GATE
	warp_def $3f, $8, 6, VICTORY_ROAD_GATE

.XYTriggers:
	db 15
	xy_trigger 0, $3b, $e, $0, Route23SouthZephyrBadgeTriggerScript, $0, $0
	xy_trigger 1, $33, $9, $0, Route23SouthHiveBadgeTriggerScript, $0, $0
	xy_trigger 2, $23, $b, $0, Route23SouthPlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $23, $c, $0, Route23SouthPlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $23, $d, $0, Route23SouthPlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $23, $e, $0, Route23SouthPlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $23, $f, $0, Route23SouthPlainBadgeTriggerScript, $0, $0
	xy_trigger 3, $1a, $8, $0, Route23SouthFogBadgeTriggerScript, $0, $0
	xy_trigger 3, $1a, $9, $0, Route23SouthFogBadgeTriggerScript, $0, $0
	xy_trigger 3, $1a, $a, $0, Route23SouthFogBadgeTriggerScript, $0, $0
	xy_trigger 3, $1a, $c, $0, Route23SouthFogBadgeTriggerScript, $0, $0
	xy_trigger 3, $1a, $d, $0, Route23SouthFogBadgeTriggerScript, $0, $0
	xy_trigger 4, $b, $4, $0, Route23SouthStormBadgeTriggerScript, $0, $0
	xy_trigger 4, $b, $6, $0, Route23SouthStormBadgeTriggerScript, $0, $0
	xy_trigger 4, $b, $7, $0, Route23SouthStormBadgeTriggerScript, $0, $0

.Signposts:
	db 0

.PersonEvents:
	db 0
