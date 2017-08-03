CeladonUniversityWestwoodsOffice_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

CeladonUniversityWestwoodsOffice_MapEventHeader:

.Warps: db 2
	warp_def $5, $3, 5, CELADON_UNIVERSITY_2F
	warp_def $5, $4, 5, CELADON_UNIVERSITY_2F

.XYTriggers: db 0

.Signposts: db 4
	signpost 0, 2, SIGNPOST_READ, CeladonUniversityWestwoodsOfficeSignpost1
	signpost 0, 3, SIGNPOST_READ, CeladonUniversityWestwoodsOfficeSignpost2
	signpost 1, 4, SIGNPOST_READ, CeladonUniversityWestwoodsOfficeBookshelf
	signpost 1, 5, SIGNPOST_READ, CeladonUniversityWestwoodsOfficeBookshelf

.PersonEvents: db 2
	person_event SPRITE_CHILD, 3, 4, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, CeladonUniversityWestwoodsOfficeChildScript, -1
	person_event SPRITE_BOOK_UNOWN_R, 4, 1, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, CeladonUniversityWestwoodsOfficeBookScript, -1

CeladonUniversityWestwoodsOfficeChildScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	iftrue .GotItem
	writetext .Text1
	buttonsound
	verbosegiveitem RAGECANDYBAR
	iffalse .Done
	setevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
.GotItem:
	writetext .Text2
	waitbutton
.Done:
	closetext
	end

.Text1:
	text "I was told there"
	line "would be free"
	cont "pizza here!"

	para "Where is it?"

	para "I'm so ANGRY!"

	para "…Maybe I should"
	line "quit snacking on"
	cont "Cakes of Rage."

	para "You can have this"
	line "one."
	done

.Text2:
	text "I'll just buy some"
	line "ramen in the cafe-"
	cont "teria."
	done

CeladonUniversityWestwoodsOfficeBookScript:
	jumptext .Text

.Text:
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

CeladonUniversityWestwoodsOfficeSignpost1:
	jumptext .Text

.Text:
	text "It's a portrait of"
	line "Westwood I."
	done

CeladonUniversityWestwoodsOfficeSignpost2:
	jumptext .Text

.Text:
	text "It's a portrait of"
	line "Westwood III."
	done

CeladonUniversityWestwoodsOfficeBookshelf:
	jumptext .Text

.Text:
	text "The Complete Works"
	line "of Prof.Westwood."

	para "…Might give that"
	line "one a miss."
	done
