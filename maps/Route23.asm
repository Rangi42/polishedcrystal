const_value set 2
	const ROUTE23_OFFICER1
	const ROUTE23_OFFICER_F1
	const ROUTE23_OFFICER2
	const ROUTE23_SWIMMING_OFFICER_F
	const ROUTE23_SWIMMING_OFFICER
	const ROUTE23_OFFICER_F2
	const ROUTE23_OFFICER_F3
	const ROUTE23_OFFICER3

Route23_MapScriptHeader:
.MapTriggers:
	db 9

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1
	maptrigger .Trigger2
	maptrigger .Trigger3
	maptrigger .Trigger4
	maptrigger .Trigger5
	maptrigger .Trigger6
	maptrigger .Trigger7
	maptrigger .Trigger8

.MapCallbacks:
	db 0

.Trigger0:
.Trigger1:
.Trigger2:
.Trigger3:
.Trigger4:
.Trigger5:
.Trigger6:
.Trigger7:
.Trigger8:
	end

Route23ZephyrBadgeOfficerScript:
	faceplayer
Route23ZephyrBadgeTriggerScript:
	stringtotext .ZephyrBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_ZEPHYRBADGE
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $1
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $2
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $3
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $4
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $5
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $6
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $7
	end

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
	iffalse Route23OfficerNoBadgeScript
	writetext Route23OfficerHaveBadgeText
	waitbutton
	writetext Route23OfficerGoAheadText
	waitbutton
	closetext
	dotrigger $8
	end

.RisingBadgeText:
	db "Rising Badge@"

Route23OfficerNoBadgeScript:
	writetext Route23OfficerNoBadgeText
	waitbutton
	closetext
	end

VictoryRoadSign:
	jumptext VictoryRoadSignText

Route23OfficerNeedBadgeText:
	text "You can pass here"
	line "only if you have"
	cont "the @"
	text_from_ram StringBuffer3
	text "."
	done

Route23OfficerNoBadgeText:
	text "You don't have the"
	line "@"
	text_from_ram StringBuffer3
	text " yet!"

	para "You have to have"
	line "it to get to the"
	cont "#mon League!@"
	done

Route23OfficerHaveBadgeText:
	text "Oh! That is the"
	line "@"
	text_from_ram StringBuffer3
	text "!@"
	sound_dex_fanfare_50_79
	db "@@"

Route23OfficerGoAheadText:
	text "OK then! Please,"
	line "go right ahead!"
	done

VictoryRoadSignText:
	text "Victory Road"
	done

Route23_MapEventHeader:
.Warps:
	db 4
	warp_def $87, $7, 5, POKEMON_LEAGUE_GATE
	warp_def $87, $8, 6, POKEMON_LEAGUE_GATE
	warp_def $1f, $4, 1, VICTORY_ROAD_1F
	warp_def $1f, $e, 1, VICTORY_ROAD_2F

.XYTriggers:
	db 23
	xy_trigger 0, $83, $e, $0, Route23ZephyrBadgeTriggerScript, $0, $0
	xy_trigger 1, $7b, $9, $0, Route23HiveBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $a, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $c, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $d, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $e, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 2, $6b, $f, $0, Route23PlainBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $8, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $9, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $b, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $c, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 3, $62, $d, $0, Route23FogBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $4, $0, Route23StormBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $6, $0, Route23StormBadgeTriggerScript, $0, $0
	xy_trigger 4, $53, $7, $0, Route23StormBadgeTriggerScript, $0, $0
	xy_trigger 5, $46, $8, $0, Route23MineralBadgeTriggerScript, $0, $0
	xy_trigger 5, $46, $9, $0, Route23MineralBadgeTriggerScript, $0, $0
	xy_trigger 5, $46, $a, $0, Route23MineralBadgeTriggerScript, $0, $0
	xy_trigger 5, $46, $c, $0, Route23MineralBadgeTriggerScript, $0, $0
	xy_trigger 5, $46, $d, $0, Route23MineralBadgeTriggerScript, $0, $0
	xy_trigger 6, $37, $c, $0, Route23GlacierBadgeTriggerScript, $0, $0
	xy_trigger 7, $2f, $6, $0, Route23RisingBadgeTriggerScript, $0, $0
	xy_trigger 7, $2f, $7, $0, Route23RisingBadgeTriggerScript, $0, $0

.Signposts:
	db 1
	signpost 32, 3, SIGNPOST_READ, VictoryRoadSign

.PersonEvents:
	db 8
	person_event SPRITE_OFFICER, 131, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23ZephyrBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 123, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23HiveBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 107, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23PlainBadgeOfficerScript, -1
	person_event SPRITE_SWIMMING_OFFICER_F, 98, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23FogBadgeOfficerScript, -1
	person_event SPRITE_SWIMMING_OFFICER, 83, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23StormBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 70, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23MineralBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 55, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23GlacierBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 47, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23RisingBadgeOfficerScript, -1
