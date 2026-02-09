Route23South_MapScriptHeader:
	def_scene_scripts
	scene_const SCENE_ROUTE23SOUTH_BADGE_CHECK_0
	scene_const SCENE_ROUTE23SOUTH_BADGE_CHECK_1
	scene_const SCENE_ROUTE23SOUTH_BADGE_CHECK_2
	scene_const SCENE_ROUTE23SOUTH_BADGE_CHECK_3
	scene_const SCENE_ROUTE23SOUTH_BADGE_CHECK_4
	scene_const SCENE_ROUTE23SOUTH_NOOP

	def_callbacks

	def_warp_events
	warp_event  9, 59, POKEMON_LEAGUE_GATE, 5
	warp_event 10, 59, POKEMON_LEAGUE_GATE, 6

	def_coord_events
	coord_event 16, 55, SCENE_ROUTE23SOUTH_BADGE_CHECK_0, Route23SouthZephyrBadgeTriggerScript
	coord_event 11, 47, SCENE_ROUTE23SOUTH_BADGE_CHECK_1, Route23SouthHiveBadgeTriggerScript
	coord_event 12, 31, SCENE_ROUTE23SOUTH_BADGE_CHECK_2, Route23SouthPlainBadgeTriggerScript
	coord_event 14, 31, SCENE_ROUTE23SOUTH_BADGE_CHECK_2, Route23SouthPlainBadgeTriggerScript
	coord_event 15, 31, SCENE_ROUTE23SOUTH_BADGE_CHECK_2, Route23SouthPlainBadgeTriggerScript
	coord_event 16, 31, SCENE_ROUTE23SOUTH_BADGE_CHECK_2, Route23SouthPlainBadgeTriggerScript
	coord_event 17, 31, SCENE_ROUTE23SOUTH_BADGE_CHECK_2, Route23SouthPlainBadgeTriggerScript
	coord_event 10, 22, SCENE_ROUTE23SOUTH_BADGE_CHECK_3, Route23SouthFogBadgeTriggerScript
	coord_event 11, 22, SCENE_ROUTE23SOUTH_BADGE_CHECK_3, Route23SouthFogBadgeTriggerScript
	coord_event 13, 22, SCENE_ROUTE23SOUTH_BADGE_CHECK_3, Route23SouthFogBadgeTriggerScript
	coord_event 14, 22, SCENE_ROUTE23SOUTH_BADGE_CHECK_3, Route23SouthFogBadgeTriggerScript
	coord_event 15, 22, SCENE_ROUTE23SOUTH_BADGE_CHECK_3, Route23SouthFogBadgeTriggerScript
	coord_event  6,  7, SCENE_ROUTE23SOUTH_BADGE_CHECK_4, Route23SouthStormBadgeTriggerScript
	coord_event  8,  7, SCENE_ROUTE23SOUTH_BADGE_CHECK_4, Route23SouthStormBadgeTriggerScript
	coord_event  9,  7, SCENE_ROUTE23SOUTH_BADGE_CHECK_4, Route23SouthStormBadgeTriggerScript

	def_bg_events

	def_object_events
	object_event 17, 55, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23SouthZephyrBadgeOfficerScript, -1
	object_event 10, 47, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23SouthHiveBadgeOfficerScript, -1
	object_event 13, 31, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23SouthPlainBadgeOfficerScript, -1
	object_event 12, 22, SPRITE_SWIMMING_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23SouthFogBadgeOfficerScript, -1
	object_event  7,  7, SPRITE_SWIMMING_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23SouthStormBadgeOfficerScript, -1

	object_const_def
	const ROUTE23SOUTH_OFFICER1
	const ROUTE23SOUTH_OFFICER2
	const ROUTE23SOUTH_OFFICER3
	const ROUTE23SOUTH_OFFICER4
	const ROUTE23SOUTH_OFFICER5

Route23SouthZephyrBadgeOfficerScript:
Route23SouthZephyrBadgeTriggerScript:
	faceobject ROUTE23SOUTH_OFFICER1, PLAYER
	faceobject PLAYER, ROUTE23SOUTH_OFFICER1
	getstring .ZephyrBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_ZEPHYRBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $0, Route23OfficerHaveBadgeScript
	setscene SCENE_ROUTE23SOUTH_BADGE_CHECK_1
	sjump Route23OfficerHaveBadgeScript

.ZephyrBadgeText:
	db "Zephyr Badge@"

Route23SouthHiveBadgeOfficerScript:
Route23SouthHiveBadgeTriggerScript:
	faceobject ROUTE23SOUTH_OFFICER2, PLAYER
	faceobject PLAYER, ROUTE23SOUTH_OFFICER2
	getstring .HiveBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_HIVEBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $1, Route23OfficerHaveBadgeScript
	setscene SCENE_ROUTE23SOUTH_BADGE_CHECK_2
	sjump Route23OfficerHaveBadgeScript

.HiveBadgeText:
	db "Hive Badge@"

Route23SouthPlainBadgeOfficerScript:
Route23SouthPlainBadgeTriggerScript:
	faceobject ROUTE23SOUTH_OFFICER3, PLAYER
	faceobject PLAYER, ROUTE23SOUTH_OFFICER3
	getstring .PlainBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_PLAINBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $2, Route23OfficerHaveBadgeScript
	setscene SCENE_ROUTE23SOUTH_BADGE_CHECK_3
	sjump Route23OfficerHaveBadgeScript

.PlainBadgeText:
	db "Plain Badge@"

Route23SouthFogBadgeOfficerScript:
Route23SouthFogBadgeTriggerScript:
	faceobject ROUTE23SOUTH_OFFICER4, PLAYER
	faceobject PLAYER, ROUTE23SOUTH_OFFICER4
	getstring .FogBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_FOGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $3, Route23OfficerHaveBadgeScript
	setscene SCENE_ROUTE23SOUTH_BADGE_CHECK_4
	sjump Route23OfficerHaveBadgeScript

.FogBadgeText:
	db "Fog Badge@"

Route23SouthStormBadgeOfficerScript:
Route23SouthStormBadgeTriggerScript:
	faceobject ROUTE23SOUTH_OFFICER5, PLAYER
	faceobject PLAYER, ROUTE23SOUTH_OFFICER5
	getstring .StormBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_STORMBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $4, Route23OfficerHaveBadgeScript
	setscene SCENE_ROUTE23SOUTH_NOOP
	sjump Route23OfficerHaveBadgeScript

.StormBadgeText:
	db "Storm Badge@"
