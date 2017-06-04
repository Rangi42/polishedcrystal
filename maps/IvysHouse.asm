const_value set 2
	const IVYSHOUSE_COOLTRAINERF1
	const IVYSHOUSE_COOLTRAINERF2

IvysHouse_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

IvysHouseFaithScript:
	jumptextfaceplayer .Text

.Text:
	text "Faith: TODO"
	done

IvysHouseCharityScript:
	jumptextfaceplayer .Text

.Text:
	text "Charity: TODO"
	done

IvysHouse_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $7, $2, 2, VALENCIA_ISLAND
	warp_def $7, $3, 2, VALENCIA_ISLAND

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 2
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, IvysHouseFaithScript, -1
	person_event SPRITE_COOLTRAINER_F, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, IvysHouseCharityScript, -1
