const_value set 2
	const INDIGOPLATEAUPOKECENTER1F_NURSE
	const INDIGOPLATEAUPOKECENTER1F_CLERK
	const INDIGOPLATEAUPOKECENTER1F_COOLTRAINER_M
	const INDIGOPLATEAUPOKECENTER1F_GRAMPS
	const INDIGOPLATEAUPOKECENTER1F_ABRA
	const INDIGOPLATEAUPOKECENTER1F_SILVER
	const INDIGOPLATEAUPOKECENTER1F_LYRA
	const INDIGOPLATEAUPOKECENTER1F_YELLOW

IndigoPlateauPokeCenter1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 1
	dbw MAPCALLBACK_NEWMAP, UnknownScript_0x18000a

UnknownScript_0x18000a:
	domaptrigger WILLS_ROOM, $0
	domaptrigger KOGAS_ROOM, $0
	domaptrigger BRUNOS_ROOM, $0
	domaptrigger KARENS_ROOM, $0
	domaptrigger LANCES_ROOM, $0
	domaptrigger HALL_OF_FAME, $0
	clearevent EVENT_WILLS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_WILLS_ROOM_EXIT_OPEN
	clearevent EVENT_KOGAS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KOGAS_ROOM_EXIT_OPEN
	clearevent EVENT_BRUNOS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_BRUNOS_ROOM_EXIT_OPEN
	clearevent EVENT_KARENS_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_KARENS_ROOM_EXIT_OPEN
	clearevent EVENT_LANCES_ROOM_ENTRANCE_CLOSED
	clearevent EVENT_LANCES_ROOM_EXIT_OPEN
	clearevent EVENT_BEAT_ELITE_4_WILL
	clearevent EVENT_BEAT_ELITE_4_KOGA
	clearevent EVENT_BEAT_ELITE_4_BRUNO
	clearevent EVENT_BEAT_ELITE_4_KAREN
	clearevent EVENT_BEAT_CHAMPION_LANCE
	setevent EVENT_LANCES_ROOM_OAK_AND_MARY
	return

PlateauRivalBattle1:
	checkevent EVENT_FINAL_BATTLE_WITH_LYRA
	iftrue .LyraFight
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .MaybeRivalFight
	if_equal TUESDAY, .MaybeLyraFight
	if_equal WEDNESDAY, .MaybeRivalFight
	if_equal THURSDAY, .MaybeLyraFight
	if_equal FRIDAY, .MaybeRivalFight
	if_equal SATURDAY, .MaybeLyraFight
	jump PlateauRivalScriptDone

.MaybeRivalFight:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	moveperson INDIGOPLATEAUPOKECENTER1F_SILVER, $f, $9
	appear INDIGOPLATEAUPOKECENTER1F_SILVER
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalMovement1
	playmusic MUSIC_RIVAL_ENCOUNTER
	spriteface PLAYER, RIGHT
	jump PlateauRivalBattleCommon

.MaybeLyraFight:
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_LYRA_FIGHT
	iftrue PlateauRivalScriptDone
.LyraFight:
	moveperson INDIGOPLATEAUPOKECENTER1F_LYRA, $f, $9
	appear INDIGOPLATEAUPOKECENTER1F_LYRA
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_LYRA, PlateauRivalMovement1
	playmusic MUSIC_NONE
	spriteface PLAYER, RIGHT
	jump PlateauLyraBattleCommon

PlateauRivalBattle2:
	checkevent EVENT_FINAL_BATTLE_WITH_LYRA
	iftrue .LyraFight
	checkcode VAR_WEEKDAY
	if_equal MONDAY, .MaybeRivalFight
	if_equal TUESDAY, .MaybeLyraFight
	if_equal WEDNESDAY, .MaybeRivalFight
	if_equal THURSDAY, .MaybeLyraFight
	if_equal FRIDAY, .MaybeRivalFight
	if_equal SATURDAY, .MaybeLyraFight
	jump PlateauRivalScriptDone

.MaybeRivalFight:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue PlateauRivalScriptDone
	appear INDIGOPLATEAUPOKECENTER1F_SILVER
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalMovement2
	playmusic MUSIC_RIVAL_ENCOUNTER
	spriteface PLAYER, LEFT
	jump PlateauRivalBattleCommon

.MaybeLyraFight:
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iffalse PlateauRivalScriptDone
	checkflag ENGINE_INDIGO_PLATEAU_LYRA_FIGHT
	iftrue PlateauRivalScriptDone
.LyraFight:
	appear INDIGOPLATEAUPOKECENTER1F_LYRA
	spriteface PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_LYRA, PlateauRivalMovement2
	playmusic MUSIC_NONE
	spriteface PLAYER, LEFT
	jump PlateauLyraBattleCommon

PlateauRivalBattleCommon:
	opentext
	writetext PlateauRivalText1
	waitbutton
	closetext
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	; Cyndaquil
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump PlateauRivalPostBattle

.Totodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump PlateauRivalPostBattle

.Chikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
PlateauRivalPostBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext PlateauRivalText2
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_SILVER
	dotrigger $0
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	end

PlateauLyraBattleCommon:
	opentext
	writetext PlateauLyraText1
	waitbutton
	playmusic MUSIC_WALLY_BATTLE_ORAS
	writetext PlateauLyraText2
	waitbutton
	closetext
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	; Cyndaquil
	winlosstext PlateauLyraWinText, PlateauLyraLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump PlateauLyraPostBattle

.Totodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	jump PlateauLyraPostBattle

.Chikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
PlateauLyraPostBattle:
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	opentext
	writetext PlateauLyraText3
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_LYRA, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_LYRA
	dotrigger $0
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_LYRA_FIGHT
	clearevent EVENT_FINAL_BATTLE_WITH_LYRA
PlateauRivalScriptDone:
	end

NurseScript_0x18012c:
	jumpstd pokecenternurse

ClerkScript_0x18012f:
	opentext
	pokemart MARTTYPE_STANDARD, MART_INDIGO_PLATEAU
	closetext
	end

CooltrainerMScript_0x180136:
	jumptextfaceplayer UnknownText_0x180178

TeleportGuyScript:
	faceplayer
	opentext
	writetext TeleportGuyText1
	yesorno
	iffalse .No
	writetext TeleportGuyYesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, $f, $6
	end

.No:
	writetext TeleportGuyNoText
	waitbutton
	closetext
	end

AbraScript:
	opentext
	writetext AbraText
	cry ABRA
	waitbutton
	closetext
	end

IndigoPlateauYellowScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_YELLOW_INTRO
	iftrue .HeardIntro
	writetext IndigoPlateauYellowGreetingText
	waitbutton
	setevent EVENT_LISTENED_TO_YELLOW_INTRO
.HeardIntro
	writetext IndigoPlateauYellowQuestionText
	yesorno
	iffalse .Refused
	writetext IndigoPlateauYellowGiveStarterText
	buttonsound
	waitsfx
	checkcode VAR_PARTYCOUNT
	if_equal $6, .PartyFull
	checkevent EVENT_GOT_BULBASAUR_FROM_IVY
	iftrue .Squirtle
	checkevent EVENT_GOT_CHARMANDER_FROM_IVY
	iftrue .Bulbasaur
	pokenamemem CHARMANDER, $0
	writetext IndigoPlateauYellowReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke CHARMANDER, 10, SITRUS_BERRY
	jump .Finish

.Bulbasaur:
	pokenamemem BULBASAUR, $0
	writetext IndigoPlateauYellowReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke BULBASAUR, 10, SITRUS_BERRY
	jump .Finish

.Squirtle:
	pokenamemem SQUIRTLE, $0
	writetext IndigoPlateauYellowReceivedKantoStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	buttonsound
	givepoke SQUIRTLE, 10, SITRUS_BERRY
.Finish:
	writebyte GREAT_BALL
	special SetLastPartyMonBall
	writetext IndigoPlateauYellowGoodbyeText
	waitbutton
	closetext
	checkcode VAR_FACING
	spriteface PLAYER, DOWN
	if_not_equal UP, .noleftstep
	applymovement INDIGOPLATEAUPOKECENTER1F_YELLOW, IndigoPlateauYellowLeftMovement
.noleftstep
	applymovement INDIGOPLATEAUPOKECENTER1F_YELLOW, IndigoPlateauYellowDownMovement
	playsound SFX_EXIT_BUILDING
	disappear INDIGOPLATEAUPOKECENTER1F_YELLOW
	setevent EVENT_GOT_A_POKEMON_FROM_YELLOW
	waitsfx
	end

.Refused:
	writetext IndigoPlateauYellowRefusedText
	waitbutton
	closetext
	end

.PartyFull:
	writetext IndigoPlateauYellowNoRoomText
	waitbutton
	closetext
	end

PokemonJournalGiovanniScript:
	setflag ENGINE_READ_GIOVANNI_JOURNAL
	jumptext PokemonJournalGiovanniText

PlateauRivalMovement1:
	step_up
	step_up
	step_up
	step_up
	step_up
	turn_head_left
	step_end

PlateauRivalMovement2:
	step_up
	step_up
	step_up
	step_up
	step_up
	turn_head_right
	step_end

PlateauRivalLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x180178:
	text "At the #mon"
	line "League, you'll get"

	para "tested by the"
	line "Elite Four."

	para "You have to beat"
	line "them all. If you"

	para "lose, you have to"
	line "start all over!"
	done

PlateauRivalText1:
	text "Hold it."

	para "You're going to"
	line "take the #mon"

	para "League challenge"
	line "now?"

	para "That's not going"
	line "to happen."

	para "My super-well-"
	line "trained #mon"

	para "are going to pound"
	line "you."

	para "<PLAYER>!"
	line "I challenge you!"
	done

PlateauRivalWinText:
	text "…"

	para "OK--I lost…"
	done

PlateauRivalText2:
	text "…Darn… I still"
	line "can't win…"

	para "I… I have to think"
	line "more about my"
	cont "#mon…"

	para "Humph! Try not to"
	line "lose!"
	done

PlateauRivalLoseText:
	text "…"

	para "Whew…"
	line "With my partners,"

	para "I'm going to be"
	line "the Champion!"
	done

PlateauLyraText1:
	text "<PLAYER>!"

	para "I've been travel-"
	line "ing around Johto,"

	para "earning badges and"
	line "gaining strength."

	para "You know what"
	line "that's like,"
	cont "<PLAYER>."

	para "And now…"

	para "Here I am, at the"
	line "Indigo Plateau."

	para "Do you know what"
	line "this means?"

	para "I get to challenge"
	line "you, not only as"
	cont "my friend, but"
	done

PlateauLyraText2:
	text "as the Pokemon"
	line "League Champion!"
	done

PlateauLyraWinText:
	text "So you're still"
	line "stronger than me…"
	done

PlateauLyraLoseText:
	text "…I won?"
	done

PlateauLyraText3:
	text "I'm not angry that"
	line "I lost."

	para "I got to explore"
	line "Johto, meet new"
	cont "people, raise my"

	para "#mon to be"
	line "stronger than I"

	para "thought they could"
	line "ever be…"

	para "And I got to"
	line "battle you at my"
	cont "very best."

	para "You beat me--now"
	line "go beat the #-"
	cont "mon League!"
	done

TeleportGuyText1:
	text "Ah! You're chal-"
	line "lenging the Elite"

	para "Four? Are you sure"
	line "you're ready?"

	para "If you need to"
	line "train some more,"

	para "my Abra can help"
	line "you."

	para "It can Teleport"
	line "you home."

	para "Would you like to"
	line "go home now?"
	done

TeleportGuyYesText:
	text "OK, OK. Picture"
	line "your house in your"
	cont "mind…"
	done

TeleportGuyNoText:
	text "OK, OK. The best"
	line "of luck to you!"
	done

AbraText:
	text "Abra: Aabra…"
	done

IndigoPlateauYellowGreetingText:
	text "Yellow: Hi,"
	line "<PLAYER>!"

	para "I was watching the"
	line "Elite Four fight."

	para "They're so intense…"
	line "And they have such"

	para "strong bonds with"
	line "their #mon…"

	para "One day I'm going"
	line "to reach their"
	cont "level."
	done

IndigoPlateauYellowQuestionText:
	text "Yellow: <PLAYER>,"
	line "can you do me a"
	cont "favor?"

	para "I have a #mon"
	line "that I can't raise"
	cont "myself, and I don't"

	para "want to leave it"
	line "in PC storage."

	para "Will you take it,"
	line "please?"
	done

IndigoPlateauYellowGiveStarterText:
	text "Yellow: Thanks,"
	line "<PLAYER>! Here"
	cont "you go!"
	done

IndigoPlateauYellowRefusedText:
	text "Yellow: Oh…"
	line "But what about the"
	cont "#mon?"
	done

IndigoPlateauYellowNoRoomText:
	text "Yellow: Oh…"
	line "You can't carry"

	para "another #mon"
	line "either…"
	done

IndigoPlateauYellowGoodbyeText:
	text "Yellow: You take"
	line "good care of that"

	para "@"
	text_from_ram StringBuffer3
	text ","
	line "<PLAYER>!"

	para "I hope we'll meet"
	line "again."
	cont "Bye-bye!"
	done

IndigoPlateauYellowReceivedKantoStarterText:
	text "<PLAYER> received"
	line "@"
	text_from_ram StringBuffer3
	text "!"
	done

PokemonJournalGiovanniText:
	text "#mon Journal"

	para "Special Feature:"
	line "Boss Giovanni!"

	para "When police sear-"
	line "ched the abandoned"
	cont "Viridian Gym, they"

	para "discovered that"
	line "its Leader,"
	cont "Giovanni, had"

	para "also been the"
	line "Team Rocket Boss."
	done

IndigoPlateauYellowLeftMovement:
	step_left
	step_end

IndigoPlateauYellowDownMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

IndigoPlateauPokeCenter1F_MapEventHeader:
.Warps:
	db 4
	warp_def $d, $9, 1, INDIGO_PLATEAU
	warp_def $d, $a, 2, INDIGO_PLATEAU
	warp_def $d, $0, 1, POKECENTER_2F
	warp_def $3, $c, 1, WILLS_ROOM

.XYTriggers:
	db 2
	xy_trigger 0, $4, $e, PlateauRivalBattle1
	xy_trigger 0, $4, $f, PlateauRivalBattle2

.Signposts:
	db 1
	signpost 7, 13, SIGNPOST_READ, PokemonJournalGiovanniScript

.PersonEvents:
	db 8
	person_event SPRITE_NURSE, 7, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, NurseScript_0x18012c, -1
	person_event SPRITE_CLERK, 9, 1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ClerkScript_0x18012f, -1
	person_event SPRITE_COOLTRAINER_M, 12, 5, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, PERSONTYPE_SCRIPT, 0, CooltrainerMScript_0x180136, -1
	person_event SPRITE_GRAMPS, 9, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, TeleportGuyScript, EVENT_TELEPORT_GUY
	person_event SPRITE_ABRA, 9, 5, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, AbraScript, EVENT_TELEPORT_GUY
	person_event SPRITE_SILVER, 9, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	person_event SPRITE_LYRA, 9, 14, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_LYRA
	person_event SPRITE_YELLOW, 9, 10, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, IndigoPlateauYellowScript, EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
