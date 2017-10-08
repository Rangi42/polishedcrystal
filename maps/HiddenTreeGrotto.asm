HiddenTreeGrotto_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 1
	dbw MAPCALLBACK_NEWMAP, HiddenGrottoCallback

HiddenTreeGrotto_MapEventHeader:

.Warps: db 2
	warp_def 15, 4, -1, HIDDEN_TREE_GROTTO
	warp_def 15, 5, -1, HIDDEN_TREE_GROTTO

.XYTriggers: db 0

.Signposts: db 1
	signpost 4, 4, SIGNPOST_GROTTOITEM, HiddenGrottoHiddenItemScript

.PersonEvents: db 2
	person_event SPRITE_GROTTO_MON, 4, 4, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, HiddenGrottoPokemonScript, EVENT_GAVE_KURT_APRICORNS
	person_event SPRITE_BALL_CUT_FRUIT, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, HiddenGrottoItemScript, EVENT_RECEIVED_BALLS_FROM_KURT

const_value set 1
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
