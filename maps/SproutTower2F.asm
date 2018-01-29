SproutTower2F_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

SproutTower2F_MapEventHeader:
	db 4 ; warps
	warp_def 4, 4, 3, SPROUT_TOWER_1F
	warp_def 6, 0, 4, SPROUT_TOWER_1F
	warp_def 3, 15, 5, SPROUT_TOWER_1F
	warp_def 14, 8, 1, SPROUT_TOWER_3F

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 15, 10, SIGNPOST_JUMPTEXT, UnknownText_0x1848c8

	db 3 ; person events
	person_event SPRITE_SAGE, 3, 10, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 4, TrainerSageNico, -1
	person_event SPRITE_SAGE, 14, 7, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 5, TrainerSageEdmond, -1
	itemball_event 1, 1, X_ACCURACY, 1, EVENT_SPROUT_TOWER2F_X_ACCURACY

TrainerSageNico:
	trainer EVENT_BEAT_SAGE_NICO, SAGE, NICO, SageNicoSeenText, SageNicoBeatenText, 0, SageNicoScript

SageNicoScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1847ff

TrainerSageEdmond:
	trainer EVENT_BEAT_SAGE_EDMOND, SAGE, EDMOND, SageEdmondSeenText, SageEdmondBeatenText, 0, SageEdmondScript

SageEdmondScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x18486f

SageNicoSeenText:
	text "However hard we"
	line "battle, the tower"
	cont "will stand strong."
	done

SageNicoBeatenText:
	text "I fought hard but"
	line "I'm too weak."
	done

UnknownText_0x1847ff:
	text "The flexible pil-"
	line "lar protects the"

	para "tower, even from"
	line "earthquakes."
	done

SageEdmondSeenText:
	text "…Sway like leaves"
	line "in the wind…"
	done

SageEdmondBeatenText:
	text "Oh, I'm weak!"
	done

UnknownText_0x18486f:
	text "I tried to copy"
	line "Bellsprout's"

	para "gentle movements"
	line "for battle…"

	para "But I didn't train"
	line "well enough."
	done

UnknownText_0x1848c8:
	text "A #mon statue…"

	para "It looks very"
	line "distinguished."
	done
