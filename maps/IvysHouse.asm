IvysHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 2, 7, 2, VALENCIA_ISLAND
	warp_event 3, 7, 2, VALENCIA_ISLAND

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event 2, 3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseFaithText, -1
	object_event 6, 4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseCharityText, -1

IvysHouseFaithText:
	text "Faith: TODO"
	done

IvysHouseCharityText:
	text "Charity: TODO"
	done
