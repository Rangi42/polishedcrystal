HiddenTreeGrotto_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, HiddenGrottoCallback

	db 2 ; warp events
	warp_event 4, 15, HIDDEN_TREE_GROTTO, -1
	warp_event 5, 15, HIDDEN_TREE_GROTTO, -1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 4, 4, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

	db 2 ; object events
	object_event 4, 4, SPRITE_GROTTO_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_GAVE_KURT_APRICORNS
	object_event 4, 4, SPRITE_BALL_CUT_FRUIT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_RECEIVED_BALLS_FROM_KURT

	const_def 1 ; object constants
	const HIDDENTREEGROTTO_POKEMON
	const HIDDENTREEGROTTO_ITEM

HiddenGrottoCallback:
	setevent EVENT_GAVE_KURT_APRICORNS
	setevent EVENT_RECEIVED_BALLS_FROM_KURT
	setevent EVENT_DRAGON_SHRINE_QUESTION_2
	special InitializeHiddenGrotto
	if_equal GROTTO_POKEMON, .pokemon
	if_equal GROTTO_ITEM, .item
	if_equal GROTTO_HIDDEN_ITEM, .hidden_item
	return

.pokemon
	clearevent EVENT_GAVE_KURT_APRICORNS
	return

.item
	clearevent EVENT_RECEIVED_BALLS_FROM_KURT
	return

.hidden_item
	clearevent EVENT_DRAGON_SHRINE_QUESTION_2
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
	dw EVENT_DRAGON_SHRINE_QUESTION_2
HiddenGrottoItemScript:
	special GetHiddenGrottoContents
	itemtotext $0, $1
	giveitem ITEM_FROM_MEM
	iffalse .PackFull
	disappear HIDDENTREEGROTTO_ITEM
	setevent EVENT_DRAGON_SHRINE_QUESTION_2
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
