FastShipCabins_SE_SSE_CaptainsCabin_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 6 ; warp events
	warp_event  2,  7, FAST_SHIP_1F, 8
	warp_event  3,  7, FAST_SHIP_1F, 8
	warp_event  2, 19, FAST_SHIP_1F, 9
	warp_event  3, 19, FAST_SHIP_1F, 9
	warp_event  2, 33, FAST_SHIP_1F, 10
	warp_event  3, 33, FAST_SHIP_1F, 10

	db 0 ; coord events

	db 0 ; bg events

	db 11 ; object events
	object_event  2, 17, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, GentlemanScript_0x75f1f, EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	object_event  3, 17, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_COMMAND, jumptextfaceplayer, UnknownText_0x7630d, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	object_event  2, 25, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, TwinScript_0x75ebb, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	object_event  3, 25, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, CaptainScript_0x75ea7, -1
	object_event  5,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 5, GenericTrainerPokefanmColin, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  2,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerTwinsMegandpeg1, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  3,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerTwinsMegandpeg2, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  5,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PURPLE, PERSONTYPE_GENERICTRAINER, 5, GenericTrainerPsychicRodney, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 3, GenericTrainerPokefanmJeremy, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, PERSONTYPE_GENERICTRAINER, 1, GenericTrainerPokefanfGeorgia, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  1, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, PERSONTYPE_GENERICTRAINER, 2, GenericTrainerSupernerdShawn, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND

	const_def 1 ; object constants
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2

CaptainScript_0x75ea7:
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue_jumptextfaceplayer UnknownText_0x76064
	jumptextfaceplayer UnknownText_0x76012

TwinScript_0x75ebb:
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, RIGHT
	showtext UnknownText_0x761e0
	showtextfaceplayer UnknownText_0x7621f
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2
	applymovement PLAYER, MovementData_0x76004
	moveobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, 3, 19
	appear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	turnobject PLAYER, UP
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, UP
	special Special_FadeInQuickly
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, DOWN
	showemote EMOTE_SHOCK, FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, 15
	applymovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, MovementData_0x7600c
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, RIGHT
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue UnknownScript_0x75f03
	showtext UnknownText_0x76284
	jump UnknownScript_0x75f09

UnknownScript_0x75f03:
	showtext UnknownText_0x762c6
UnknownScript_0x75f09:
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, DOWN
	applyonemovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, step_down
	opentext
	writetext UnknownText_0x76143
	buttonsound
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	setmapscene FAST_SHIP_1F, $0
	jump UnknownScript_0x75f37

GentlemanScript_0x75f1f:
	checkevent EVENT_GOT_MACHO_BRACE_FROM_GRANDPA_ON_SS_AQUA
	iftrue_jumptextfaceplayer UnknownText_0x761be
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	iftrue UnknownScript_0x75f58
	writetext UnknownText_0x760ae
	waitbutton
	closetext
	setmapscene FAST_SHIP_1F, $0
	end

UnknownScript_0x75f37:
	writetext UnknownText_0x7619b
	buttonsound
	verbosegiveitem MACHO_BRACE
	setevent EVENT_GOT_MACHO_BRACE_FROM_GRANDPA_ON_SS_AQUA
	closetext
	waitsfx
	playsound SFX_ELEVATOR_END
	pause 30
	opentext
	writetext UnknownText_0x76645
	waitbutton
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	setevent EVENT_FAST_SHIP_FOUND_GIRL
	endtext

UnknownScript_0x75f58:
	writetext UnknownText_0x7619b
	buttonsound
	verbosegiveitem MACHO_BRACE
	iffalse_endtext
	setevent EVENT_GOT_MACHO_BRACE_FROM_GRANDPA_ON_SS_AQUA
	endtext

GenericTrainerPokefanmColin:
	generictrainer POKEFANM, COLIN, EVENT_BEAT_POKEFANM_COLIN, PokefanmColinSeenText, PokefanmColinBeatenText

	text "You're traveling"
	line "all alone?"

	para "Isn't your mom"
	line "worried?"
	done

GenericTrainerTwinsMegandpeg1:
	generictrainer TWINS, MEGANDPEG1, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg1SeenText, TwinsMegandpeg1BeatenText

	text "Baby is a rude"
	line "name to call us"
	cont "girls!"
	done

GenericTrainerTwinsMegandpeg2:
	generictrainer TWINS, MEGANDPEG2, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg2SeenText, TwinsMegandpeg2BeatenText

	text "Sometimes, kids"
	line "are smarter than"
	cont "grown-ups!"
	done

GenericTrainerPsychicRodney:
	generictrainer PSYCHIC_T, RODNEY, EVENT_BEAT_PSYCHIC_RODNEY, PsychicRodneySeenText, PsychicRodneyBeatenText

	text "I get it. You can"
	line "hear Johto's radio"
	cont "on the Fast Ship."
	done

GenericTrainerPokefanmJeremy:
	generictrainer POKEFANM, JEREMY, EVENT_BEAT_POKEFANM_JEREMY, PokefanmJeremySeenText, PokefanmJeremyBeatenText

	text "I must go to the"
	line "#mon Salon and"
	cont "fix them up nice!"
	done

GenericTrainerPokefanfGeorgia:
	generictrainer POKEFANF, GEORGIA, EVENT_BEAT_POKEFANF_GEORGIA, PokefanfGeorgiaSeenText, PokefanfGeorgiaBeatenText

	text "Oh, yes! I have to"
	line "get my #mon out"
	cont "of Day-Care!"
	done

GenericTrainerSupernerdShawn:
	generictrainer SUPER_NERD, SHAWN, EVENT_BEAT_SUPER_NERD_SHAWN, SupernerdShawnSeenText, SupernerdShawnBeatenText

	text "You should use the"
	line "right Balls to fit"
	cont "the situation."
	done

MovementData_0x76004:
	big_step_right
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	big_step_up
	step_end

MovementData_0x7600c:
	step_up
	step_up
	turn_head_left
	step_end

UnknownText_0x76012:
	text "Whew! Thanks for"
	line "coming along."

	para "Keeping that lit-"
	line "tle girl amused"
	cont "was exhausting."
	done

UnknownText_0x76064:
	text "How do you like"
	line "S.S.Aqua's ride?"

	para "She practically"
	line "skates across the"
	cont "waves."
	done

UnknownText_0x760ae:
	text "Oh, hello…"

	para "I still can't find"
	line "my granddaughter."

	para "If she's on the"
	line "ship, that's OK."

	para "She's an energetic"
	line "child, so she may"

	para "be bugging some-"
	line "one. I'm worried…"
	done

UnknownText_0x76143:
	text "<PLAYER>, was it?"
	line "I heard you enter-"
	cont "tained my grand-"
	cont "daughter."

	para "I want to thank"
	line "you for that."
	done

UnknownText_0x7619b:
	text "I know! I'd like"
	line "you to have this!"
	done

UnknownText_0x761be:
	text "We're traveling"
	line "around the world."
	done

UnknownText_0x761e0:
	text "Captain, play with"
	line "me, please?"

	para "I'm bored! I want"
	line "to play more!"
	done

UnknownText_0x7621f:
	text "Hi! Will you play"
	line "with me?"

	para "…Oh!"

	para "Grandpa's worried"
	line "about me?"

	para "I have to go!"

	para "I have to go find"
	line "Grandpa!"
	done

UnknownText_0x76284:
	text "Grandpa, here I"
	line "am! I was playing"

	para "with the Captain"
	line "and this guy!"
	done

UnknownText_0x762c6:
	text "Grandpa, here I"
	line "am! I was playing"

	para "with the Captain"
	line "and this big girl!"
	done

UnknownText_0x7630d:
	text "I had lots of fun"
	line "playing!"
	done

PokefanmColinSeenText:
	text "Hey, kid! Want to"
	line "battle with me?"
	done

PokefanmColinBeatenText:
	text "You're strong!"
	done

TwinsMegandpeg1SeenText:
	text "You think I'm a"
	line "baby?"
	cont "That's not fair!"
	done

TwinsMegandpeg1BeatenText:
	text "Oh! We lost!"
	done

TwinsMegandpeg2SeenText:
	text "I'm not a baby!"

	para "That's not nice to"
	line "say to a lady!"
	done

TwinsMegandpeg2BeatenText:
	text "Oh! We lost!"
	done

PsychicRodneySeenText:
	text "Ssh! My brain is"
	line "picking up radio"
	cont "signals!"
	done

PsychicRodneyBeatenText:
	text "…I hear some-"
	line "thing!"
	done

PokefanmJeremySeenText:
	text "What do you think?"
	line "My #mon are"
	cont "beautiful, yes?"
	done

PokefanmJeremyBeatenText:
	text "Oh, no! My beauti-"
	line "ful #mon!"
	done

PokefanfGeorgiaSeenText:
	text "I'm going to shop"
	line "at the Dept.Store"
	cont "and then…"
	done

PokefanfGeorgiaBeatenText:
	text "What was I going"
	line "to do?"
	done

SupernerdShawnSeenText:
	text "What kinds of #"
	line "Balls do you have"
	cont "with you?"
	done

SupernerdShawnBeatenText:
	text "Wait! Stop! Don't!"
	line "Please!"
	done

UnknownText_0x76645:
	text "Fast Ship S.S.Aqua"
	line "has arrived in"
	cont "Vermilion City."
	done
