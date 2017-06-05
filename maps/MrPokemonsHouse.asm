const_value set 2
	const MRPOKEMONSHOUSE_GENTLEMAN
	const MRPOKEMONSHOUSE_OAK
	const MRPOKEMONSHOUSE_POKEDEX

MrPokemonsHouse_MapScriptHeader:
.MapTriggers:
	db 2
	maptrigger .Trigger0
	maptrigger .Trigger1

.MapCallbacks:
	db 0

.Trigger0:
	priorityjump .MrPokemonEvent
	end

.Trigger1:
	end

.MrPokemonEvent:
	showemote EMOTE_SHOCK, MRPOKEMONSHOUSE_GENTLEMAN, 15
	spriteface MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	opentext
	writetext MrPokemonIntroText1
	waitbutton
	closetext
	applymovement PLAYER, MrPokemonsHouse_PlayerWalksToMrPokemon
	opentext
	writetext MrPokemonIntroText2
	buttonsound
	waitsfx
	giveitem MYSTERY_EGG
	writetext MrPokemonsHouse_GotEggText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	blackoutmod CHERRYGROVE_CITY
	writetext MrPokemonIntroText3
	buttonsound
	spriteface MRPOKEMONSHOUSE_GENTLEMAN, RIGHT
	writetext MrPokemonIntroText4
	buttonsound
	spriteface MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	spriteface MRPOKEMONSHOUSE_OAK, LEFT
	writetext MrPokemonIntroText5
	waitbutton
	closetext
	jump MrPokemonsHouse_OakScript

MrPokemonsHouse_MrPokemonScript:
	faceplayer
	opentext
	checkitem RED_SCALE
	iftrue .RedScale
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .AlwaysNewDiscoveries
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	end

.AlwaysNewDiscoveries:
	writetext MrPokemonText_AlwaysNewDiscoveries
	waitbutton
	closetext
	end

.RedScale:
	writetext MrPokemonText_GimmeTheScale
	yesorno
	iffalse .refused
	checkcode VAR_PARTYCOUNT
	if_equal PARTY_LENGTH, .party_full
	special GiveShinyDittoEgg
	opentext
	writetext MrPokemonText_GotShinyDittoEgg
	playsound SFX_KEY_ITEM
	waitsfx
	takeitem RED_SCALE
	jump .AlwaysNewDiscoveries

.refused
	writetext MrPokemonText_Disappointed
	waitbutton
	closetext
	end

.party_full
	writetext MrPokemonText_PartyFull
	waitbutton
	closetext
	end

MrPokemonsHouse_OakScript:
	playmusic MUSIC_PROF_OAK
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakWalksToPlayer
	spriteface PLAYER, RIGHT
	opentext
	writetext MrPokemonsHouse_OakText1
	waitbutton
	closetext
	spriteface MRPOKEMONSHOUSE_OAK, UP
	pause 10
	applymovement MRPOKEMONSHOUSE_POKEDEX, MrPokemonsHouse_OakTakesPokedex
	disappear MRPOKEMONSHOUSE_POKEDEX
	pause 10
	spriteface MRPOKEMONSHOUSE_OAK, LEFT
	pause 10
	opentext
	writetext MrPokemonsHouse_GetDexText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_POKEDEX
	writetext MrPokemonsHouse_OakText2
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakExits
	playsound SFX_EXIT_BUILDING
	disappear MRPOKEMONSHOUSE_OAK
	waitsfx
	special RestartMapMusic
	pause 15
	spriteface PLAYER, UP
	opentext
	writetext MrPokemonsHouse_MrPokemonHealText
	waitbutton
	closetext
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	opentext
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	setevent EVENT_RIVAL_NEW_BARK_TOWN
	setevent EVENT_KRISS_HOUSE_1F_NEIGHBOR
	clearevent EVENT_KRISS_NEIGHBORS_HOUSE_NEIGHBOR
	dotrigger $1
	domaptrigger CHERRYGROVE_CITY, $1
	domaptrigger ELMS_LAB, $3
	specialphonecall SPECIALCALL_ROBBED
	clearevent EVENT_COP_IN_ELMS_LAB
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .RivalTakesChikorita
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .RivalTakesCyndaquil
	setevent EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesChikorita:
	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesCyndaquil:
	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	end

MapMrPokemonsHouseSignpost1Script:
	jumptext MrPokemonsHouse_ForeignMagazinesText

MapMrPokemonsHouseSignpost3Script:
	jumptext MrPokemonsHouse_BrokenComputerText

MapMrPokemonsHouseSignpost4Script:
	jumptext MrPokemonsHouse_StrangeCoinsText

MrPokemonsHouse_PlayerWalksToMrPokemon:
	step_right
	step_up
	step_end

MrPokemonsHouse_OakWalksToPlayer:
	step_down
	step_left
	step_left
	step_end

MrPokemonsHouse_OakTakesPokedex:
	fix_facing
	slide_step_down
	remove_fixed_facing
	step_end

MrPokemonsHouse_OakExits:
	step_down
	step_left
	turn_head_down
	step_sleep_2
	step_end

MrPokemonIntroText1:
	text "Hello, hello! You"
	line "must be <PLAYER>."

	para "Prof.Elm said that"
	line "you would visit."
	done

MrPokemonIntroText2:
	text "This is what I"
	line "want Prof.Elm to"
	cont "examine."
	done

MrPokemonsHouse_GotEggText:
	text "<PLAYER> received"
	line "Mystery Egg."
	done

MrPokemonIntroText3:
	text "I know a couple"
	line "who run a #mon"
	cont "Day-Care service."

	para "They gave me that"
	line "Egg."

	para "I was intrigued,"
	line "so I sent mail to"
	cont "Prof.Elm."

	para "For #mon evolu-"
	line "tion, Prof.Elm is"
	cont "the authority."
	done

MrPokemonIntroText4:
	text "Even Prof.Oak here"
	line "recognizes that."
	done

MrPokemonIntroText5:
	text "If my assumption"
	line "is correct, Prof."
	cont "Elm will know it."
	done

MrPokemonsHouse_MrPokemonHealText:
	text "You are returning"
	line "to Prof.Elm?"

	para "Here. Your #mon"
	line "should have some"
	cont "rest."
	done

MrPokemonText_ImDependingOnYou:
	text "I'm depending on"
	line "you!"
	done

MrPokemonText_AlwaysNewDiscoveries:
	text "Life is delight-"
	line "ful! Always, new"

	para "discoveries to be"
	line "made!"
	done

MrPokemonsHouse_OakText1:
	text "Oak: Aha! So"
	line "you're <PLAYER>!"

	para "I'm Oak! A #mon"
	line "researcher."

	para "I was just visit-"
	line "ing my old friend"
	cont "Mr.#mon."

	para "I heard you were"
	line "running an errand"

	para "for Prof.Elm, so I"
	line "waited here."

	para "Oh! What's this?"
	line "A rare #mon!"

	para "Let's see…"

	para "Hm, I see!"

	para "I understand why"
	line "Prof.Elm gave you"

	para "a #mon for this"
	line "errand."

	para "To researchers"
	line "like Prof.Elm and"

	para "I, #mon are our"
	line "friends."

	para "He saw that you"
	line "would treat your"

	para "#mon with love"
	line "and care."

	para "…Ah!"

	para "You seem to be"
	line "dependable."

	para "How would you like"
	line "to help me out?"

	para "See? This is the"
	line "latest version of"
	cont "#dex."

	para "It automatically"
	line "records data on"

	para "#mon you've"
	line "seen or caught."

	para "It's a hi-tech"
	line "encyclopedia!"
	done

MrPokemonsHouse_GetDexText:
	text "<PLAYER> received"
	line "#dex!"
	done

MrPokemonsHouse_OakText2:
	text "Go meet many kinds"
	line "of #mon and"

	para "complete that"
	line "#dex!"

	para "But I've stayed"
	line "too long."

	para "I have to get to"
	line "Goldenrod for my"
	cont "usual radio show."

	para "<PLAYER>, I'm"
	line "counting on you!"
	done

MrPokemonText_GimmeTheScale:
	text "Hm? That Scale!"
	line "What's that?"
	cont "A red Gyarados?"

	para "That's rare! "
	line "I, I want it…"

	para "<PLAYER>, would you"
	line "care to trade it?"

	para "I can offer this"
	line "#mon Egg I got"
	cont "from Prof.Oak."
	done

MrPokemonText_GotShinyDittoEgg:
	text "<PLAYER> received"
	line "Rare Egg!"
	done

MrPokemonText_PartyFull:
	text "You don't have any"
	line "room for this!"
	done

MrPokemonText_Disappointed:
	text "That's disappoint-"
	line "ing. That happens"
	cont "to be very rare."
	done

MrPokemonsHouse_ForeignMagazinesText:
	text "It's packed with"
	line "foreign magazines."

	para "Can't even read"
	line "their titles…"
	done

MrPokemonsHouse_BrokenComputerText:
	text "It's a big com-"
	line "puter. Hmm. It's"
	cont "broken."
	done

MrPokemonsHouse_StrangeCoinsText:
	text "A whole pile of"
	line "strange coins!"

	para "Maybe they're from"
	line "another country…"
	done

MrPokemonsHouse_MapEventHeader:
.Warps:
	db 2
	warp_def $7, $2, 2, ROUTE_30
	warp_def $7, $3, 2, ROUTE_30

.XYTriggers:
	db 0

.Signposts:
	db 5
	signpost 1, 0, SIGNPOST_READ, MapMrPokemonsHouseSignpost1Script
	signpost 1, 1, SIGNPOST_READ, MapMrPokemonsHouseSignpost1Script
	signpost 1, 6, SIGNPOST_READ, MapMrPokemonsHouseSignpost3Script
	signpost 1, 7, SIGNPOST_READ, MapMrPokemonsHouseSignpost3Script
	signpost 4, 6, SIGNPOST_READ, MapMrPokemonsHouseSignpost4Script

.PersonEvents:
	db 3
	person_event SPRITE_GENTLEMAN, 5, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, MrPokemonsHouse_MrPokemonScript, -1
	person_event SPRITE_OAK, 5, 6, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MR_POKEMONS_HOUSE_OAK
	person_event SPRITE_POKEDEX_UNOWN_A, 4, 4, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_GOT_POKEDEX_FROM_OAK
