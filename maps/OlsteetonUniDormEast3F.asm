OlsteetonUniDormEast3F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  1,  0, OLSTEETON_UNI_DORM_EAST_2F, 2
	warp_event 10,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_2, 1
	warp_event 14,  0, OLSTEETON_UNI_DORM_EAST_3F_ROOM_3, 1
	warp_event  9,  0, OLSTEETON_UNI_DORM_EAST_ELEVATOR, 1
	; warp_event 17,  3, OLSTEETON_UNI_DORM_EAST_ROOF, 1



	def_coord_events

	def_bg_events
; 	bg_event 11,  1, BGEVENT_JUMPTEXT, OlsteetonUniDormEast1FBookshelf1Text
; 	bg_event 10,  1, BGEVENT_READ, OlsteetonUniDormEast1FBookshelf2
; 	bg_event  0,  9, BGEVENT_RIGHT, OlsteetonUniDormEast1FComputer

	def_object_events
; 	object_event 10,  6, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, OlsteetonUniDormEast1FNeeshaScript, -1
; 	object_event  5,  1, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FLassText, -1
; 	object_event  4,  1, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FRichBoyText, -1
; 	object_event  1,  4, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FCooltrainerfText, -1
; 	object_event  2,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FSuper_nerd1Text, -1
; 	object_event  5,  7, SPRITE_BUG_MANIAC, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonUniDormEast1FSuper_nerd2Text, -1

	object_const_def
; 	const OlsteetonUniDormEast1F_NEESHA

; OlsteetonUniDormWest1FRichBoyText:
; 	text "My roommate is"
;   line "super into"
;   cont "legendary #mon."

;   para "For me, I just"
;   line "think Fairy"
;   cont "types are cool!"
; 	done

; OlsteetonUniDormWest1FCooltrainerfText:
; 	text "What's even the"
;   line "point of my" 

;   para "Native Bio-"
;   line "logy degree?"

;   para "I'm gonna have"
;   line "to move clear"

;   para "to Unova if I"
;   line "want to find"
;   cont "a job!"

;   para "Stupid Mega-"
;   line "Corp!"
; 	done

; OlsteetonUniDormWest1FSuper_nerd1Text:
; 	text "No one truly ap-"
;   line "preciates Bug"
;   cont "#mon like me."

;   para "And Ast. Asher,"
;   line "I suppose..."
; 	done

; OlsteetonUniDormWest1FSuper_nerd2Text:
; 	text "Who cares about"
;   line "Bug types?!"

;   para "Where are all"
;   line "the Dragons?!"

;   para "We need more"
;   line "research on"
;   cont "them!"
; 	done

; OlsteetonUniDormWest1FBookshelf1Text:
; 	text "A reccreational"
;   line "bookshelf."

;   para "'Not Yet Night,'"
;   line "'Not-Old Moon,'"

;   para "'Hidden Sun,' &"
;   line "'Smashing Sunrise'"

;   para "Some of these"
;   line "sound semi"
;   cont "familiar..."
; 	done

; OlsteetonUniDormWest1FBookshelf2:
; 	opentext
; 	writetext .Text1
; 	waitbutton
; 	checkevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
; 	iftruefwd .GotItem
; 	verbosegiveitem PP_MAX
; 	iffalsefwd .Done
; 	setevent EVENT_GOT_PP_MAX_IN_UNIVERSITY
; .Done
; 	endtext

; .GotItem
; 	jumpopenedtext .Text2

; .Text1:
; 	text "This book has a"
; 	line "secret compartment"

; 	para "where the pages"
; 	line "should be!"
; 	done

; .Text2:
; 	text "Too bad--it's"
; 	line "empty."
; 	done

; OlsteetonUniDormWest1FComputer:
; 	jumpthistext

; 	text "Finally! A PC"
;   line "where it looks"

;   para "like someone is"
;   line "actually studying!"

;   para "..."

;   para "No, wait."
;   line "It's actually"

;   para "Not-Giant"
;   line "Fortress..."
; 	done
OlsteetonUniDormEast3FText:
	text "3rd Floor"
	done
OlsteetonUniDormEast3FRoom1Text:
	text "Room 301"
	line "Resident Advisor"
	cont "David"
	done

OlsteetonUniDormEast3FRoom2Text:
	text "Room 302"
	line "Shane"
	done

OlsteetonUniDormEast3FRoom3Text:
	text "Room 303"
	line "Elijah"
	done