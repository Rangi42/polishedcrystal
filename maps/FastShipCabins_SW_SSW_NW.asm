FastShipCabins_SW_SSW_NW_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  0, FAST_SHIP_1F, 5
	warp_event  2, 19, FAST_SHIP_1F, 6
	warp_event  3, 19, FAST_SHIP_1F, 6
	warp_event  2, 31, FAST_SHIP_1F, 7
	warp_event  3, 31, FAST_SHIP_1F, 7

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, FastShipBed
	bg_event  7,  2, BGEVENT_READ, FastShipBed

	def_object_events
	object_event  1, 15, SPRITE_FIREBREATHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerFirebreatherLyle, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  6, 15, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 2, GenericTrainerBug_catcherKen, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5, 27, SPRITE_RICH_BOY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerRichBoyWinston, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  1, 26, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_GENERICTRAINER, 3, GenericTrainerBeautyCassie, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  3, 28, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGuitaristmClyde, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND

GenericTrainerFirebreatherLyle:
	generictrainer FIREBREATHER, LYLE, EVENT_BEAT_FIREBREATHER_LYLE, FirebreatherLyleSeenText, FirebreatherLyleBeatenText

	ctxt "I guess fire is"
	line "weak on the sea."

	para "It doesn't matter?"
	line "Really?"
	done

GenericTrainerBug_catcherKen:
	generictrainer BUG_CATCHER, KEN, EVENT_BEAT_BUG_CATCHER_KEN, Bug_catcherKenSeenText, Bug_catcherKenBeatenText

	ctxt "You can find lots"
	line "of #mon in the"
	cont "trees of Johto!"
	done

GenericTrainerRichBoyWinston:
	generictrainer RICH_BOY, WINSTON, EVENT_BEAT_RICH_BOY_WINSTON, RichBoyWinstonSeenText, RichBoyWinstonBeatenText

	ctxt "This boat is so"
	line "drab."
	done

GenericTrainerBeautyCassie:
	generictrainer BEAUTY, CASSIE, EVENT_BEAT_BEAUTY_CASSIE, BeautyCassieSeenText, BeautyCassieBeatenText

	ctxt "A voyage is best"
	line "for getting over"
	cont "a broken heart."

	para "But a Fast Ship"
	line "trip is too short"
	cont "for grieving."
	done

TrainerGuitaristmClyde:
	trainer GUITARISTM, CLYDE, EVENT_BEAT_GUITARISTM_CLYDE, GuitaristmClydeSeenText, GuitaristmClydeBeatenText, 0, GuitaristmClydeScript

GuitaristmClydeScript:
	endifjustbattled
	opentext
	checkbp 0
	iffalse .BattleTower
	jumpopenedtext GuitaristClydeAfterBattleText

.BattleTower:
	jumpopenedtext GuitaristClydeAfterBattleMobileText

FastShipBed:
	showtext FastShipBedText1
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	special HealParty
	playmusic MUSIC_HEAL
	pause 60
	special RestartMapMusic
	special Special_FadeInQuickly
	showtext FastShipBedText2
	checkevent EVENT_FAST_SHIP_HAS_ARRIVED
	iftrue UnknownScript_0x75ae1
	checkevent EVENT_FAST_SHIP_FOUND_GIRL
	iftrue UnknownScript_0x75ae2
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue UnknownScript_0x75ae2
UnknownScript_0x75ae1:
	end

UnknownScript_0x75ae2:
	playsound SFX_ELEVATOR_END
	pause 30
	checkevent EVENT_FAST_SHIP_DESTINATION_OLIVINE
	iftrue UnknownScript_0x75af7
	showtext FastShipArrivedVermilionText
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

UnknownScript_0x75af7:
	showtext FastShipArrivedOlivineText
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	end

FirebreatherLyleSeenText:
	ctxt "I'm going to Kanto"
	line "to put on fire-"
	cont "breathing shows!"
	done

FirebreatherLyleBeatenText:
	ctxt "Fizzle… The"
	line "flame's tiny…"
	done

Bug_catcherKenSeenText:
	ctxt "I'm visiting my"
	line "grandma to catch"
	cont "me some bugs!"
	done

Bug_catcherKenBeatenText:
	ctxt "Ooh, wow."
	line "You're tough!"
	done

RichBoyWinstonSeenText:
	ctxt "There's no way you"
	line "could afford a"
	cont "ticket."

	para "It looks like we've"
	line "got a stowaway!"
	done

RichBoyWinstonBeatenText:
	ctxt "Wow! Who'd you buy"
	line "your #mon from?"
	done

BeautyCassieSeenText:
	ctxt "I'm trying to"
	line "forget my woes."
	cont "Let's battle!"
	done

BeautyCassieBeatenText:
	ctxt "My heart weeps…"
	done

GuitaristmClydeSeenText:
	ctxt "I'm going to audi-"
	line "tion my songs at"

	para "Goldenrod's Radio"
	line "Station."
	done

GuitaristmClydeBeatenText:
	ctxt "Yowza!"
	line "Total distortion!"
	done

GuitaristClydeAfterBattleText:
	ctxt "Speaking of the"
	line "Radio Station,"

	para "what's this week's"
	line "lucky number?"
	done

GuitaristClydeAfterBattleMobileText:
	ctxt "I was going to"
	line "make my debut at"
	cont "the Battle Tower…"

	para "I should go back"
	line "to Vermilion and"
	cont "redo my training…"
	done

FastShipBedText1:
	ctxt "A comfy bed!"
	line "Time to sleep…"
	done

FastShipBedText2:
	ctxt "Ah, refreshed and"
	line "restored!"
	done

FastShipArrivedOlivineText:
	ctxt "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Olivine City."
	done

FastShipArrivedVermilionText:
	ctxt "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Vermilion City."
	done
