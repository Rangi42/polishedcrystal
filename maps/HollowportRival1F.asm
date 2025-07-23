HollowportRival1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4,  7, HOLLOWPORT, 3
	warp_event  5,  7, HOLLOWPORT, 3
	warp_event  5,  0, HOLLOWPORT_RIVAL_2F, 1

	def_coord_events

	def_bg_events
	bg_event 10,  1, BGEVENT_UP, RivalsFridgeScript
	bg_event  8,  1, BGEVENT_JUMPTEXT, RivalsSinkText
	bg_event  9,  1, BGEVENT_JUMPTEXT, RivalsStoveText
	bg_event  6,  1, BGEVENT_UP, RivalsTVScript

	def_object_events
	; object_event  2,  4, SPRITE_DAD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, RivalsDadScript, -1

; RivalsDadScript:
; 	faceplayer
; 	opentext
; 	jumpopenedtext RivalsDadHelpingText

; .RivalInside
; 	jumpopenedtext RivalsDadInsideText

; .RivalTraining
; 	jumpopenedtext RivalsDadTrainingText

; RivalsDadInsideText:
; 	text "Hi, <PLAYER>!"
; 	line "Rival is upstairs."

; 	para "She's playing"
; 	line "with her #mon"
; 	cont "as usual."
; 	done

RivalsDadHelpingText:
	text "Hi, <PLAYER>!"
	line "Gwen isn't here."

	para "She's been busy"
	line "helping the prof-"
	cont "essor."
	done

; RivalsDadTrainingText:
; 	text "Hi, <PLAYER>!"
; 	line "Rival isn't here."

; 	para "She's collecting"
; 	line "Badges all over"
; 	cont "Johto!"
; 	done

RivalsFridgeScript:
	jumpthistext

	text "Let's see what's"
	line "in the fridge…"

	para "Fresh Water and"
	line "rice balls!"
	done

RivalsSinkText:
	text "The sink is spot-"
	line "less."
	done

RivalsStoveText:
	text "Curry is simmering"
	line "on the stove."
	done

RivalsTVScript:
	jumpthistext

	text "There's a movie on"
	line "TV: A girl with"

	para "her hair in pig-"
	line "tails is walking"
	cont "up a brick road."

	para "I'd better get"
	line "going too!"
	done
