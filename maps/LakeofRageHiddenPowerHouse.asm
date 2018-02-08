LakeofRageHiddenPowerHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, LAKE_OF_RAGE, 1
	warp_event  3,  7, LAKE_OF_RAGE, 1

	db 0 ; coord events

	db 3 ; bg events
	bg_event  5,  1, SIGNPOST_JUMPSTD, radio2
	bg_event  6,  1, SIGNPOST_JUMPSTD, difficultbookshelf
	bg_event  7,  1, SIGNPOST_JUMPSTD, difficultbookshelf

	db 1 ; object events
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, HiddenPowerGuy, -1

HiddenPowerGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM10_HIDDEN_POWER
	iftrue .AlreadyGotItem
	writetext .Text1
	buttonsound
	verbosegivetmhm TM_HIDDEN_POWER
	setevent EVENT_GOT_TM10_HIDDEN_POWER
	writetext .Text2
	waitbutton
	jump .CheckHiddenPower
.AlreadyGotItem:
	writetext .Text4
	waitbutton
.CheckHiddenPower
	writetext .Text3
	yesorno
	iffalse_jumpopenedtext .Text7
	writetext .Text5
	buttonsound
	special Special_HiddenPowerGuru
	iffalse_jumpopenedtext .Text4
	ifequal $1, .Egg
	thisopenedtext

	text "I can sense it…"

	para "Your @"
	text_from_ram StringBuffer3
	text ""
	line "has a Hidden Power"
	cont "of @"
	text_from_ram StringBuffer1
	text "!"
	done

.Egg:
	thisopenedtext

	text "An Egg has not yet"
	line "developed a Hidden"
	cont "Power…"
	done

.Text1:
	text "…You have strayed"
	line "far…"

	para "Here I have medi-"
	line "tated. Inside me,"

	para "a new power has"
	line "been awakened."

	para "Let me share my"
	line "power with your"
	cont "#mon."

	para "Take this, child."
	done

.Text2:
	text "Do you see it? It"
	line "is Hidden Power!"

	para "It draws out the"
	line "power of #mon"
	cont "for attacking."

	para "Remember this: its"
	line "type depends on"
	cont "the #mon"
	cont "using it."
	done

.Text3:
	text "Shall I divine"
	line "the Hidden Power"
	cont "of your #mon?"
	done

.Text4:
	text "I am meditating…"
	done

.Text5:
	text "Which #mon's"
	line "Hidden Power"
	cont "should I find?"
	done

.Text7:
	text "…Very well…"
	done
