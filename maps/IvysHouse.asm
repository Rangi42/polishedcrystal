IvysHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

IvysHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 2, VALENCIA_ISLAND
	warp_def 7, 3, 2, VALENCIA_ISLAND

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseFaithText, -1
	person_event SPRITE_COOLTRAINER_F, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseCharityText, -1

IvysHouseFaithText:
	text "Faith: TODO"
	done

IvysHouseCharityText:
	text "Charity: TODO"
	done
