OlsteetonUni_MapScriptHeader:
	def_scene_scripts

	def_callbacks


	def_warp_events
	warp_event  2, 10, OLSTEETON_UNI_GATE, 3
	warp_event  2, 11, OLSTEETON_UNI_GATE, 4
	warp_event  6,  7, OLSTEETON_UNI_LIBRARY_1F, 2
	warp_event 17,  7, OLSTEETON_UNI_SCIENCE_CENTER, 1
	; warp_event  7,  0, OLSTEETON_UNI_DINING_HALL, 1
	; warp_event 19,  8, OLSTEETON_UNI_CLASSROOM_1, 1
	; warp_event 19,  8, OLSTEETON_UNI_CLASSROOM_2, 1
	; warp_event 19,  8, OLSTEETON_UNI_CLASSROOM_3, 1
	; warp_event 19,  8, OLSTEETON_UNI_CLASSROOM_4, 1
	; warp_event  7,  8, OLSTEETON_UNI_NURSE_DEPT, 1

	def_coord_events


	def_bg_events
	; bg_event 22,  8, BGEVENT_JUMPTEXT, AzaleaTownSignText
	; bg_event 18,  8, BGEVENT_JUMPTEXT, KurtsHouseSignText
	; bg_event 30,  6, BGEVENT_JUMPTEXT, AzaleaGymSignText
	; bg_event 24, 16, BGEVENT_JUMPTEXT, SlowpokeWellSignText
	; bg_event 32, 16, BGEVENT_JUMPTEXT, CharcoalKilnSignText
	; bg_event  8,  8, BGEVENT_JUMPTEXT, AzaleaTownIlexForestSignText
	; bg_event  3, 18, BGEVENT_JUMPTEXT, AzaleaTownAdvancedTipsSignText
	; bg_event 19, 21, BGEVENT_ITEM + FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

	def_object_events
	fruittree_event 21,  5, FRUITTREE_AZALEA_TOWN, WHT_APRICORN, PAL_NPC_WHITE

	object_const_def



; AzaleaTownSignText:
; 	text "Azalea Town"
; 	line "Where People and"

; 	para "#mon Live in"
; 	line "Happy Harmony"
; 	done

; KurtsHouseSignText:
; 	text "Kurt's House"
; 	done

; AzaleaGymSignText:
; 	text "Azalea Town"
; 	line "#mon Gym"
; 	cont "Leader: Bugsy"

; 	para "The Walking"
; 	line "Bug #mon"
; 	cont "Encyclopedia"
; 	done

; SlowpokeWellSignText:
; 	text "Slowpoke Well"

; 	para "Also known as the"
; 	line "Rainmaker Well."

; 	para "Locals believe"
; 	line "that a Slowpoke's"
; 	cont "yawn summons rain."

; 	para "Records show that"
; 	line "a Slowpoke's yawn"

; 	para "ended a drought"
; 	line "400 years ago."
; 	done

; CharcoalKilnSignText:
; 	text "Charcoal Kiln"
; 	done

; AzaleaTownIlexForestSignText:
; 	text "Ilex Forest"

; 	para "Enter through the"
; 	line "gate."
; 	done

; AzaleaTownAdvancedTipsSignText:
; 	text "Advanced Tips!"

; 	para "The Switch battle"
; 	line "style lets you"

; 	para "know which #-"
; 	line "mon an opponent is"
; 	cont "about to send out,"

; 	para "but the Predict"
; 	line "style does not!"
; 	done

; AzaleaTownWoosterText:
; 	text "Wooster: Gugyoo…"
; 	done
