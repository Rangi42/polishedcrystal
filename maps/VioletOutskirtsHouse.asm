VioletOutskirtsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, VioletOutskirtsHouseCaretaker

	def_warp_events
	warp_event  3,  7, VIOLET_OUTSKIRTS, 2
	warp_event  4,  7, VIOLET_OUTSKIRTS, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, VioletOutskirtsGhostBattleScript
	bg_event  1,  1, BGEVENT_JUMPTEXT, VioletOutskirtsHouseDustText
	bg_event  2,  1, BGEVENT_JUMPTEXT, VioletOutskirtsHouseRadioText
	bg_event  6,  1, BGEVENT_JUMPTEXT, VioletOutskirtsHouseDustText
	bg_event  7,  1, BGEVENT_JUMPTEXT, VioletOutskirtsHouseDustText

	def_object_events
	object_event  2,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_GRAY, OBJECTTYPE_SCRIPT, 0, VioletOutskirtsHouseCaretakerScript, EVENT_VIOLET_CEMETERY_CARETAKER

	object_const_def
	const VIOLETOUTSKIRTSHOUSE_CARETAKER

VioletOutskirtsHouseCaretaker:
	checkevent EVENT_CAUGHT_HISUIAN_TYPHLOSION
	iftruefwd .endcallback
	disappear VIOLETOUTSKIRTSHOUSE_CARETAKER
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftruefwd .endcallback
	special LoadMapPalettes
	special FadeInPalettes_EnableDynNoApply
	showtext VioletOutskirtsHouseNotAloneText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
.endcallback
	endcallback

VioletOutskirtsGhostBattleScript:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue_jumptext VioletOutskirtsHouseStillAPresenceText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue_jumptext VioletOutskirtsHouseNotSafeHereText
	opentext
	writetext VioletOutskirtsHouseOldShrineText
	checkevent EVENT_CAUGHT_HISUIAN_TYPHLOSION
	iftruefwd .Done
	promptbutton
	writetext VioletOutskirtsHouseAhText
	waitbutton
	closetext
	loadvar VAR_BATTLETYPE, BATTLETYPE_GHOST
	loadwildmon TYPHLOSION, HISUIAN_FORM, 60
	startbattle
	special CheckBattleCaughtResult
	iftruefwd .CaughtHisuianTyphlosion
	reloadmapafterbattle
	opentext
	checkkeyitem SILPHSCOPE2
	iffalsefwd .NoSilphScope2
; Defeated (or ran from) Typhlosion
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext VioletOutskirtsHouseStillAPresenceText
	sjumpfwd .Done
; Didn't identify Typhlosion
.NoSilphScope2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	writetext VioletOutskirtsHouseNotSafeHereText
.Done
	waitbutton
	endtext

.CaughtHisuianTyphlosion
	appear VIOLETOUTSKIRTSHOUSE_CARETAKER
	setevent EVENT_CAUGHT_HISUIAN_TYPHLOSION
	reloadmapafterbattle
	end

VioletOutskirtsHouseCaretakerScript:
	checkevent EVENT_TALKED_TO_VIOLET_CEMETERY_CARETAKER
	iftrue_jumptextfaceplayer VioletOutskirtsHouseCaretakerThankYouText
	setevent EVENT_TALKED_TO_VIOLET_CEMETERY_CARETAKER
	jumpthistextfaceplayer

	text "…… ……"

	para "You found my"
	line "friend…"

	para "It would guide"
	line "departed spirits"
	cont "to the next life…"

	para "As I tended to"
	line "their graves…"

	para "…… ……"

	para "That was so"
	line "long ago…"

	para "No one visits"
	line "any more…"

	para "The graves are"
	line "left untended…"

	para "But you… still"
	line "came here…"

	para "…… ……"

	para "Thank you…"

	para "Please take care"
	line "of my… friend…"
	done

VioletOutskirtsHouseOldShrineText:
	text "It's a very old"
	line "shrine."
	done

VioletOutskirtsHouseAhText:
	text "…… …… ……"

	para "…… …… ……"

	para "Ah!"
	done

VioletOutskirtsHouseCaretakerThankYouText:
	text "…… ……"

	para "Thank you…"
	line "dear…"
	done

VioletOutskirtsHouseStillAPresenceText:
	text "The spirit is"
	line "gone, but there's"
	cont "still a presence…"
	done

VioletOutskirtsHouseNotSafeHereText:
	text "There's still a"
	line "strong presence."

	para "It's not safe here!"
	done

VioletOutskirtsHouseRadioText:
	text "It doesn't seem"
	line "to work."
	done

VioletOutskirtsHouseDustText:
	text "It's covered in a"
	line "thick layer of"
	cont "dust."
	done

VioletOutskirtsHouseNotAloneText:
	text "You have a sense"
	line "that something"
	cont "is watching you…"
	done
