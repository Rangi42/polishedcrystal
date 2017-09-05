MountMortar1FOutside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMortar1FOutside_MapEventHeader:

.Warps: db 9
	warp_def 33, 3, 3, ROUTE_42
	warp_def 33, 17, 4, ROUTE_42
	warp_def 33, 37, 5, ROUTE_42
	warp_def 5, 17, 1, MOUNT_MORTAR_2F_INSIDE
	warp_def 21, 11, 1, MOUNT_MORTAR_1F_INSIDE
	warp_def 21, 29, 2, MOUNT_MORTAR_1F_INSIDE
	warp_def 29, 17, 2, MOUNT_MORTAR_B1F
	warp_def 13, 7, 3, MOUNT_MORTAR_1F_INSIDE
	warp_def 13, 33, 4, MOUNT_MORTAR_1F_INSIDE

.XYTriggers: db 0

.Signposts: db 1
	signpost 22, 25, SIGNPOST_ITEM + HYPER_POTION, EVENT_MOUNT_MORTAR_1F_OUTSIDE_HIDDEN_HYPER_POTION

.PersonEvents: db 4
	person_event SPRITE_COOLTRAINER_F, 15, 9, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 3, TrainerBattleGirlSubaru, -1
	person_event SPRITE_COOLTRAINER_F, 11, 30, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerBattleGirlDiane, -1
	itemball_event 15, 13, ETHER, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_ETHER
	itemball_event 18, 31, REVIVE, 1, EVENT_MOUNT_MORTAR_1F_OUTSIDE_REVIVE

TrainerBattleGirlSubaru:
	trainer EVENT_BEAT_BATTLE_GIRL_SUBARU, BATTLE_GIRL, SUBARU, BattleGirlSubaruSeenText, BattleGirlSubaruBeatenText, 0, BattleGirlSubaruScript

BattleGirlSubaruScript:
	end_if_just_battled
	jumptextfaceplayer BattleGirlSubaruAfterText

TrainerBattleGirlDiane:
	trainer EVENT_BEAT_BATTLE_GIRL_DIANE, BATTLE_GIRL, DIANE, BattleGirlDianeSeenText, BattleGirlDianeBeatenText, 0, BattleGirlDianeScript

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
