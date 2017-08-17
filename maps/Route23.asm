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
	xy_trigger 0, $83, $e, Route23ZephyrBadgeTriggerScript
	xy_trigger 1, $7b, $9, Route23HiveBadgeTriggerScript
	xy_trigger 2, $6b, $a, Route23PlainBadgeTriggerScript
	xy_trigger 2, $6b, $c, Route23PlainBadgeTriggerScript
	xy_trigger 2, $6b, $d, Route23PlainBadgeTriggerScript
	xy_trigger 2, $6b, $e, Route23PlainBadgeTriggerScript
	xy_trigger 2, $6b, $f, Route23PlainBadgeTriggerScript
	xy_trigger 3, $62, $8, Route23FogBadgeTriggerScript
	xy_trigger 3, $62, $9, Route23FogBadgeTriggerScript
	xy_trigger 3, $62, $b, Route23FogBadgeTriggerScript
	xy_trigger 3, $62, $c, Route23FogBadgeTriggerScript
	xy_trigger 3, $62, $d, Route23FogBadgeTriggerScript
	xy_trigger 4, $53, $4, Route23StormBadgeTriggerScript
	xy_trigger 4, $53, $6, Route23StormBadgeTriggerScript
	xy_trigger 4, $53, $7, Route23StormBadgeTriggerScript
	xy_trigger 5, $46, $8, Route23MineralBadgeTriggerScript
	xy_trigger 5, $46, $9, Route23MineralBadgeTriggerScript
	xy_trigger 5, $46, $a, Route23MineralBadgeTriggerScript
	xy_trigger 5, $46, $c, Route23MineralBadgeTriggerScript
	xy_trigger 5, $46, $d, Route23MineralBadgeTriggerScript
	xy_trigger 6, $37, $c, Route23GlacierBadgeTriggerScript
	xy_trigger 7, $2f, $6, Route23RisingBadgeTriggerScript
	xy_trigger 7, $2f, $7, Route23RisingBadgeTriggerScript

.Signposts: db 1
	signpost 32, 3, SIGNPOST_JUMPTEXT, VictoryRoadSignText

.PersonEvents: db 8
	person_event SPRITE_SWIMMING_OFFICER, 83, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23StormBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 131, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23ZephyrBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 123, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23HiveBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 107, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23PlainBadgeOfficerScript, -1
	person_event SPRITE_SWIMMING_OFFICER_F, 98, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23FogBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 70, 11, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23MineralBadgeOfficerScript, -1
	person_event SPRITE_OFFICER_F, 55, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23GlacierBadgeOfficerScript, -1
	person_event SPRITE_OFFICER, 47, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Route23RisingBadgeOfficerScript, -1

const_value set 2
	const ROUTE23_SWIMMING_OFFICER

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
	jumpopenedtext Route23OfficerNoBadgeText

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
