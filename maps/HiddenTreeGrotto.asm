HiddenTreeGrotto_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback
	callback MAPCALLBACK_TILES, HiddenTreeGrottoTileCallback

	def_warp_events
	warp_event  3,  9, HIDDEN_TREE_GROTTO, -1

	def_coord_events

	def_bg_events
	bg_event  3,  3, BGEVENT_GROTTOITEM, HiddenGrottoHiddenItemScript

	def_object_events
	object_event  3,  3, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  3,  3, SPRITE_BALL_CUT_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, PAL_NPC_POKE_BALL, OBJECTTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	object_const_def
	const HIDDENTREEGROTTO_POKEMON
	const HIDDENTREEGROTTO_ITEM

HiddenGrottoCallback:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	special InitializeHiddenGrotto
	ifequalfwd GROTTO_POKEMON, .pokemon
	ifequalfwd GROTTO_ITEM, .item
	ifequalfwd GROTTO_HIDDEN_ITEM, .hidden_item
	endcallback

.pokemon
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	endcallback

.item
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	endcallback

.hidden_item
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	endcallback

HiddenTreeGrottoTileCallback:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftruefwd .end
	changeblock 2, 2, $24
.end
	endcallback

HiddenGrottoPokemonScript:
	special EmptiedHiddenGrotto
	loadgrottomon
	loadvar VAR_BATTLETYPE, BATTLETYPE_GROTTO
	startbattle
	disappear HIDDENTREEGROTTO_POKEMON
	reloadmapafterbattle
	end

HiddenGrottoHiddenItemScript:
	dw EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
HiddenGrottoItemScript:
	special GetHiddenGrottoContents
	getitemname USE_SCRIPT_VAR, STRING_BUFFER_4
	giveitem ITEM_FROM_MEM
	iffalsefwd .PackFull
	disappear HIDDENTREEGROTTO_ITEM
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	opentext
	writetext .ItemText
	special ShowItemIcon
	playsound SFX_ITEM
	pause 60
	itemnotify
	closetext
	special EmptiedHiddenGrotto
	end

.PackFull:
	opentext
	writetext .ItemText
	waitbutton
	pocketisfull
	endtext

.ItemText:
	text "<PLAYER> found"
	line ""
	text_ram wStringBuffer4
	text "!"
	done
