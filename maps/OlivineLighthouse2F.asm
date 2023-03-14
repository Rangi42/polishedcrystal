OlivineLighthouse2F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 11, OLIVINE_LIGHTHOUSE_1F, 3
	warp_event  5,  3, OLIVINE_LIGHTHOUSE_3F, 2
	warp_event 16, 13, OLIVINE_LIGHTHOUSE_1F, 4
	warp_event 17, 13, OLIVINE_LIGHTHOUSE_1F, 5
	warp_event 16, 11, OLIVINE_LIGHTHOUSE_3F, 4
	warp_event 17, 11, OLIVINE_LIGHTHOUSE_3F, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerSailorHuey1, -1
	object_event 17,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGentlemanAlfred, -1

TrainerGentlemanAlfred:
	trainer GENTLEMAN, ALFRED, EVENT_BEAT_GENTLEMAN_ALFRED, GentlemanAlfredSeenText, GentlemanAlfredBeatenText, 0, GentlemanAlfredScript

GentlemanAlfredScript:
	endifjustbattled
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue_jumptextfaceplayer GentlemanAlfredFinalText
	jumptextfaceplayer GentlemanAlfredAfterBattleText

TrainerSailorHuey1:
	trainer SAILOR, HUEY1, EVENT_BEAT_SAILOR_HUEY, SailorHuey1SeenText, SailorHuey1BeatenText, 0, SailorHuey1Script

SailorHuey1Script:
	loadvar VAR_CALLERID, PHONE_SAILOR_HUEY
	opentext
	checkflag ENGINE_HUEY_READY_FOR_REMATCH
	iftruefwd .WantsBattle
	checkcellnum PHONE_SAILOR_HUEY
	iftruefwd .NumberAccepted
	checkevent EVENT_HUEY_ASKED_FOR_PHONE_NUMBER
	iftruefwd .AskedBefore
	setevent EVENT_HUEY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjumpfwd .AskForNumber

.AskedBefore:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_SAILOR_HUEY
	ifequalfwd $1, .PhoneFull
	ifequalfwd $2, .NumberDeclined
	gettrainername SAILOR, HUEY1, $0
	scall .RegisteredNumber
	sjumpfwd .NumberAccepted

.WantsBattle:
	scall .Rematch
	winlosstext SailorHuey1BeatenText, 0
	readmem wHueyFightCount
	ifequalfwd 3, .Fight3
	ifequalfwd 2, .Fight2
	ifequalfwd 1, .Fight1
	ifequalfwd 0, .LoadFight0
.Fight3:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftruefwd .LoadFight3
.Fight2:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftruefwd .LoadFight2
.Fight1:
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftruefwd .LoadFight1
.LoadFight0:
	loadtrainer SAILOR, HUEY1
	startbattle
	reloadmapafterbattle
	loadmem wHueyFightCount, 1
	clearflag ENGINE_HUEY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SAILOR, HUEY2
	startbattle
	reloadmapafterbattle
	loadmem wHueyFightCount, 2
	clearflag ENGINE_HUEY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SAILOR, HUEY3
	startbattle
	reloadmapafterbattle
	loadmem wHueyFightCount, 3
	clearflag ENGINE_HUEY_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SAILOR, HUEY4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_HUEY_READY_FOR_REMATCH
	checkevent EVENT_HUEY_PROTEIN
	iftruefwd .HasProtein
	checkevent EVENT_GOT_PROTEIN_FROM_HUEY
	iftruefwd .SkipGift
	scall .RematchGift
	verbosegiveitem PROTEIN
	iffalsefwd .PackFull
	setevent EVENT_GOT_PROTEIN_FROM_HUEY
	sjumpfwd .NumberAccepted

.SkipGift:
	end

.HasProtein:
	opentext
	writetext SailorHueyGiveProteinText
	waitbutton
	verbosegiveitem PROTEIN
	iffalsefwd .PackFull
	clearevent EVENT_HUEY_PROTEIN
	setevent EVENT_GOT_PROTEIN_FROM_HUEY
	sjumpfwd .NumberAccepted

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

.PackFull:
	setevent EVENT_HUEY_PROTEIN
	jumpstd packfullm
	end

.RematchGift:
	jumpstd rematchgiftm

SailorHuey1SeenText:
	text "Men of the sea are"
	line "always spoiling"
	cont "for a good fight!"
	done

SailorHuey1BeatenText:
	text "Urf!"
	line "I lose!"
	done

GentlemanAlfredSeenText:
	text "Hm? This is no"
	line "place for playing."
	done

GentlemanAlfredBeatenText:
	text "Ah! I can see that"
	line "you're serious."
	done

GentlemanAlfredAfterBattleText:
	text "Up top is a #-"
	line "mon that keeps the"
	cont "Lighthouse lit."

	para "But I hear that"
	line "it's sick now and"

	para "can't be cured by"
	line "ordinary medicine."
	done

GentlemanAlfredFinalText:
	text "Up top is a #-"
	line "mon that keeps the"
	cont "Lighthouse lit."

	para "You helped cure"
	line "its sickness?"

	para "You've done us a"
	line "real service!"
	done

SailorHueyGiveProteinText:
	text "Man! You're as"
	line "tough as ever!"

	para "Anyway, here's"
	line "that medicine from"
	cont "before."
	done
