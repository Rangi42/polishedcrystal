CeladonUniversityWestwoodsOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityWestwoodsOffice_MapEventHeader:

.Warps: db 2
	warp_def 5, 3, 5, CELADON_UNIVERSITY_2F
	warp_def 5, 4, 5, CELADON_UNIVERSITY_2F

.XYTriggers: db 0

.Signposts: db 4
	signpost 0, 2, SIGNPOST_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost1Text
	signpost 0, 3, SIGNPOST_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost2Text
	signpost 1, 4, SIGNPOST_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText
	signpost 1, 5, SIGNPOST_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText

.PersonEvents: db 2
	person_event SPRITE_CHILD, 3, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityWestwoodsOfficeChildScript, -1
	person_event SPRITE_BOOK, 4, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_COMMAND, jumptext, CeladonUniversityWestwoodsOfficeBookText, -1

CeladonUniversityWestwoodsOfficeChildScript:
	checkevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	buttonsound
	verbosegiveitem RAGECANDYBAR
	iffalse_endtext
	setevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	thisopenedtext

.Text2:
	text "I'll just buy some"
	line "ramen in the cafe-"
	cont "teria."
	done

.Text1:
	text "I was told there"
	line "would be free"
	cont "pizza here!"

	para "Where is it?"

	para "I'm so ANGRY!"

	para "…Maybe I should"
	line "quit snacking on"
if DEF(FAITHFUL)
	cont "RageCandyBars."
else
	cont "Cakes of Rage."
endc

	para "You can have this"
	line "one."
	done

CeladonUniversityWestwoodsOfficeBookText:
	text "Dear Diary,"

	para "My work compiling"
	line "entries for the"

	para "#dex continues"
	line "to be well-recei-"
	cont "ved."

	para "Proof that one"
	line "does not always"

	para "need to leave the"
	line "office to succeed!"

	para "Using reports sub-"
	line "mitted by others"

	para "gets the job done"
	line "just fine."
	done

CeladonUniversityWestwoodsOfficeSignpost1Text:
	text "It's a portrait of"
	line "Westwood I."
	done

CeladonUniversityWestwoodsOfficeSignpost2Text:
	text "It's a portrait of"
	line "Westwood III."
	done

CeladonUniversityWestwoodsOfficeBookshelfText:
	text "The Complete Works"
	line "of Prof.Westwood."

	para "…Might give that"
	line "one a miss."
	done
