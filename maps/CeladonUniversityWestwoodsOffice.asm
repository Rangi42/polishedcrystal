CeladonUniversityWestwoodsOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3,  5, CELADON_UNIVERSITY_2F, 5
	warp_event  4,  5, CELADON_UNIVERSITY_2F, 5

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost1Text
	bg_event  3,  0, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeSignpost2Text
	bg_event  4,  1, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText
	bg_event  5,  1, BGEVENT_JUMPTEXT, CeladonUniversityWestwoodsOfficeBookshelfText

	def_object_events
	object_event  4,  3, SPRITE_CHILD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonUniversityWestwoodsOfficeChildScript, -1
	object_event  1,  4, SPRITE_BOOK_PAPER_POKEDEX, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptext, CeladonUniversityWestwoodsOfficeBookText, -1

CeladonUniversityWestwoodsOfficeChildScript:
	checkevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text2
	faceplayer
	opentext
	writetext .Text1
	promptbutton
	verbosegiveitem RAGECANDYBAR
	iffalse_endtext
	setevent EVENT_GOT_RAGECANDYBAR_IN_UNIVERSITY
	jumpthisopenedtext

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
