MountMortar2FInside_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 17, 33, MOUNT_MORTAR_1F_OUTSIDE, 4
	warp_event  3,  5, MOUNT_MORTAR_1F_INSIDE, 6

	def_coord_events

	def_bg_events
	bg_event 24,  8, BGEVENT_ITEM + FULL_RESTORE, EVENT_MOUNT_MORTAR_2F_INSIDE_HIDDEN_FULL_RESTORE

	def_object_events
	itemball_event 28, 22, MAX_POTION, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION
	itemball_event  2, 33, RARE_CANDY, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_RARE_CANDY
	tmhmball_event 19, 17, TM_AERIAL_ACE, EVENT_MOUNT_MORTAR_2F_INSIDE_TM_AERIAL_ACE
	itemball_event 16,  5, DRAGON_SCALE, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_DRAGON_SCALE
	itemball_event  9, 11, ELIXIR, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_ELIXIR
	itemball_event 28,  5, ESCAPE_ROPE, 1, EVENT_MOUNT_MORTAR_2F_INSIDE_ESCAPE_ROPE
	object_event 13, 26, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSupernerdHugh, -1

GenericTrainerSupernerdHugh:
	generictrainer SUPER_NERD, HUGH, EVENT_BEAT_SUPER_NERD_HUGH, SupernerdHughSeenText, SupernerdHughBeatenText

	text "I'm investigating"
	line "Mt.Mortar, but my"
	cont "pal's gone AWOL."

	para "Have you seen a"
	line "trainer who has a"

	para "Slowpoke that can"
	line "use Strength?"
	done

SupernerdHughSeenText:
	text "Yo! Markus!"
	done

SupernerdHughBeatenText:
	text "Sorry, my mistake."
	done

