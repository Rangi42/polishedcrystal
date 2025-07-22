Olsteeton_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2, 18, ROUTE_102_OLSTEETON_GATE, 3
	warp_event  2, 19, ROUTE_102_OLSTEETON_GATE, 4
	; warp_event 11, 11, OLSTEETON_MALL_1F, 1
	; warp_event 14, 11, OLSTEETON_MALL_2F, 1
	; warp_event 17, 11, OLSTEETON_MALL_3F, 1
	; warp_event 27, 11, MART, 1
	; warp_event 27, 18, RIVERFRONT_APT_1F, 1
	; warp_event 27, 19, RIVERFRONT_APT_1F, 2
	; warp_event 32, 19, RIVERFRONT_APT_1F, 3
	; warp_event 32, 18, RIVERFRONT_APT_1F, 4
	; warp_event  7, 17, OLSTEETON_POKE_CENTER, 1
	; warp_event  4, 11, OLSTEETON_GYM_1F, 1
	; warp_event 13, 17, OLSTEETON_RESTAURANT, 1
	; warp_event 27, 27, , 1
	; warp_event 21, 11, , 1
	; ; warp_event  3, 27, HOUSE, 1
	; warp_event 29, 33, , 1
	; warp_event  9, 29, , 1
	; warp_event 11, 33, , 1

	def_coord_events

	def_bg_events
	bg_event 16, 28, BGEVENT_JUMPTEXT, OlsteetonSignText
	bg_event  2, 12, BGEVENT_JUMPTEXT, OlsteetonGymSignText
	bg_event  7, 29, BGEVENT_JUMPTEXT, OlsteetonUniversitySignText
	bg_event 12, 11, BGEVENT_JUMPTEXT, OlsteetonDeptStoreSignText
	bg_event 16, 12, BGEVENT_JUMPTEXT, OlsteetonHomeDecorStoreSignText
	bg_event 22, 11, BGEVENT_JUMPTEXT, OlsteetonMansionSignText
	bg_event 14, 18, BGEVENT_JUMPTEXT, OlsteetonGameCornerSignText
	bg_event 28, 11, BGEVENT_JUMPTEXT, OlsteetonPrizeExchangeSignText
	bg_event 14, 18, BGEVENT_JUMPTEXT, OlsteetonCafeSignText
	bg_event 27, 17, BGEVENT_JUMPTEXT, OlsteetonHotelSignText
	bg_event 36, 11, BGEVENT_JUMPTEXT, OlsteetonTrainerTips1Text
	bg_event 33, 14, BGEVENT_JUMPTEXT, OlsteetonTrainerTips2Text
	; bg_event  3, 24, BGEVENT_ITEM + PP_UP, EVENT_Olsteeton_CITY_HIDDEN_PP_UP

	def_object_events
	; object_event  5, 16, SPRITE_RICH_BOY, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlsteetonScript, -1
	object_event 32,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonFisherText, -1
	pokemon_event 33,  2, WARTORTLE, SPRITEMOVEDATA_POKEMON, -1, PAL_NPC_BLUE, OlsteetonPoliwrathText, -1
	object_event 24, 24, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTeacher1Text, -1
	object_event  6, 27, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGramps1Text, -1
	object_event 21, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonGramps2Text, -1
	object_event 33,  9, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonYoungster1Text, -1
	object_event  7, 32, SPRITE_CAMPER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonYoungster2Text, -1
	object_event 31, 30, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonTeacher2Text, -1
	object_event  7, 24, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonLassText_PCC, -1
	object_event 20, 17, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_BROWN, OBJECTTYPE_COMMAND, jumptextfaceplayer, OlsteetonLassText, -1
	; itemball_event 39,  7, MAX_ETHER, 1, EVENT_Olsteeton_CITY_MAX_ETHER
	; cuttree_event 33, 34, EVENT_Olsteeton_CITY_CUT_TREE
	; cuttree_event -5, 24, EVENT_ROUTE_16_CUT_TREE

OlsteetonFlyPoint:
	setflag ENGINE_FLYPOINT_OLSTEETON
	endcallback

; OlsteetonScript:
; 	faceplayer
; 	opentext
; 	checkevent EVENT_LISTENED_TO_SWAGGER_INTRO
; 	iftruefwd OlsteetonTutorSwaggerScript
; 	writetext OlsteetonRichBoyText
; 	waitbutton
; 	setevent EVENT_LISTENED_TO_SWAGGER_INTRO
; OlsteetonTutorSwaggerScript:
; 	writetext Text_OlsteetonTutorSwagger
; 	waitbutton
; 	checkitem SILVER_LEAF
; 	iffalsefwd .NoSilverLeaf
; 	writetext Text_OlsteetonTutorQuestion
; 	yesorno
; 	iffalsefwd .TutorRefused
; 	setval SWAGGER
; 	writetext ClearText
; 	special Special_MoveTutor
; 	ifequalfwd $0, .TeachMove
; .TutorRefused
; 	jumpopenedtext Text_OlsteetonTutorRefused

; .NoSilverLeaf
; 	jumpopenedtext Text_OlsteetonTutorNoSilverLeaf

; .TeachMove
; 	takeitem SILVER_LEAF
; 	jumpopenedtext Text_OlsteetonTutorTaught

; OlsteetonRichBoyText:
; 	text "Is my suit not"
; 	line "bedazzling?"

; 	para "It turns heads"
; 	line "when I swagger"
; 	cont "down the street!"

; 	para "The people love"
; 	line "me!"

; 	para "I'm in a generous"
; 	line "mood today."
; 	done

; Text_OlsteetonTutorSwagger:
; 	text "I shall teach"
; 	line "your #mon to"

; 	para "Swagger like me"
; 	line "for merely a"
; 	cont "Silver Leaf."
; 	done

; Text_OlsteetonTutorNoSilverLeaf:
; 	text "…You have no"
; 	line "Silver Leaf?"
; 	cont "What a pity."
; 	done

; Text_OlsteetonTutorQuestion:
; 	text "You wish me to"
; 	line "teach your #-"
; 	cont "mon Swagger?"
; 	done

; Text_OlsteetonTutorRefused:
; 	text "Then goodbye!"
; 	done

; Text_OlsteetonTutorTaught:
; 	text "Behold! Your #-"
; 	line "mon has learned"
; 	cont "to Swagger!"
; 	done

OlsteetonFisherText:
	text "This Poliwrath is"
	line "my partner."

	para "It used to be"
	line "Quiet, but the"

	para "manager lady in"
	line "the condo here"

	para "brewed us some"
	line "tea with a Mint"

	para "Leaf that made it"
	line "act more Jolly!"
	done

OlsteetonPoliwrathText:
	text "Poliwrath: Croak!"
	done

OlsteetonTeacher1Text:
	text "I lost at the slot"
	line "machines again…"

	para "We girls also play"
	line "the slots now."

	para "You should check"
	line "them out too."
	done

OlsteetonGramps1Text:
	text "Grimer have been"
	line "appearing lately."

	para "See that pond out"
	line "in front of the"

	para "house? Grimer live"
	line "there now."

	para "Where did they"
	line "come from? This is"
	cont "a serious problem…"
	done

OlsteetonGramps2Text:
	text "Nihihi! This Gym"
	line "is great! Only"

	para "girls are allowed"
	line "here!"
	done

OlsteetonYoungster1Text:
	text "Want to know a"
	line "secret?"

	para "Olsteeton Condo"
	line "has a hidden back"
	cont "door."
	done

OlsteetonYoungster2Text:
	text "The restaurant"
	line "there is having an"
	cont "eating contest."

	para "There's one con-"
	line "testant from the"

	para "Sinnoh region this"
	line "year."

	para "Just watching her"
	line "go at it makes me"
	cont "feel bloated…"
	done

OlsteetonTeacher2Text:
	text "Olsteeton Dept.Store"
	line "has the biggest"

	para "and best selection"
	line "of merchandise."

	para "If you can't get"
	line "it there, you"

	para "can't get it any-"
	line "where."

	para "Gee… I sound like"
	line "a sales clerk."
	done

OlsteetonLassText_PCC:
	text "I love being"
	line "surrounded by tall"
	cont "buildings!"

	para "Isn't it true that"
	line "Goldenrod #mon"

	para "Center was made"
	line "much, much bigger?"

	para "That is so neat!"
	line "I wish we had a"

	para "place like that in"
	line "Kanto…"
	done

OlsteetonLassText:
	text "#mon are offer-"
	line "ed as prizes at"
	cont "the Game Corner."

	para "The poor things…"
	done

OlsteetonSignText:
	text "Olsteeton City"

	para "The City of"
	line "Rainbow Dreams"
	done

OlsteetonGymSignText:
	text "Olsteeton City"
	line "#mon Gym"
	cont "Leader: Erika"

	para "The Nature-Loving"
	line "Princess"
	done

OlsteetonUniversitySignText:
	text "Olsteeton University"

	para "“Growth Through"
	line "Studying”"
	done

OlsteetonDeptStoreSignText:
	text "Find What You"
	line "Need at Olsteeton"
	cont "Dept.Store!"
	done

OlsteetonHomeDecorStoreSignText:
	text "Olsteeton Dept.Store"
	line "Home Decor Wing"
	done

OlsteetonMansionSignText:
	text "Olsteeton"
	line "Condominium"
	done

OlsteetonGameCornerSignText:
	text "The Playground for"
	line "Everybody--Olsteeton"
	cont "Game Corner"
	done

OlsteetonPrizeExchangeSignText:
	text "Coins exchanged"
	line "for prizes!"
	cont "Prize Exchange"
	done

OlsteetonCafeSignText:
	text "Olsteeton Diner"

	para "Eatathon Contest"
	line "all day today!"
	done

OlsteetonHotelSignText:
	text "Olsteeton Hotel"

	para "Relax in our"
	line "swimming pool!"
	done

OlsteetonTrainerTips1Text:
	text "Trainer Tips"

if DEF(FAITHFUL)
	para "Guard Spec."
else
	para "Guard Stats"
endc
	line "protects #mon"

	para "against stat"
	line "reductions."

	para "Get your items at"
	line "Olsteeton Dept."
	cont "Store!"
	done

OlsteetonTrainerTips2Text:
	text "Trainer Tips"

	para "Eevee is a #mon"
	line "full of potential."

	para "Try exposing it to"
	line "many different"
	cont "locations, times"
	cont "of day, and"
	cont "Evolution stones."
	done
