BattleFactory1F_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactory1FContinueChallenge

	def_callbacks

	def_warp_events
	warp_event 12, 11, VERMILION_CITY, 15
	warp_event 13, 11, VERMILION_CITY, 16
	warp_event 12,  1, BATTLE_FACTORY_HALLWAY, 1

	def_coord_events

	def_bg_events
	bg_event 14,  5, BGEVENT_READ, BattleFactory1FRulesScript
	bg_event 10,  5, BGEVENT_JUMPTEXT, BattleFactory1FStreakText

	def_object_events
	object_event 12,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BattleFactory1FReceptionistScript, -1
	pc_nurse_event  6,  6

	object_const_def
	const BATTLEFACTORY1F_RECEPTIONIST

BattleFactory1FContinueChallenge:
; Triggers (usefully) if we're in an ongoing Battle Factory run.
	; Only trigger this once.
	setscene 1

	; Check current battle status to see if we need to resume or reset winstreak
	special Special_BattleTower_GetChallengeState
	ifequal BATTLETOWER_CHALLENGE_IN_PROGRESS, .LeftWithoutSaving
	ifequal BATTLETOWER_SAVED_AND_LEFT, .ResumeChallenge
	ifequal BATTLETOWER_LOST_CHALLENGE, .LostChallenge
	ifequal BATTLETOWER_WON_CHALLENGE, .WonChallenge
	end

.ResumeChallenge:
	; We saved in-between rounds. Resume Battle Factory challenge.
	opentext
	writethistext
		text "We've been waiting"
		line "for you."
		prompt

	; Schedule script for running. This prevents odd issues that a regular jump
	; causes for scene scripts. This is NOT a true jump, so "end" is necessary.
	prioritysjump Script_ReturnToBattleFactoryChallenge
	end

.LeftWithoutSaving:
	; The player resetted the game in the middle of a battle.
	; This counts as a battle loss, and will reset the winstreak.
	prioritysjump .LeftWithoutSaving2
	end

.LeftWithoutSaving2:
	opentext
	writethistext
		text "Excuse me!"
		line "You didn't save"

		para "before exiting"
		line "the Battle Room."

		para "I'm awfully sorry,"
		line "but your challenge"

		para "will be declared"
		line "invalid."
		done
	waitbutton
	sjump .CommitResult

.LostChallenge:
	opentext
	prioritysjump .CommitResult
	end

.WonChallenge:
	prioritysjump .WonChallenge2
	end

.WonChallenge2:
	opentext
	writethistext
		text "Congratulations!"

		para "You've beaten all"
		line "the trainers!"

		para "For that, you get"
		line "this great prize!"
		prompt
	verbosegiveitem ABILITYPATCH
	; fallthrough
.CommitResult:
	special Special_BattleTower_CommitChallengeResult
	iffalse .WeHopeToServeYouAgain
	setevent EVENT_BEAT_PALMER
.WeHopeToServeYouAgain:
	writethistext
		text "We hope to serve"
		line "you again."
		done
	waitbutton
	endtext

BattleFactory1FRulesScript:
	opentext
	writethistext
		text "Battle Factory"
		line "rules are written"
		cont "here."

		para "Read the rules?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "Three #mon may"
		line "enter battles."

		para "All three must be"
		line "different."

		para "The items they"
		line "hold must also be"
		cont "different."

		para "Eggs or certain"
		line "Legendary #mon"
		cont "aren't eligible"
		cont "to battle."
		done

BattleFactory1FStreakText:
	text "Streak: "
	text_decimal wBattleTowerCurStreak, 2, 5
	text " wins"
	line "Record: "
	text_decimal wBattleTowerTopStreak, 2, 5
	text " wins"
	done

BattleFactory1FReceptionistScript:
	opentext
	writethistext
		text "Battle Factory"
		line "welcomes you!"

		para "I can show you to"
		line "the Battle Floor."
		done
	promptbutton
	checkevent EVENT_BATTLE_FACTORY_INTRO
	iftrue .BattleFactoryMenu

	; only ask once, so set the flag regardless
	setevent EVENT_BATTLE_FACTORY_INTRO
	writethistext
		text "Would you like to"
		line "hear about the"
		cont "Battle Factory?"
		done
	yesorno
	iffalse .BattleFactoryMenu

.Explanation:
	writethistext
		; TODO: explain Factory rules
		text "Battle Factory is"
		line "a facility for"
		cont "#mon battles."

		para "To interrupt a"
		line "session, you must"

		para "save. If not, you"
		line "won't be able to"

		para "resume your Floor"
		line "challenge."
		prompt
	; fallthrough
.BattleFactoryMenu:
	; Setscene here in case the player aborted a quicksave prompted by challenge
	setscene 1
	writethistext
		text "Want to head onto"
		line "the Battle Floor?"
		done

	special Special_BattleTower_MainMenu
	ifequal $1, .Challenge
	ifequal $2, .Explanation
	writethistext
		text "We hope to serve"
		line "you again."
		prompt
	endtext

.Challenge:
	writethistext
		text "Choose #mon"
		line "to enter."
		prompt
	special Special_BattleTower_SelectParticipants
	iffalse .BattleFactoryMenu
	writethistext
		text "Before entering"
		line "the Battle Floor,"

		para "your progress will"
		line "be saved."
		done
	yesorno
	iffalse .BattleFactoryMenu

	; Done here to ensure it's saved in case the player resets later.
	; The scene script running after the player saves but before the
	; challenge starts is harmless since there's no challenge prepared.
	setscene 0
	special Special_TryQuickSave
	iffalse .BattleFactoryMenu

	; Initializes opponent trainers and stores player mon choices in SRAM
	special Special_BattleTower_BeginChallenge
	; fallthrough
Script_ReturnToBattleFactoryChallenge:
	; From this point onwards, resetting the game should count as a streak loss
	setval BATTLETOWER_CHALLENGE_IN_PROGRESS
	special Special_BattleTower_SetChallengeState

	; Everything ready to go for challenge start
	writethistext
		text "Right this way to"
		line "the Battle Floor."
		done
	waitbutton
	closetext

	musicfadeout MUSIC_NONE, 8
	follow BATTLEFACTORY1F_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORY1F_RECEPTIONIST, .WalkToHallway
	stopfollow
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLEFACTORY1F_RECEPTIONIST
	applyonemovement PLAYER, step_up
	warpcheck
	end

.WalkToHallway:
	step_up
	step_up
	step_up
	step_up
	step_end
