engine_flag: MACRO
	dwb \1, 1 << \2
ENDM

EngineFlags: ; 80462
; All locations are in WRAM bank 1.

	; location, bit

	; pokegear
	engine_flag wPokegearFlags, 1 ; radio card ; $0
	engine_flag wPokegearFlags, 0 ; map card
	engine_flag wPokegearFlags, 2 ; phone card
	engine_flag wPokegearFlags, 3 ; expn card
	engine_flag wPokegearFlags, 7 ; on/off

	;   wDaycareMan, 7 ; daycare 1 on
	engine_flag wDaycareMan, 6 ; egg is ready
	;   wDaycareMan, 5 ; monster 1 and 2 are compatible
	engine_flag wDaycareMan, 0 ; monster 1 in daycare
	;   wDaycareLady, 7 = daycare 2 on
	engine_flag wDaycareLady, 0 ; monster 2 in daycare

	engine_flag wMomSavingMoney, 0 ; mom saving money ; $8
	engine_flag wMomSavingMoney, 7 ; dst

	engine_flag StatusFlags, 0 ; pokedex
	engine_flag StatusFlags, 1 ; unown dex
	                           ; flash
	engine_flag StatusFlags, 3 ; pokerus
	engine_flag StatusFlags, 4 ; rocket signal on ch20
	                           ; wild encounters on/off
	engine_flag StatusFlags, 6 ; credits skip
	engine_flag StatusFlags, 7 ; bug contest on
	engine_flag StatusFlags2, 0 ; rockets in radio tower ; $10
	engine_flag StatusFlags2, 1 ; safari game
	engine_flag StatusFlags2, 2 ; bug contest timer
	engine_flag StatusFlags2, 3 ; seen shamouti island
	engine_flag StatusFlags2, 4 ; bike shop call enabled (1024 bike steps reqd)
	engine_flag StatusFlags2, 5 ; give pokerus
	engine_flag StatusFlags2, 6 ; exorcised lav radio tower
	engine_flag StatusFlags2, 7 ; rockets in mahogany

	engine_flag BikeFlags, 0 ; strength active ; $18
	engine_flag BikeFlags, 1 ; always on bike (cant surf)
	engine_flag BikeFlags, 2 ; downhill (cycling road)

	engine_flag JohtoBadges, 0 ; zephyrbadge
	engine_flag JohtoBadges, 1 ; hivebadge
	engine_flag JohtoBadges, 2 ; plainbadge
	engine_flag JohtoBadges, 3 ; fogbadge
	engine_flag JohtoBadges, 4 ; mineralbadge
	engine_flag JohtoBadges, 5 ; stormbadge ; $20
	engine_flag JohtoBadges, 6 ; glacierbadge
	engine_flag JohtoBadges, 7 ; risingbadge

	engine_flag KantoBadges, 0 ; boulderbadge
	engine_flag KantoBadges, 1 ; cascadebadge
	engine_flag KantoBadges, 2 ; thunderbadge
	engine_flag KantoBadges, 3 ; rainbowbadge
	engine_flag KantoBadges, 4 ; soulbadge
	engine_flag KantoBadges, 5 ; marshbadge ; $28
	engine_flag KantoBadges, 6 ; volcanobadge
	engine_flag KantoBadges, 7 ; earthbadge

	; unown sets
	engine_flag UnlockedUnowns, 0 ; 1
	engine_flag UnlockedUnowns, 1 ; 2
	engine_flag UnlockedUnowns, 2 ; 3
	engine_flag UnlockedUnowns, 3 ; 4
	engine_flag UnlockedUnowns, 4 ; 5
	engine_flag UnlockedUnowns, 5 ; 6 ; $30
	engine_flag UnlockedUnowns, 6 ; 7
	engine_flag UnlockedUnowns, 7 ; 8

	; fly
	engine_flag VisitedSpawns, 0     ; your house
	engine_flag VisitedSpawns, 1     ; pallet
	engine_flag VisitedSpawns, 2     ; viridian
	engine_flag VisitedSpawns, 3     ; pewter
	engine_flag VisitedSpawns, 4     ; mt moon
	engine_flag VisitedSpawns, 5     ; cerulean ; $38
	engine_flag VisitedSpawns, 6     ; rock tunnel
	engine_flag VisitedSpawns, 7     ; vermilion
	engine_flag VisitedSpawns + 1, 0 ; lavender
	engine_flag VisitedSpawns + 1, 1 ; saffron
	engine_flag VisitedSpawns + 1, 2 ; celadon
	engine_flag VisitedSpawns + 1, 3 ; fuchsia
	engine_flag VisitedSpawns + 1, 4 ; cinnabar
	engine_flag VisitedSpawns + 1, 5 ; indigo plateau ; $40
	engine_flag VisitedSpawns + 1, 6 ; new bark
	engine_flag VisitedSpawns + 1, 7 ; cherrygrove
	engine_flag VisitedSpawns + 2, 0 ; violet
	engine_flag VisitedSpawns + 2, 1 ; union cave
	engine_flag VisitedSpawns + 2, 2 ; azalea
	engine_flag VisitedSpawns + 2, 3 ; cianwood
	engine_flag VisitedSpawns + 2, 4 ; goldenrod
	engine_flag VisitedSpawns + 2, 5 ; olivine ; $48
	engine_flag VisitedSpawns + 2, 6 ; ecruteak
	engine_flag VisitedSpawns + 2, 7 ; mahogany
	engine_flag VisitedSpawns + 3, 0 ; lake of rage
	engine_flag VisitedSpawns + 3, 1 ; blackthorn
	engine_flag VisitedSpawns + 3, 2 ; silver cave

	engine_flag wLuckyNumberShowFlag, 0 ; lucky number show

	engine_flag DailyFlags, 0 ; kurt making balls
	engine_flag DailyFlags, 1 ; daily bug contest? ; $50
	engine_flag DailyFlags, 2 ; special wilddata?
	engine_flag DailyFlags, 3 ; valeries morning walk
	engine_flag DailyFlags, 4 ; all fruit trees
	engine_flag DailyFlags, 5 ; wobbuffet given
	engine_flag DailyFlags, 6 ; goldenrod underground merchant closed
	engine_flag DailyFlags, 7 ; fought in trainer hall today

	engine_flag DailyFlags2, 0 ; gym leader rematch 1
	engine_flag DailyFlags2, 1 ; gym leader rematch 2 ; $58
	engine_flag DailyFlags2, 2 ; gym leader rematch 3
	engine_flag DailyFlags2, 3 ; daily photograph
	engine_flag DailyFlags2, 4 ; daily shrine visit
	engine_flag DailyFlags2, 5 ; daily mystery gift
	engine_flag DailyFlags2, 6 ; red in mt. silver
	engine_flag DailyFlags2, 7 ; leaf in navel rock

	engine_flag DailyFlags3, 0 ; bought leftovers
	engine_flag DailyFlags3, 1 ; took hyper test ; $60
	engine_flag DailyFlags3, 2 ; cheryl done today
	engine_flag DailyFlags3, 3 ; riley done today
	engine_flag DailyFlags3, 4 ; buck done today
	engine_flag DailyFlags3, 5 ; marley done today
	engine_flag DailyFlags3, 6 ; mira done today
	engine_flag DailyFlags3, 7 ; anabel done today

	engine_flag DailyFlags4, 0 ; seashore shell bell
	engine_flag DailyFlags4, 1 ; shamouti restaurant challenge ; $68
	engine_flag DailyFlags4, 2 ; fought psychic inver
	engine_flag DailyFlags4, 3 ; bought moomoo milk
	engine_flag DailyFlags4, 4 ; changed trendy phrase
	engine_flag DailyFlags4, 5 ; all hidden grottoes
	engine_flag DailyFlags4, 6 ; daily unused
	engine_flag DailyFlags4, 7 ; daily unused

	engine_flag WeeklyFlags, 0 ; mt moon square clefairy
	engine_flag WeeklyFlags, 1 ; union cave lapras ; $70
	engine_flag WeeklyFlags, 2 ; goldenrod underground haircut used
	engine_flag WeeklyFlags, 3 ; goldenrod mall happiness event floor05 person07
	engine_flag WeeklyFlags, 4 ; tea in blues house
	engine_flag WeeklyFlags, 5 ; indigo plateau rival fight
	engine_flag WeeklyFlags, 6 ; indigo plateau lyra fight
	engine_flag WeeklyFlags, 7 ; buenas password

	engine_flag SwarmFlags, 0 ; buenas password 2
	engine_flag SwarmFlags, 1 ; goldenrod dept store sale is on ; $78

	engine_flag GameTimerPause, 7 ; game timer pause

	engine_flag PlayerGender, 0 ; player is female

	engine_flag wCelebiEvent, 2 ; have gs ball after kurt examined it
	engine_flag wCelebiEvent, 3 ; have silphscope2
	engine_flag wCelebiEvent, 4 ; have shiny charm

	; rematches
	engine_flag wDailyRematchFlags, 0 ; jack
	engine_flag wDailyRematchFlags, 1 ; huey
	engine_flag wDailyRematchFlags, 2 ; gaven
	engine_flag wDailyRematchFlags, 3 ; beth
	engine_flag wDailyRematchFlags, 4 ; jose ; $80
	engine_flag wDailyRematchFlags, 5 ; reena
	engine_flag wDailyRematchFlags, 6 ; joey
	engine_flag wDailyRematchFlags, 7 ; wade
	engine_flag wDailyRematchFlags + 1, 0 ; ralph
	engine_flag wDailyRematchFlags + 1, 1 ; liz
	engine_flag wDailyRematchFlags + 1, 2 ; anthony
	engine_flag wDailyRematchFlags + 1, 3 ; todd
	engine_flag wDailyRematchFlags + 1, 4 ; gina ; $88
	engine_flag wDailyRematchFlags + 1, 5 ; arnie
	engine_flag wDailyRematchFlags + 1, 6 ; alan
	engine_flag wDailyRematchFlags + 1, 7 ; dana
	engine_flag wDailyRematchFlags + 2, 0 ; chad
	engine_flag wDailyRematchFlags + 2, 1 ; tully
	engine_flag wDailyRematchFlags + 2, 2 ; brent
	engine_flag wDailyRematchFlags + 2, 3 ; tiffany
	engine_flag wDailyRematchFlags + 2, 4 ; vance ; $90
	engine_flag wDailyRematchFlags + 2, 5 ; wilton
	engine_flag wDailyRematchFlags + 2, 6 ; parry
	engine_flag wDailyRematchFlags + 2, 7 ; erin

	engine_flag wDailyPhoneItemFlags, 0 ; beverly has nugget
	engine_flag wDailyPhoneItemFlags, 1 ; jose has star piece
	engine_flag wDailyPhoneItemFlags, 2 ; wade has item (see EVENT_WADE_HAS_*** in constants/event_flags.asm)
	engine_flag wDailyPhoneItemFlags, 3 ; gina has leaf stone
	engine_flag wDailyPhoneItemFlags, 4 ; alan has fire stone ; $98
	engine_flag wDailyPhoneItemFlags, 5 ; liz has thunderstone
	engine_flag wDailyPhoneItemFlags, 6 ; derek has nugget
	engine_flag wDailyPhoneItemFlags, 7 ; tully has water stone

	engine_flag wDailyPhoneItemFlags + 1, 0 ; tiffany has pink bow
	engine_flag wDailyPhoneItemFlags + 1, 1 ; wilton has item (see EVENT_WILTON_HAS_*** in constants/event_flags.asm)

	engine_flag wDailyPhoneTimeOfDayFlags, 0 ; jack monday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 1 ; huey wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags, 2 ; gaven thursday morning ; $a0
	engine_flag wDailyPhoneTimeOfDayFlags, 3 ; beth friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 4 ; jose saturday night
	engine_flag wDailyPhoneTimeOfDayFlags, 5 ; reena sunday morning
	engine_flag wDailyPhoneTimeOfDayFlags, 6 ; joey monday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags, 7 ; wade tuesday night

	engine_flag wDailyPhoneTimeOfDayFlags + 1, 0 ; ralph wednesday morning
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 1 ; liz thursday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 2 ; anthony fiday night ; $a8
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 3 ; todd saturday morning
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 4 ; gina sunday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 5 ; arnie tuesday morning
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 6 ; alan wednesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags + 1, 7 ; dana thursday night

	engine_flag wDailyPhoneTimeOfDayFlags + 2, 0 ; chad friday morning
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 1 ; tully sunday night
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 2 ; brent monday morning ; $b0
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 3 ; tiffany tuesday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 4 ; vance wednesday night
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 5 ; wilton thursday morning
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 6 ; parry friday afternoon
	engine_flag wDailyPhoneTimeOfDayFlags + 2, 7 ; erin saturday night

	engine_flag wPlayerSpriteSetupFlags, 2 ; female player has been transformed into male

	engine_flag SwarmFlags, 2 ; dunsparce swarm
	engine_flag SwarmFlags, 3 ; yanma swarm ; $b8

	engine_flag PokemonJournals, 0 ; read falkner journal
	engine_flag PokemonJournals, 1 ; read bugsy journal
	engine_flag PokemonJournals, 2 ; read whitney journal
	engine_flag PokemonJournals, 3 ; read morty journal
	engine_flag PokemonJournals, 4 ; read chuck journal
	engine_flag PokemonJournals, 5 ; read jasmine journal
	engine_flag PokemonJournals, 6 ; read pryce journal
	engine_flag PokemonJournals, 7 ; read clair journal ; $c0

	engine_flag PokemonJournals + 1, 0 ; read brock journal
	engine_flag PokemonJournals + 1, 1 ; read misty journal
	engine_flag PokemonJournals + 1, 2 ; read lt.surge journal
	engine_flag PokemonJournals + 1, 3 ; read erika journal
	engine_flag PokemonJournals + 1, 4 ; read janine journal
	engine_flag PokemonJournals + 1, 5 ; read sabrina journal
	engine_flag PokemonJournals + 1, 6 ; read blaine journal
	engine_flag PokemonJournals + 1, 7 ; read blue journal ; $c8

	engine_flag PokemonJournals + 2, 0 ; read will journal
	engine_flag PokemonJournals + 2, 1 ; read koga journal
	engine_flag PokemonJournals + 2, 2 ; read bruno journal
	engine_flag PokemonJournals + 2, 3 ; read karen journal
	engine_flag PokemonJournals + 2, 4 ; read lance journal
	engine_flag PokemonJournals + 2, 5 ; read red journal
	engine_flag PokemonJournals + 2, 6 ; read green journal
	engine_flag PokemonJournals + 2, 7 ; read prof.oak journal ; $d0

	engine_flag PokemonJournals + 3, 0 ; read prof.elm journal
	engine_flag PokemonJournals + 3, 1 ; read prof.ivy journal
	engine_flag PokemonJournals + 3, 2 ; read giovanni journal
	engine_flag PokemonJournals + 3, 3 ; read lorelei journal
	engine_flag PokemonJournals + 3, 4 ; read agatha journal
	engine_flag PokemonJournals + 3, 5 ; read bill journal
	engine_flag PokemonJournals + 3, 6 ; read kurt journal
	engine_flag PokemonJournals + 3, 7 ; read mr.fuji journal ; $d8
