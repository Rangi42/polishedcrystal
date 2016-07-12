const_value set 2
	const PEWTERMUSEUMOFSCIENCE1F_RECEPTIONIST
	const PEWTERMUSEUMOFSCIENCE1F_SCIENTIST1
	const PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2
	const PEWTERMUSEUMOFSCIENCE1F_GRAMPS

PewterMuseumOfScience1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

Museum1FFossilScientistScript:
	; TODO: use a menu like with Kurt's Apricorns
	faceplayer
	opentext
	writetext Museum1FFossilScientistText
	waitbutton
	checkitem HELIX_FOSSIL
	iftrue .AskToResurrect
	checkitem DOME_FOSSIL
	iftrue .AskToResurrect
	checkitem OLD_AMBER
	iftrue .AskToResurrect
	writetext NoFossilsText
	waitbutton
	closetext
	end
.AskToResurrect
	checkitem HELIX_FOSSIL
	iffalse .TryDomeFossil
	writetext AskHelixFossilText
	yesorno
	iffalse .TryDomeFossil
	jump ResurrectHelixFossil
.TryDomeFossil
	checkitem DOME_FOSSIL
	iffalse .TryOldAmber
	writetext AskDomeFossilText
	yesorno
	iffalse .TryOldAmber
	jump ResurrectDomeFossil
.TryOldAmber
	checkitem OLD_AMBER
	iffalse .MaybeLater
	writetext AskOldAmberText
	yesorno
	iffalse .MaybeLater
	jump ResurrectOldAmber
.MaybeLater
	writetext MaybeLaterText
	waitbutton
	closetext
	end

ResurrectHelixFossil:
	checkcode VAR_PARTYCOUNT
	if_equal $6, NoRoomForFossilPokemon
	takeitem HELIX_FOSSIL
	writetext ResurrectingPokemonText
	waitbutton
	closetext
	spriteface PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2, UP
	pause 30
	playsound SFX_BOOT_PC
	waitsfx
	pause 30
	playsound SFX_PROTECT
	waitsfx
	pause 30
	playsound SFX_SHUT_DOWN_PC
	waitsfx
	pause 30
	faceplayer
	opentext
	writetext GotOmanyteText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke OMANYTE, 20
	writetext TakeGoodCareOfItText
	waitbutton
	closetext
	end

ResurrectDomeFossil:
	checkcode VAR_PARTYCOUNT
	if_equal $6, NoRoomForFossilPokemon
	takeitem DOME_FOSSIL
	writetext ResurrectingPokemonText
	waitbutton
	closetext
	spriteface PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2, UP
	pause 30
	playsound SFX_BOOT_PC
	waitsfx
	pause 30
	playsound SFX_PROTECT
	waitsfx
	pause 30
	playsound SFX_SHUT_DOWN_PC
	waitsfx
	pause 30
	faceplayer
	opentext
	writetext GotKabutoText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke KABUTO, 20
	writetext TakeGoodCareOfItText
	waitbutton
	closetext
	end

ResurrectOldAmber:
	checkcode VAR_PARTYCOUNT
	if_equal $6, NoRoomForFossilPokemon
	takeitem OLD_AMBER
	writetext ResurrectingPokemonText
	waitbutton
	closetext
	spriteface PEWTERMUSEUMOFSCIENCE1F_SCIENTIST2, UP
	pause 30
	playsound SFX_BOOT_PC
	waitsfx
	pause 30
	playsound SFX_PROTECT
	waitsfx
	pause 30
	playsound SFX_SHUT_DOWN_PC
	waitsfx
	pause 30
	faceplayer
	opentext
	writetext GotAerodactylText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke AERODACTYL, 20
	writetext TakeGoodCareOfItText
	waitbutton
	closetext
	end

NoRoomForFossilPokemon:
	writetext NoRoomForFossilPokemonText
	waitbutton
	closetext
	end

Museum1FReceptionistScript:
	jumptextfaceplayer Museum1FReceptionistText

Museum1FScientistScript:
	jumptextfaceplayer Museum1FScientistText

Museum1FGrampsScript:
	jumptextfaceplayer Museum1FGrampsText

Museum1FReceptionistDeskSignpostScript:
	jumptext Museum1FReceptionistDeskSignpostText

KabutopsFossilSignpostScript:
	refreshscreen $0
	trainerpic KABUTOPS_FOSSIL
	waitbutton
	closepokepic
	jumptext KabutopsFossilSignpostText

OmastarFossilSignpostScript:
	refreshscreen $0
	trainerpic OMASTAR_FOSSIL
	waitbutton
	closepokepic
	jumptext OmastarFossilSignpostText

AerodactylFossilSignpostScript:
	refreshscreen $0
	trainerpic AERODACTYL_FOSSIL
	waitbutton
	closepokepic
	jumptext AerodactylFossilSignpostText

Museum1FBookshelfSignpostScript:
	jumptext Museum1FBookshelfSignpostText

Museum1FReceptionistText:
	text "You can't sneak"
	line "in the back way!"
	done

Museum1FScientistText:
	text "We are proud of"
	line "three fossils of"
	cont "rare, prehistoric"
	cont "#mon!"
	done

Museum1FFossilScientistText:
	text "Did you know that"
	line "you can extract"
	cont "#mon from"
	cont "fossils?"

	para "If you ever need"
	line "to, let me take"
	cont "care of it!"
	done

Museum1FGrampsText:
	text "That is one"
	line "magnificent"
	cont "fossil!"
	done

Museum1FReceptionistDeskSignpostText:
	text "Welcome!"

	para "Thanks to a gene-"
	line "rous donation"
	cont "from Silph Co.,"

	para "admission is free"
	line "of charge!"

	para "Please go ahead."
	done

KabutopsFossilSignpostText:
	text "Kabutops Fossil"
	line "(Dome)"

	para "A primitive and"
	line "rare Pokémon."
	done

OmastarFossilSignpostText:
	text "Omastar Fossil"
	line "(Helix)"

	para "A primitive and"
	line "rare Pokémon."
	done

AerodactylFossilSignpostText:
	text "Aerodactyl Fossil"

	para "A primitive and"
	line "rare Pokémon."
	done

Museum1FBookshelfSignpostText:
	text "Thick and well-"
	line "read books!"

	para "Archaeology Man-"
	line "ual, Lost #mon,"
	cont "#mon Ancestors,"

	para "Caring at the"
	line "Loamy Layer of"
	cont "Kanto…"
	done

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

NoFossilsText:
	text "Hey! You don't"
	line "have any fossils."
	done

MaybeLaterText:
	text "Just talk to me"
	line "if you change"
	cont "your mind."
	done

ResurrectingPokemonText:
	text "Okay! I'll"
	line "resurrect the"
	cont "#mon for you!"
	done

NoRoomForFossilPokemonText:
	text "Hey! You can't"
	line "carry another"
	cont "#mon."
	done

GotOmanyteText:
	text "<PLAYER> received"
	line "Omanyte."
	done

GotKabutoText:
	text "<PLAYER> received"
	line "Kabuto."
	done

GotAerodactylText:
	text "<PLAYER> received"
	line "Aerodactyl."
	done

TakeGoodCareOfItText:
	text "Take good care"
	line "of it!"
	done

PewterMuseumOfScience1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 5
	warp_def $7, $a, 6, PEWTER_CITY
	warp_def $7, $b, 6, PEWTER_CITY
	warp_def $7, $10, 7, PEWTER_CITY
	warp_def $7, $11, 7, PEWTER_CITY
	warp_def $7, $7, 1, PEWTER_MUSEUM_OF_SCIENCE_2F

.XYTriggers:
	db 0

.Signposts:
	db 10
	signpost 4, 11, SIGNPOST_READ, Museum1FReceptionistDeskSignpostScript
	signpost 3, 2, SIGNPOST_READ, KabutopsFossilSignpostScript
	signpost 3, 4, SIGNPOST_READ, OmastarFossilSignpostScript
	signpost 6, 2, SIGNPOST_READ, AerodactylFossilSignpostScript
	signpost 1, 12, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 13, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 14, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 15, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 16, SIGNPOST_READ, Museum1FBookshelfSignpostScript
	signpost 1, 17, SIGNPOST_READ, Museum1FBookshelfSignpostScript

.PersonEvents:
	db 4
	person_event SPRITE_RECEPTIONIST, 4, 12, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FReceptionistScript, -1
	person_event SPRITE_SCIENTIST, 2, 16, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FScientistScript, -1
	person_event SPRITE_SCIENTIST, 3, 18, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, Museum1FFossilScientistScript, -1
	person_event SPRITE_GRAMPS, 4, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Museum1FGrampsScript, -1
