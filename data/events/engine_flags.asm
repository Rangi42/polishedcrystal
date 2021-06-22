engine_flag: MACRO
; location, bit
; (all locations are in WRAM bank 1)
	dwb \1 + (\2 / 8), 1 << (\2 % 8)
ENDM

EngineFlags:
; entries correspond to ENGINE_* constants
	table_width 3, EngineFlags

	; pokegear
	engine_flag wPokegearFlags, 1 ; radio card ; $0
	engine_flag wPokegearFlags, 0 ; map card
	engine_flag wPokegearFlags, 2 ; phone card
	engine_flag wPokegearFlags, 3 ; expn card
	engine_flag wPokegearFlags, 7 ; on/off

	;   wDayCareMan, DAYCAREMAN_ACTIVE_F ; daycare 1 on
	engine_flag wDayCareMan, DAYCAREMAN_HAS_EGG_F ; egg is ready
	;   wDayCareMan, DAYCAREMAN_MONS_COMPATIBLE_F ; monster 1 and 2 are compatible
	engine_flag wDayCareMan, DAYCAREMAN_HAS_MON_F ; monster 1 in daycare
	;   wDayCareLady, DAYCARELADY_ACTIVE_F = daycare 2 on
	engine_flag wDayCareLady, DAYCARELADY_HAS_MON_F ; monster 2 in daycare

	engine_flag wMomSavingMoney, 0 ; mom saving money ; $8
	engine_flag wMomSavingMoney, 7 ; dst

	engine_flag wStatusFlags, 0 ; pokedex
	engine_flag wStatusFlags, 1 ; unown dex
	                            ; flash
	engine_flag wStatusFlags, 3 ; pokerus
	engine_flag wStatusFlags, 4 ; rocket signal on ch20
	                            ; wild encounters on/off
	engine_flag wStatusFlags, 6 ; credits skip
	engine_flag wStatusFlags, 7 ; bug contest on

	engine_flag wStatusFlags2, 0 ; rockets in radio tower
	engine_flag wStatusFlags2, 1 ; safari game
	engine_flag wStatusFlags2, 2 ; bug contest timer
	engine_flag wStatusFlags2, 3 ; seen shamouti island
	engine_flag wStatusFlags2, 4 ; bike shop call enabled (1024 bike steps reqd)
	engine_flag wStatusFlags2, 5 ; give pokerus
	engine_flag wStatusFlags2, 6 ; exorcised lav radio tower
	engine_flag wStatusFlags2, 7 ; rockets in mahogany

	engine_flag wOWState, OWSTATE_STRENGTH
	engine_flag wOWState, OWSTATE_BIKING_FORCED
	engine_flag wOWState, OWSTATE_BIKING_DOWNHILL
	engine_flag wOWState, OWSTATE_SURF
	engine_flag wOWState, OWSTATE_ROCK_SMASH
	engine_flag wOWState, OWSTATE_HEADBUTT
	engine_flag wOWState, OWSTATE_WHIRLPOOL
	engine_flag wOWState, OWSTATE_WATERFALL
	engine_flag wOWState, OWSTATE_CUT

	engine_flag wJohtoBadges, ZEPHYRBADGE
	engine_flag wJohtoBadges, HIVEBADGE
	engine_flag wJohtoBadges, PLAINBADGE
	engine_flag wJohtoBadges, FOGBADGE
	engine_flag wJohtoBadges, MINERALBADGE
	engine_flag wJohtoBadges, STORMBADGE
	engine_flag wJohtoBadges, GLACIERBADGE
	engine_flag wJohtoBadges, RISINGBADGE

	engine_flag wKantoBadges, BOULDERBADGE
	engine_flag wKantoBadges, CASCADEBADGE
	engine_flag wKantoBadges, THUNDERBADGE
	engine_flag wKantoBadges, RAINBOWBADGE
	engine_flag wKantoBadges, MARSHBADGE
	engine_flag wKantoBadges, SOULBADGE
	engine_flag wKantoBadges, VOLCANOBADGE
	engine_flag wKantoBadges, EARTHBADGE

	; unown sets
	engine_flag wUnlockedUnowns, 0 ; 1
	engine_flag wUnlockedUnowns, 1 ; 2
	engine_flag wUnlockedUnowns, 2 ; 3
	engine_flag wUnlockedUnowns, 3 ; 4
	engine_flag wUnlockedUnowns, 4 ; 5
	engine_flag wUnlockedUnowns, 5 ; 6
	engine_flag wUnlockedUnowns, 6 ; 7
	engine_flag wUnlockedUnowns, 7 ; 8

	; fly
	engine_flag wVisitedSpawns, 0  ; your house
	engine_flag wVisitedSpawns, 1  ; pallet
	engine_flag wVisitedSpawns, 2  ; viridian
	engine_flag wVisitedSpawns, 3  ; pewter
	engine_flag wVisitedSpawns, 4  ; mt moon
	engine_flag wVisitedSpawns, 5  ; cerulean
	engine_flag wVisitedSpawns, 6  ; cerulean cape
	engine_flag wVisitedSpawns, 7  ; rock tunnel
	engine_flag wVisitedSpawns, 8  ; vermilion
	engine_flag wVisitedSpawns, 9  ; lavender
	engine_flag wVisitedSpawns, 10 ; saffron
	engine_flag wVisitedSpawns, 11 ; celadon
	engine_flag wVisitedSpawns, 12 ; fuchsia
	engine_flag wVisitedSpawns, 13 ; cinnabar
	engine_flag wVisitedSpawns, 14 ; indigo plateau
	engine_flag wVisitedSpawns, 15 ; new bark
	engine_flag wVisitedSpawns, 16 ; cherrygrove
	engine_flag wVisitedSpawns, 17 ; violet
	engine_flag wVisitedSpawns, 18 ; union cave
	engine_flag wVisitedSpawns, 19 ; azalea
	engine_flag wVisitedSpawns, 20 ; cianwood
	engine_flag wVisitedSpawns, 21 ; goldenrod
	engine_flag wVisitedSpawns, 22 ; olivine
	engine_flag wVisitedSpawns, 23 ; ecruteak
	engine_flag wVisitedSpawns, 24 ; mahogany
	engine_flag wVisitedSpawns, 25 ; yellow forest
	engine_flag wVisitedSpawns, 26 ; lake of rage
	engine_flag wVisitedSpawns, 27 ; blackthorn
	engine_flag wVisitedSpawns, 28 ; silver cave

	engine_flag wLuckyNumberShowFlag, 0 ; lucky number show

	engine_flag wDailyFlags, 0 ; kurt making balls
	engine_flag wDailyFlags, 1 ; daily bug contest?
	engine_flag wDailyFlags, 2 ; special wilddata?
	engine_flag wDailyFlags, 3 ; valeries morning walk
	engine_flag wDailyFlags, 4 ; daily unused
	engine_flag wDailyFlags, 5 ; shuckle given
	engine_flag wDailyFlags, 6 ; goldenrod underground merchant closed
	engine_flag wDailyFlags, 7 ; fought in trainer hall today

	engine_flag wDailyFlags2, 0 ; gym leader rematch 1
	engine_flag wDailyFlags2, 1 ; gym leader rematch 2
	engine_flag wDailyFlags2, 2 ; gym leader rematch 3
	engine_flag wDailyFlags2, 3 ; daily photograph
	engine_flag wDailyFlags2, 4 ; daily shrine visit
	engine_flag wDailyFlags2, 5 ; daily mystery gift
	engine_flag wDailyFlags2, 6 ; red in mt. silver
	engine_flag wDailyFlags2, 7 ; leaf in navel rock

	engine_flag wDailyFlags3, 0 ; bought leftovers
	engine_flag wDailyFlags3, 1 ; took hyper test
	engine_flag wDailyFlags3, 2 ; cheryl done today
	engine_flag wDailyFlags3, 3 ; riley done today
	engine_flag wDailyFlags3, 4 ; buck done today
	engine_flag wDailyFlags3, 5 ; marley done today
	engine_flag wDailyFlags3, 6 ; mira done today
	engine_flag wDailyFlags3, 7 ; anabel done today

	engine_flag wDailyFlags4, 0 ; seashore shell bell
	engine_flag wDailyFlags4, 1 ; shamouti restaurant challenge
	engine_flag wDailyFlags4, 2 ; fought psychic inver
	engine_flag wDailyFlags4, 3 ; bought moomoo milk
	engine_flag wDailyFlags4, 4 ; changed trendy phrase
	engine_flag wDailyFlags4, 5 ; all hidden grottoes
	engine_flag wDailyFlags4, 6 ; daily unused
	engine_flag wDailyFlags4, 7 ; daily unused

	engine_flag wWeeklyFlags, 0 ; mt moon square clefairy
	engine_flag wWeeklyFlags, 1 ; union cave lapras
	engine_flag wWeeklyFlags, 2 ; goldenrod underground haircut used
	engine_flag wWeeklyFlags, 3 ; goldenrod mall happiness event floor05 person07
	engine_flag wWeeklyFlags, 4 ; tea in blues house
	engine_flag wWeeklyFlags, 5 ; indigo plateau rival fight
	engine_flag wWeeklyFlags, 6 ; indigo plateau lyra fight
	engine_flag wWeeklyFlags, 7 ; buenas password

	engine_flag wSwarmFlags, 0 ; buenas password 2
	engine_flag wSwarmFlags, 1 ; goldenrod dept store sale is on

	engine_flag wGameTimerPaused, 7 ; game timer pause

	engine_flag wPlayerGender, 0 ; player is female

	engine_flag wCelebiEvent, 2 ; have gs ball after kurt examined it
	engine_flag wCelebiEvent, 3 ; have silphscope2
	engine_flag wCelebiEvent, 4 ; have shiny charm

	; rematches
	engine_flag wDailyRematchFlags, 0  ; jack
	engine_flag wDailyRematchFlags, 1  ; huey
	engine_flag wDailyRematchFlags, 2  ; gaven
	engine_flag wDailyRematchFlags, 3  ; beth
	engine_flag wDailyRematchFlags, 4  ; jose
	engine_flag wDailyRematchFlags, 5  ; reena
	engine_flag wDailyRematchFlags, 6  ; joey
	engine_flag wDailyRematchFlags, 7  ; wade
	engine_flag wDailyRematchFlags, 8  ; ralph
	engine_flag wDailyRematchFlags, 9  ; liz
	engine_flag wDailyRematchFlags, 10 ; anthony
	engine_flag wDailyRematchFlags, 11 ; todd
	engine_flag wDailyRematchFlags, 12 ; gina
	engine_flag wDailyRematchFlags, 13 ; arnie
	engine_flag wDailyRematchFlags, 14 ; alan
	engine_flag wDailyRematchFlags, 15 ; dana
	engine_flag wDailyRematchFlags, 16 ; chad
	engine_flag wDailyRematchFlags, 17 ; tully
	engine_flag wDailyRematchFlags, 18 ; brent
	engine_flag wDailyRematchFlags, 19 ; tiffany
	engine_flag wDailyRematchFlags, 20 ; vance
	engine_flag wDailyRematchFlags, 21 ; wilton
	engine_flag wDailyRematchFlags, 22 ; parry
	engine_flag wDailyRematchFlags, 23 ; erin

	engine_flag wDailyPhoneItemFlags, 0 ; beverly has nugget
	engine_flag wDailyPhoneItemFlags, 1 ; jose has star piece
	engine_flag wDailyPhoneItemFlags, 2 ; wade has item (see EVENT_WADE_HAS_*** in constants/event_flags.asm)
	engine_flag wDailyPhoneItemFlags, 3 ; gina has leaf stone
	engine_flag wDailyPhoneItemFlags, 4 ; alan has fire stone
	engine_flag wDailyPhoneItemFlags, 5 ; liz has thunderstone
	engine_flag wDailyPhoneItemFlags, 6 ; derek has nugget
	engine_flag wDailyPhoneItemFlags, 7 ; tully has water stone
	engine_flag wDailyPhoneItemFlags, 8 ; tiffany has pink bow
	engine_flag wDailyPhoneItemFlags, 9 ; wilton has item (see EVENT_WILTON_HAS_*** in constants/event_flags.asm)

	engine_flag wDailyPhoneTimeOfDayFlags, 0  ; jack monday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 1  ; huey wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 2  ; gaven thursday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 3  ; beth friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 4  ; jose saturday night
	engine_flag wDailyPhoneTimeOfDayFlags, 5  ; reena sunday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 6  ; joey monday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 7  ; wade tuesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 8  ; ralph wednesday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 9  ; liz thursday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 10 ; anthony fiday night
	engine_flag wDailyPhoneTimeOfDayFlags, 11 ; todd saturday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 12 ; gina sunday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 13 ; arnie tuesday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 14 ; alan wednesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 15 ; dana thursday night
	engine_flag wDailyPhoneTimeOfDayFlags, 16 ; chad friday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 17 ; tully sunday night
	engine_flag wDailyPhoneTimeOfDayFlags, 18 ; brent monday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 19 ; tiffany tuesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 20 ; vance wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 21 ; wilton thursday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 22 ; parry friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 23 ; erin saturday night

	engine_flag wPlayerSpriteSetupFlags, 2 ; female player has been transformed into male

	engine_flag wSwarmFlags, 2 ; dunsparce swarm
	engine_flag wSwarmFlags, 3 ; yanma swarm

	engine_flag wPokemonJournals, 0  ; falkner
	engine_flag wPokemonJournals, 1  ; bugsy
	engine_flag wPokemonJournals, 2  ; whitney
	engine_flag wPokemonJournals, 3  ; morty
	engine_flag wPokemonJournals, 4  ; chuck
	engine_flag wPokemonJournals, 5  ; jasmine
	engine_flag wPokemonJournals, 6  ; pryce
	engine_flag wPokemonJournals, 7  ; clair
	engine_flag wPokemonJournals, 8  ; brock
	engine_flag wPokemonJournals, 9  ; misty
	engine_flag wPokemonJournals, 10 ; lt.surge
	engine_flag wPokemonJournals, 11 ; erika
	engine_flag wPokemonJournals, 12 ; janine
	engine_flag wPokemonJournals, 13 ; sabrina
	engine_flag wPokemonJournals, 14 ; blaine
	engine_flag wPokemonJournals, 15 ; blue
	engine_flag wPokemonJournals, 16 ; will
	engine_flag wPokemonJournals, 17 ; koga
	engine_flag wPokemonJournals, 18 ; bruno
	engine_flag wPokemonJournals, 19 ; karen
	engine_flag wPokemonJournals, 20 ; lance
	engine_flag wPokemonJournals, 21 ; red
	engine_flag wPokemonJournals, 22 ; green
	engine_flag wPokemonJournals, 23 ; prof.oak
	engine_flag wPokemonJournals, 24 ; prof.elm
	engine_flag wPokemonJournals, 25 ; prof.ivy
	engine_flag wPokemonJournals, 26 ; prof.westwood
	engine_flag wPokemonJournals, 27 ; giovanni
	engine_flag wPokemonJournals, 28 ; lorelei
	engine_flag wPokemonJournals, 29 ; agatha
	engine_flag wPokemonJournals, 30 ; bill
	engine_flag wPokemonJournals, 31 ; kurt
	engine_flag wPokemonJournals, 32 ; mr.fuji

	engine_flag wStatusFlags3, 0 ; judge machine

	assert_table_length NUM_ENGINE_FLAGS
