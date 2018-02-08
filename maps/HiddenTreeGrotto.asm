HiddenTreeGrotto_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback

	db 2 ; warp events
	warp_event  4, 15, HIDDEN_TREE_GROTTO, -1
	warp_event  5, 15, HIDDEN_TREE_GROTTO, -1

	db 0 ; coord events

	db 1 ; bg events
	bg_event  4,  4, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

	db 2 ; object events
	object_event  4,  4, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  4, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2

	const_def 1 ; object constants
	const HIDDENTREEGROTTO_POKEMON
	const HIDDENTREEGROTTO_ITEM

HiddenGrottoCallback:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	special InitializeHiddenGrotto
	ifequal GROTTO_POKEMON, .pokemon
	ifequal GROTTO_ITEM, .item
	ifequal GROTTO_HIDDEN_ITEM, .hidden_item
	return

.pokemon
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	return

.item
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	return

.hidden_item
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	return

HiddenGrottoPokemonScript:
	special EmptiedHiddenGrotto
	loadgrottomon
	writecode VAR_BATTLETYPE, BATTLETYPE_GROTTO
	startbattle
	disappear HIDDENTREEGROTTO_POKEMON
	reloadmapafterbattle
	end

HiddenGrottoHiddenItemScript:
	dw EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
HiddenGrottoItemScript:
	special GetHiddenGrottoContents
	itemtotext $0, $1
	giveitem ITEM_FROM_MEM
	iffalse .PackFull
	disappear HIDDENTREEGROTTO_ITEM
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	opentext
	writetext .ItemText
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
	line "@"
	text_from_ram StringBuffer4
	text "!"
	done
