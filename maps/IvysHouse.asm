IvysHouse_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 2, 2, VALENCIA_ISLAND
	warp_def 7, 3, 2, VALENCIA_ISLAND

	db 0 ; xy triggers

	db 0 ; signposts

	db 2 ; person events
	person_event SPRITE_COOLTRAINER_F, 3, 2, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseFaithText, -1
	person_event SPRITE_COOLTRAINER_F, 4, 6, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_COMMAND, jumptextfaceplayer, IvysHouseCharityText, -1

IvysHouseFaithText:
	text "Faith: TODO"
	done

IvysHouseCharityText:
	text "Charity: TODO"
	done
