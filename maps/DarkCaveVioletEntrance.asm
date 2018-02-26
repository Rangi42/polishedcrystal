DarkCaveVioletEntrance_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 3 ; warp events
	warp_event  3, 15, ROUTE_31, 3
	warp_event 17,  1, DARK_CAVE_BLACKTHORN_ENTRANCE, 2
	warp_event 35, 33, ROUTE_46, 3

	db 1 ; coord events
	coord_event  5,  2, 0, DarkCaveVioletEntranceFalknerTrigger

	db 1 ; bg events
	bg_event 26,  3, SIGNPOST_ITEM + ELIXER, EVENT_DARK_CAVE_VIOLET_ENTRANCE_HIDDEN_ELIXER

	db 11 ; object events
	object_event 10,  2, SPRITE_URSARING, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DARK_CAVE_URSARING
	object_event  9,  2, SPRITE_PIDGEOTTO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DARK_CAVE_PIDGEOTTO
	object_event  8,  2, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_DARK_CAVE_FALKNER
	itemball_event  6,  8, POTION, 1, EVENT_DARK_CAVE_VIOLET_ENTRANCE_POTION
	smashrock_event 16, 14
	smashrock_event 27, 6
	smashrock_event  7, 14
	smashrock_event 36, 31
	itemball_event 36, 22, DUSK_STONE, 1, EVENT_DARK_CAVE_VIOLET_ENTRANCE_DUSK_STONE
	itemball_event 35,  9, HYPER_POTION, 1, EVENT_DARK_CAVE_VIOLET_ENTRANCE_HYPER_POTION
	itemball_event 30, 28, DIRE_HIT, 1, EVENT_DARK_CAVE_VIOLET_ENTRANCE_DIRE_HIT

	const_def 1 ; object constants
	const DARKCAVEVIOLETENTRANCE_URSARING
	const DARKCAVEVIOLETENTRANCE_PIDGEOTTO
	const DARKCAVEVIOLETENTRANCE_FALKNER

DarkCaveVioletEntranceFalknerTrigger:
	waitsfx
	checkdarkness
	iftrue .Darkness
	special SaveMusic
	playmusic MUSIC_JOHTO_TRAINER_BATTLE
	pause 40
	opentext
	writetext DarkCaveVioletEntranceFalknerAttackText
	pause 30
	closetext
	cry PIDGEOTTO
	waitsfx
	playsound SFX_TACKLE
	applymovement DARKCAVEVIOLETENTRANCE_PIDGEOTTO, DarkCaveVioletEntranceMovementData_PidgeottoAttack
	waitsfx
	pause 30
	cry URSARING
	pause 30
	disappear DARKCAVEVIOLETENTRANCE_URSARING
	pause 15
	special RestoreMusic
	opentext
	writetext DarkCaveVioletEntranceFalknerReturnText
	pause 30
	closetext
	disappear DARKCAVEVIOLETENTRANCE_PIDGEOTTO
	pause 20
	applymovement DARKCAVEVIOLETENTRANCE_FALKNER, DarkCaveVioletEntranceMovementData_FalknerHeadBack
	showemote EMOTE_SHOCK, DARKCAVEVIOLETENTRANCE_FALKNER, 15
	showtext DarkCaveVioletEntranceFalknerIntroText
	follow PLAYER, DARKCAVEVIOLETENTRANCE_FALKNER
	applymovement PLAYER, DarkCaveVioletEntranceMovementData_PlayerStepAside
	stopfollow
	turnobject PLAYER, DOWN
	applymovement DARKCAVEVIOLETENTRANCE_FALKNER, DarkCaveVioletEntranceMovementData_FalknerLeave
	disappear DARKCAVEVIOLETENTRANCE_FALKNER
	pause 15
	clearevent EVENT_VIOLET_GYM_FALKNER
	setmapscene VIOLET_GYM, $1
	setscene $1
	end

.Darkness:
	showtext DarkCaveVioletEntranceFalknerDarknessText
	applyonemovement PLAYER, step_left
	end

DarkCaveVioletEntranceMovementData_PidgeottoAttack:
	fix_facing
	big_step_right
	big_step_left
	remove_fixed_facing
	step_end

DarkCaveVioletEntranceMovementData_FalknerHeadBack:
DarkCaveVioletEntranceMovementData_PlayerStepAside:
	step_left
	step_left
	step_end

DarkCaveVioletEntranceMovementData_FalknerLeave:
	step_down
	step_left
	step_down
	step_down
	step_down
	step_down
	step_end

DarkCaveVioletEntranceFalknerAttackText:
	text "Falkner: Use Wing"
	line "Attack, Pidgeotto!"
	done

DarkCaveVioletEntranceFalknerReturnText:
	text "Good job,"
	line "Pidgeotto."
	done

DarkCaveVioletEntranceFalknerIntroText:
	text "Oh! You must be"
	line "a trainer."

	para "I'm Falkner, the"
	line "Violet #mon"
	cont "Gym Leader."

	para "I don't explore"
	line "caves for fun,"

	para "but that Ursaring"
	line "was attacking"

	para "trainers too weak"
	line "to defend them-"
	cont "selves."

	para "As a Gym Leader,"
	line "it's my job to"

	para "handle this sort"
	line "of situation."

	para "So you're here to"
	line "earn a badge?"

	para "Then meet me at"
	line "the Violet Gym."
	done

DarkCaveVioletEntranceFalknerDarknessText:
	text "Falkner: Is"
	line "someone there?"

	para "Don't come any"
	line "closer!"

	para "It's too dark, you"
	line "could get hurt."
	done
