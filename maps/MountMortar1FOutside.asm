MountMortar1FOutside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 33, ROUTE_42, 3
	warp_event 17, 33, ROUTE_42, 4
	warp_event 37, 33, ROUTE_42, 5
	warp_event 17,  5, MOUNT_MORTAR_2F_INSIDE, 1
	warp_event 11, 21, MOUNT_MORTAR_1F_INSIDE, 1
	warp_event 29, 21, MOUNT_MORTAR_1F_INSIDE, 2
	warp_event 17, 29, MOUNT_MORTAR_B1F, 2
	warp_event  7, 13, MOUNT_MORTAR_1F_INSIDE, 3
	warp_event 33, 13, MOUNT_MORTAR_1F_INSIDE, 4

	def_coord_events

	def_bg_events
	bg_event 25, 22, BGEVENT_ITEM + HYPER_POTION, EVENT_MOUNT_MORTAR_1F_OUTSIDE_HIDDEN_HYPER_POTION

	def_object_events
	object_event  9, 15, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBattleGirlSubaru, -1
	object_event 30, 11, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBattleGirlDiane, -1
	itemball_event 13, 15, ETHER, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_ETHER
	itemball_event 31, 18, REVIVE, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_REVIVE

GenericTrainerBattleGirlSubaru:
	generictrainer BATTLE_GIRL, SUBARU, EVENT_BEAT_BATTLE_GIRL_SUBARU, BattleGirlSubaruSeenText, BattleGirlSubaruBeatenText

	text "All this climbing"
	line "and I'm still not"
	cont "the toughest…"
	done

GenericTrainerBattleGirlDiane:
	generictrainer BATTLE_GIRL, DIANE, EVENT_BEAT_BATTLE_GIRL_DIANE, BattleGirlDianeSeenText, BattleGirlDianeBeatenText

	text "I bow to you."
	done

BattleGirlSubaruSeenText:
	text "Kiyaah!"
	done

BattleGirlSubaruBeatenText:
	text "Ooof!"
	done

BattleGirlDianeSeenText:
	text "Hii-yaah!"
	done

BattleGirlDianeBeatenText:
	text "This round goes"
	line "to you."
	done

