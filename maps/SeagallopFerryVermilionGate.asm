const_value set 2
	const SEAGALLOPFERRYVERMILIONGATE_SAILOR

SeagallopFerryVermilionGate_MapScriptHeader:
.MapTriggers:
	db 2

	; triggers
	dw .Trigger0, 0
	dw .Trigger1, 0

.MapCallbacks:
	db 0

.Trigger0:
	end

.Trigger1:
	priorityjump SeagallopFerryVermilionGate_PlayerArrives
	end

SeagallopFerryVermilionGate_PlayerArrives:
	applymovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, SeagallopFerryVermilionGateSailorArrive1MovementData
	applymovement PLAYER, SeagallopFerryVermilionGatePlayerArriveMovementData
	opentext
	writetext SeagallopFerryVermilionCityRefusedText
	waitbutton
	closetext
	applymovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, SeagallopFerryVermilionGateSailorArrive2MovementData
	dotrigger $0
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
	verbosegiveitem ORANGETICKET
	setevent EVENT_GOT_ORANGE_TICKET
.got_orangeticket
	checkitem ORANGETICKET
	iftrue .have_orangeticket
	checkitem MYSTICTICKET
	iftrue .have_mysticticket
	checkitem OLD_SEA_MAP
	iftrue .have_old_sea_map
	writetext SeagallopFerryClosedText
	waitbutton
	closetext
	end

.have_orangeticket
	checkitem MYSTICTICKET
	iftrue .have_orangeticket_and_mysticticket
	checkitem OLD_SEA_MAP
	iftrue .have_orangeticket_and_old_sea_map
.use_orangeticket
	writetext SeagallopFerryOrangeTicketQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	domaptrigger SEAGALLOP_FERRY_SHAMOUTI_GATE, $1
	warp SEAGALLOP_FERRY_SHAMOUTI_GATE, $6, $5
	end

.have_mysticticket
	checkitem OLD_SEA_MAP
	iftrue .have_mysticticket_and_old_sea_map
.use_mysticticket
	writetext SeagallopFerryMysticTicketQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	domaptrigger SEAGALLOP_FERRY_NAVEL_GATE, $1
	warp SEAGALLOP_FERRY_NAVEL_GATE, $6, $5
	end

.have_orangeticket_and_mysticticket
	checkitem OLD_SEA_MAP
	iftrue .have_three_tickets
	writetext SeagallopFerryWhichTicketText
	loadmenudata OrangeMysticMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .use_orangeticket
	if_equal $2, .use_mysticticket
	jump .no_ferry

.have_old_sea_map
.use_old_sea_map
	writetext SeagallopFerryOldSeaMapQuestionText
	yesorno
	iffalse .no_ferry
	scall SeagallopFerryDepartureScript
	domaptrigger FARAWAY_ISLAND, $1
	warp FARAWAY_ISLAND, $c, $2a
	end

.have_orangeticket_and_old_sea_map
	writetext SeagallopFerryWhichTicketText
	loadmenudata MysticOldSeaMapMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .use_mysticticket
	if_equal $2, .use_old_sea_map
	jump .no_ferry

.have_mysticticket_and_old_sea_map
	writetext SeagallopFerryWhichTicketText
	loadmenudata OrangeOldSeaMapMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .use_orangeticket
	if_equal $2, .use_old_sea_map
	jump .no_ferry

.have_three_tickets
	writetext SeagallopFerryWhichTicketText
	loadmenudata ThreeTicketsMenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .use_orangeticket
	if_equal $2, .use_mysticticket
	if_equal $3, .use_old_sea_map
.no_ferry:
	writetext SeagallopFerryVermilionCityRefusedText
	waitbutton
	closetext
	end

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
	spriteface SEAGALLOPFERRYVERMILIONGATE_SAILOR, DOWN
	pause 10
	applymovement SEAGALLOPFERRYVERMILIONGATE_SAILOR, SeagallopFerryVermilionGateSailorDepartMovementData
	playsound SFX_EXIT_BUILDING
	disappear SEAGALLOPFERRYVERMILIONGATE_SAILOR
	waitsfx
	applymovement PLAYER, SeagallopFerryVermilionGatePlayerDepartMovementData
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	waitsfx
	appear SEAGALLOPFERRYVERMILIONGATE_SAILOR
	end

SeagallopFerryVermilionGateSailorDepartMovementData:
	step_down
	step_end

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

SeagallopFerryVermilionGate_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $0, $6, 11, VERMILION_CITY

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_SAILOR, 4, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, SeagallopFerryVermilionGateSailorScript, EVENT_OLIVINE_PORT_SAILOR_AT_GANGWAY
