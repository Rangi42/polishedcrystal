Route23_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9, 135, POKEMON_LEAGUE_GATE, 5
	warp_event 10, 135, POKEMON_LEAGUE_GATE, 6
	warp_event  6, 31, VICTORY_ROAD_1F, 1
	warp_event 16, 31, VICTORY_ROAD_2F, 1

	def_coord_events
	coord_event 16, 131, 0, Route23ZephyrBadgeTriggerScript
	coord_event 11, 123, 1, Route23HiveBadgeTriggerScript
	coord_event 12, 107, 2, Route23PlainBadgeTriggerScript
	coord_event 14, 107, 2, Route23PlainBadgeTriggerScript
	coord_event 15, 107, 2, Route23PlainBadgeTriggerScript
	coord_event 16, 107, 2, Route23PlainBadgeTriggerScript
	coord_event 17, 107, 2, Route23PlainBadgeTriggerScript
	coord_event 10, 98, 3, Route23FogBadgeTriggerScript
	coord_event 11, 98, 3, Route23FogBadgeTriggerScript
	coord_event 13, 98, 3, Route23FogBadgeTriggerScript
	coord_event 14, 98, 3, Route23FogBadgeTriggerScript
	coord_event 15, 98, 3, Route23FogBadgeTriggerScript
	coord_event  6, 83, 4, Route23StormBadgeTriggerScript
	coord_event  8, 83, 4, Route23StormBadgeTriggerScript
	coord_event  9, 83, 4, Route23StormBadgeTriggerScript
	coord_event 10, 70, 5, Route23MineralBadgeTriggerScript
	coord_event 11, 70, 5, Route23MineralBadgeTriggerScript
	coord_event 12, 70, 5, Route23MineralBadgeTriggerScript
	coord_event 14, 70, 5, Route23MineralBadgeTriggerScript
	coord_event 15, 70, 5, Route23MineralBadgeTriggerScript
	coord_event 14, 55, 6, Route23GlacierBadgeTriggerScript
	coord_event  8, 47, 7, Route23RisingBadgeTriggerScript
	coord_event  9, 47, 7, Route23RisingBadgeTriggerScript

	def_bg_events
	bg_event  5, 32, BGEVENT_JUMPTEXT, VictoryRoadSignText

	def_object_events
	object_event 17, 131, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23ZephyrBadgeOfficerScript, -1
	object_event 10, 123, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23HiveBadgeOfficerScript, -1
	object_event 13, 107, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23PlainBadgeOfficerScript, -1
	object_event 12, 98, SPRITE_SWIMMING_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23FogBadgeOfficerScript, -1
	object_event  7, 83, SPRITE_SWIMMING_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23StormBadgeOfficerScript, -1
	object_event 13, 70, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23MineralBadgeOfficerScript, -1
	object_event 15, 55, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23GlacierBadgeOfficerScript, -1
	object_event 10, 47, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23RisingBadgeOfficerScript, -1

	object_const_def
	const ROUTE23_OFFICER1
	const ROUTE23_OFFICER2
	const ROUTE23_OFFICER3
	const ROUTE23_OFFICER4
	const ROUTE23_OFFICER5
	const ROUTE23_OFFICER6
	const ROUTE23_OFFICER7
	const ROUTE23_OFFICER8

VictoryRoadSignText:
	text "Victory Road"
	done

Route23ZephyrBadgeOfficerScript:
Route23ZephyrBadgeTriggerScript:
	faceobject ROUTE23_OFFICER1, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER1
	getstring .ZephyrBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_ZEPHYRBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $0, Route23OfficerHaveBadgeScript
	setscene $1
	sjump Route23OfficerHaveBadgeScript

.ZephyrBadgeText:
	db "Zephyr Badge@"

Route23HiveBadgeOfficerScript:
Route23HiveBadgeTriggerScript:
	faceobject ROUTE23_OFFICER2, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER2
	getstring .HiveBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_HIVEBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $1, Route23OfficerHaveBadgeScript
	setscene $2
	sjump Route23OfficerHaveBadgeScript

.HiveBadgeText:
	db "Hive Badge@"

Route23PlainBadgeOfficerScript:
Route23PlainBadgeTriggerScript:
	faceobject ROUTE23_OFFICER3, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER3
	getstring .PlainBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_PLAINBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $2, Route23OfficerHaveBadgeScript
	setscene $3
	sjump Route23OfficerHaveBadgeScript

.PlainBadgeText:
	db "Plain Badge@"

Route23FogBadgeOfficerScript:
Route23FogBadgeTriggerScript:
	faceobject ROUTE23_OFFICER4, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER4
	getstring .FogBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_FOGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $3, Route23OfficerHaveBadgeScript
	setscene $4
	sjump Route23OfficerHaveBadgeScript

.FogBadgeText:
	db "Fog Badge@"

Route23StormBadgeOfficerScript:
Route23StormBadgeTriggerScript:
	faceobject ROUTE23_OFFICER5, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER5
	getstring .StormBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_STORMBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $4, Route23OfficerHaveBadgeScript
	setscene $5
	sjump Route23OfficerHaveBadgeScript

.StormBadgeText:
	db "Storm Badge@"

Route23MineralBadgeOfficerScript:
Route23MineralBadgeTriggerScript:
	faceobject ROUTE23_OFFICER6, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER6
	getstring .MineralBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_MINERALBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $5, Route23OfficerHaveBadgeScript
	setscene $6
	sjump Route23OfficerHaveBadgeScript

.MineralBadgeText:
	db "Mineral Badge@"

Route23GlacierBadgeOfficerScript:
Route23GlacierBadgeTriggerScript:
	faceobject ROUTE23_OFFICER7, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER7
	getstring .GlacierBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_GLACIERBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $6, Route23OfficerHaveBadgeScript
	setscene $7
	sjump Route23OfficerHaveBadgeScript

.GlacierBadgeText:
	db "Glacier Badge@"

Route23RisingBadgeOfficerScript:
Route23RisingBadgeTriggerScript:
	faceobject ROUTE23_OFFICER8, PLAYER
	faceobject PLAYER, ROUTE23_OFFICER8
	getstring .RisingBadgeText, 0
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_RISINGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $7, Route23OfficerHaveBadgeScript
	setscene $8
	sjump Route23OfficerHaveBadgeScript

.RisingBadgeText:
	db "Rising Badge@"

Route23OfficerNoBadgeText:
	text "You don't have the"
	line ""
	text_ram wStringBuffer3
	text " yet!"

	para "You have to have"
	line "it to get to the"
	cont "#mon League!"
	done

Route23OfficerHaveBadgeScript:
	writetext .SeeBadgeText
	playsound SFX_DEX_FANFARE_50_79
	promptbutton
	jumpthisopenedtext

	text "OK then! Please,"
	line "go right ahead!"
	done

.SeeBadgeText:
	text "Oh! That is the"
	line ""
	text_ram wStringBuffer3
	text "!"
	done

Route23OfficerNeedBadgeText:
	text "You can pass here"
	line "only if you have"
	cont "the "
	text_ram wStringBuffer3
	text "."
	done
