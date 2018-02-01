MountMortar1FOutside_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 9 ; warp events
	warp_event 3, 33, 3, ROUTE_42
	warp_event 17, 33, 4, ROUTE_42
	warp_event 37, 33, 5, ROUTE_42
	warp_event 17, 5, 1, MOUNT_MORTAR_2F_INSIDE
	warp_event 11, 21, 1, MOUNT_MORTAR_1F_INSIDE
	warp_event 29, 21, 2, MOUNT_MORTAR_1F_INSIDE
	warp_event 17, 29, 2, MOUNT_MORTAR_B1F
	warp_event 7, 13, 3, MOUNT_MORTAR_1F_INSIDE
	warp_event 33, 13, 4, MOUNT_MORTAR_1F_INSIDE

	db 0 ; coord events

	db 1 ; bg events
	bg_event 25, 22, SIGNPOST_ITEM + HYPER_POTION, EVENT_MOUNT_MORTAR_1F_OUTSIDE_HIDDEN_HYPER_POTION

	db 4 ; object events
	object_event 9, 15, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBattleGirlSubaru, -1
	object_event 30, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBattleGirlDiane, -1
	itemball_event 13, 15, ETHER, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_ETHER
	itemball_event 31, 18, REVIVE, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_REVIVE

TrainerBattleGirlSubaru:
	trainer BATTLE_GIRL, SUBARU, EVENT_BEAT_BATTLE_GIRL_SUBARU, BattleGirlSubaruSeenText, BattleGirlSubaruBeatenText, 0, BattleGirlSubaruScript

BattleGirlSubaruScript:
	end_if_just_battled
	jumptextfaceplayer BattleGirlSubaruAfterText

TrainerBattleGirlDiane:
	trainer BATTLE_GIRL, DIANE, EVENT_BEAT_BATTLE_GIRL_DIANE, BattleGirlDianeSeenText, BattleGirlDianeBeatenText, 0, BattleGirlDianeScript

BattleGirlDianeScript:
	end_if_just_battled
	jumptextfaceplayer BattleGirlDianeAfterText

BattleGirlSubaruSeenText:
	text "Kiyaah!"
	done

BattleGirlSubaruBeatenText:
	text "Ooof!"
	done

BattleGirlSubaruAfterText:
	text "All this climbing"
	line "and I'm still not"
	cont "the toughest…"
	done

BattleGirlDianeSeenText:
	text "Hii-yaah!"
	done

BattleGirlDianeBeatenText:
	text "This round goes"
	line "to you."
	done

BattleGirlDianeAfterText:
	text "I bow to you."
	done
