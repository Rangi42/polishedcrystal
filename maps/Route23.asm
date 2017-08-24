Route23_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

Route23_MapEventHeader:

.Warps: db 4
	warp_def 135, 7, 5, POKEMON_LEAGUE_GATE
	warp_def 135, 8, 6, POKEMON_LEAGUE_GATE
	warp_def 31, 4, 1, VICTORY_ROAD_1F
	warp_def 31, 14, 1, VICTORY_ROAD_2F

.XYTriggers: db 23
	xy_trigger 0, 131, 14, Route23ZephyrBadgeTriggerScript
	xy_trigger 1, 123, 9, Route23HiveBadgeTriggerScript
	xy_trigger 2, 107, 10, Route23PlainBadgeTriggerScript
	xy_trigger 2, 107, 12, Route23PlainBadgeTriggerScript
	xy_trigger 2, 107, 13, Route23PlainBadgeTriggerScript
	xy_trigger 2, 107, 14, Route23PlainBadgeTriggerScript
	xy_trigger 2, 107, 15, Route23PlainBadgeTriggerScript
	xy_trigger 3, 98, 8, Route23FogBadgeTriggerScript
	xy_trigger 3, 98, 9, Route23FogBadgeTriggerScript
	xy_trigger 3, 98, 11, Route23FogBadgeTriggerScript
	xy_trigger 3, 98, 12, Route23FogBadgeTriggerScript
	xy_trigger 3, 98, 13, Route23FogBadgeTriggerScript
	xy_trigger 4, 83, 4, Route23StormBadgeTriggerScript
	xy_trigger 4, 83, 6, Route23StormBadgeTriggerScript
	xy_trigger 4, 83, 7, Route23StormBadgeTriggerScript
	xy_trigger 5, 70, 8, Route23MineralBadgeTriggerScript
	xy_trigger 5, 70, 9, Route23MineralBadgeTriggerScript
	xy_trigger 5, 70, 10, Route23MineralBadgeTriggerScript
	xy_trigger 5, 70, 12, Route23MineralBadgeTriggerScript
	xy_trigger 5, 70, 13, Route23MineralBadgeTriggerScript
	xy_trigger 6, 55, 12, Route23GlacierBadgeTriggerScript
	xy_trigger 7, 47, 6, Route23RisingBadgeTriggerScript
	xy_trigger 7, 47, 7, Route23RisingBadgeTriggerScript

.Signposts: db 1
	signpost 32, 3, SIGNPOST_JUMPTEXT, VictoryRoadSignText

.PersonEvents: db 8
	person_event SPRITE_OFFICER, 131, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23ZephyrBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 123, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23HiveBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 107, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23PlainBadgeOfficerScript, -1
	person_event SPRITE_SWIMMING_OFFICER_F, 98, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23FogBadgeOfficerScript, -1
	person_event SPRITE_SWIMMING_OFFICER, 83, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23StormBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 70, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23MineralBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 55, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23GlacierBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 47, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23RisingBadgeOfficerScript, -1

VictoryRoadSignText:
	text "Victory Road"
	done

Route23ZephyrBadgeOfficerScript:
	faceplayer
Route23ZephyrBadgeTriggerScript:
	stringtotext .ZephyrBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_ZEPHYRBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $0, Route23OfficerHaveBadgeScript
	dotrigger $1
	jump Route23OfficerHaveBadgeScript

.ZephyrBadgeText:
	db "Zephyr Badge@"

Route23HiveBadgeOfficerScript:
	faceplayer
Route23HiveBadgeTriggerScript:
	stringtotext .HiveBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_HIVEBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $1, Route23OfficerHaveBadgeScript
	dotrigger $2
	jump Route23OfficerHaveBadgeScript

.HiveBadgeText:
	db "Hive Badge@"

Route23PlainBadgeOfficerScript:
	faceplayer
Route23PlainBadgeTriggerScript:
	stringtotext .PlainBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_PLAINBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $2, Route23OfficerHaveBadgeScript
	dotrigger $3
	jump Route23OfficerHaveBadgeScript

.PlainBadgeText:
	db "Plain Badge@"

Route23FogBadgeOfficerScript:
	faceplayer
Route23FogBadgeTriggerScript:
	stringtotext .FogBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_FOGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $3, Route23OfficerHaveBadgeScript
	dotrigger $4
	jump Route23OfficerHaveBadgeScript

.FogBadgeText:
	db "Fog Badge@"

Route23StormBadgeOfficerScript:
	faceplayer
Route23StormBadgeTriggerScript:
	stringtotext .StormBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_STORMBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $4, Route23OfficerHaveBadgeScript
	dotrigger $5
	jump Route23OfficerHaveBadgeScript

.StormBadgeText:
	db "Storm Badge@"

Route23MineralBadgeOfficerScript:
	faceplayer
Route23MineralBadgeTriggerScript:
	stringtotext .MineralBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_MINERALBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $5, Route23OfficerHaveBadgeScript
	dotrigger $6
	jump Route23OfficerHaveBadgeScript

.MineralBadgeText:
	db "Mineral Badge@"

Route23GlacierBadgeOfficerScript:
	faceplayer
Route23GlacierBadgeTriggerScript:
	stringtotext .GlacierBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_GLACIERBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $6, Route23OfficerHaveBadgeScript
	dotrigger $7
	jump Route23OfficerHaveBadgeScript

.GlacierBadgeText:
	db "Glacier Badge@"

Route23RisingBadgeOfficerScript:
	faceplayer
Route23RisingBadgeTriggerScript:
	stringtotext .RisingBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_RISINGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checktriggers
	if_greater_than $7, Route23OfficerHaveBadgeScript
	dotrigger $8
	jump Route23OfficerHaveBadgeScript

.RisingBadgeText:
	db "Rising Badge@"

Route23OfficerNoBadgeText:
	text "You don't have the"
	line "@"
	text_from_ram StringBuffer3
	text " yet!"

	para "You have to have"
	line "it to get to the"
	cont "#mon League!@"
	done

Route23OfficerHaveBadgeScript:
	writetext .SeeBadgeText
	waitbutton
	thisopenedtext

	text "OK then! Please,"
	line "go right ahead!"
	done

.SeeBadgeText:
	text "Oh! That is the"
	line "@"
	text_from_ram StringBuffer3
	text "!@"
	sound_dex_fanfare_50_79
	db "@@"

Route23OfficerNeedBadgeText:
	text "You can pass here"
	line "only if you have"
	cont "the @"
	text_from_ram StringBuffer3
	text "."
	done
