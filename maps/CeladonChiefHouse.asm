const_value set 2
	const CELADONCHIEFHOUSE_COOLTRAINERM

CeladonChiefHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

CeladonChiefHouseCooltrainerMScript:
	jumptextfaceplayer CeladonChiefHouseCooltrainerMText

CeladonChiefHouseHiddenDubiousDisc:
	dwb EVENT_CELADON_CHIEF_HOUSE_HIDDEN_DUBIOUS_DISC, DUBIOUS_DISC

CeladonChiefHouseCooltrainerMText:
	text "The Game Corner is"
	line "making us a lot"
	cont "of money!"

	para "It's all legal,"
	line "too. Honestly!"
	done

CeladonChiefHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 10, CELADON_CITY
	warp_def $7, $3, 10, CELADON_CITY

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 1, 7, SIGNPOST_ITEM, CeladonChiefHouseHiddenDubiousDisc

.PersonEvents:
	db 1
	person_event SPRITE_COOLTRAINER_M, 3, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonChiefHouseCooltrainerMScript, -1
