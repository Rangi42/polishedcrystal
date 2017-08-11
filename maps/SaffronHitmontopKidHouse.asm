SaffronHitmontopKidHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SaffronHitmontopKidHouse_MapEventHeader:

.Warps: db 2
	warp_def $7, $2, 19, SAFFRON_CITY
	warp_def $7, $3, 19, SAFFRON_CITY

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 2
	person_event SPRITE_CHILD, 4, 5, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SaffronHitmontopKidHouseChildScript, -1
	person_event SPRITE_TEACHER, 4, 2, SPRITEMOVEDATA_STANDING_LEFT, 2, 2, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SaffronHitmontopKidHouseTeacherScript, -1

const_value set 2
	const SAFFRONHITMONTOPKIDHOUSE_CHILD

SaffronHitmontopKidHouseChildScript:
	showtextfaceplayer SaffronHitmontopKidHouseChildText1
	applymovement SAFFRONHITMONTOPKIDHOUSE_CHILD, SaffronHitmontopKidHouseChildSpinMovement
	faceplayer
	pause 20
	checkpoke HITMONTOP
	iffalse .Done
	showemote EMOTE_SHOCK, SAFFRONHITMONTOPKIDHOUSE_CHILD, 15
	showtext SaffronHitmontopKidHouseChildText2
	applymovement SAFFRONHITMONTOPKIDHOUSE_CHILD, SaffronHitmontopKidHouseSpin2Movement
	pause 20
	showtext SaffronHitmontopKidHouseChildText3
	setevent EVENT_SHOWED_SAFFRON_KID_HITMONTOP
.Done
	end

SaffronHitmontopKidHouseTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_AIR_BALLOON_FROM_SAFFRON
	iftrue .GotItem
	checkevent EVENT_SHOWED_SAFFRON_KID_HITMONTOP
	iffalse .NoShow
	writetext SaffronHitmontopKidHouseTeacherText2
	buttonsound
	verbosegiveitem AIR_BALLOON
	iffalse .Done
	setevent EVENT_GOT_AIR_BALLOON_FROM_SAFFRON
.GotItem:
	writetext SaffronHitmontopKidHouseTeacherText3
	waitbutton
.Done:
	closetext
	end

.NoShow:
	jumpopenedtext SaffronHitmontopKidHouseTeacherText1

SaffronHitmontopKidHouseChildText1:
	text "Top! Top!"
	line "Hit-mon-TOP!"
	done

SaffronHitmontopKidHouseChildText2:
	text "Top… Top? TOP!"
	line "HITMONTOP! ♥"
	done

SaffronHitmontopKidHouseChildText3:
	text "That's a"
	line "Hitmontop!"
	cont "Oh boy! So cool!"
	done

SaffronHitmontopKidHouseTeacherText1:
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

SaffronHitmontopKidHouseTeacherText2:
	text "Oh my! You made my"
	line "son so happy!"

	para "It's not much of a"
	line "thank-you, but I'd"

	para "like you to have"
	line "this."
	done

SaffronHitmontopKidHouseTeacherText3:
	text "My son finally got"
	line "to meet his favor-"
	cont "ite #mon."
	done

SaffronHitmontopKidHouseChildSpinMovement:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
SaffronHitmontopKidHouseSpin2Movement:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end
