AskResurrectFossilScript::
	checkitem HELIX_FOSSIL
	iftruefwd .own_helix
	checkitem DOME_FOSSIL
	iftruefwd .own_dome
	checkitem OLD_AMBER
	iftruefwd .ask_old_amber
	jumpthisopenedtext

	text "Hey! You don't"
	line "have any fossils."
	done

.own_helix
	checkitem DOME_FOSSIL
	iftruefwd .own_helix_and_dome
	checkitem OLD_AMBER
	iftruefwd .ask_helix_amber
	writetext AskHelixFossilText
	yesorno
	iftrue ResurrectHelixFossil
	sjumpfwd .maybe_later

.own_dome
	checkitem OLD_AMBER
	iftruefwd .ask_dome_amber
	writetext AskDomeFossilText
	yesorno
	iftrue ResurrectDomeFossil
	sjumpfwd .maybe_later

.own_helix_and_dome
	checkitem OLD_AMBER
	iftruefwd .ask_helix_dome_amber
	loadmenu HelixDomeMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectHelixFossil
	ifequal $2, ResurrectDomeFossil
	sjumpfwd .maybe_later

.ask_old_amber
	writetext AskOldAmberText
	yesorno
	iftrue ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_helix_amber
	loadmenu HelixAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectHelixFossil
	ifequal $2, ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_dome_amber
	loadmenu DomeAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectDomeFossil
	ifequalfwd $2, ResurrectOldAmber
	sjumpfwd .maybe_later

.ask_helix_dome_amber
	loadmenu HelixDomeAmberMenuDataHeader
	verticalmenu
	closewindow
	ifequalfwd $1, ResurrectHelixFossil
	ifequalfwd $2, ResurrectDomeFossil
	ifequalfwd $3, ResurrectOldAmber
.maybe_later:
	jumpthisopenedtext

	text "Just talk to me"
	line "if you change"
	cont "your mind."
	done

HelixDomeMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Helix Fossil@"
	db "Dome Fossil@"
	db "Cancel@"

HelixAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Helix Fossil@"
	db "Old Amber@"
	db "Cancel@"

DomeAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 4, 14, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db "Dome Fossil@"
	db "Old Amber@"
	db "Cancel@"

HelixDomeAmberMenuDataHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 2, 15, 11
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Helix Fossil@"
	db "Dome Fossil@"
	db "Old Amber@"
	db "Cancel@"

ResurrectHelixFossil:
	takeitem HELIX_FOSSIL
	scall ResurrectAFossilScript
	givepoke OMANYTE, 20
	sjumpfwd FinishResurrect

ResurrectDomeFossil:
	takeitem DOME_FOSSIL
	scall ResurrectAFossilScript
	givepoke KABUTO, 20
	sjumpfwd FinishResurrect

ResurrectOldAmber:
	takeitem OLD_AMBER
	scall ResurrectAFossilScript
	givepoke AERODACTYL, 20
FinishResurrect:
	iffalse_jumpopenedtext NoRoomForFossilPokemonText
	jumpthisopenedtext

	text "Take good care"
	line "of it!"
	done

ResurrectAFossilScript:
	writetext ResurrectingPokemonText
	waitbutton
	closetext
	memcall wResurrectFossilScriptBank
	pause 15
	playsound SFX_BOOT_PC
	waitsfx
	pause 30
	playsound SFX_4_NOTE_DITTY
	waitsfx
	pause 5
	waitsfx
	pause 30
	playsound SFX_SHUT_DOWN_PC
	waitsfx
	pause 15
	faceplayer
	opentext
	end

AskHelixFossilText:
	text "Do you want to"
	line "resurrect the"
	cont "Helix Fossil?"
	done

AskDomeFossilText:
	text "Do you want to"
	line "resurrect the"
	cont "Dome Fossil?"
	done

AskOldAmberText:
	text "Do you want to"
	line "resurrect the"
	cont "Old Amber?"
	done

ResurrectingPokemonText:
	text "OK! I'll resurrect"
	line "the #mon!"
	done

NoRoomForFossilPokemonText:
	text "Hey! You can't"
	line "carry another"
	cont "#mon, and your"
	cont "Box is full, too!"
	done
