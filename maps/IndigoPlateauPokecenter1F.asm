IndigoPlateauPokecenter1F_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PrepareEliteFourCallback

	def_warp_events
	warp_event  9, 13, INDIGO_PLATEAU, 1
	warp_event 10, 13, INDIGO_PLATEAU, 2
	warp_event  0, 13, POKECENTER_2F, 1
	warp_event 12,  3, WILLS_ROOM, 1

	def_coord_events
	coord_event 14,  4, 0, PlateauRivalBattleTrigger1
	coord_event 15,  4, 0, PlateauRivalBattleTrigger2

	def_bg_events
	bg_event 13,  7, BGEVENT_READ, PokemonJournalGiovanniScript

	def_object_events
	object_event 14,  9, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	object_event 14,  9, SPRITE_LYRA, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_INDIGO_PLATEAU_POKECENTER_LYRA
	object_event 10,  9, SPRITE_YELLOW, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IndigoPlateauYellowScript, EVENT_INDIGO_PLATEAU_POKECENTER_YELLOW
	pc_nurse_event  9, 7
	mart_clerk_event  1,  9, MARTTYPE_STANDARD, MART_INDIGO_PLATEAU
	object_event  6,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, IndigoPlateauTeleportGuyScript, EVENT_TELEPORT_GUY
	pokemon_event  5,  9, ABRA, -1, -1, PAL_NPC_BROWN, IndigoPlateauAbraText, EVENT_TELEPORT_GUY
	object_event  5, 12, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, jumptextfaceplayer, IndigoPlateauCooltrainermText, -1

	object_const_def
	const INDIGOPLATEAUPOKECENTER1F_SILVER
	const INDIGOPLATEAUPOKECENTER1F_LYRA
	const INDIGOPLATEAUPOKECENTER1F_YELLOW

PrepareEliteFourCallback:
	setmapscene WILLS_ROOM, $0
	setmapscene KOGAS_ROOM, $0
	setmapscene BRUNOS_ROOM, $0
	setmapscene KARENS_ROOM, $0
	setmapscene LANCES_ROOM, $0
	setmapscene HALL_OF_FAME, $0
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
	endcallback

PlateauRivalBattleTrigger1:
	moveobject INDIGOPLATEAUPOKECENTER1F_SILVER, 15, 9
	moveobject INDIGOPLATEAUPOKECENTER1F_LYRA, 15, 9
PlateauRivalBattleTrigger2:
	checkevent EVENT_FINAL_BATTLE_WITH_LYRA
	iftrue .LyraFight
	readvar VAR_WEEKDAY
	ifequal MONDAY, .MaybeRivalFight
	ifequal TUESDAY, .MaybeLyraFight
	ifequal WEDNESDAY, .MaybeRivalFight
	ifequal THURSDAY, .MaybeLyraFight
	ifequal FRIDAY, .MaybeRivalFight
	ifequal SATURDAY, .MaybeLyraFight
	end

.MaybeRivalFight:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iffalse DoNothingScript
	checkflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	iftrue DoNothingScript
	appear INDIGOPLATEAUPOKECENTER1F_SILVER
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalApproachesMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	faceobject INDIGOPLATEAUPOKECENTER1F_SILVER, PLAYER
	faceobject PLAYER, INDIGOPLATEAUPOKECENTER1F_SILVER
	showtext PlateauRivalText1
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_RIVAL
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .RivalTotodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .RivalChikorita
	; Cyndaquil
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 6
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .RivalPostBattle

.RivalTotodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 4
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .RivalPostBattle

.RivalChikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_SILVER
	loadtrainer RIVAL2, 5
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
.RivalPostBattle:
	special DeleteSavedMusic
	playmusic MUSIC_RIVAL_AFTER
	showtext PlateauRivalText2
	turnobject PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_SILVER, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_SILVER
	setscene $0
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_RIVAL_FIGHT
	end

.MaybeLyraFight:
	checkevent EVENT_BEAT_ELITE_FOUR_AGAIN
	iffalse DoNothingScript
	checkflag ENGINE_INDIGO_PLATEAU_LYRA_FIGHT
	iftrue DoNothingScript
.LyraFight:
	appear INDIGOPLATEAUPOKECENTER1F_LYRA
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	special Special_FadeOutMusic
	pause 15
	applymovement INDIGOPLATEAUPOKECENTER1F_LYRA, PlateauRivalApproachesMovement
	faceobject INDIGOPLATEAUPOKECENTER1F_LYRA, PLAYER
	faceobject PLAYER, INDIGOPLATEAUPOKECENTER1F_LYRA
	opentext
	writetext PlateauLyraText1
	waitbutton
	playmusic MUSIC_WALLY_BATTLE_ORAS
	writetext PlateauLyraText2
	waitbutton
	closetext
	setevent EVENT_INDIGO_PLATEAU_POKECENTER_LYRA
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .LyraTotodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .LyraChikorita
	; Cyndaquil
	winlosstext PlateauLyraWinText, PlateauLyraLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 1
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .LyraPostBattle

.LyraTotodile:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 2
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .LyraPostBattle

.LyraChikorita:
	winlosstext PlateauRivalWinText, PlateauRivalLoseText
	setlasttalked INDIGOPLATEAUPOKECENTER1F_LYRA
	loadtrainer LYRA2, 3
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
.LyraPostBattle:
	special DeleteSavedMusic
	playmusic MUSIC_LYRA_DEPARTURE_HGSS
	showtext PlateauLyraText3
	turnobject PLAYER, DOWN
	applymovement INDIGOPLATEAUPOKECENTER1F_LYRA, PlateauRivalLeavesMovement
	disappear INDIGOPLATEAUPOKECENTER1F_LYRA
	setscene $0
	playmapmusic
	setflag ENGINE_INDIGO_PLATEAU_LYRA_FIGHT
	clearevent EVENT_FINAL_BATTLE_WITH_LYRA
	end

PlateauRivalText1:
	text "Hold it."

	para "You're going to"
	line "take the #mon"

	para "League challenge"
	line "now?"

	para "That's not going"
	line "to happen."

	para "My super well-"
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
	text "as the #mon"
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

PlateauRivalApproachesMovement:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

PlateauRivalLeavesMovement:
	step_down
	step_down
	step_down
	step_down
	step_down
	step_end

PokemonJournalGiovanniScript:
	setflag ENGINE_READ_GIOVANNI_JOURNAL
	jumpthistext

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

IndigoPlateauYellowScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_YELLOW_INTRO
	iftrue .HeardIntro
	writetext .GreetingText
	waitbutton
	setevent EVENT_LISTENED_TO_YELLOW_INTRO
.HeardIntro
	writetext .QuestionText
	yesorno
	iffalse_jumpopenedtext .RefusedText
	writetext .GiveStarterText
	promptbutton
	waitsfx
	checkevent EVENT_GOT_BULBASAUR_FROM_IVY
	iftrue .Squirtle
	checkevent EVENT_GOT_CHARMANDER_FROM_IVY
	iftrue .Bulbasaur
	givepoke CHARMANDER, NO_FORM, 10, SITRUS_BERRY
	sjump .Finish

.Bulbasaur:
	givepoke BULBASAUR, NO_FORM, 10, SITRUS_BERRY
	sjump .Finish

.Squirtle:
	givepoke SQUIRTLE, NO_FORM, 10, SITRUS_BERRY
.Finish:
	iffalse_jumpopenedtext .PartyAndBoxFullText
	writetext .GoodbyeText
	waitbutton
	closetext
	readvar VAR_FACING
	turnobject PLAYER, DOWN
	ifnotequal UP, .noleftstep
	applyonemovement INDIGOPLATEAUPOKECENTER1F_YELLOW, step_left
.noleftstep
	applymovement INDIGOPLATEAUPOKECENTER1F_YELLOW, .DownMovement
	playsound SFX_EXIT_BUILDING
	disappear INDIGOPLATEAUPOKECENTER1F_YELLOW
	setevent EVENT_GOT_A_POKEMON_FROM_YELLOW
	waitsfx
	end

.PartyAndBoxFullText:
	text "Yellow: Oh…"
	line "You can't carry"

	para "another #mon"
	line "either…"

	para "And your box is"
	line "full, too…"
	done

.GreetingText:
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

.QuestionText:
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

.GiveStarterText:
	text "Yellow: Thanks,"
	line "<PLAYER>! Here"
	cont "you go!"
	done

.RefusedText:
	text "Yellow: Oh…"
	line "But what about the"
	cont "#mon?"
	done

.GoodbyeText:
	text "Yellow: You take"
	line "good care of that"

	para ""
	text_ram wStringBuffer3
	text ","
	line "<PLAYER>!"

	para "I hope we'll meet"
	line "again."
	cont "Bye-bye!"
	done

.DownMovement:
	step_down
	step_down
	step_down
	step_down
	step_end

IndigoPlateauTeleportGuyScript:
	faceplayer
	opentext
	writetext .Text
	yesorno
	iffalse_jumpopenedtext .NoText
	writetext .YesText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	special FadeOutPalettes
	waitsfx
	warp NEW_BARK_TOWN, 15, 6
	end

.Text:
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

.YesText:
	text "OK, OK. Picture"
	line "your house in your"
	cont "mind…"
	done

.NoText:
	text "OK, OK. The best"
	line "of luck to you!"
	done

IndigoPlateauAbraText:
	text "Abra: Aabra…"
	done

IndigoPlateauCooltrainermText:
	text "At the #mon"
	line "League, you'll get"

	para "tested by the"
	line "Elite Four."

	para "You have to beat"
	line "them all. If you"

	para "lose, you have to"
	line "start all over!"
	done
