SeagallopFerryVermilionGate_MapScriptHeader:
	def_scene_scripts
	scene_script SeagallopFerryVermilionGateTrigger0
	scene_script SeagallopFerryVermilionGateTrigger1

	def_callbacks

	def_warp_events
	warp_event  6,  0, VERMILION_CITY, 11

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  4, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SeagallopFerryVermilionGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY

	object_const_def
	const SEAGALLOPFERRYVERMILIONGATE_SAILOR

SeagallopFerryVermilionGateTrigger1:
	sdefer SeagallopFerryVermilionGate_PlayerArrives
SeagallopFerryVermilionGateTrigger0:
	end

SeagallopFerryVermilionGate_PlayerArrives:
	applymovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, SeagallopFerryVermilionGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryVermilionGatePlayerArriveMovementData
	showtext SeagallopFerryVermilionCityRefusedText
	applymovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, SeagallopFerryVermilionGateSailorArrive2MovementData
	setscene $0
	end

SeagallopFerryVermilionGateSailorScript:
	faceplayer
	opentext
	writetext SeagallopFerryWelcomeText
	waitbutton
	checkevent EVENT_GOT_ORANGE_TICKET
	iftrue .got_orangeticket
	writetext SeagallopFerryGiveOrangeTicketText
	waitbutton
	verbosegivekeyitem ORANGETICKET
	setevent EVENT_GOT_ORANGE_TICKET
.got_orangeticket
	checkkeyitem ORANGETICKET
	iftrue .have_orangeticket
	checkkeyitem MYSTICTICKET
	iftrue .have_mysticticket_no_orangeticket
	checkkeyitem OLD_SEA_MAP
	iftrue .use_old_sea_map
	jumpopenedtext SeagallopFerryClosedText

.have_orangeticket
	checkkeyitem MYSTICTICKET
	iftrue .have_orangeticket_and_mysticticket
	checkkeyitem OLD_SEA_MAP
	iftrue .use_orangeticket_or_old_sea_map
.use_orangeticket
	writetext SeagallopFerryOrangeTicketQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	setmapscene SEAGALLOP_FERRY_SHAMOUTI_GATE, $1
	warp SEAGALLOP_FERRY_SHAMOUTI_GATE, 6, 5
	end

.have_mysticticket_no_orangeticket
	checkkeyitem OLD_SEA_MAP
	iftrue .use_mysticticket_or_old_sea_map
.use_mysticticket
	writetext SeagallopFerryMysticTicketQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	setmapscene SEAGALLOP_FERRY_NAVEL_GATE, $1
	warp SEAGALLOP_FERRY_NAVEL_GATE, 6, 5
	end

.have_orangeticket_and_mysticticket
	checkkeyitem OLD_SEA_MAP
	iftrue .have_three_tickets
	writetext SeagallopFerryWhichTicketText
	loadmenu OrangeMysticMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .use_orangeticket
	ifequal $2, .use_mysticticket
	sjump .no_ferry

.use_old_sea_map
	writetext SeagallopFerryOldSeaMapQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	setmapscene FARAWAY_ISLAND, $1
	warp FARAWAY_ISLAND, 12, 42
	end

.use_mysticticket_or_old_sea_map
	writetext SeagallopFerryWhichTicketText
	loadmenu MysticOldSeaMapMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .use_mysticticket
	ifequal $2, .use_old_sea_map
	sjump .no_ferry

.use_orangeticket_or_old_sea_map
	writetext SeagallopFerryWhichTicketText
	loadmenu OrangeOldSeaMapMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .use_orangeticket
	ifequal $2, .use_old_sea_map
	sjump .no_ferry

.have_three_tickets
	writetext SeagallopFerryWhichTicketText
	loadmenu ThreeTicketsMenuDataHeader
	verticalmenu
	closewindow
	ifequal $1, .use_orangeticket
	ifequal $2, .use_mysticticket
	ifequal $3, .use_old_sea_map
.no_ferry:
	jumpopenedtext SeagallopFerryVermilionCityRefusedText

OrangeMysticMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "OrangeTicket@"
	db "MysticTicket@"
	db "Cancel@"

MysticOldSeaMapMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "MysticTicket@"
	db "Old Sea Map@"
	db "Cancel@"

OrangeOldSeaMapMenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "OrangeTicket@"
	db "Old Sea Map@"
	db "Cancel@"

ThreeTicketsMenuDataHeader:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "OrangeTicket@"
	db "MysticTicket@"
	db "Old Sea Map@"
	db "Cancel@"

SeagallopFerryDepartureScript:
	writetext SeagallopFerryDepartureText
	waitbutton
	closetext
	turnobject SEAGALLOPFERRYVERMILIONGATE_SAILOR, DOWN
	pause 10
	applyonemovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, step_down
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYVERMILIONGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryVermilionGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYVERMILIONGATE_SAILOR
	end

SeagallopFerryVermilionGatePlayerDepartMovementData:
	step_down
	step_down
	step_end

SeagallopFerryVermilionGatePlayerArriveMovementData:
	step_up
	step_up
	step_up
	turn_head_down
	step_end

SeagallopFerryVermilionGateSailorArrive1MovementData:
	step_up
	step_left
	turn_head_right
	step_end

SeagallopFerryVermilionGateSailorArrive2MovementData:
	step_right
	step_down
	turn_head_up
	step_end

SeagallopFerryWelcomeText:
	text "Welcome aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryGiveOrangeTicketText:
	text "The man who just"
	line "left said he didn't"

	para "need this ticket."
	line "You can have it."
	done

SeagallopFerryClosedText:
	text "I'm sorry, you don't"
	line "have a ticket."
	done

SeagallopFerryOrangeTicketQuestionText:
	text "That OrangeTicket"
	line "is for a ride to"
	cont "Shamouti Island."

	para "We'll be happy to"
	line "take you there"
	cont "any time."
	done

SeagallopFerryMysticTicketQuestionText:
	text "Oh! That's a"
	line "MysticTicket!"
	cont "Now that is rare."

	para "We'll be happy to"
	line "take you to Navel"
	cont "Rock any time."
	done

SeagallopFerryOldSeaMapQuestionText:
	text "Oh! That Old Sea"
	line "Map you have…"

	para "It looks like a"
	line "faraway island."

	para "We'll be happy to"
	line "take you there"
	cont "any time."
	done

SeagallopFerryWhichTicketText:
	text "Do you have a"
	line "ticket?"
	done

SeagallopFerryDepartureText:
	text "All right!"

	para "All aboard the"
	line "Seagallop Ferry!"
	done

SeagallopFerryVermilionCityRefusedText:
	text "Come again!"
	done
