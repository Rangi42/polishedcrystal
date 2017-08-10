FuchsiaPokeCenter1F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

FuchsiaPokeCenter1F_MapEventHeader:

.Warps: db 3
	warp_def $7, $5, 4, FUCHSIA_CITY
	warp_def $7, $6, 4, FUCHSIA_CITY
	warp_def $7, $0, 1, POKECENTER_2F

.XYTriggers: db 0

.Signposts: db 1
	signpost 1, 10, SIGNPOST_READ, PokemonJournalJanineScript

.PersonEvents: db 4
	person_event SPRITE_JANINE_IMPERSONATOR, 3, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, JanineImpersonatorScript, -1
	person_event SPRITE_NURSE, 1, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_JUMPSTD, 0, pokecenternurse, -1
	person_event SPRITE_COOLTRAINER_M, 4, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x196494, -1
	person_event SPRITE_COOLTRAINER_F, 4, 1, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, PERSONTYPE_JUMPTEXTFP, 0, UnknownText_0x1964dc, -1

const_value set 2
	const FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR

PokemonJournalJanineScript:
	setflag ENGINE_READ_JANINE_JOURNAL
	jumptext .Text

.Text:
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
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, .SpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_JANINE
	special MapCallbackSprites_LoadUsedSpritesGFX
	opentext
	writetext .Text2
	waitbutton
	closetext
	applymovement FUCHSIAPOKECENTER1F_JANINE_IMPERSONATOR, .SpinMovement
	faceplayer
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
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
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

UnknownText_0x196494:
	text "Hey! You have a"
	line "brand new kind of"
	cont "#dex."

	para "Did Prof.Oak give"
	line "that to you?"
	done

UnknownText_0x1964dc:
	text "I got quite a"
	line "shock at the Gym."

	para "There were all"
	line "these girls who"
	cont "looked identical."
	done
