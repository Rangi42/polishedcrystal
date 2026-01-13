Route23North_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  6, 31, VICTORY_ROAD_1F, 1
	warp_event 16, 31, VICTORY_ROAD_2F, 1

	def_coord_events
	coord_event 10, 70, 5, Route23NorthMineralBadgeTriggerScript
	coord_event 11, 70, 5, Route23NorthMineralBadgeTriggerScript
	coord_event 12, 70, 5, Route23NorthMineralBadgeTriggerScript
	coord_event 14, 70, 5, Route23NorthMineralBadgeTriggerScript
	coord_event 15, 70, 5, Route23NorthMineralBadgeTriggerScript
	coord_event 14, 55, 6, Route23NorthGlacierBadgeTriggerScript
	coord_event  8, 47, 7, Route23NorthRisingBadgeTriggerScript
	coord_event  9, 47, 7, Route23NorthRisingBadgeTriggerScript

	def_bg_events
	bg_event  5, 32, BGEVENT_JUMPTEXT, VictoryRoadSignText

	def_object_events
	object_event 13, 70, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23NorthMineralBadgeOfficerScript, -1
	object_event 15, 55, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23NorthGlacierBadgeOfficerScript, -1
	object_event 10, 47, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23NorthRisingBadgeOfficerScript, -1
	object_event  8, 32, SPRITE_OFFICER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, Route23NorthHealOfficerScript, -1

	object_const_def
	const ROUTE23NORTH_OFFICER6
	const ROUTE23NORTH_OFFICER7
	const ROUTE23NORTH_OFFICER8

VictoryRoadSignText:
	text "Victory Road"
	done

Route23NorthHealOfficerScript:
	showtextfaceplayer .IntroText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "The #mon League"
	line "awaits you!"

	para "Just don't give up,"
	line "OK?"
	done

.IntroText:
	text "You need to be"
	line "ready to face"

	para "anything on"
	line "Victory Road."

	para "Let me give you a"
	line "bit of encourage-"
	cont "ment!"
	done

Route23NorthMineralBadgeOfficerScript:
Route23NorthMineralBadgeTriggerScript:
	faceobject ROUTE23NORTH_OFFICER6, PLAYER
	faceobject PLAYER, ROUTE23NORTH_OFFICER6
	getstring .MineralBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_MINERALBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $5, Route23OfficerHaveBadgeScript
	setscene $6
	sjumpfwd Route23OfficerHaveBadgeScript

.MineralBadgeText:
	db "Mineral Badge@"

Route23NorthGlacierBadgeOfficerScript:
Route23NorthGlacierBadgeTriggerScript:
	faceobject ROUTE23NORTH_OFFICER7, PLAYER
	faceobject PLAYER, ROUTE23NORTH_OFFICER7
	getstring .GlacierBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_GLACIERBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $6, Route23OfficerHaveBadgeScript
	setscene $7
	sjumpfwd Route23OfficerHaveBadgeScript

.GlacierBadgeText:
	db "Glacier Badge@"

Route23NorthRisingBadgeOfficerScript:
Route23NorthRisingBadgeTriggerScript:
	faceobject ROUTE23NORTH_OFFICER8, PLAYER
	faceobject PLAYER, ROUTE23NORTH_OFFICER8
	getstring .RisingBadgeText, STRING_BUFFER_3
	opentext
	writetext Route23OfficerNeedBadgeText
	waitbutton
	checkflag ENGINE_RISINGBADGE
	iffalse_jumpopenedtext Route23OfficerNoBadgeText
	checkscene
	ifgreater $7, Route23OfficerHaveBadgeScript
	setscene $8
	sjumpfwd Route23OfficerHaveBadgeScript

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
