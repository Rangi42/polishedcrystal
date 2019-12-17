KrissHouse2F_MapScriptHeader:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, KrissHouse2FInitializeRoom
	callback MAPCALLBACK_TILES, KrissHouse2FSetSpawn

	db 1 ; warp events
	warp_event  7,  0, KRISS_HOUSE_1F, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event  2,  1, SIGNPOST_UP, KrissHousePC
	bg_event  3,  1, SIGNPOST_READ, KrissHouseRadio
	bg_event  5,  1, SIGNPOST_READ, PokemonJournalProfElmScript
	bg_event  6,  0, SIGNPOST_IFSET, KrissHousePoster

	db 4 ; object events
	object_event  4,  2, SPRITE_CONSOLE, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, GameConsole, EVENT_KRISS_HOUSE_2F_CONSOLE
	object_event  4,  4, SPRITE_DOLL_1, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Doll1, EVENT_KRISS_HOUSE_2F_DOLL_1
	object_event  5,  4, SPRITE_DOLL_2, SPRITEMOVEDATA_DOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, Doll2, EVENT_KRISS_HOUSE_2F_DOLL_2
	object_event  0,  1, SPRITE_BIG_DOLL, SPRITEMOVEDATA_BIGDOLL, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BigDoll, EVENT_KRISS_HOUSE_2F_BIG_DOLL

KrissHouse2FInitializeRoom:
	special ToggleDecorationsVisibility
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	checkevent EVENT_INITIALIZED_EVENTS
	iftrue .SkipInizialization
	jumpstd initializeevents

.SkipInizialization:
	return

KrissHouse2FSetSpawn:
	special ToggleMaptileDecorations
	return

Doll1:
	describedecoration 1

Doll2:
	describedecoration 2

BigDoll:
	describedecoration 3

GameConsole:
	describedecoration 4

KrissHousePoster:
	dw EVENT_KRISS_ROOM_POSTER
	describedecoration 0

KrissHouseRadio:

if DEF(DEBUG)

	opentext
	; time
	special Special_SetDayOfWeek
	special Special_InitialClearDSTFlag
	; full pokegear
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	setflag ENGINE_MAP_CARD
	setflag ENGINE_RADIO_CARD
	setflag ENGINE_EXPN_CARD
	; pokedex
	setflag ENGINE_POKEDEX
	setflag ENGINE_UNOWN_DEX
	; all key items
x = 0
rept NUM_KEY_ITEMS
	givekeyitem x
x = x + 1
endr
	; all tms+hms
x = 0
rept NUM_TMS + NUM_HMS
	givetmhm x
x = x + 1
endr
	; all items
x = 1
rept NUM_ITEMS
	giveitem x, 99
x = x + 1
endr
	; all decorations
x = EVENT_DECO_BED_1
rept EVENT_DECO_BIG_LAPRAS_DOLL - EVENT_DECO_BED_1 + 1
	setevent x
x = x + 1
endr
	; max money
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 1000000
	givemoney $0, 999999
	givecoins 50000
	loadvar wBattlePoints, 250
	; all badges
	setflag ENGINE_ZEPHYRBADGE
	setflag ENGINE_HIVEBADGE
	setflag ENGINE_PLAINBADGE
	setflag ENGINE_FOGBADGE
	setflag ENGINE_STORMBADGE
	setflag ENGINE_MINERALBADGE
	setflag ENGINE_GLACIERBADGE
	setflag ENGINE_RISINGBADGE
	setflag ENGINE_BOULDERBADGE
	setflag ENGINE_CASCADEBADGE
	setflag ENGINE_THUNDERBADGE
	setflag ENGINE_RAINBOWBADGE
	setflag ENGINE_MARSHBADGE
	setflag ENGINE_SOULBADGE
	setflag ENGINE_VOLCANOBADGE
	setflag ENGINE_EARTHBADGE
	setevent EVENT_BEAT_FALKNER
	setevent EVENT_BEAT_BUGSY
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_BEAT_MORTY
	setevent EVENT_BEAT_CHUCK
	setevent EVENT_BEAT_JASMINE
	setevent EVENT_BEAT_PRYCE
	setevent EVENT_BEAT_CLAIR
	setevent EVENT_BEAT_BROCK
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_LTSURGE
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_JANINE
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_BLAINE
	setevent EVENT_BEAT_BLUE
	setevent EVENT_BEAT_ELITE_FOUR
	setevent EVENT_BEAT_ELITE_FOUR_AGAIN
	setevent EVENT_BATTLE_TOWER_OPEN
	clearevent EVENT_BATTLE_TOWER_CLOSED
	; fly anywhere
	setflag ENGINE_FLYPOINT_NEW_BARK
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	setflag ENGINE_FLYPOINT_VIOLET
	setflag ENGINE_FLYPOINT_UNION_CAVE
	setflag ENGINE_FLYPOINT_AZALEA
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_FLYPOINT_ECRUTEAK
	setflag ENGINE_FLYPOINT_OLIVINE
	setflag ENGINE_FLYPOINT_CIANWOOD
	setflag ENGINE_FLYPOINT_MAHOGANY
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	setflag ENGINE_FLYPOINT_BLACKTHORN
	setflag ENGINE_FLYPOINT_SILVER_CAVE
	setflag ENGINE_FLYPOINT_INDIGO_PLATEAU
	setflag ENGINE_FLYPOINT_PALLET
	setflag ENGINE_FLYPOINT_VIRIDIAN
	setflag ENGINE_FLYPOINT_PEWTER
	setflag ENGINE_FLYPOINT_MT_MOON
	setflag ENGINE_FLYPOINT_CERULEAN
	setflag ENGINE_FLYPOINT_VERMILION
	setflag ENGINE_FLYPOINT_CELADON
	setflag ENGINE_FLYPOINT_ROCK_TUNNEL
	setflag ENGINE_FLYPOINT_LAVENDER
	setflag ENGINE_FLYPOINT_FUCHSIA
	setflag ENGINE_FLYPOINT_SAFFRON
	setflag ENGINE_FLYPOINT_CINNABAR
	; magnet train works
	setevent EVENT_RESTORED_POWER_TO_KANTO
	; post-e4
	setflag ENGINE_CREDITS_SKIP
	setflag ENGINE_HAVE_SHINY_CHARM
	; good party
	givepoke MEWTWO, 100, ARMOR_SUIT
	loadvar wPartyMon1EVs+0, 252
	loadvar wPartyMon1EVs+1, 252
	loadvar wPartyMon1EVs+2, 252
	loadvar wPartyMon1EVs+3, 252
	loadvar wPartyMon1EVs+4, 252
	loadvar wPartyMon1EVs+5, 252
	loadvar wPartyMon1DVs+0, $ff
	loadvar wPartyMon1DVs+1, $ff
	loadvar wPartyMon1DVs+2, $ff
	loadvar wPartyMon1Personality, ABILITY_2 | MODEST
	loadvar wPartyMon1Stats+0, 999 / $100
	loadvar wPartyMon1Stats+1, 999 % $100
	loadvar wPartyMon1Stats+2, 999 / $100
	loadvar wPartyMon1Stats+3, 999 % $100
	loadvar wPartyMon1Stats+4, 999 / $100
	loadvar wPartyMon1Stats+5, 999 % $100
	loadvar wPartyMon1Stats+6, 999 / $100
	loadvar wPartyMon1Stats+7, 999 % $100
	loadvar wPartyMon1Stats+8, 999 / $100
	loadvar wPartyMon1Stats+9, 999 % $100
	; hm slaves
	givepoke MEW, 100, LEFTOVERS
	givepoke MEW, 100, LEFTOVERS
	loadvar wPartyMon2Moves+0, FLY
	loadvar wPartyMon2Moves+1, SURF
	loadvar wPartyMon2Moves+2, STRENGTH
	loadvar wPartyMon2Moves+3, CUT
	loadvar wPartyMon2PP+0, 15
	loadvar wPartyMon2PP+1, 15
	loadvar wPartyMon2PP+2, 15
	loadvar wPartyMon2PP+3, 30
	loadvar wPartyMon3Moves+0, FLASH
	loadvar wPartyMon3Moves+1, ROCK_SMASH
	loadvar wPartyMon3Moves+2, WHIRLPOOL
	loadvar wPartyMon3Moves+3, WATERFALL
	loadvar wPartyMon3PP+0, 20
	loadvar wPartyMon3PP+1, 15
	loadvar wPartyMon3PP+2, 15
	loadvar wPartyMon3PP+3, 15
	; fill pokedex
	callasm FillPokedex
	; intro events
	addcellnum PHONE_MOM
	setmapscene KRISS_HOUSE_1F, $1
	setevent EVENT_KRISS_HOUSE_MOM_1
	clearevent EVENT_KRISS_HOUSE_MOM_2
;	; prof.elm events
;	addcellnum PHONE_ELM
;	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
;	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
;	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
;	setevent EVENT_GOT_A_POKEMON_FROM_ELM
;	setevent EVENT_RIVAL_CHERRYGROVE_CITY
;	setevent EVENT_LYRA_IN_ELMS_LAB
;	setmapscene ELMS_LAB, $5
;	setmapscene NEW_BARK_TOWN, $2
	closetext
	end

FillPokedex:
	ld a, 1
	ld [wUnlockedUnownMode], a
	ld [wFirstUnownSeen], a
	ld [wFirstMagikarpSeen], a
	ld hl, wUnownDex
	ld a, 1
rept NUM_UNOWN
	ld [hli], a
	inc a
endr
	ld hl, wPokedexSeen
	call .Fill
	ld hl, wPokedexCaught
.Fill:
	ld a, %11111111
	ld bc, 31 ; 001-248
	call ByteFill
	ld a, %00111111
	ld [hl], a ; 249-254
	ret

else

	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .NormalRadio
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .AbbreviatedRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writetext KrisRadioText1
	pause 45
	writetext KrisRadioText2
	pause 45
	writetext KrisRadioText3
	pause 45
	musicfadeout MUSIC_NEW_BARK_TOWN, 16
	writetext KrisRadioText4
	pause 45
	closetext
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	end

.NormalRadio:
	jumpstd radio1

.AbbreviatedRadio:
	opentext
	writetext KrisRadioText4
	pause 45
	endtext

endc

PokemonJournalProfElmScript:
	setflag ENGINE_READ_PROF_ELM_JOURNAL
	thistext

	text "#mon Journal"

	para "Special Feature:"
	line "#mon Prof.Elm!"

	para "Prof.Elm was the"
	line "top student of"
	cont "Prof.Oak."

	para "They're said to"
	line "often argue about"
	cont "research."
	done

KrissHousePC:
	opentext
	special Special_KrissHousePC
	iftrue .Warp
	endtext
.Warp:
	warp NONE, 0, 0
	end

KrisRadioText1:
	text "Prof.Oak's #mon"
	line "Talk! Please tune"
	cont "in next time!"
	done

KrisRadioText2:
	text "#mon Channel!"
	done

KrisRadioText3:
	text "This is DJ Mary,"
	line "your co-host!"
	done

KrisRadioText4:
	text "#mon!"
	line "#mon Channel…"
	done
