LakeofRageHiddenPowerHouse_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

LakeofRageHiddenPowerHouse_MapEventHeader:

.Warps: db 2
	warp_def 7, 2, 1, LAKE_OF_RAGE
	warp_def 7, 3, 1, LAKE_OF_RAGE

.XYTriggers: db 0

.Signposts: db 3
	signpost 1, 5, SIGNPOST_JUMPSTD, radio2
	signpost 1, 6, SIGNPOST_JUMPSTD, difficultbookshelf
	signpost 1, 7, SIGNPOST_JUMPSTD, difficultbookshelf

.PersonEvents: db 1
	person_event SPRITE_FISHER, 3, 2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, HiddenPowerGuy, -1

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
	if_equal $0, .Cancel
	if_equal $1, .Egg
	jumpopenedtext .Text6

.Cancel:
	jumpopenedtext .Text4

.Egg:
	jumpopenedtext .Text8

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

.Text6:
	text "I can sense it…"

	para "Your @"
	text_from_ram StringBuffer3
	text ""
	line "has a Hidden Power"
	cont "of @"
	text_from_ram StringBuffer1
	text "!"
	done

.Text7:
	text "…Very well…"
	done

.Text8:
	text "An Egg has not yet"
	line "developed a Hidden"
	cont "Power…"
	done
