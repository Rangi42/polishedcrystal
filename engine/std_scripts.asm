StdScripts::
	dba PokeCenterNurseScript
	dba DifficultBookshelfScript
	dba PictureBookshelfScript
	dba MagazineBookshelfScript
	dba TeamRocketOathScript
	dba IncenseBurnerScript
	dba MerchandiseShelfScript
	dba TownMapScript
	dba WindowScript
	dba TVScript
	dba Radio1Script
	dba Radio2Script
	dba TrashCanScript
	dba StrengthBoulderScript
	dba SmashRockScript
	dba PokeCenterSignScript
	dba MartSignScript
	dba GoldenrodRocketsScript
	dba RadioTowerRocketsScript
	dba ElevatorButtonScript
	dba DayToTextScript
	dba BugContestResultsWarpScript
	dba BugContestResultsScript
	dba InitializeEventsScript
	dba AskNumber1MScript
	dba AskNumber2MScript
	dba RegisteredNumberMScript
	dba NumberAcceptedMScript
	dba NumberDeclinedMScript
	dba PhoneFullMScript
	dba RematchMScript
	dba GiftMScript
	dba PackFullMScript
	dba RematchGiftMScript
	dba AskNumber1FScript
	dba AskNumber2FScript
	dba RegisteredNumberFScript
	dba NumberAcceptedFScript
	dba NumberDeclinedFScript
	dba PhoneFullFScript
	dba RematchFScript
	dba GiftFScript
	dba PackFullFScript
	dba RematchGiftFScript
	dba GymStatue0Script
	dba GymStatue1Script
	dba GymStatue2Script
	dba GymStatue3Script
	dba ReceiveItemScript
	dba PCScript
	dba GameCornerCoinVendorScript
	dba HappinessCheckScript
	dba CutTreeScript
	dba RefrigeratorScript
	dba SinkScript
	dba StoveScript
	dba VendingMachineScript
	dba TreeGrottoScript
	dba CaveGrottoScript

PokeCenterNurseScript:
	opentext
	checkevent EVENT_NURSE_SAW_FOUR_TRAINER_STARS
	iftrue .four_star_center
	checkmorn
	iftrue .morn
	checkday
	iftrue .day
	checknite
	iftrue .nite
	jump .ok

.morn
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .morn_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalse .morn_center
	farwritetext PokeComNurseMornText
	buttonsound
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	jump .ok
.morn_center
	farwritetext NurseMornText
	buttonsound
	jump .ok

.day
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .day_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalse .day_center
	farwritetext PokeComNurseDayText
	buttonsound
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	jump .ok
.day_center
	farwritetext NurseDayText
	buttonsound
	jump .ok

.nite
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .nite_center
	checkevent EVENT_WELCOMING_TO_POKECOM_CENTER
	iffalse .nite_center
	farwritetext PokeComNurseNiteText
	buttonsound
	setevent EVENT_WELCOMED_TO_POKECOM_CENTER
	jump .ok
.nite_center
	farwritetext NurseNiteText
	buttonsound
	jump .ok

.ok
	checkcode VAR_TRAINER_STARS
	if_not_equal 4, .ask_heal
	farwritetext NurseFourTrainerStarsText
	setevent EVENT_NURSE_SAW_FOUR_TRAINER_STARS
	jump .answer_heal

.ask_heal
	farwritetext NurseAskHealText
.answer_heal
	yesorno
	iffalse .done
	jump .heal_pokemon

.four_star_center
	farwritetext NurseTheUsualText
	yesorno
	iffalse .done
.heal_pokemon
	farwritetext NurseTakePokemonText
	pause 20
	spriteface LAST_TALKED, LEFT
	pause 10
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 0 ; Machine is at a Pokemon Center
	special HealMachineAnim
	pause 30
	special RestoreMusic
	spriteface LAST_TALKED, DOWN
	pause 10

	checkphonecall ; elm already called about pokerus
	iftrue .no
	checkflag ENGINE_POKERUS ; nurse already talked about pokerus
	iftrue .no
	special SpecialCheckPokerus
	iftrue .pokerus
.no

	farwritetext NurseReturnPokemonText
	pause 20

.done
	farwritetext NurseGoodbyeText

	spriteface LAST_TALKED, UP
	pause 10
	spriteface LAST_TALKED, DOWN
	pause 10

	waitendtext

.pokerus
	; already cleared earlier in the script
	checkevent EVENT_WELCOMED_TO_POKECOM_CENTER
	iftrue .pokerus_comcenter
	farwritetext NursePokerusText
	waitbutton
	closetext
	jump .pokerus_done

.pokerus_comcenter
	farwritetext PokeComNursePokerusText
	waitbutton
	closetext

.pokerus_done
	setflag ENGINE_POKERUS
	specialphonecall SPECIALCALL_POKERUS
	end

DifficultBookshelfScript:
	farjumptext DifficultBookshelfText

PictureBookshelfScript:
	farjumptext PictureBookshelfText

MagazineBookshelfScript:
	farjumptext MagazineBookshelfText

TeamRocketOathScript:
	farjumptext TeamRocketOathText

IncenseBurnerScript:
	farjumptext IncenseBurnerText

MerchandiseShelfScript:
	farjumptext MerchandiseShelfText

RefrigeratorScript:
	farjumptext RefrigeratorText

SinkScript:
	farjumptext SinkText

StoveScript:
	farjumptext StoveText

TownMapScript:
	opentext
	farwritetext TownMapText
	waitbutton
	special Special_TownMap
	endtext

WindowScript:
	farjumptext WindowText

TVScript:
	checkcode VAR_FACING
	if_not_equal UP, WrongSideScript
	farjumptext TVText

WrongSideScript:
	farjumptext WrongSideText

Radio1Script:
	callasm IsKantoRadioOffAir
	iftrue RadioOffAirScript
	opentext
	writebyte MAPRADIO_POKEMON_CHANNEL
	special MapRadio
	endtext

Radio2Script:
	callasm IsKantoRadioOffAir
	iftrue RadioOffAirScript
	opentext
	writebyte MAPRADIO_LUCKY_CHANNEL
	special MapRadio
	endtext

RadioOffAirScript:
	farjumptext RadioOffAirText

IsKantoRadioOffAir:
	farcall RegionCheck
	ld a, e
	cp KANTO_REGION
	jr nz, .no
	ld a, [wPokegearFlags]
	bit 3, a
	jr nz, .no
	ld a, TRUE
	jr .ok
.no
	xor a ; ld a, FALSE
.ok
	ld [ScriptVar], a
	ret

TrashCanScript: ; 0xbc1a5
	farjumptext TrashCanText

PCScript:
	checkcode VAR_FACING
	if_not_equal UP, WrongSideScript
	opentext
	special PokemonCenterPC
	endtext

ElevatorButtonScript:
	playsound SFX_READ_TEXT_2
	pause 15
	playsound SFX_ELEVATOR_END
	end

StrengthBoulderScript:
	farjump AskStrengthScript

SmashRockScript:
	farjump AskRockSmashScript

PokeCenterSignScript:
	farjumptext PokeCenterSignText

MartSignScript
	farjumptext MartSignText

DayToTextScript:
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .Monday
	if_equal TUESDAY, .Tuesday
	if_equal WEDNESDAY, .Wednesday
	if_equal THURSDAY, .Thursday
	if_equal FRIDAY, .Friday
	if_equal SATURDAY, .Saturday
	stringtotext .SundayText, 0
	end
.Monday:
	stringtotext .MondayText, 0
	end
.Tuesday:
	stringtotext .TuesdayText, 0
	end
.Wednesday:
	stringtotext .WednesdayText, 0
	end
.Thursday:
	stringtotext .ThursdayText, 0
	end
.Friday:
	stringtotext .FridayText, 0
	end
.Saturday:
	stringtotext .SaturdayText, 0
	end
.SundayText:
	db "Sunday@"
.MondayText:
	db "Monday@"
.TuesdayText:
	db "Tuesday@"
.WednesdayText:
	db "Wednesday@"
.ThursdayText:
	db "Thursday@"
.FridayText:
	db "Friday@"
.SaturdayText:
	db "Saturday@"

GoldenrodRocketsScript:
	clearevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	end

RadioTowerRocketsScript:
	setflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_CIVILIANS
	setevent EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	clearevent EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	clearevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	setevent EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_EAST
	specialphonecall SPECIALCALL_WEIRDBROADCAST
	domaptrigger MAHOGANY_TOWN, $1
	end

BugContestResultsWarpScript:
	special ClearBGPalettes
	scall BugContestResults_CopyContestantsToResults
	setevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	clearevent EVENT_ROUTE_36_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
	setevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	warp ROUTE_36_NATIONAL_PARK_GATE, $0, $4
	applymovement PLAYER, Movement_ContestResults_WalkAfterWarp
	; fallthrough

BugContestResultsScript:
	clearflag ENGINE_BUG_CONTEST_TIMER
	clearevent EVENT_WARPED_FROM_ROUTE_35_NATIONAL_PARK_GATE
	clearevent EVENT_CONTEST_OFFICER_HAS_PRIZE
	opentext
	farwritetext ContestResults_ReadyToJudgeText
	waitbutton
	special BugContestJudging
	RAM2MEM $0
	if_equal 1, .FirstPlace
	if_equal 2, .SecondPlace
	if_equal 3, .ThirdPlace
	copybytetovar wBugContestOfficerPrize
	itemtotext $0, $1
	farwritetext ContestResults_ConsolationPrizeText
	buttonsound
	waitsfx
	copybytetovar wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iftrue .GotConsolationPrize
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_PRIZE
.GotConsolationPrize
	farwritetext ContestResults_DidNotWinText
	buttonsound
	jump .FinishUp

.FirstPlace
	setevent EVENT_GAVE_KURT_APRICORNS
.SecondPlace
.ThirdPlace
	copybytetovar wBugContestOfficerPrize
	itemtotext $0, $1
	farwritetext ContestResults_PlayerWonAPrizeText
	waitbutton
	copybytetovar wBugContestOfficerPrize
	verbosegiveitem ITEM_FROM_MEM
	iftrue .GotWinnersPrize
	farwritetext BugContestPrizeNoRoomText
	buttonsound
	setevent EVENT_CONTEST_OFFICER_HAS_PRIZE
.GotWinnersPrize
	farwritetext ContestResults_JoinUsNextTimeText
	buttonsound
.FinishUp
	checkevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	iffalse .DidNotLeaveMons
	farwritetext ContestResults_ReturnPartyText
	waitbutton
	special ContestReturnMons
.DidNotLeaveMons
	special CheckPartyFullAfterContest
	if_equal $0, .CleanUp
	if_equal $2, .CleanUp
	farwritetext ContestResults_PartyFullText
	waitbutton
.CleanUp
	closetext
	dotrigger $0
	domaptrigger ROUTE_35_NATIONAL_PARK_GATE, $0
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setflag ENGINE_DAILY_BUG_CONTEST
	special PlayMapMusic
	end
; 0xbc31e

BugContestResults_CopyContestantsToResults ; 0xbc380
	checkevent EVENT_BUG_CATCHING_CONTESTANT_1A
	iftrue .skip1
	clearevent EVENT_BUG_CATCHING_CONTESTANT_1B
.skip1
	checkevent EVENT_BUG_CATCHING_CONTESTANT_2A
	iftrue .skip2
	clearevent EVENT_BUG_CATCHING_CONTESTANT_2B
.skip2
	checkevent EVENT_BUG_CATCHING_CONTESTANT_3A
	iftrue .skip3
	clearevent EVENT_BUG_CATCHING_CONTESTANT_3B
.skip3
	checkevent EVENT_BUG_CATCHING_CONTESTANT_4A
	iftrue .skip4
	clearevent EVENT_BUG_CATCHING_CONTESTANT_4B
.skip4
	checkevent EVENT_BUG_CATCHING_CONTESTANT_5A
	iftrue .skip5
	clearevent EVENT_BUG_CATCHING_CONTESTANT_5B
.skip5
	checkevent EVENT_BUG_CATCHING_CONTESTANT_6A
	iftrue .skip6
	clearevent EVENT_BUG_CATCHING_CONTESTANT_6B
.skip6
	checkevent EVENT_BUG_CATCHING_CONTESTANT_7A
	iftrue .skip7
	clearevent EVENT_BUG_CATCHING_CONTESTANT_7B
.skip7
	checkevent EVENT_BUG_CATCHING_CONTESTANT_8A
	iftrue .skip8
	clearevent EVENT_BUG_CATCHING_CONTESTANT_8B
.skip8
	checkevent EVENT_BUG_CATCHING_CONTESTANT_9A
	iftrue .skip9
	clearevent EVENT_BUG_CATCHING_CONTESTANT_9B
.skip9
	checkevent EVENT_BUG_CATCHING_CONTESTANT_10A
	iftrue .skip10
	clearevent EVENT_BUG_CATCHING_CONTESTANT_10B
.skip10
	end

InitializeEventsScript:
	setevent EVENT_EARLS_ACADEMY_EARL
	setevent EVENT_VIOLET_GYM_FALKNER
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_ILEX_FOREST_APPRENTICE
	setevent EVENT_ILEX_FOREST_FARFETCHD
	setevent EVENT_ILEX_FOREST_CHARCOAL_MASTER
	setevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_PETREL
	setevent EVENT_TEAM_ROCKET_BASE_B2F_ARIANA
	setevent EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	setevent EVENT_RIVAL_TEAM_ROCKET_BASE
	setevent EVENT_BLACKTHORN_CITY_DRAGON_TAMER_DOES_NOT_BLOCK_GYM
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	setevent EVENT_LYRA_IN_HER_ROOM
	setevent EVENT_LYRA_NEW_BARK_TOWN
	setevent EVENT_LYRA_ROUTE_29
	setevent EVENT_LYRA_ROUTE_34
	setevent EVENT_LYRA_ROUTE_42
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setevent EVENT_RIVAL_AZALEA_TOWN
	setevent EVENT_RIVAL_UNDERGROUND_PATH
	setevent EVENT_VALERIE_ECRUTEAK_CITY
	setevent EVENT_VALERIE_BELLCHIME_TRAIL
	setevent EVENT_AZALEA_TOWN_SLOWPOKES
	setevent EVENT_KURTS_HOUSE_SLOWPOKE
	setevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	setevent EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
	setevent EVENT_COP_IN_ELMS_LAB
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_SCIENTIST_CLIMAX
	setevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	setevent EVENT_BOULDER_IN_ICE_PATH_1A
	setevent EVENT_BOULDER_IN_ICE_PATH_2A
	setevent EVENT_BOULDER_IN_ICE_PATH_3A
	setevent EVENT_BOULDER_IN_ICE_PATH_4A
	setevent EVENT_BOULDER_FELL_IN_DIM_CAVE_2F
	setevent EVENT_BOULDER_FELL_IN_DIM_CAVE_3F
	setevent EVENT_BOULDER_FELL_IN_DIM_CAVE_4F
	setevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_BUG_CATCHING_CONTESTANT_1A
	setevent EVENT_BUG_CATCHING_CONTESTANT_2A
	setevent EVENT_BUG_CATCHING_CONTESTANT_3A
	setevent EVENT_BUG_CATCHING_CONTESTANT_4A
	setevent EVENT_BUG_CATCHING_CONTESTANT_5A
	setevent EVENT_BUG_CATCHING_CONTESTANT_6A
	setevent EVENT_BUG_CATCHING_CONTESTANT_7A
	setevent EVENT_BUG_CATCHING_CONTESTANT_8A
	setevent EVENT_BUG_CATCHING_CONTESTANT_9A
	setevent EVENT_BUG_CATCHING_CONTESTANT_10A
	setevent EVENT_BUG_CATCHING_CONTESTANT_1B
	setevent EVENT_BUG_CATCHING_CONTESTANT_2B
	setevent EVENT_BUG_CATCHING_CONTESTANT_3B
	setevent EVENT_BUG_CATCHING_CONTESTANT_4B
	setevent EVENT_BUG_CATCHING_CONTESTANT_5B
	setevent EVENT_BUG_CATCHING_CONTESTANT_6B
	setevent EVENT_BUG_CATCHING_CONTESTANT_7B
	setevent EVENT_BUG_CATCHING_CONTESTANT_8B
	setevent EVENT_BUG_CATCHING_CONTESTANT_9B
	setevent EVENT_BUG_CATCHING_CONTESTANT_10B
	setevent EVENT_FAST_SHIP_1F_GENTLEMAN
	setevent EVENT_FAST_SHIP_B1F_SAILOR_RIGHT
	setevent EVENT_FAST_SHIP_CABINS_NNW_NNE_NE_SAILOR
	setevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_TIN_TOWER_ROOF_HO_OH
	setevent EVENT_WHIRL_ISLAND_LUGIA_CHAMBER_LUGIA
	setevent EVENT_KRISS_HOUSE_2F_CONSOLE
	setevent EVENT_KRISS_HOUSE_2F_DOLL_1
	setevent EVENT_KRISS_HOUSE_2F_DOLL_2
	setevent EVENT_KRISS_HOUSE_2F_BIG_DOLL
	setevent EVENT_DECO_BED_1
	setevent EVENT_DECO_PLANT_4
	setevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
	setevent EVENT_OLIVINE_GYM_JASMINE
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	setevent EVENT_NEVER_MET_BILL
	setevent EVENT_ECRUTEAK_POKE_CENTER_BILL
	setevent EVENT_LAKE_OF_RAGE_LANCE
	setevent EVENT_WAREHOUSE_LAYOUT_1
	setevent EVENT_WAREHOUSE_BLOCKED_OFF
	setevent EVENT_DRAGONS_DEN_CLAIR
	setevent EVENT_RIVAL_OLIVINE_CITY
	setevent EVENT_RIVAL_VICTORY_ROAD
	setevent EVENT_RIVAL_DRAGONS_DEN
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	setevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	setevent EVENT_BURNED_TOWER_B1F_BEASTS_1
	setevent EVENT_OLIVINE_PORT_SPRITES_AFTER_HALL_OF_FAME
	setevent EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	setevent EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	setevent EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	setevent EVENT_KURTS_HOUSE_KURT_2
	setevent EVENT_KURTS_HOUSE_GRANDDAUGHTER_2
	setevent EVENT_RANG_CLEAR_BELL_1
	setevent EVENT_FLORIA_AT_FLOWER_SHOP
	setevent EVENT_FLORIA_AT_SUDOWOODO
	setevent EVENT_GOLDENROD_CITY_MOVE_TUTOR
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_FISHER
	setevent EVENT_RUINS_OF_ALPH_OUTSIDE_TOURIST_YOUNGSTERS
	setevent EVENT_DRAGON_SHRINE_CLAIR
	setevent EVENT_BATTLE_TOWER_BATTLE_ROOM_YOUNGSTER
	setevent EVENT_KRISS_NEIGHBORS_HOUSE_NEIGHBOR
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_AZALEA_TOWN_KURT
	setevent EVENT_ILEX_FOREST_KURT
	setevent EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
	setevent EVENT_ILEX_FOREST_LASS
	setevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_ECRUTEAK_CITY_GRAMPS
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	setevent EVENT_KRISS_HOUSE_MOM_2
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	setevent EVENT_CIANWOOD_CITY_EUSINE
	setevent EVENT_TIN_TOWER_1F_EUSINE
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	setevent EVENT_SET_WHEN_FOUGHT_HO_OH
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setevent EVENT_YELLOW_FOREST_ROCKET_TAKEOVER
	setevent EVENT_ROUTE_48_JESSIE
	setevent EVENT_ROUTE_48_JAMES
	setevent EVENT_YELLOW_FOREST_SKARMORY
	setevent EVENT_ROUTE_42_OFFICER
	setevent EVENT_RADIO_TOWER_PETREL
	setevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	setevent EVENT_CERULEAN_GYM_ROCKET
	setevent EVENT_ROUTE_24_ROCKET
	setevent EVENT_ROUTE_25_COOLTRAINER_M_AFTER
	setevent EVENT_ROUTE_25_MISTY_BOYFRIEND
	setevent EVENT_TRAINERS_IN_CERULEAN_GYM
	setevent EVENT_COPYCATS_HOUSE_2F_DOLL
	setevent EVENT_VIRIDIAN_GYM_BLUE
	setevent EVENT_SEAFOAM_GYM_GYM_GUY
	setevent EVENT_MT_MOON_SQUARE_CLEFAIRY
	setevent EVENT_SAFFRON_TRAIN_STATION_POPULATION
	setevent EVENT_LAVENDER_TOWN_FLEEING_YOUNGSTER
	setevent EVENT_LAV_RADIO_TOWER_POPULATION
	setevent EVENT_SOUL_HOUSE_MR_FUJI
	setevent EVENT_ROUTE_8_KANTO_POKEMON_FEDERATION
	setevent EVENT_SHAMOUTI_ISLAND_PIKABLU_GUY
	setevent EVENT_SHAMOUTI_COAST_CANDELA
	setevent EVENT_SHAMOUTI_COAST_BLANCHE
	setevent EVENT_SHAMOUTI_COAST_SPARK
	setevent EVENT_LAWRENCE_ROUTE_10
	setevent EVENT_LAWRENCES_ZAPDOS_ROUTE_10
	setevent EVENT_LAWRENCE_FINAL_BIRD
	setevent EVENT_LAWRENCE_FINAL_BIRD_SURF
	setevent EVENT_LAWRENCE_SHAMOUTI_SHRINE_RUINS
	setevent EVENT_BATTLE_TOWER_CLOSED
	setevent EVENT_BATTLE_TOWER_CHERYL
	setevent EVENT_BATTLE_TOWER_RILEY
	setevent EVENT_BATTLE_TOWER_BUCK
	setevent EVENT_BATTLE_TOWER_MARLEY
	setevent EVENT_BATTLE_TOWER_MIRA
	setevent EVENT_BATTLE_TOWER_ANABEL
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_LYRA
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
	setevent EVENT_MYSTRI_UNOWN_W
	setevent EVENT_MYSTRI_UNOWN_A
	setevent EVENT_MYSTRI_UNOWN_R
	setevent EVENT_MYSTRI_UNOWN_P
	setevent EVENT_MYSTRI_STAGE_CYNTHIA
	setevent EVENT_MYSTRI_STAGE_EGG
	setevent EVENT_SINJOH_RUINS_HOUSE_CYNTHIA
	setevent EVENT_EMBEDDED_TOWER_STEVEN_2
	setevent EVENT_ILEX_FOREST_LYRA
	setevent EVENT_ILEX_FOREST_CELEBI
	setevent EVENT_LAWRENCE_FARAWAY_ISLAND
	setevent EVENT_GIOVANNIS_CAVE_LYRA
	setevent EVENT_GIOVANNIS_CAVE_CELEBI
	setevent EVENT_GIOVANNIS_CAVE_GIOVANNI
	setevent EVENT_CHRIS_IN_NAVEL_ROCK
	setevent EVENT_KRIS_IN_NAVEL_ROCK
	setflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setflag ENGINE_ROCKETS_IN_MAHOGANY
	variablesprite SPRITE_FUCHSIA_GYM_1, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_2, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_3, SPRITE_JANINE
	variablesprite SPRITE_FUCHSIA_GYM_4, SPRITE_JANINE
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	variablesprite SPRITE_JANINE_IMPERSONATOR, SPRITE_LASS
	variablesprite SPRITE_REMATCH_GYM_LEADER_1, SPRITE_BROCK
	variablesprite SPRITE_REMATCH_GYM_LEADER_2, SPRITE_BROCK
	variablesprite SPRITE_GUIDE_GENT, SPRITE_GRAMPS
	variablesprite SPRITE_NEW_BARK_LYRA, SPRITE_LYRA
	variablesprite SPRITE_GOLDENROD_LYRA, SPRITE_LYRA
	variablesprite SPRITE_ROUTE_30_RATTATA, SPRITE_RATTATA
	variablesprite SPRITE_CHERRYGROVE_RIVAL, SPRITE_SILVER
	variablesprite SPRITE_OLIVINE_RIVAL, SPRITE_COWGIRL
	variablesprite SPRITE_LAKE_OF_RAGE_LANCE, SPRITE_LANCE
	variablesprite SPRITE_CERULEAN_CAPE_MISTY, SPRITE_MISTY
	setevent EVENT_INITIALIZED_EVENTS
	return

AskNumber1MScript:
	special RandomPhoneMon
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber1Text
	end
.Huey:
	farwritetext HueyAskNumber1Text
	end
.Gaven:
	farwritetext GavenAskNumber1Text
	end
.Jose:
	farwritetext JoseAskNumber1Text
	end
.Joey:
	farwritetext JoeyAskNumber1Text
	end
.Wade:
	farwritetext WadeAskNumber1Text
	end
.Ralph:
	farwritetext RalphAskNumber1Text
	end
.Anthony:
	farwritetext AnthonyAskNumber1Text
	end
.Todd:
	farwritetext ToddAskNumber1Text
	end
.Irwin:
	farwritetext IrwinAskNumber1Text
	end
.Arnie:
	farwritetext ArnieAskNumber1Text
	end
.Alan:
	farwritetext AlanAskNumber1Text
	end
.Chad:
	farwritetext ChadAskNumber1Text
	end
.Derek:
	farwritetext DerekAskNumber1Text
	end
.Tully:
	farwritetext TullyAskNumber1Text
	end
.Brent:
	farwritetext BrentAskNumber1Text
	end
.Vance:
	farwritetext VanceAskNumber1Text
	end
.Wilton:
	farwritetext WiltonAskNumber1Text
	end
.Kenji:
	farwritetext KenjiAskNumber1Text
	end
.Parry:
	farwritetext ParryAskNumber1Text
	end

AskNumber2MScript:
	special RandomPhoneMon
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackAskNumber2Text
	end
.Huey:
	farwritetext HueyAskNumber2Text
	end
.Gaven:
	farwritetext GavenAskNumber2Text
	end
.Jose:
	farwritetext JoseAskNumber2Text
	end
.Joey:
	farwritetext JoeyAskNumber2Text
	end
.Wade:
	farwritetext WadeAskNumber2Text
	end
.Ralph:
	farwritetext RalphAskNumber2Text
	end
.Anthony:
	farwritetext AnthonyAskNumber2Text
	end
.Todd:
	farwritetext ToddAskNumber2Text
	end
.Irwin:
	farwritetext IrwinAskNumber2Text
	end
.Arnie:
	farwritetext ArnieAskNumber2Text
	end
.Alan:
	farwritetext AlanAskNumber2Text
	end
.Chad:
	farwritetext ChadAskNumber2Text
	end
.Derek:
	farwritetext DerekAskNumber2Text
	end
.Tully:
	farwritetext TullyAskNumber2Text
	end
.Brent:
	farwritetext BrentAskNumber2Text
	end
.Vance:
	farwritetext VanceAskNumber2Text
	end
.Wilton:
	farwritetext WiltonAskNumber2Text
	end
.Kenji:
	farwritetext KenjiAskNumber2Text
	end
.Parry:
	farwritetext ParryAskNumber2Text
	end

RegisteredNumberMScript:
	farwritetext RegisteredNumber1Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	end

NumberAcceptedMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberAcceptedText
	waitendtext

.Huey:
	farwritetext HueyNumberAcceptedText
	waitendtext

.Gaven:
	farwritetext GavenNumberAcceptedText
	waitendtext

.Jose:
	farwritetext JoseNumberAcceptedText
	waitendtext

.Joey:
	farwritetext JoeyNumberAcceptedText
	waitendtext

.Wade:
	farwritetext WadeNumberAcceptedText
	waitendtext

.Ralph:
	farwritetext RalphNumberAcceptedText
	waitendtext

.Anthony:
	farwritetext AnthonyNumberAcceptedText
	waitendtext

.Todd:
	farwritetext ToddNumberAcceptedText
	waitendtext

.Irwin:
	farwritetext IrwinNumberAcceptedText
	waitendtext

.Arnie:
	farwritetext ArnieNumberAcceptedText
	waitendtext

.Alan:
	farwritetext AlanNumberAcceptedText
	waitendtext

.Chad:
	farwritetext ChadNumberAcceptedText
	waitendtext

.Derek:
	farwritetext DerekNumberAcceptedText
	waitendtext

.Tully:
	farwritetext TullyNumberAcceptedText
	waitendtext

.Brent:
	farwritetext BrentNumberAcceptedText
	waitendtext

.Vance:
	farwritetext VanceNumberAcceptedText
	waitendtext

.Wilton:
	farwritetext WiltonNumberAcceptedText
	waitendtext

.Kenji:
	farwritetext KenjiNumberAcceptedText
	waitendtext

.Parry:
	farwritetext ParryNumberAcceptedText
	waitendtext

NumberDeclinedMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackNumberDeclinedText
	waitendtext

.Huey:
	farwritetext HueyNumberDeclinedText
	waitendtext

.Gaven:
	farwritetext GavenNumberDeclinedText
	waitendtext

.Jose:
	farwritetext JoseNumberDeclinedText
	waitendtext

.Joey:
	farwritetext JoeyNumberDeclinedText
	waitendtext

.Wade:
	farwritetext WadeNumberDeclinedText
	waitendtext

.Ralph:
	farwritetext RalphNumberDeclinedText
	waitendtext

.Anthony:
	farwritetext AnthonyNumberDeclinedText
	waitendtext

.Todd:
	farwritetext ToddNumberDeclinedText
	waitendtext

.Irwin:
	farwritetext IrwinNumberDeclinedText
	waitendtext

.Arnie:
	farwritetext ArnieNumberDeclinedText
	waitendtext

.Alan:
	farwritetext AlanNumberDeclinedText
	waitendtext

.Chad:
	farwritetext ChadNumberDeclinedText
	waitendtext

.Derek:
	farwritetext DerekNumberDeclinedText
	waitendtext

.Tully:
	farwritetext TullyNumberDeclinedText
	waitendtext

.Brent:
	farwritetext BrentNumberDeclinedText
	waitendtext

.Vance:
	farwritetext VanceNumberDeclinedText
	waitendtext

.Wilton:
	farwritetext WiltonNumberDeclinedText
	waitendtext

.Kenji:
	farwritetext KenjiNumberDeclinedText
	waitendtext

.Parry:
	farwritetext ParryNumberDeclinedText
	waitendtext

PhoneFullMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_JUGGLER_IRWIN, .Irwin
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackPhoneFullText
	waitendtext

.Huey:
	farwritetext HueyPhoneFullText
	waitendtext

.Gaven:
	farwritetext GavenPhoneFullText
	waitendtext

.Jose:
	farwritetext JosePhoneFullText
	waitendtext

.Joey:
	farwritetext JoeyPhoneFullText
	waitendtext

.Wade:
	farwritetext WadePhoneFullText
	waitendtext

.Ralph:
	farwritetext RalphPhoneFullText
	waitendtext

.Anthony:
	farwritetext AnthonyPhoneFullText
	waitendtext

.Todd:
	farwritetext ToddPhoneFullText
	waitendtext

.Irwin:
	farwritetext IrwinPhoneFullText
	waitendtext

.Arnie:
	farwritetext ArniePhoneFullText
	waitendtext

.Alan:
	farwritetext AlanPhoneFullText
	waitendtext

.Chad:
	farwritetext ChadPhoneFullText
	waitendtext

.Derek:
	farwritetext DerekPhoneFullText
	waitendtext

.Tully:
	farwritetext TullyPhoneFullText
	waitendtext

.Brent:
	farwritetext BrentPhoneFullText
	waitendtext

.Vance:
	farwritetext VancePhoneFullText
	waitendtext

.Wilton:
	farwritetext WiltonPhoneFullText
	waitendtext

.Kenji:
	farwritetext KenjiPhoneFullText
	waitendtext

.Parry:
	farwritetext ParryPhoneFullText
	waitendtext

RematchMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SCHOOLBOY_JACK, .Jack
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_COOLTRAINERM_GAVEN, .Gaven
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_FISHER_RALPH, .Ralph
	if_equal PHONE_HIKER_ANTHONY, .Anthony
	if_equal PHONE_CAMPER_TODD, .Todd
	if_equal PHONE_BUG_CATCHER_ARNIE, .Arnie
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_SCHOOLBOY_CHAD, .Chad
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_POKEMANIAC_BRENT, .Brent
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_HIKER_PARRY, .Parry

.Jack:
	farwritetext JackRematchText
	waitendtext

.Huey:
	farwritetext HueyRematchText
	waitendtext

.Gaven:
	farwritetext GavenRematchText
	waitendtext

.Jose:
	farwritetext JoseRematchText
	waitendtext

.Joey:
	farwritetext JoeyRematchText
	waitendtext

.Wade:
	farwritetext WadeRematchText
	waitendtext

.Ralph:
	farwritetext RalphRematchText
	waitendtext

.Anthony:
	farwritetext AnthonyRematchText
	waitendtext

.Todd:
	farwritetext ToddRematchText
	waitendtext

.Arnie:
	farwritetext ArnieRematchText
	waitendtext

.Alan:
	farwritetext AlanRematchText
	waitendtext

.Chad:
	farwritetext ChadRematchText
	waitendtext

.Tully:
	farwritetext TullyRematchText
	waitendtext

.Brent:
	farwritetext BrentRematchText
	waitendtext

.Vance:
	farwritetext VanceRematchText
	waitendtext

.Wilton:
	farwritetext WiltonRematchText
	waitendtext

.Parry:
	farwritetext ParryRematchText
	waitendtext

GiftMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji

.Jose:
	farwritetext JoseGiftText
	buttonsound
	end
.Wade:
	farwritetext WadeGiftText
	buttonsound
	end
.Alan:
	farwritetext AlanGiftText
	buttonsound
	end
.Derek:
	farwritetext DerekGiftText
	buttonsound
	end
.Tully:
	farwritetext TullyGiftText
	buttonsound
	end
.Wilton:
	farwritetext WiltonGiftText
	buttonsound
	end
.Kenji:
	farwritetext KenjiGiftText
	buttonsound
	end

PackFullMScript:
	checkcode VAR_CALLERID
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_BIRDKEEPER_JOSE, .Jose
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BUG_CATCHER_WADE, .Wade
	if_equal PHONE_SCHOOLBOY_ALAN, .Alan
	if_equal PHONE_POKEFANM_DEREK, .Derek
	if_equal PHONE_FISHER_TULLY, .Tully
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_FISHER_WILTON, .Wilton
	if_equal PHONE_BLACKBELT_KENJI, .Kenji
	if_equal PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyPackFullText
	waitendtext

.Jose:
	farwritetext JosePackFullText
	waitendtext

.Joey:
	farwritetext JoeyPackFullText
	waitendtext

.Wade:
	farwritetext WadePackFullText
	waitendtext

.Alan:
	farwritetext AlanPackFullText
	waitendtext

.Derek:
	farwritetext DerekPackFullText
	waitendtext

.Tully:
	farwritetext TullyPackFullText
	waitendtext

.Vance:
	farwritetext VancePackFullText
	waitendtext

.Wilton:
	farwritetext WiltonPackFullText
	waitendtext

.Kenji:
	farwritetext KenjiPackFullText
	waitendtext

.Parry:
	farwritetext ParryPackFullText
	waitendtext

RematchGiftMScript:
	opentext
	checkcode VAR_CALLERID
	if_equal PHONE_SAILOR_HUEY, .Huey
	if_equal PHONE_YOUNGSTER_JOEY, .Joey
	if_equal PHONE_BIRDKEEPER_VANCE, .Vance
	if_equal PHONE_HIKER_PARRY, .Parry

.Huey:
	farwritetext HueyRematchGiftText
	buttonsound
	end
.Joey:
	farwritetext JoeyRematchGiftText
	buttonsound
	end
.Vance:
	farwritetext VanceRematchGiftText
	buttonsound
	end
.Parry:
	farwritetext ParryRematchGiftText
	buttonsound
	end

AskNumber1FScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber1Text
	end
.Beth:
	farwritetext BethAskNumber1Text
	end
.Reena:
	farwritetext ReenaAskNumber1Text
	end
.Liz:
	farwritetext LizAskNumber1Text
	end
.Gina:
	farwritetext GinaAskNumber1Text
	end
.Dana:
	farwritetext DanaAskNumber1Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber1Text
	end
.Erin:
	farwritetext ErinAskNumber1Text
	end

AskNumber2FScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyAskNumber2Text
	end
.Beth:
	farwritetext BethAskNumber2Text
	end
.Reena:
	farwritetext ReenaAskNumber2Text
	end
.Liz:
	farwritetext LizAskNumber2Text
	end
.Gina:
	farwritetext GinaAskNumber2Text
	end
.Dana:
	farwritetext DanaAskNumber2Text
	end
.Tiffany:
	farwritetext TiffanyAskNumber2Text
	end
.Erin:
	farwritetext ErinAskNumber2Text
	end

RegisteredNumberFScript:
	farwritetext RegisteredNumber2Text
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	buttonsound
	end

NumberAcceptedFScript: ; 0xbcbd3
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberAcceptedText
	waitendtext

.Beth:
	farwritetext BethNumberAcceptedText
	waitendtext

.Reena:
	farwritetext ReenaNumberAcceptedText
	waitendtext

.Liz:
	farwritetext LizNumberAcceptedText
	waitendtext

.Gina:
	farwritetext GinaNumberAcceptedText
	waitendtext

.Dana:
	farwritetext DanaNumberAcceptedText
	waitendtext

.Tiffany:
	farwritetext TiffanyNumberAcceptedText
	waitendtext

.Erin:
	farwritetext ErinNumberAcceptedText
	waitendtext

NumberDeclinedFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyNumberDeclinedText
	waitendtext

.Beth:
	farwritetext BethNumberDeclinedText
	waitendtext

.Reena:
	farwritetext ReenaNumberDeclinedText
	waitendtext

.Liz:
	farwritetext LizNumberDeclinedText
	waitendtext

.Gina:
	farwritetext GinaNumberDeclinedText
	waitendtext

.Dana:
	farwritetext DanaNumberDeclinedText
	waitendtext

.Tiffany:
	farwritetext TiffanyNumberDeclinedText
	waitendtext

.Erin:
	farwritetext ErinNumberDeclinedText
	waitendtext

PhoneFullFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPhoneFullText
	waitendtext

.Beth:
	farwritetext BethPhoneFullText
	waitendtext

.Reena:
	farwritetext ReenaPhoneFullText
	waitendtext

.Liz:
	farwritetext LizPhoneFullText
	waitendtext

.Gina:
	farwritetext GinaPhoneFullText
	waitendtext

.Dana:
	farwritetext DanaPhoneFullText
	waitendtext

.Tiffany:
	farwritetext TiffanyPhoneFullText
	waitendtext

.Erin:
	farwritetext ErinPhoneFullText
	waitendtext

RematchFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_COOLTRAINERF_BETH, .Beth
	if_equal PHONE_COOLTRAINERF_REENA, .Reena
	if_equal PHONE_PICNICKER_LIZ, .Liz
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beth:
	farwritetext BethRematchText
	waitendtext

.Reena:
	farwritetext ReenaRematchText
	waitendtext

.Liz:
	farwritetext LizRematchText
	waitendtext

.Gina:
	farwritetext GinaRematchText
	waitendtext

.Dana:
	farwritetext DanaRematchText
	waitendtext

.Tiffany:
	farwritetext TiffanyRematchText
	waitendtext

.Erin:
	farwritetext ErinRematchText
	waitendtext

GiftFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany

.Beverly:
	farwritetext BeverlyGiftText
	buttonsound
	end
.Gina:
	farwritetext GinaGiftText
	buttonsound
	end
.Dana:
	farwritetext DanaGiftText
	buttonsound
	end
.Tiffany:
	farwritetext TiffanyGiftText
	buttonsound
	end

PackFullFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_POKEFAN_BEVERLY, .Beverly
	if_equal PHONE_PICNICKER_GINA, .Gina
	if_equal PHONE_LASS_DANA, .Dana
	if_equal PHONE_PICNICKER_TIFFANY, .Tiffany
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Beverly:
	farwritetext BeverlyPackFullText
	waitendtext

.Gina:
	farwritetext GinaPackFullText
	waitendtext

.Dana:
	farwritetext DanaPackFullText
	waitendtext

.Tiffany:
	farwritetext TiffanyPackFullText
	waitendtext

.Erin:
	farwritetext ErinPackFullText
	waitendtext

RematchGiftFScript:
	checkcode VAR_CALLERID
	if_equal PHONE_PICNICKER_ERIN, .Erin

.Erin:
	opentext
	farwritetext ErinRematchGiftText
	buttonsound
	end

GymStatue0Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	waitendtext

GymStatue1Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	buttonsound
	farwritetext GymStatue_WinningTrainersText
	waitendtext

GymStatue2Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	buttonsound
	farwritetext GymStatue_TwoWinningTrainersText
	waitendtext

GymStatue3Script:
	mapnametotext $0
	opentext
	farwritetext GymStatue_CityGymText
	buttonsound
	farwritetext GymStatue_ThreeWinningTrainersText
	waitendtext

ReceiveItemScript: ; 0xbcdb9
	waitsfx
	farwritetext ReceivedItemText
	playsound SFX_ITEM
	waitsfx
	end
; 0xbcdc3

GameCornerCoinVendorScript: ; 0xbcdcd
	faceplayer
	opentext
	farwritetext CoinVendor_WelcomeText
	buttonsound
	checkitem COIN_CASE
	iftrue CoinVendor_IntroScript
	farwritetext CoinVendor_NoCoinCaseText
	waitendtext
; 0xbcde0

CoinVendor_IntroScript: ; 0xbcde0
	farwritetext CoinVendor_IntroText

.loop ; 0xbcde4
	special Special_DisplayMoneyAndCoinBalance
	loadmenudata .MenuDataHeader
	verticalmenu
	closewindow
	if_equal $1, .Buy50
	if_equal $2, .Buy500
	jump .Cancel
; 0xbcdf7

.Buy50: ; 0xbcdf7
	checkcoins 49950
	if_equal $0, .CoinCaseFull
	checkmoney $0, 1000
	if_equal $2, .NotEnoughMoney
	givecoins 50
	takemoney $0, 1000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy50CoinsText
	waitbutton
	jump .loop
; 0xbce1b

.Buy500: ; 0xbce1b
	checkcoins 49500
	if_equal $0, .CoinCaseFull
	checkmoney $0, 10000
	if_equal $2, .NotEnoughMoney
	givecoins 500
	takemoney $0, 10000
	waitsfx
	playsound SFX_TRANSACTION
	farwritetext CoinVendor_Buy500CoinsText
	waitbutton
	jump .loop
; 0xbce3f

.NotEnoughMoney: ; 0xbce3f
	farwritetext CoinVendor_NotEnoughMoneyText
	waitendtext
; 0xbce46

.CoinCaseFull: ; 0xbce46
	farwritetext CoinVendor_CoinCaseFullText
	waitendtext
; 0xbce4d

.Cancel: ; 0xbce4d
	farwritetext CoinVendor_CancelText
	waitendtext
; 0xbce54

.MenuDataHeader:
	db $40 ; flags
	db 04, 00 ; start coords
	db 11, 15 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 3 ; items
	db " 50 :  ¥1000@"
	db "500 : ¥10000@"
	db "Cancel@"
; 0xbce7f


HappinessCheckScript:
	faceplayer
	opentext
	special GetFirstPokemonHappiness
	if_less_than 50, .Unhappy
	if_less_than 150, .KindaHappy
	farwritetext HappinessText3
	waitendtext

.KindaHappy:
	farwritetext HappinessText2
	waitendtext

.Unhappy:
	farwritetext HappinessText1
	waitendtext

Movement_ContestResults_WalkAfterWarp: ; bcea1
	step_right
	step_down
	turn_head_up
	step_end
; bcea5

CutTreeScript:
	farjump AskCutTreeScript

VendingMachineScript:
	opentext
	farwritetext VendingMachineText
.Start:
	special PlaceMoneyTopRight
	loadmenudata .MenuData
	verticalmenu
	closewindow
	if_equal $1, .FreshWater
	if_equal $2, .SodaPop
	if_equal $3, .Lemonade
	endtext

.FreshWater:
	checkmoney $0, 200
	if_equal $2, .NotEnoughMoney
	giveitem FRESH_WATER
	iffalse .NotEnoughSpace
	takemoney $0, 200
	itemtotext FRESH_WATER, $0
	scall .VendItem
	random $20
	if_not_equal $0, .Start
	giveitem FRESH_WATER
	iffalse .Start
	itemtotext FRESH_WATER, $0
	jump .ExtraItem

.SodaPop:
	checkmoney $0, 300
	if_equal $2, .NotEnoughMoney
	giveitem SODA_POP
	iffalse .NotEnoughSpace
	takemoney $0, 300
	itemtotext SODA_POP, $0
	scall .VendItem
	random $20
	if_not_equal $0, .Start
	giveitem SODA_POP
	iffalse .Start
	itemtotext SODA_POP, $0
	jump .ExtraItem

.Lemonade:
	checkmoney $0, 350
	if_equal $2, .NotEnoughMoney
	giveitem LEMONADE
	iffalse .NotEnoughSpace
	takemoney $0, 350
	itemtotext LEMONADE, $0
	scall .VendItem
	random $20
	if_not_equal $0, .Start
	giveitem LEMONADE
	iffalse .Start
	itemtotext LEMONADE, $0
	jump .ExtraItem

.VendItem:
	pause 10
	playsound SFX_ENTER_DOOR
	farwritetext VendingMachineClangText
	buttonsound
	itemnotify
	end

.ExtraItem:
	pause 10
	playsound SFX_ENTER_DOOR
	farwritetext VendingMachineScoreText
	buttonsound
	itemnotify
	jump .Start

.NotEnoughMoney:
	farwritetext VendingMachineNoMoneyText
	waitbutton
	jump .Start

.NotEnoughSpace:
	farwritetext VendingMachineNoSpaceText
	waitbutton
	jump .Start

.MenuData:
	db $40 ; flags
	db 02, 00 ; start coords
	db 11, 19 ; end coords
	dw .MenuData2
	db 1 ; default option

.MenuData2:
	db $80 ; flags
	db 4 ; items
	db "Fresh Water  ¥200@"
	db "Soda Pop     ¥300@"
	db "Lemonade     ¥350@"
	db "Cancel@"

TreeGrottoScript:
	scall _HiddenGrottoInitScript
	iffalse_endtext
	closetext
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	pause 15
	callasm _HiddenGrottoBackupMap
	warpfacing UP, HIDDEN_TREE_GROTTO, 4, 15
	end

CaveGrottoScript:
	scall _HiddenGrottoInitScript
	iffalse_endtext
	closetext
	playsound SFX_EXIT_BUILDING
	special FadeOutPalettes
	pause 15
	callasm _HiddenGrottoBackupMap
	warpfacing UP, HIDDEN_CAVE_GROTTO, 35, 85
	end

_HiddenGrottoInitScript:
	callasm .StoreCurHiddenGrotto
	opentext
	farwritetext HiddenGrottoText
	yesorno
	end

.StoreCurHiddenGrotto:
	ld a, [ScriptVar]
	ld [CurHiddenGrotto], a
	ret

_HiddenGrottoBackupMap:
	ld a, [MapGroup]
	ld [BackupMapGroup], a
	ld a, [MapNumber]
	ld [BackupMapNumber], a
	ret
