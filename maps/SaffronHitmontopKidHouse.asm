SaffronHitmontopKidHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, SAFFRON_CITY, 19
	warp_event  3,  7, SAFFRON_CITY, 19

	db 0 ; coord events

	db 0 ; bg events

	db 2 ; object events
	object_event  5,  4, SPRITE_CHILD, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_BROWN, PERSONTYPE_SCRIPT, 0, SaffronHitmontopKidHouseChildScript, -1
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 2, 2, -1, -1, PAL_NPC_RED, PERSONTYPE_SCRIPT, 0, SaffronHitmontopKidHouseTeacherScript, -1

	const_def 1 ; object constants
	const SAFFRONHITMONTOPKIDHOUSE_CHILD

SaffronHitmontopKidHouseChildScript:
	showtextfaceplayer .Text1
	applymovement SAFFRONHITMONTOPKIDHOUSE_CHILD, .SpinMovement
	faceplayer
	pause 20
	checkpoke HITMONTOP
	iffalse .Done
	showemote EMOTE_SHOCK, SAFFRONHITMONTOPKIDHOUSE_CHILD, 15
	showtext .Text2
	applymovement SAFFRONHITMONTOPKIDHOUSE_CHILD, .Spin2Movement
	pause 20
	showtext .Text3
	setevent EVENT_SHOWED_SAFFRON_KID_HITMONTOP
.Done
	end

.Text1:
	text "Top! Top!"
	line "Hit-mon-TOP!"
	done

.Text2:
	text "Top… Top? TOP!"
	line "HITMONTOP! ♥"
	done

.Text3:
	text "That's a"
	line "Hitmontop!"
	cont "Oh boy! So cool!"
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
.Spin2Movement:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

SaffronHitmontopKidHouseTeacherScript:
	checkevent EVENT_GOT_AIR_BALLOON_FROM_SAFFRON
	iftrue_jumptextfaceplayer .Text3
	faceplayer
	opentext
	checkevent EVENT_SHOWED_SAFFRON_KID_HITMONTOP
	iffalse_jumpopenedtext .Text1
	writetext .Text2
	buttonsound
	verbosegiveitem AIR_BALLOON
	iffalse_endtext
	setevent EVENT_GOT_AIR_BALLOON_FROM_SAFFRON
	thisopenedtext

.Text3:
	text "My son finally got"
	line "to meet his favor-"
	cont "ite #mon."
	done

.Text1:
	text "My son likes to"
	line "pretend he's a"
	cont "#mon."

	para "It gets a little"
	line "embarrassing some-"
	cont "times."

	para "Maybe if he saw a"
	line "real Hitmontop he"
	cont "would calm down…"
	done

.Text2:
	text "Oh my! You made my"
	line "son so happy!"

	para "It's not much of a"
	line "thank-you, but I'd"

	para "like you to have"
	line "this."
	done
