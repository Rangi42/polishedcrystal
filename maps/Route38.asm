Route38_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event 35, 8, 1, ROUTE_38_ECRUTEAK_GATE
	warp_event 35, 9, 2, ROUTE_38_ECRUTEAK_GATE

	db 0 ; coord events

	db 2 ; bg events
	bg_event 33, 7, SIGNPOST_JUMPTEXT, Route38SignText
	bg_event 5, 13, SIGNPOST_JUMPTEXT, Route38TrainerTipsText

	db 7 ; object events
	object_event 4, 1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerSchoolboyChad1, -1
	object_event 15, 3, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerLassDana1, -1
	object_event 12, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBird_keeperToby, -1
	object_event 19, 9, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBeautyValencia, -1
	object_event 24, 5, SPRITE_SAILOR, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 2, TrainerSailorHarry, -1
	fruittree_event 12, 10, FRUITTREE_ROUTE_38, SITRUS_BERRY
	object_event 5, 8, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_TRAINER, 1, TrainerBeautyOlivia, -1

TrainerBird_keeperToby:
	trainer BIRD_KEEPER, TOBY, EVENT_BEAT_BIRD_KEEPER_TOBY, Bird_keeperTobySeenText, Bird_keeperTobyBeatenText, 0, .script

.script
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a1f86

TrainerSailorHarry:
	trainer SAILOR, HARRY, EVENT_BEAT_SAILOR_HARRY, SailorHarrySeenText, SailorHarryBeatenText, 0, .script

.script
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a220c

TrainerLassDana1:
	trainer LASS, DANA1, EVENT_BEAT_LASS_DANA, LassDana1SeenText, LassDana1BeatenText, 0, .script

.script
	writecode VAR_CALLERID, PHONE_LASS_DANA
	opentext
	checkflag ENGINE_DANA
	iftrue .DanaRematch
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue .TryGiveThunderstone
	checkcellnum PHONE_LASS_DANA
	iftrue .NumberAccepted
	checkevent EVENT_DANA_ASKED_FOR_PHONE_NUMBER
	iftrue .SecondTimeAsking
	writetext UnknownText_0x1a20ec
	buttonsound
	setevent EVENT_DANA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1F
	jump .AskForPhoneNumber

.SecondTimeAsking:
	scall .AskNumber2F
.AskForPhoneNumber:
	askforphonenumber PHONE_LASS_DANA
	if_equal $1, .PhoneFull
	if_equal $2, .DeclinedPhoneNumber
	trainertotext LASS, DANA1, $0
	scall .RegisteredPhoneNumber
	jump .NumberAccepted

.DanaRematch:
	scall .Rematch
	winlosstext LassDana1BeatenText, 0
	copybytetovar wDanaFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer LASS, DANA1
	startbattle
	reloadmapafterbattle
	loadvar wDanaFightCount, 1
	clearflag ENGINE_DANA
	end

.LoadFight1:
	loadtrainer LASS, DANA2
	startbattle
	reloadmapafterbattle
	loadvar wDanaFightCount, 2
	clearflag ENGINE_DANA
	end

.LoadFight2:
	loadtrainer LASS, DANA3
	startbattle
	reloadmapafterbattle
	loadvar wDanaFightCount, 3
	clearflag ENGINE_DANA
	end

.LoadFight3:
	loadtrainer LASS, DANA4
	startbattle
	reloadmapafterbattle
	loadvar wDanaFightCount, 4
	clearflag ENGINE_DANA
	end

.LoadFight4:
	loadtrainer LASS, DANA5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA
	end

.TryGiveThunderstone:
	scall .Gift
	verbosegiveitem THUNDERSTONE
	iffalse .NoRoomForThunderstone
	clearflag ENGINE_DANA_HAS_THUNDERSTONE
	setevent EVENT_DANA_GAVE_THUNDERSTONE
	jump .NumberAccepted

.NoRoomForThunderstone:
	jump .PackFull

.AskNumber1F:
	jumpstd asknumber1f
	end

.AskNumber2F:
	jumpstd asknumber2f
	end

.RegisteredPhoneNumber:
	jumpstd registerednumberf
	end

.NumberAccepted:
	jumpstd numberacceptedf
	end

.DeclinedPhoneNumber:
	jumpstd numberdeclinedf
	end

.PhoneFull:
	jumpstd phonefullf
	end

.Rematch:
	jumpstd rematchf
	end

.Gift:
	jumpstd giftf
	end

.PackFull:
	jumpstd packfullf
	end

TrainerSchoolboyChad1:
	trainer SCHOOLBOY, CHAD1, EVENT_BEAT_SCHOOLBOY_CHAD, SchoolboyChad1SeenText, SchoolboyChad1BeatenText, 0, .script

.script
	writecode VAR_CALLERID, PHONE_SCHOOLBOY_CHAD
	opentext
	checkflag ENGINE_CHAD
	iftrue .ChadRematch
	checkcellnum PHONE_SCHOOLBOY_CHAD
	iftrue .HaveChadsNumber
	checkevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	iftrue .SecondTimeAsking
	writetext UnknownText_0x1a200e
	buttonsound
	setevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumber1
	jump .AskToRegisterNumber

.SecondTimeAsking:
	scall .AskPhoneNumber2
.AskToRegisterNumber:
	askforphonenumber PHONE_SCHOOLBOY_CHAD
	if_equal $1, .PhoneFull
	if_equal $2, .SaidNo
	trainertotext SCHOOLBOY, CHAD1, $0
	scall .RegisteredChad
	jump .HaveChadsNumber

.ChadRematch:
	scall .Rematch
	winlosstext SchoolboyChad1BeatenText, 0
	copybytetovar wChadFightCount
	if_equal 4, .Fight4
	if_equal 3, .Fight3
	if_equal 2, .Fight2
	if_equal 1, .Fight1
	if_equal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer SCHOOLBOY, CHAD1
	startbattle
	reloadmapafterbattle
	loadvar wChadFightCount, 1
	clearflag ENGINE_CHAD
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, CHAD2
	startbattle
	reloadmapafterbattle
	loadvar wChadFightCount, 2
	clearflag ENGINE_CHAD
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, CHAD3
	startbattle
	reloadmapafterbattle
	loadvar wChadFightCount, 3
	clearflag ENGINE_CHAD
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, CHAD4
	startbattle
	reloadmapafterbattle
	loadvar wChadFightCount, 4
	clearflag ENGINE_CHAD
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, CHAD5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD
	end

.AskPhoneNumber1:
	jumpstd asknumber1m
	end

.AskPhoneNumber2:
	jumpstd asknumber2m
	end

.RegisteredChad:
	jumpstd registerednumberm
	end

.HaveChadsNumber:
	jumpstd numberacceptedm
	end

.SaidNo:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.Rematch:
	jumpstd rematchm
	end

TrainerBeautyValencia:
	trainer BEAUTY, VALENCIA, EVENT_BEAT_BEAUTY_VALENCIA, BeautyValenciaSeenText, BeautyValenciaBeatenText, 0, .script

.script
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a2185

TrainerBeautyOlivia:
	trainer BEAUTY, OLIVIA, EVENT_BEAT_BEAUTY_OLIVIA, BeautyOliviaSeenText, BeautyOliviaBeatenText, 0, .script

.script
	end_if_just_battled
	jumptextfaceplayer UnknownText_0x1a229a

Bird_keeperTobySeenText:
	text "Fly high into the"
	line "sky, my beloved"
	cont "bird #mon!"
	done

Bird_keeperTobyBeatenText:
	text "I feel like just"
	line "flying away now."
	done

UnknownText_0x1a1f86:
	text "I plan to train in"
	line "Cianwood City to"

	para "teach my #mon"
	line "how to Fly."
	done

SchoolboyChad1SeenText:
	text "Let me try some-"
	line "thing I learned"
	cont "today."
	done

SchoolboyChad1BeatenText:
	text "I didn't study"
	line "enough, I guess."
	done

UnknownText_0x1a200e:
	text "I have to take so"
	line "many tests, I"

	para "don't have much"
	line "time for #mon."

	para "So when I do get"
	line "to play, I really"
	cont "concentrate."
	done

LassDana1SeenText:
	text "You seem to be"
	line "good at #mon."

	para "If you are, how"
	line "about giving me"
	cont "some advice?"
	done

LassDana1BeatenText:
	text "I see. So you can"
	line "battle that way."
	done

UnknownText_0x1a20ec:
	text "I know something"
	line "good!"

	para "Moomoo Farm's milk"
	line "is famous for its"
	cont "flavor."
	done

BeautyValenciaSeenText:
	text "Hi! Aren't you a"
	line "cute trainer!"

	para "May I see your"
	line "#mon?"
	done

BeautyValenciaBeatenText:
	text "I'm glad I got to"
	line "see your #mon!"
	done

UnknownText_0x1a2185:
	text "When I see #-"
	line "mon, it seems to"
	cont "soothe my nerves."
	done

SailorHarrySeenText:
	text "I've been over-"
	line "seas, so I know"

	para "about all sorts of"
	line "#mon!"
	done

SailorHarryBeatenText:
	text "Your skill is"
	line "world class!"
	done

UnknownText_0x1a220c:
	text "All kinds of peo-"
	line "ple around the"

	para "world live happily"
	line "with #mon."
	done

BeautyOliviaSeenText:
	text "Don't you think my"
	line "#mon and I are"
	cont "beautiful?"
	done

BeautyOliviaBeatenText:
	text "We drink Moomoo"
	line "Milk every day."
	done

UnknownText_0x1a229a:
	text "Moomoo Milk is"
	line "good for beauty"
	cont "and health."

	para "I like to buy a"
	line "dozen bottles at"
	cont "a time!"
	done

Route38SignText:
	text "Route 38"

	para "Olivine City -"
	line "Ecruteak City"
	done

Route38TrainerTipsText:
	text "Trainer Tips"

	para "If a #mon is"
	line "trying to evolve,"
	cont "you can stop it."

	para "Press the B But-"
	line "ton during evolu-"
	cont "tion."

	para "That startles the"
	line "#mon and stops"
	cont "its evolution."
	done
