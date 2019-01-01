FuchsiaPokeCenter1F_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  5,  7, FUCHSIA_CITY, 4
	warp_event  6,  7, FUCHSIA_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	db 0 ; coord events

	db 1 ; bg events
	bg_event 10,  1, SIGNPOST_READ, PokemonJournalJanineScript

	db 4 ; object events
	object_event  6,  3, SPRITE_NEW_BARK_LYRA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_SCRIPT, 0, JanineImpersonatorScript, -1
	pc_nurse_event  5, 1
	object_event  9,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, FuchsiaPokeCenter1FCooltrainerMText, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, FuchsiaPokeCenter1FCooltrainerFText, -1

	const_def 1 ; object constants
	const FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR

PokemonJournalJanineScript:
	setflag ENGINE_READ_JANINE_JOURNAL
	thistext

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
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_JANINE
	special MapCallbackSprites_LoadUsedSpritesGFX
	showtext .Text2
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, .SpinMovement
	faceplayer
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LASS
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
