FuchsiaPokeCenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  5,  7, FUCHSIA_CITY, 4
	warp_event  6,  7, FUCHSIA_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_READ, PokemonJournalJanineScript

	def_object_events
	object_event  6,  3, SPRITE_JANINE_IMPERSONATOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, JanineImpersonatorScript, -1
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaPokeCenter1FCooltrainerMText, -1
	object_event  1,  4, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, FuchsiaPokeCenter1FCooltrainerFText, -1

	object_const_def
	const FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR

PokemonJournalJanineScript:
	setflag ENGINE_READ_JANINE_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Leader Janine!"

	para "Janine was said to"
	line "be a fan of the"

	para "#mon zoo in"
	line "Fuchsia City"
	cont "as a child."
	done

JanineImpersonatorScript:
	showtextfaceplayer .Text1
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, .SpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_JANINE
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Text2
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, .SpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_CUTE_GIRL
	special MapCallbackSprites_LoadUsedSpritesGFX
	end

.Text1:
	text "I'm Janine! Hocus-"
	line "pocus… Poof!"
	done

.Text2:
	text "See? I look just"
	line "like her now!"
	done

.SpinMovement:
rept 3
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
endr
	turn_head_down
	step_end

FuchsiaPokeCenter1FCooltrainerMText:
	text "Hey! You have a"
	line "brand new kind of"
	cont "#dex."

	para "Did Prof.Oak give"
	line "that to you?"
	done

FuchsiaPokeCenter1FCooltrainerFText:
	text "I got quite a"
	line "shock at the Gym."

	para "There were all"
	line "these girls who"
	cont "looked identical."
	done
