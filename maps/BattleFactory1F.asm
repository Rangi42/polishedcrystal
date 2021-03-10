BattleFactory1F_MapScriptHeader:
	def_scene_scripts
	scene_script BattleFactory1FTrigger0

	def_callbacks

	def_warp_events
	warp_event 10, 13, BATTLE_TOWER_OUTSIDE, 3
	warp_event 11, 13, BATTLE_TOWER_OUTSIDE, 4
	warp_event 10,  0, BATTLE_FACTORY_HALLWAY, 1

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, MapBattleFactory1FSignpost0Script

	def_object_events
	object_event 10,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ReceptionistScript_BattleFactory, -1
	pc_nurse_event  6, 6

	object_const_def
	const BATTLEFACTORY1F_RECEPTIONIST

BattleFactory1FTrigger0:
; Triggers (usefully) if we're in an ongoing battle factory run.
	; Only trigger this once.
	setscene 1

	; Check current battle status to see if we need to resume or reset winstreak
	special Special_BattleTower_GetChallengeState
	ifequal BATTLETOWER_CHALLENGE_IN_PROGRESS, .LeftWithoutSaving
	ifequal BATTLETOWER_SAVED_AND_LEFT, .ResumeChallenge
	ifequal BATTLETOWER_LOST_CHALLENGE, .LostChallenge
	ifequal BATTLETOWER_WON_CHALLENGE, .WonChallenge
	end

.ResumeChallenge
	; We saved inbetween rounds. Resume Battle Factory challenge.
	opentext
	writethistext
		text "We've been waiting"
		line "for you."
		prompt

	; Schedule script for running. This prevents odd issues that a regular jump
	; causes for scene scripts. This is NOT a true jump, so "end" is necessary.
	priorityjump Script_ReturnToRentalChallenge
	end

.LeftWithoutSaving:
	; The player resetted the game in the middle of a battle.
	; This counts as a battle loss, and will reset the winstreak.
	priorityjump .LeftWithoutSaving2
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
	jump Script_CommitBattleFactoryResult

.LostChallenge:
	opentext
	priorityjump Script_CommitBattleFactoryResult
	end

.WonChallenge:
	priorityjump .WonChallenge2
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
Script_CommitBattleFactoryResult:
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

MapBattleFactory1FSignpost0Script:
	opentext
	writethistext
		text "Streak: "
		deciram wBattleFactoryCurStreak, 2, 5
		text " wins"
		line "Record: "
		deciram wBattleFactoryTopStreak, 2, 5
		text " wins"
		done
	waitbutton

	writethistext
		text "Battle rules"
		line "are written here."

		para "Read the rules?"
		done
	yesorno
	iffalse_endtext
	jumpthisopenedtext
		text "You are given 6"
		line "rental #mon."

		para "Three #mon may"
		line "enter battles."

		para "All three must be"
		line "different."

		para "The items they"
		line "hold must also be"
		cont "different."

		para "After winning a"
		line "battle, you may"
		cont "swap a #mon"
		cont "from your foe."
		done

ReceptionistScript_BattleFactory:
	opentext
	writethistext
		text "Battle Factory"
		line "welcomes you!"

		para "I could show you"
		line "to a Battle Room."
		done
	buttonsound
	checkevent EVENT_BATTLE_FACTORY_INTRO
	iftrue .Menu

	; only ask once, so set the flag regardless
	setevent EVENT_BATTLE_FACTORY_INTRO
	writethistext
		text "Would you like to"
		line "hear about this"
		cont "facility?"
		done
	yesorno
	iffalse .Menu

.Explanation:
	writethistext
		text "Battle Factory is"
		line "a facility where"
		cont "you battle using"
		cont "rental #mon."

		para "Countless #mon"
		line "trainers gather"

		para "from all over to"
		line "hold battles in"

		para "specially designed"
		line "Battle Rooms."

		para "Each Room holds"
		line "seven trainers."

		para "Beat them all to"
		line "get Battle Points."

		para "To interrupt a"
		line "session, you must"

		para "save. If not, you"
		line "won't be able to"

		para "resume your Room"
		line "challenge."
		prompt
	; fallthrough
.Menu:
	; Setscene here in case the player aborted a quicksave prompted by challenge
	setscene $1
	writethistext
		text "Want to go into a"
		line "Battle Room?"
		done
	loadmenu MenuDataHeader_BattleInfoCancel
	verticalmenu
	closewindow
	ifequal $1, .Challenge
	ifequal $2, .Explanation
	writethistext
		text "We hope to serve"
		line "you again."
		prompt
	endtext

.Challenge:
	scall Script_MustSaveBeforeBattle
	iffalse .Menu

	; Set this early in case the player leaves before picking their team.
	; This prevents them from re-rolling without forfeiting a streak.
	writebyte BATTLETOWER_CHALLENGE_IN_PROGRESS
	special Special_BattleTower_SetChallengeState
	special Special_BattleTower_SetupRentalMode

	writethistext
		text "I will give you"
		line "6 rental #mon."
		prompt

.Rental_SelectMon:
	writethistext
		text "Choose #mon"
		line "to enter."
		prompt

	special Special_BattleTower_SelectParticipants
	iftrue Script_PrepareForRentalBattle

	writethistext
		text "Cancel your run?"
		line "This counts as a"
		cont "streak loss."
		done
	yesorno
	iffalse .Rental_SelectMon
	jump Script_CommitBattleFactoryResult

Script_PrepareForRentalBattle:
	; Initializes opponent trainers and stores player mon choices in SRAM
	special Special_BattleTower_BeginChallenge
	; fallthrough
Script_ReturnToRentalChallenge:
	; From this point onwards, resetting the game should count as a streak loss
	writebyte BATTLETOWER_CHALLENGE_IN_PROGRESS
	special Special_BattleTower_SetChallengeState

	; Everything ready to go for challenge start
	writethistext
		text "Right this way to"
		line "your Battle Room."
		done
	waitbutton
	closetext

	musicfadeout MUSIC_NONE, 8
	follow BATTLEFACTORY1F_RECEPTIONIST, PLAYER
	applymovement BATTLEFACTORY1F_RECEPTIONIST, MovementData_BattleFactory1FWalkToElevator
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLEFACTORY1F_RECEPTIONIST
	stopfollow
	applyonemovement PLAYER, step_up
	warpcheck
	end

MovementData_BattleFactory1FWalkToElevator:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end
