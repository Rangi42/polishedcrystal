OlsteetonUniClockTower2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  8,  0, OLSTEETON_UNI_CLOCK_TOWER_1F, 3
	warp_event  3,  5, OLSTEETON_UNI_CLOCK_TOWER_3F, 1


	def_coord_events

	def_bg_events
	bg_event  3,  3, BGEVENT_JUMPTEXT, OlsteetonUniClockTower2FStatueText

	def_object_events
	; object_event 10,  2, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerSageNico, -1
	; object_event  1,  1, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 5, GenericTrainerSageEdmond, -1
	itemball_event  4,  6, X_ACCURACY, 1, EVENT_SPROUT_TOWER2F_X_ACCURACY

; GenericTrainerSageNico:
; 	generictrainer SAGE, NICO, EVENT_BEAT_SAGE_NICO, SageNicoSeenText, SageNicoBeatenText

; 	text "The flexible pil-"
; 	line "lar protects the"

; 	para "tower, even from"
; 	line "earthquakes."
; 	done

; GenericTrainerSageEdmond:
; 	generictrainer SAGE, EDMOND, EVENT_BEAT_SAGE_EDMOND, SageEdmondSeenText, SageEdmondBeatenText

; 	text "I tried to copy"
; 	line "Bellsprout's"

; 	para "gentle movements"
; 	line "for battle…"

; 	para "But I didn't train"
; 	line "well enough."
; 	done

; SageNicoSeenText:
; 	text "However hard we"
; 	line "battle, the tower"
; 	cont "will stand strong."
; 	done

; SageNicoBeatenText:
; 	text "I fought hard but"
; 	line "I'm too weak."
; 	done

; SageEdmondSeenText:
; 	text "…Sway like leaves"
; 	line "in the wind…"
; 	done

; SageEdmondBeatenText:
; 	text "Oh, I'm weak!"
; 	done

OlsteetonUniClockTower2FStatueText:
	text "It's a"
	line "giant hourglass."
	done
