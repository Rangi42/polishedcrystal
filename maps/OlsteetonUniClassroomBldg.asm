OlsteetonUniClassroomBldg_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event 12, 13, OLSTEETON_UNI, 11
	warp_event 13, 13, OLSTEETON_UNI, 11
	warp_event  9,  0, OLSTEETON_UNI_CLASSROOM_BIOLOGY, 1
	warp_event 17,  0, OLSTEETON_UNI_CLASSROOM_ART, 1
	warp_event 21,  0, OLSTEETON_UNI_CLASSROOM_BUSINESS, 1
	warp_event  3,  8, OLSTEETON_UNI_CLASSROOM_STRATEGY, 1
	warp_event  7,  8, OLSTEETON_UNI_CLASSROOM_HISTORY, 1
	warp_event 19,  8, OLSTEETON_UNI_CLASSROOM_THEORY, 1

	def_coord_events

	def_bg_events
	bg_event  6,  8, BGEVENT_JUMPTEXT, UniClassroomHistorySignText
	bg_event  2,  8, BGEVENT_JUMPTEXT, UniClassroomStrategySignText
	bg_event 16,  0, BGEVENT_JUMPTEXT, UniClassroomArtSignText
	bg_event  3,  0, BGEVENT_JUMPTEXT, UniClassroomDoorSignText
	bg_event 18,  8, BGEVENT_JUMPTEXT, UniClassroomTheorySignText
	bg_event 20,  0, BGEVENT_JUMPTEXT, UniClassroomBusinessSignText
	bg_event  8,  0, BGEVENT_JUMPTEXT, UniClassroomBiologySignText
	bg_event 13,  2, BGEVENT_READ, UniClassroomPoliwagSignText
	bg_event  2,  0, BGEVENT_JUMPTEXT, UniClassroomPhilosophySignText
	bg_event 22,  8, BGEVENT_JUMPTEXT, UniClassroomEthicsSignText
	bg_event 23,  8, BGEVENT_JUMPTEXT, UniClassroomEthicsDoorSignText


	def_object_events
	object_event  25, 2, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, PAL_NPC_PURPLE, OBJECTTYPE_SCRIPT, 0, UniClassroomCooltrainerfScript, -1
	object_event  2,  2, SPRITE_COOL_DUDE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomCooltrainermText, -1
	object_event 12,  3, SPRITE_SCHOOLBOY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomYoungster1Text, -1
	object_event 11,  7, SPRITE_COWGIRL, SPRITEMOVEDATA_WALK_UP_DOWN, 2, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomCowgirlText, -1
	object_event 24,  9, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomBug_catcherText, -1
	object_event 3,  11, SPRITE_CUTE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomLassText, -1
	object_event  6, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, jumptextfaceplayer, UniClassroomYoungster2Text, -1

UniClassroomCooltrainerfScript:
	checkevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	iftrue_jumptextfaceplayer .Text5
	faceplayer
	opentext
	writetext .Text1
	waitbutton
	writetext .Text2
	yesorno
	iffalse_jumpopenedtext .Text6
	takeitem FRESH_WATER
	iffalse_jumpopenedtext .Text6
	writetext .Text3
	waitbutton
	writetext .Text4
	waitbutton
	verbosegiveitem ANTIDOTE
	iffalsefwd .NoRoomForAntidote
	setevent EVENT_GOT_ANTIDOTE_IN_UNIVERSITY
	jumpthisopenedtext

.Text5:
	text "Antidotes cure"
	line "poison in #-"
	cont "mon, but a person"

	para "would get sick"
	line "by drinking one."
	done

.NoRoomForAntidote:
	giveitem FRESH_WATER
	jumpthisopenedtext

	text "Oh… Keep your"
	line "Fresh Water then…"
	done

.Text1:
	text "Wow, I'm thirsty!"

	para "But I don't have"
	line "change for the"
	cont "vending machines…"

	para "Do you have any"
	line "Fresh Water?"
	done

.Text2:
	text "Give away a"
	line "Fresh Water?"
	done

.Text3:
	text "<PLAYER> gave away"
	line "the Fresh Water."
	done

.Text4:
	text "Thank you so much!"
	line "Here, take this!"
	done

.Text6:
	text "Oh… But I'm so"
	line "thirsty…"
	done

UniClassroomCooltrainermText:
	text "The cafeteria gets"
	line "pretty crowded,"

	para "so I prefer to eat"
	line "in the hall."
	done

UniClassroomYoungster1Text:
	text "I failed the"
	line "Hyper Test again…"

	para "But I won't"
	line "give up!"
	done

UniClassroomCowgirlText:
	text "My class is going"
	line "on a field trip to"
	cont "the Safari Zone!"
	done

UniClassroomBug_catcherText:
	text "Prof.Willow sends"
	line "his assistants to"

	para "wander all over"
	line "the city and study"

	para "the #mon that"
	line "live here."
	done

UniClassroomLassText:
	text "In addition to"
	line "being the Celadon"
	cont "Gym Leader,"

	para "Erika was top of"
	line "her class here at"
	cont "the university."

	para "I wish I was as"
	line "cool as her."
	done

UniClassroomYoungster2Text:
	text "Prof.Westwood is a"
	line "little eccentric."

	para "Sometimes he apol-"
	line "ogizes to his"

	para "ancestors' por-"
	line "traits."
	done

UniClassroomHistorySignText:
	text "#mon History"
	done

UniClassroomStrategySignText:
	text "Battle Strategy"
	done

UniClassroomArtSignText:
	text "#mon Art"
	done

UniClassroomTheorySignText:
	text "#ball Theory"
	done

UniClassroomBusinessSignText:
	text "#Business"
	done

UniClassroomBiologySignText:
	text "#mon Biology"
	done

UniClassroomDoorSignText:
	text "There is a"
	line "note taped to"
	cont "the door:"

	para "CLASS CANCELED"
	line "Read Chapter 6."
	done

UniClassroomEthicsSignText:
	text "Ethics of"
	line "#mon Battles"
	done
UniClassroomEthicsDoorSignText:
	text "The door"
	line "is locked, and"
	cont "the lights"
	cont "are off."

	para "It looks like"
	line "this classroom"

	para "hasn't been used"
	line "for some time."
	done
UniClassroomPoliwagSignText:
	reanchormap
	pokepic POLIWAG
	cry POLIWAG
	waitbutton
	closepokepic
	jumpthistext

	text "Please don't"
	line "tap the glass."

	para "It scares"
	line "the Poliwags."
	done

UniClassroomPhilosophySignText:
	text "#losophy"
	done
