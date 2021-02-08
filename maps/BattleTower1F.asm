BattleTower1F_MapScriptHeader:
	def_scene_scripts
	scene_script BattleTower1FTrigger0

	def_callbacks

	def_warp_events
	warp_event 10, 13, BATTLE_TOWER_OUTSIDE, 3
	warp_event 11, 13, BATTLE_TOWER_OUTSIDE, 4
	warp_event 10,  0, BATTLE_TOWER_ELEVATOR, 1
	warp_event  0,  5, BATTLE_TOWER_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, MapBattleTower1FSignpost0Script

	def_object_events
	object_event 10,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ReceptionistScript_BattleTower, -1
	pc_nurse_event  6, 6
	object_event 14,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_1, -1
	object_event 16,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_2, -1
	object_event 18,  6, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_COMMAND, pokemart, MARTTYPE_BP, MART_BT_3, -1
	object_event  6, 12, SPRITE_BURGLAR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BattleTowerPharmacistScript, -1
	object_event 16, 11, SPRITE_ACE_TRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 0, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerCooltrainerF, -1
	object_event  2, 10, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerBugCatcher, -1
	object_event 20,  9, SPRITE_GRANNY, SPRITEMOVEDATA_WALK_UP_DOWN, 1, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_BattleTowerGranny, -1

	object_const_def
	const BATTLETOWER1F_RECEPTIONIST

BattleTower1FTrigger0:
; Triggers (usefully) if we're in an ongoing battle tower run.
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
	; We saved inbetween rounds. Resume Battle Tower challenge.
	opentext
	writethistext
		text "We've been waiting"
		line "for you."
		prompt

	; Schedule script for running. This prevents odd issues that a regular jump
	; causes for scene scripts. This is NOT a true jump, so "end" is necessary.
	priorityjump Script_ReturnToBattleChallenge
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
	jump .CommitResult

.LostChallenge:
	opentext
	priorityjump .CommitResult
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

MapBattleTower1FSignpost0Script:
	opentext
	writethistext
		text "Streak: "
		deciram wBattleTowerCurStreak, 2, 5
		text " wins"
		line "Record: "
		deciram wBattleTowerTopStreak, 2, 5
		text " wins"
		done
	waitbutton

	writethistext
		text "Battle Tower rules"
		line "are written here."

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

ReceptionistScript_BattleTower:
	opentext
	writethistext
		text "Battle Tower"
		line "welcomes you!"

		para "I could show you"
		line "to a Battle Room."
		done
	buttonsound
	checkevent EVENT_BATTLE_TOWER_INTRO
	iftrue .BattleTowerMenu

	; only ask once, so set the flag regardless
	setevent EVENT_BATTLE_TOWER_INTRO
	writethistext
		text "Would you like to"
		line "hear about the"
		cont "Battle Tower?"
		done
	yesorno
	iffalse .BattleTowerMenu

.Explanation:
	writethistext
		text "Battle Tower is a"
		line "facility made for"
		cont "#mon battles."

		para "Countless #mon"
		line "trainers gather"

		para "from all over to"
		line "hold battles in"

		para "specially designed"
		line "Battle Rooms."

		para "There are many"
		line "Battle Rooms in"
		cont "the Battle Tower."

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
.BattleTowerMenu:
	; Setscene here in case the player aborted a quicksave prompted by challenge
	setscene $1
	writethistext
		text "Want to go into a"
		line "Battle Room?"
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
	iffalse .BattleTowerMenu
	writethistext
		text "Before entering"
		line "the Battle Room,"

		para "your progress will"
		line "be saved."
		done
	yesorno
	iffalse .BattleTowerMenu

	; Done here to ensure it's saved in case the player resets later.
	; The scene script running after the player saves but before the
	; challenge starts is harmless since there's no challenge prepared.
	setscene $0
	special Special_TryQuickSave
	iffalse .BattleTowerMenu

	; Initializes opponent trainers and stores player mon choices in SRAM
	special Special_BattleTower_BeginChallenge
	; fallthrough
Script_ReturnToBattleChallenge:
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
	follow BATTLETOWER1F_RECEPTIONIST, PLAYER
	applymovement BATTLETOWER1F_RECEPTIONIST, MovementData_BattleTower1FWalkToElevator
	special Special_BattleTower_MaxVolume
	warpsound
	disappear BATTLETOWER1F_RECEPTIONIST
	stopfollow
	applyonemovement PLAYER, step_up
	warpcheck
	end

BattleTowerPharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_TRICK_INTRO
	iftrue BattleTowerTutorTrickScript
	writethistext
		text "The trainers here"
		line "strategically use"
		cont "held items."

		para "But I've got a"
		line "trick up my"
		cont "sleeve--I'll swap"

		para "their items for"
		line "mine with Trick!"
		done
	waitbutton
	setevent EVENT_LISTENED_TO_TRICK_INTRO
BattleTowerTutorTrickScript:
	writethistext
		text "I'll teach your"
		line "#mon how to"

		para "use Trick…"
		line "for a Silver Leaf."
		done
	waitbutton
	checkitem SILVER_LEAF
	iffalse .NoSilverLeaf
	writethistext
		text "Should I teach"
		line "your #mon"
		cont "Trick?"
		done
	yesorno
	iffalse .TutorRefused
	writebyte TRICK
	writetext ClearText
	special Special_MoveTutor
	ifequal $0, .TeachMove
.TutorRefused
	jumpthisopenedtext
		text "Talk to me if you"
		line "change your mind."
		done

.NoSilverLeaf
	jumpthisopenedtext
		text "Tch. You don't have"
		line "a Silver Leaf…"
		done

.TeachMove
	takeitem SILVER_LEAF
	jumpthisopenedtext
		text "Now your #mon"
		line "can use Trick too!"
		cont "Isn't it devious?"
		done

MovementData_BattleTower1FWalkToElevator:
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end

Text_WeveBeenWaitingForYou:
	text "We've been waiting"
	line "for you. This way"

	para "to a Battle Room,"
	line "please."
	done

Text_BattleTowerCooltrainerF:
	text "There are lots of"
	line "Battle Rooms, but"

	para "I'm going to win"
	line "them all!"
	done

Text_BattleTowerGranny:
	text "It's a grueling"
	line "task, not being"

	para "able to use items"
	line "in battle."

	para "Making your"
	line "#mon hold items"

	para "is the key to"
	line "winning battles."
	done

Text_BattleTowerBugCatcher:
	text "I'm trying to see"
	line "how far I can go"

	para "using just bug"
	line "#mon."

	para "Don't let there be"
	line "any fire #mon…"
	done
