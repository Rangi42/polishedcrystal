KurtsHouse_MapScriptHeader:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, KurtsHouseKurtCallback

	def_warp_events
	warp_event  3,  7, AZALEA_TOWN, 4
	warp_event  4,  7, AZALEA_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_JUMPSTD, radio2
	bg_event  8,  0, BGEVENT_JUMPTEXT, KurtsHouseOakPhotoText
	bg_event  9,  0, BGEVENT_JUMPTEXT, KurtsHouseOakPhotoText
	bg_event  5,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript
	bg_event  2,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript
	bg_event  3,  1, BGEVENT_READ, PokemonJournalProfWestwoodScript
	bg_event  4,  1, BGEVENT_JUMPTEXT, KurtsHouseCelebiStatueText

	def_object_events
	object_event  3,  2, SPRITE_KURT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Kurt1, EVENT_KURTS_HOUSE_KURT_1
	object_event  5,  3, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtsGranddaughter1, EVENT_KURTS_HOUSE_GRANDDAUGHTER_1
	object_event 14,  3, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Kurt2, EVENT_KURTS_HOUSE_KURT_2
	object_event 11,  4, SPRITE_SCHOOLGIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, KurtsGranddaughter2, EVENT_KURTS_HOUSE_GRANDDAUGHTER_2
	pokemon_event  6,  3, SLOWPOKE, -1, -1, PAL_NPC_RED, KurtsHouseSlowpokeText, EVENT_KURTS_HOUSE_SLOWPOKE

	object_const_def
	const KURTSHOUSE_KURT1
	const KURTSHOUSE_TWIN1
	const KURTSHOUSE_KURT2
	const KURTSHOUSE_TWIN2

KurtsHouseKurtCallback:
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iffalse .Done
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .Done
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue .MakingBalls
	disappear KURTSHOUSE_KURT2
	appear KURTSHOUSE_KURT1
	disappear KURTSHOUSE_TWIN2
	appear KURTSHOUSE_TWIN1
	endcallback

.MakingBalls:
	disappear KURTSHOUSE_KURT1
	appear KURTSHOUSE_KURT2
	disappear KURTSHOUSE_TWIN1
	appear KURTSHOUSE_TWIN2
.Done:
	endcallback

Kurt1:
	faceplayer
	opentext
	checkevent EVENT_KURT_GAVE_YOU_APRICORN_BOX
	iftrue .GotApricornBox
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedSlowpokeWell
	writetext KurtsHouseKurtMakingBallsMustWaitText
	waitbutton
	closetext
	special Special_FadeOutMusic
	setevent EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	readvar VAR_FACING
	ifequal UP, .RunAround
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtExitHouseMovement
	playsound SFX_EXIT_BUILDING
	disappear KURTSHOUSE_KURT1
	waitsfx
	special RestartMapMusic
	end

.RunAround:
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtGoAroundPlayerThenExitHouseMovement
	playsound SFX_EXIT_BUILDING
	disappear KURTSHOUSE_KURT1
	waitsfx
	special RestartMapMusic
	end

.ClearedSlowpokeWell:
	writetext KurtsHouseKurtHonoredToMakeBallsText
	promptbutton
	verbosegivekeyitem APRICORN_BOX
	setevent EVENT_KURT_GAVE_YOU_APRICORN_BOX
.GotApricornBox:
	checkevent EVENT_GAVE_KURT_RED_APRICORN
	iftrue .GiveLevelBall
	checkevent EVENT_GAVE_KURT_BLU_APRICORN
	iftrue .GiveLureBall
	checkevent EVENT_GAVE_KURT_YLW_APRICORN
	iftrue .GiveMoonBall
	checkevent EVENT_GAVE_KURT_GRN_APRICORN
	iftrue .GiveFriendBall
	checkevent EVENT_GAVE_KURT_WHT_APRICORN
	iftrue .GiveFastBall
	checkevent EVENT_GAVE_KURT_BLK_APRICORN
	iftrue .GiveHeavyBall
	checkevent EVENT_GAVE_KURT_PNK_APRICORN
	iftrue .GiveLoveBall
	checkevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	iftrue .CanGiveGSBallToKurt
.NoGSBall:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue .CheckApricorns
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue .CheckApricorns
	writetext KurtsHouseKurtBallsFromApricornsText
	waitbutton
.CheckApricorns:
	callasm .CheckHaveAnyApricorns
	iftrue .AskApricorn
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue_jumpopenedtext KurtsHouseKurtTurnedOutGreatText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	iftrue_jumpopenedtext KurtsHouseKurtBallsFromApricornsText
	endtext

.CheckHaveAnyApricorns:
	xor a
	ld hl, wApricorns
	or [hl]
rept NUM_APRICORNS - 1
	inc hl
	or [hl]
endr
	ldh [hScriptVar], a
	ret

.AskApricorn:
	writetext KurtsHouseKurtAskYouHaveAnApricornText
	promptbutton
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	special Special_SelectApricornForKurt
	iffalse_jumpopenedtext KurtsHouseKurtThatsALetdownText
	ifequal BLU_APRICORN, .Blu
	ifequal YLW_APRICORN, .Ylw
	ifequal GRN_APRICORN, .Grn
	ifequal WHT_APRICORN, .Wht
	ifequal BLK_APRICORN, .Blk
	ifequal PNK_APRICORN, .Pnk
; .Red
	setevent EVENT_GAVE_KURT_RED_APRICORN
	sjump .GaveKurtApricorns

.Blu:
	setevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump .GaveKurtApricorns

.Ylw:
	setevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump .GaveKurtApricorns

.Grn:
	setevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump .GaveKurtApricorns

.Wht:
	setevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump .GaveKurtApricorns

.Blk:
	setevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump .GaveKurtApricorns

.Pnk:
	setevent EVENT_GAVE_KURT_PNK_APRICORN
.GaveKurtApricorns:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext KurtsHouseKurtGetStartedText
	waitbutton
	closetext
	follow KURTSHOUSE_KURT1, PLAYER
	applymovement KURTSHOUSE_KURT1, KurtsHouseFollowKurt_MovementData
	stopfollow
	pause 15
	turnobject KURTSHOUSE_KURT1, DOWN
	showtext KurtsHouseKurtItWillTakeADayText
	applymovement PLAYER, KurtsHouseStepAwayFromKurt_MovementData
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playsound SFX_ENTER_DOOR
	waitsfx
	pause 35
	warpfacing UP, KURTS_HOUSE, 3, 3
	sjump Kurt1

.ThatTurnedOutGreat:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	jumpopenedtext KurtsHouseKurtTurnedOutGreatText

.GiveLevelBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LEVEL_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_RED_APRICORN
	sjump .ThatTurnedOutGreat

.GiveLureBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LURE_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_BLU_APRICORN
	sjump .ThatTurnedOutGreat

.GiveMoonBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar MOON_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_YLW_APRICORN
	sjump .ThatTurnedOutGreat

.GiveFriendBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar FRIEND_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_GRN_APRICORN
	sjump .ThatTurnedOutGreat

.GiveFastBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar FAST_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_WHT_APRICORN
	sjump .ThatTurnedOutGreat

.GiveHeavyBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar HEAVY_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_BLK_APRICORN
	sjump .ThatTurnedOutGreat

.GiveLoveBall:
	checkflag ENGINE_KURT_MAKING_BALLS
	iftrue KurtMakingBallsScript
	writetext KurtsHouseKurtJustFinishedYourBallText
	promptbutton
	verbosegiveitemvar LOVE_BALL, VAR_KURT_APRICORNS
	iffalse_endtext
	clearevent EVENT_GAVE_KURT_PNK_APRICORN
	sjump .ThatTurnedOutGreat

.CanGiveGSBallToKurt:
	checkevent EVENT_GAVE_GS_BALL_TO_KURT
	iftrue .GaveGSBallToKurt
	checkkeyitem GS_BALL
	iffalse .NoGSBall
	writetext KurtsHouseKurtWhatIsThatText
	waitbutton
	closetext
	setevent EVENT_GAVE_GS_BALL_TO_KURT
	takekeyitem GS_BALL
	setflag ENGINE_KURT_MAKING_BALLS
	end

.GaveGSBallToKurt:
	checkflag ENGINE_KURT_MAKING_BALLS
	iffalse .NotMakingBalls
	writetext KurtsHouseKurtImCheckingItNowText
	waitbutton
	jumpopenedtext KurtsHouseKurtAhHaISeeText

.NotMakingBalls:
	writetext KurtsHouseKurtThisBallStartedToShakeText
	waitbutton
	closetext
	setevent EVENT_FOREST_IS_RESTLESS
	clearevent EVENT_CAN_GIVE_GS_BALL_TO_KURT
	clearevent EVENT_GAVE_GS_BALL_TO_KURT
	special Special_FadeOutMusic
	pause 20
	showemote EMOTE_SHOCK, KURTSHOUSE_KURT1, 30
	readvar VAR_FACING
	ifequal UP, .GSBallRunAround
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtExitHouseMovement
	sjump .KurtHasLeftTheBuilding

.GSBallRunAround:
	turnobject PLAYER, DOWN
	playsound SFX_FLY
	applymovement KURTSHOUSE_KURT1, KurtsHouseKurtGoAroundPlayerThenExitHouseMovement
.KurtHasLeftTheBuilding:
	playsound SFX_EXIT_BUILDING
	disappear KURTSHOUSE_KURT1
	clearevent EVENT_AZALEA_TOWN_KURT
	waitsfx
	special RestartMapMusic
	setmapscene AZALEA_TOWN, $2
	end

Kurt2:
	faceplayer
	opentext
	checkevent EVENT_GAVE_GS_BALL_TO_KURT
	iftrue KurtScript_ImCheckingItNow
KurtMakingBallsScript:
	checkevent EVENT_BUGGING_KURT_TOO_MUCH
	iffalse Script_FirstTimeBuggingKurt
	writetext KurtsHouseKurtDontBotherMeText
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	end

Script_FirstTimeBuggingKurt:
	writetext KurtsHouseKurtGranddaughterHelpingWorkFasterText
	waitbutton
	closetext
	turnobject LAST_TALKED, UP
	setevent EVENT_BUGGING_KURT_TOO_MUCH
	end

KurtScript_ImCheckingItNow:
	writetext KurtsHouseKurtImCheckingItNowText
	waitbutton
	turnobject LAST_TALKED, UP
	jumpopenedtext KurtsHouseKurtAhHaISeeText

KurtsGranddaughter1:
	faceplayer
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue KurtsGranddaughter2Subscript
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	iftrue_jumptext KurtsGranddaughterFunText
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue_jumptext KurtsGranddaughterLonelyText
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue_jumptext KurtsGranddaughterDadText
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue_jumptext KurtsGranddaughterSlowpokeBackText
	checkevent EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	iftrue_jumptext KurtsGranddaughterLonelyText
	jumptext KurtsGranddaughterSlowpokeGoneText

KurtsGranddaughter2:
	faceplayer
KurtsGranddaughter2Subscript:
	opentext
	checkevent EVENT_GAVE_GS_BALL_TO_KURT
	iftrue .GSBall
	writetext KurtsGranddaughterHelpText
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

.GSBall:
	writetext KurtsGranddaughterGSBallText
	waitbutton
	closetext
	turnobject LAST_TALKED, RIGHT
	end

PokemonJournalProfWestwoodScript:
	setflag ENGINE_READ_PROF_WESTWOOD_JOURNAL
	jumpthistext

	text "#mon Journal"

	para "Special Feature:"
	line "Prof.Westwood!"

	para "Prof.Westwood V"
	line "teaches at Celadon"
	cont "University."

	para "His ancestor's re-"
	line "search in 1925 led"

	para "to the development"
	line "of modern #"
	cont "Balls."
	done

KurtsHouseKurtGoAroundPlayerThenExitHouseMovement:
	big_step_right
KurtsHouseKurtExitHouseMovement:
	run_step_down
	run_step_down
	run_step_down
	run_step_down
	run_step_down
	step_end

KurtsHouseFollowKurt_MovementData:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_down
	step_down
	step_down
	step_right
	step_right
	step_right
	step_up
	step_up
	step_end

KurtsHouseStepAwayFromKurt_MovementData:
	step_down
	step_left
	step_left
	step_end

KurtsHouseKurtMakingBallsMustWaitText:
	text "Hm? Who are you?"

	para "<PLAYER>, eh? You"
	line "want me to make"
	cont "some Balls?"

	para "Sorry, but that'll"
	line "have to wait."

	para "Do you know Team"
	line "Rocket? Ah, don't"

	para "worry. I'll tell"
	line "you anyhow."

	para "Team Rocket's an"
	line "evil gang that"

	para "uses #mon for"
	line "their dirty work."

	para "They're supposed"
	line "to have disbanded"
	cont "three years ago."

	para "Anyway, they're at"
	line "the well, cutting"

	para "off SlowpokeTails"
	line "for sale!"

	para "So I'm going to"
	line "go give them a"
	cont "lesson in pain!"

	para "Hang on, Slowpoke!"
	line "Old Kurt is on his"
	cont "way!"
	done

KurtsHouseKurtHonoredToMakeBallsText:
	text "Kurt: Hi, <PLAYER>!"

	para "You handled your-"
	line "self like a real"
	cont "hero at the well."

	para "I like your style!"

	para "I would be honored"
	line "to make Balls for"

	para "a trainer like"
	line "you."

	para "But first, you'll"
	line "need Apricorns."

	para "Here, take this"
	line "Apricorn Box!"
	done

KurtsHouseKurtBallsFromApricornsText:
	text "Kurt: I make Balls"
	line "from Apricorns."

	para "Collect them from"
	line "trees and bring"
	cont "'em to me."

	para "I'll make Balls"
	line "out of them."
	done

KurtsHouseKurtAskYouHaveAnApricornText:
	text "Kurt: You have an"
	line "Apricorn for me?"

	para "Fine! I'll turn it"
	line "into a Ball."
	done

KurtsHouseKurtGetStartedText:
	text "Kurt: I'll get"
	line "started right now!"
	done

KurtsHouseKurtItWillTakeADayText:
	text "Kurt: It'll take a"
	line "while to make you"

	para "a Ball. Come back"
	line "for it later."
	done

KurtsHouseKurtThatsALetdownText:
	text "Kurt: Oh…"
	line "That's a letdown."
	done

KurtsHouseKurtDontBotherMeText:
	text "Kurt: I'm working!"
	line "Don't bother me!"
	done

KurtsHouseKurtJustFinishedYourBallText:
	text "Kurt: Ah, <PLAYER>!"
	line "I just finished"
	cont "your Ball. Here!"
	done

KurtsHouseKurtTurnedOutGreatText:
	text "Kurt: That turned"
	line "out great."

	para "Try catching"
	line "#mon with it."
	done

KurtsHouseKurtGranddaughterHelpingWorkFasterText:
	text "Kurt: Now that my"
	line "granddaughter is"

	para "helping me, I can"
	line "work much faster."
	done

KurtsHouseKurtWhatIsThatText:
	text "Wh-what is that?"

	para "I've never seen"
	line "one before."

	para "It looks a lot"
	line "like a # Ball,"

	para "but it appears to"
	line "be something else."

	para "Let me check it"
	line "for you."
	done

KurtsHouseKurtImCheckingItNowText:
	text "I'm checking it"
	line "now."
	done

KurtsHouseKurtAhHaISeeText:
	text "Ah-ha! I see!"
	line "So…"
	done

KurtsHouseKurtThisBallStartedToShakeText:
	text "<PLAYER>!"

	para "This Ball started"
	line "to shake while I"
	cont "was checking it."

	para "There must be"
	line "something to this!"
	done

KurtsGranddaughterSlowpokeGoneText:
	text "The Slowpoke are"
	line "gone… Were they"

	para "taken away by bad"
	line "people?"
	done

KurtsGranddaughterLonelyText:
	text "Grandpa's gone…"
	line "I'm so lonely…"
	done

KurtsGranddaughterSlowpokeBackText:
	text "The Slowpoke my"
	line "dad gave me came"

	para "back! Its tail is"
	line "growing back too!"
	done

KurtsGranddaughterDadText:
	text "Dad works at Silph"
	line "where he studies"
	cont "# Balls."

	para "I have to stay"
	line "home with Grandpa"
	cont "and Slowpoke."
	done

KurtsGranddaughterHelpText:
	text "I get to help"
	line "Grandpa now!"

	para "We'll make good"
	line "Balls for you, so"
	cont "please wait!"
	done

KurtsGranddaughterFunText:
	text "It's fun to make"
	line "Balls!"
	done

KurtsGranddaughterGSBallText:
	text "Grandpa's checking"
	line "a Ball right now."

	para "So I'm waiting"
	line "till he's done."
	done

KurtsHouseSlowpokeText:
	text "Slowpoke: …"
	line "Yawn?"
	done

KurtsHouseOakPhotoText:
	text "…A young Prof."
	line "Oak?"
	done

KurtsHouseCelebiStatueText:
	text "It's a statue of"
	line "the forest's pro-"
	cont "tector."
	done
