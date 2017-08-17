MountMortar2FInside_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

MountMortar2FInside_MapEventHeader:

.Warps: db 2
	warp_def 33, 17, 4, MOUNT_MORTAR_1F_OUTSIDE
	warp_def 5, 3, 6, MOUNT_MORTAR_1F_INSIDE

.XYTriggers: db 0

.Signposts: db 1
	signpost 8, 24, SIGNPOST_ITEM + FULL_RESTORE, EVENT_MOUNT_MORTAR_2F_INSIDE_HIDDEN_FULL_RESTORE

.PersonEvents: db 7
	itemball_event 22, 28, MAX_POTION, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION
	itemball_event 33, 2, RARE_CANDY, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_RARE_CANDY
	tmhmball_event 17, 19, TM_AERIAL_ACE, EVENT_MOUNT_MORTAR_2F_INSIDE_TM_AERIAL_ACE
	itemball_event 5, 16, DRAGON_SCALE, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_DRAGON_SCALE
	itemball_event 11, 9, ELIXER, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_ELIXER
	itemball_event 5, 28, ESCAPE_ROPE, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_ESCAPE_ROPE
	person_event SPRITE_SUPER_NERD, 26, 13, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 2, TrainerSupernerdHugh, -1

TrainerSupernerdHugh:
	trainer EVENT_BEAT_SUPER_NERD_HUGH, SUPER_NERD, HUGH, SupernerdHughSeenText, SupernerdHughBeatenText, 0, SupernerdHughScript

SupernerdHughScript:
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x7e10e

SupernerdHughSeenText:
	text "Yo! Markus!"
	done

SupernerdHughBeatenText:
	text "Sorry, my mistake."
	done

UnknownText_0x7e10e:
	text "I'm investigating"
	line "Mt.Mortar, but my"
	cont "pal's gone AWOL."

	para "Have you seen a"
	line "trainer who has a"

	para "Slowpoke that can"
	line "use Strength?"
	done
