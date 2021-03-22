TinTowerRoof_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, TinTowerRoofHoOh

	def_warp_events
	warp_event  7, 13, TIN_TOWER_10F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, HO_OH, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TinTowerHoOh, EVENT_TIN_TOWER_ROOF_HO_OH

	object_const_def
	const TINTOWERROOF_HO_OH

TinTowerRoofHoOh:
	checkevent EVENT_FOUGHT_HO_OH
	iftrue .NoAppear
	checkkeyitem RAINBOW_WING
	iftrue .Appear
	sjump .NoAppear

.Appear:
	appear TINTOWERROOF_HO_OH
	endcallback

.NoAppear:
	disappear TINTOWERROOF_HO_OH
	endcallback

TinTowerHoOh:
	faceplayer
	opentext
	writetext HoOhText
	cry HO_OH
	pause 15
	closetext
	setevent EVENT_FOUGHT_HO_OH
	loadvar VAR_BATTLETYPE, BATTLETYPE_LEGENDARY
	loadwildmon HO_OH, 75
	startbattle
	disappear TINTOWERROOF_HO_OH
	reloadmapafterbattle
	setevent EVENT_SET_WHEN_FOUGHT_HO_OH
	end

HoOhText:
	text "Shaoooh!"
	done
