Route26_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  7,  5, POKEMON_LEAGUE_GATE, 3
	warp_event 15, 57, ROUTE_26_HEAL_SPEECH_HOUSE, 1
	warp_event  5, 71, ROUTE_26_DAY_OF_WEEK_SIBLINGS_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  8,  6, BGEVENT_JUMPTEXT, Route26SignText

	def_object_events
	object_event  9, 38, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerKazu, -1
	object_event 14, 24, SPRITE_ACE_TRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerCooltrainermGaven1, -1
	object_event 10, 56, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerCooltrainerfJoyce, -1
	object_event  5,  8, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfBeth1, -1
	object_event 13, 79, SPRITE_PSYCHIC, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerPsychicRichard, -1
	object_event  2, 82, SPRITE_BATTLE_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 4, GenericTrainerBattleGirlRonda, -1
	object_event  6, 100, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 1, GenericTrainerFisherScott, -1
	object_event 10, 92, SPRITE_DRAGON_TAMER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerDragonTamerErick, -1
	fruittree_event 14, 54, FRUITTREE_ROUTE_26, SITRUS_BERRY, PAL_NPC_BROWN
	itemball_event  9, 15, MAX_ELIXIR, 1, EVENT_ROUTE_26_MAX_ELIXIR
	tmhmball_event 13, 34, TM_DRAGON_CLAW, EVENT_ROUTE_26_TM_DRAGON_CLAW

GenericTrainerDragonTamerKazu:
	generictrainer DRAGON_TAMER, KAZU, EVENT_BEAT_DRAGON_TAMER_KAZU, DragonTamerKazuSeenText, DragonTamerKazuBeatenText

	text "It's going to be"
	line "tough to win at"
	cont "the League."

	para "I need to do some"
	line "more training."

	para "I hear that the"
	line "League's Elite"

	para "Four are tougher"
	line "than Gym Leaders."
	done

TrainerCooltrainermGaven1:
	trainer COOLTRAINERM, GAVEN1, EVENT_BEAT_COOLTRAINERM_GAVEN, CooltrainermGaven1SeenText, CooltrainermGaven1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERM_GAVEN
	opentext
	checkflag ENGINE_GAVEN_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERM_GAVEN
	iftrue .NumberAccepted
	checkevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainermGavenAfterText
	promptbutton
	setevent EVENT_GAVEN_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERM_GAVEN
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	gettrainername COOLTRAINERM, GAVEN1, $0
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainermGaven1BeatenText, 0
	readmem wGavenFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer COOLTRAINERM, GAVEN1
	startbattle
	reloadmapafterbattle
	loadmem wGavenFightCount, 1
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERM, GAVEN2
	startbattle
	reloadmapafterbattle
	loadmem wGavenFightCount, 2
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERM, GAVEN3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GAVEN_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd asknumber1m

.AskNumber2:
	jumpstd asknumber2m

.RegisteredNumber:
	jumpstd registerednumberm

.NumberAccepted:
	jumpstd numberacceptedm

.NumberDeclined:
	jumpstd numberdeclinedm

.PhoneFull:
	jumpstd phonefullm

.Rematch:
	jumpstd rematchm

GenericTrainerCooltrainerfJoyce:
	generictrainer COOLTRAINERF, JOYCE, EVENT_BEAT_COOLTRAINERF_JOYCE, CooltrainerfJoyceSeenText, CooltrainerfJoyceBeatenText

	text "I've defeated"
	line "eight Gym Leaders,"

	para "so I was feeling"
	line "confident."

	para "I'll have to try"
	line "harder next time."
	done

TrainerCooltrainerfBeth1:
	trainer COOLTRAINERF, BETH1, EVENT_BEAT_COOLTRAINERF_BETH, CooltrainerfBeth1SeenText, CooltrainerfBeth1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_COOLTRAINERF_BETH
	opentext
	checkflag ENGINE_BETH_READY_FOR_REMATCH
	iftrue .WantsBattle
	checkcellnum PHONE_COOLTRAINERF_BETH
	iftrue .NumberAccepted
	checkevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext CooltrainerfBethAfterText
	promptbutton
	setevent EVENT_BETH_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_COOLTRAINERF_BETH
	ifequal $1, .PhoneFull
	ifequal $2, .NumberDeclined
	gettrainername COOLTRAINERF, BETH1, $0
	scall .RegisteredNumber
	sjump .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext CooltrainerfBeth1BeatenText, 0
	readmem wBethFightCount
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight2:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight2
.Fight1:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer COOLTRAINERF, BETH1
	startbattle
	reloadmapafterbattle
	loadmem wBethFightCount, 1
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer COOLTRAINERF, BETH2
	startbattle
	reloadmapafterbattle
	loadmem wBethFightCount, 2
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer COOLTRAINERF, BETH3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_BETH_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd asknumber1f

.AskNumber2:
	jumpstd asknumber2f

.RegisteredNumber:
	jumpstd registerednumberf

.NumberAccepted:
	jumpstd numberacceptedf

.NumberDeclined:
	jumpstd numberdeclinedf

.PhoneFull:
	jumpstd phonefullf

.Rematch:
	jumpstd rematchf

GenericTrainerPsychicRichard:
	generictrainer PSYCHIC_T, RICHARD, EVENT_BEAT_PSYCHIC_RICHARD, PsychicRichardSeenText, PsychicRichardBeatenText

	text "People and #mon"
	line "grow from their"
	cont "experiences."

	para "Don't get lazy and"
	line "complacent."
	done

GenericTrainerBattleGirlRonda:
	generictrainer BATTLE_GIRL, RONDA, EVENT_BEAT_BATTLE_GIRL_RONDA, BattleGirlRondaSeenText, BattleGirlRondaBeatenText

	text "You see some of"
	line "the world's str-"

	para "ongest trainers"
	line "come through here."

	para "And I get to fight"
	line "them all!"
	done

GenericTrainerFisherScott:
	generictrainer FISHER, SCOTT, EVENT_BEAT_FISHER_SCOTT, FisherScottSeenText, FisherScottBeatenText

	text "Just like in fish-"
	line "ing, it's all over"

	para "in #mon if you"
	line "give up."
	done

GenericTrainerDragonTamerErick:
	generictrainer DRAGON_TAMER, ERICK, EVENT_BEAT_DRAGON_TAMER_ERICK, DragonTamerErickSeenText, DragonTamerErickBeatenText

	text "Victory Road is"
	line "harsh."

	para "Every trainer must"
	line "forge their own"
	cont "way through it."
	done

DragonTamerKazuSeenText:
	text "I'm making my"
	line "final preparations"

	para "for the #mon"
	line "League."
	done

DragonTamerKazuBeatenText:
	text "I blew it!"
	done

CooltrainermGaven1SeenText:
	text "By experiencing"
	line "tough battles, you"
	cont "gain power."
	done

CooltrainermGaven1BeatenText:
	text "Gaah! Life is even"
	line "tougher!"
	done

CooltrainermGavenAfterText:
	text "To get to the"
	line "#mon League,"

	para "you have to get"
	line "through Victory"
	cont "Road."

	para "But Victory Road"
	line "is tough."

	para "Practically nobody"
	line "goes there!"
	done

CooltrainerfJoyceSeenText:
	text "Since you've come"
	line "this far, you must"
	cont "be good."

	para "I'm going to give"
	line "this battle every-"
	cont "thing I've got!"
	done

CooltrainerfJoyceBeatenText:
	text "No! I don't"
	line "believe this!"
	done

CooltrainerfBeth1SeenText:
	text "I lost to a train-"
	line "er named <RIVAL>."

	para "He was really"
	line "strong, but…"

	para "It was as if he"
	line "absolutely had to"
	cont "win at any cost."

	para "I felt sorry for"
	line "his #mon."
	done

CooltrainerfBeth1BeatenText:
	text "#mon aren't"
	line "tools of war."
	done

CooltrainerfBethAfterText:
	text "#mon are in-"
	line "valuable, lifelong"
	cont "partners."
	done

PsychicRichardSeenText:
	text "Wow, look at all"
	line "those Badges!"
	cont "I'm impressed."

	para "But you're not"
	line "satisfied by just"

	para "collecting them,"
	line "right?"
	done

PsychicRichardBeatenText:
	text "Good battle!"
	done

BattleGirlRondaSeenText:
	text "Stop! I challenge"
	line "you to a duel!"
	done

BattleGirlRondaBeatenText:
	text "Victory is yours!"
	done

FisherScottSeenText:
	text "I'm feeling great"
	line "today!"

	para "I feel like I"
	line "could boot even"
	cont "the League Champ!"
	done

FisherScottBeatenText:
	text "No! Not in this"
	line "battle!"
	done

DragonTamerErickSeenText:
	text "Here be dragons!"
	done

DragonTamerErickBeatenText:
	text "My dragons were"
	line "conquered…"
	done

Route26SignText:
	text "Route 26"

	para "#mon League"
	line "Reception Gate"
	done
