Route102_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  4, 12, ROUTE_101_102_GATE, 3
	warp_event  4, 13, ROUTE_101_102_GATE, 4
	warp_event 25,  4, ROUTE_102_OLSTEETON_GATE, 1
	warp_event 25,  5, ROUTE_102_OLSTEETON_GATE, 2

	def_coord_events


	def_bg_events
	bg_event 21, 11, BGEVENT_JUMPTEXT, Route102TrainerTips2Text
	bg_event 23,  3, BGEVENT_JUMPTEXT, OlsteetonGateSignText
	bg_event  4, 10, BGEVENT_JUMPTEXT, Route102SignText
	bg_event  9, 13, BGEVENT_JUMPTEXT, Route102TrainerTips1Text
	bg_event 27, 14, BGEVENT_JUMPTEXT, Route102AdvancedTips1Text
	bg_event  5,  0, BGEVENT_JUMPTEXT, Route102AdvancedTips2Text
	; bg_event 30, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_36
	; bg_event 31, 11, BGEVENT_JUMPSTD, treegrotto, HIDDENGROTTO_ROUTE_36

	def_object_events
	fruittree_event 26, 14, FRUITTREE_ROUTE_36, RAWST_BERRY, PAL_NPC_TEAL
	; object_event 50,  5, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerSchoolgirlMolly, -1

	object_const_def




; GenericTrainerSchoolgirlMolly:
; 	generictrainer SCHOOLGIRL, MOLLY, EVENT_BEAT_SCHOOLGIRL_MOLLY, SchoolgirlMollySeenText, SchoolgirlMollyBeatenText

; 	text "I still have a"
; 	line "lot to learn."
; 	done



; SchoolgirlMollySeenText:
; 	text "Mr.Earl taught me"
; 	line "how to battle with"
; 	cont "#mon!"
; 	done

; SchoolgirlMollyBeatenText:
; 	text "My studying…"
; 	done


Route102SignText:
	text "Route 102"
	done

OlsteetonGateSignText:
	text "EAST: Olsteeton"
	line "WEST: Route 102"
	done

Route102TrainerTips1Text:
	text "Trainer Tips"

	para "#mon stats"
	line "vary--even within"
	cont "the same species."

	para "Their stats may be"
	line "similar at first."

	para "However, differ-"
	line "ences will become"

	para "pronounced as the"
	line "#mon grow."
	done

Route102TrainerTips2Text:
	text "Trainer Tips"

	para "Use Dig to return"
	line "to the entrance of"
	cont "any place."

	para "It is convenient"
	line "for exploring"

	para "caves and other"
	line "landmarks."
	done

Route102AdvancedTips1Text:
	text "Advanced Tips!"

	para "You can pick from"
	line "twenty different"
	cont "textbox frames and"

	para "eight different"
	line "text typefaces in"
	cont "the Options!"
	done

Route102AdvancedTips2Text:
	text "Advanced Tips!"

	para "Treating your"
	line "#mon with hair-"
	cont "cuts, blessings or"

	para "massages can make"
	line "them help you out"

	para "in battles due to"
	line "their affection!"
	done
