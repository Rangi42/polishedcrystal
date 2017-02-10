const_value set 2
	const POKECENTER2F_TRADE_RECEPTIONIST
	const POKECENTER2F_BATTLE_RECEPTIONIST
	const POKECENTER2F_TIME_CAPSULE_RECEPTIONIST

PokeCenter2F_MapScriptHeader:
.MapTriggers:
	db 4

	; triggers
	maptrigger .Trigger0
	maptrigger .Trigger1
	maptrigger .Trigger2
	maptrigger .Trigger3

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_TILES, Script_ChangePokeCenter2FMap

.Trigger0:
	end

.Trigger1:
	priorityjump Script_LeftCableTradeCenter
	end

.Trigger2:
	priorityjump Script_LeftCableColosseum
	end

.Trigger3:
	priorityjump Script_LeftTimeCapsule
	end

Script_TradeCenterClosed:
	faceplayer
	opentext
	writetext Text_TradeRoomClosed
	waitbutton
	closetext
	end

Script_BattleRoomClosed:
	faceplayer
	opentext
	writetext Text_BattleRoomClosed
	waitbutton
	closetext
	end

Script_ChangePokeCenter2FMap:
	callasm CheckPokeCenter2FRegion
	if_equal $0, .done
	changemap BANK(KantoPokeCenter2F_BlockData), KantoPokeCenter2F_BlockData
.done
	return

LinkReceptionistScript_Trade:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalse Script_TradeCenterClosed
	opentext
	writetext Text_TradeReceptionistIntro
	yesorno
	iffalse .Cancel
	special Special_SetBitsForLinkTradeRequest
	writetext Text_PleaseWait
	special Special_WaitForLinkedFriend
	iffalse .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalse .DidNotSave
	special Special_TryQuickSave
	iffalse .DidNotSave
	writetext Text_PleaseWait
	special Special_CheckLinkTimeout
	iffalse .LinkTimedOut
	copybytetovar wOtherPlayerLinkMode
	iffalse .LinkedToFirstGen
	special Special_CheckBothSelectedSameRoom
	iffalse .IncompatibleRooms
	writetext Text_PleaseComeIn2
	waitbutton
	closetext
	scall PokeCenter2F_CheckGender
	warpcheck
	end

.FriendNotReady:
	special WaitForOtherPlayerToExit
	writetext Text_FriendNotReady
	closetext
	end

.LinkedToFirstGen:
	special Special_FailedLinkToPast
	writetext Text_CantLinkToThePast
	special Special_CloseLink
	closetext
	end

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	closetext
	end

.LinkTimedOut:
	writetext Text_LinkTimedOut
	jump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	closetext
	end

LinkReceptionistScript_Battle:
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalse Script_BattleRoomClosed
	opentext
	writetext Text_BattleReceptionistIntro
	yesorno
	iffalse .Cancel
	special Special_SetBitsForBattleRequest
	writetext Text_PleaseWait
	special Special_WaitForLinkedFriend
	iffalse .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalse .DidNotSave
	special Special_TryQuickSave
	iffalse .DidNotSave
	writetext Text_PleaseWait
	special Special_CheckLinkTimeout
	iffalse .LinkTimedOut
	copybytetovar wOtherPlayerLinkMode
	iffalse .LinkedToFirstGen
	special Special_CheckBothSelectedSameRoom
	iffalse .IncompatibleRooms
	writetext Text_PleaseComeIn2
	waitbutton
	closetext
	scall PokeCenter2F_CheckGender
	warpcheck
	end

.FriendNotReady:
	special WaitForOtherPlayerToExit
	writetext Text_FriendNotReady
	closetext
	end

.LinkedToFirstGen:
	special Special_FailedLinkToPast
	writetext Text_CantLinkToThePast
	special Special_CloseLink
	closetext
	end

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	closetext
	end

.LinkTimedOut:
	writetext Text_LinkTimedOut
	jump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	closetext
	end

Script_TimeCapsuleClosed:
	faceplayer
	opentext
	writetext Text_TimeCapsuleClosed
	waitbutton
	closetext
	end

LinkReceptionistScript_TimeCapsule:
	checkevent EVENT_NEVER_MET_BILL
	iftrue Script_TimeCapsuleClosed
	special Special_SetBitsForTimeCapsuleRequest
	faceplayer
	opentext
	writetext Text_TimeCapsuleReceptionistIntro
	yesorno
	iffalse .Cancel
	special Special_CheckTimeCapsuleCompatibility
	if_equal $1, .MonTooNew
	if_equal $2, .MonMoveTooNew
	if_equal $3, .MonHasMail
	writetext Text_PleaseWait
	special Special_WaitForLinkedFriend
	iffalse .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalse .DidNotSave
	special Special_TryQuickSave
	iffalse .DidNotSave
	writetext Text_PleaseWait
	special Special_CheckLinkTimeout
	iffalse .LinkTimedOut
	copybytetovar wOtherPlayerLinkMode
	iffalse .OK
	special Special_CheckBothSelectedSameRoom
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	closetext
	end

.OK:
	special Special_EnterTimeCapsule
	writetext Text_PleaseComeIn2
	waitbutton
	closetext
	scall TimeCapsuleScript_CheckPlayerGender
	warpcheck
	end

.FriendNotReady:
	special WaitForOtherPlayerToExit
	writetext Text_FriendNotReady
	closetext
	end

.LinkTimedOut:
	writetext Text_LinkTimedOut
	jump .Cancel

.DidNotSave:
	writetext Text_PleaseComeAgain
.Cancel:
	special WaitForOtherPlayerToExit
	closetext
	end

.MonTooNew:
	writetext Text_RejectNewMon
	closetext
	end

.MonMoveTooNew:
	writetext Text_RejectMonWithNewMove
	closetext
	end

.MonHasMail:
	writetext Text_RejectMonWithMail
	closetext
	end

Script_LeftCableTradeCenter:
	special WaitForOtherPlayerToExit
	scall Script_WalkOutOfLinkTradeRoom
	dotrigger $0
	domaptrigger TRADE_CENTER, $0
	end

Script_LeftCableColosseum:
	special WaitForOtherPlayerToExit
	scall Script_WalkOutOfLinkBattleRoom
	dotrigger $0
	domaptrigger COLOSSEUM, $0
	end

PokeCenter2F_CheckGender:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	applymovement2 PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsUp
	end

.Female:
	applymovement2 PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight_2
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsUp
	opentext
	writetext Text_OhPleaseWait
	waitbutton
	closetext
	applymovement2 PokeCenter2FMovementData_ReceptionistLooksRight
	spriteface PLAYER, LEFT
	opentext
	writetext Text_ChangeTheLook
	waitbutton
	closetext
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte (1 << 7) | (PAL_OW_RED << 4)
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	setflag ENGINE_KRIS_IN_CABLE_CLUB
	special ReplaceKrisSprite
	opentext
	writetext Text_LikeTheLook
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepUp
	end

Script_WalkOutOfLinkTradeRoom:
	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iftrue .Female
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_3
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

.Female:
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_3
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepDown_2
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte (1 << 7) | (PAL_OW_BLUE << 4)
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special ReplaceKrisSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown_2
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

Script_WalkOutOfLinkBattleRoom:
	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iftrue .Female
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_3
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

.Female:
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_3
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepDown_2
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte (1 << 7) | (PAL_OW_BLUE << 4)
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special ReplaceKrisSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown_2
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

TimeCapsuleScript_CheckPlayerGender:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	checkcode VAR_FACING
	if_equal LEFT, .MaleFacingLeft
	if_equal RIGHT, .MaleFacingRight
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsLeftLooksDown
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsUp_2
	end

.MaleFacingLeft:
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsLeftLooksDown
	applymovement PLAYER, PokeCenter2FMovementData_PlayerWalksLeftAndUp
	end

.MaleFacingRight:
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsRightLooksDown
	applymovement PLAYER, PokeCenter2FMovementData_PlayerWalksRightAndUp
	end

.Female:
	checkcode VAR_FACING
	if_equal RIGHT, .FemaleFacingRight
	if_equal LEFT, .FemaleFacingLeft
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight_2
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepUp_2
	jump .FemaleContinue

.FemaleFacingRight:
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsRightLooksLeft_2
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepRight
	jump .FemaleContinue

.FemaleFacingLeft:
	applymovement2 PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight_2
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepLeft
.FemaleContinue:
	opentext
	writetext Text_OhPleaseWait
	waitbutton
	closetext
	checkcode VAR_FACING
	if_not_equal UP, .FemaleChangeApperance
	spriteface PLAYER, LEFT
.FemaleChangeApperance:
	opentext
	writetext Text_ChangeTheLook
	waitbutton
	closetext
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte (1 << 7) | (PAL_OW_RED << 4)
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingDown
	faceperson PLAYER, POKECENTER2F_TIME_CAPSULE_RECEPTIONIST
	setflag ENGINE_KRIS_IN_CABLE_CLUB
	special ReplaceKrisSprite
	opentext
	writetext Text_LikeTheLook
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepUp_2
	end

Script_LeftTimeCapsule:
	special WaitForOtherPlayerToExit
	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iftrue .Female
	applymovement POKECENTER2F_TIME_CAPSULE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown
	applymovement POKECENTER2F_TIME_CAPSULE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_2
	jump .Done

.Female:
	applymovement POKECENTER2F_TIME_CAPSULE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepDown
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte (1 << 7) | (PAL_OW_BLUE << 4)
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special ReplaceKrisSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesOneStepDown
	applymovement POKECENTER2F_TIME_CAPSULE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_2
.Done:
	dotrigger $0
	domaptrigger TIME_CAPSULE, $0
	end

MapPokeCenter2FSignpost0Script:
	refreshscreen $0
	special Special_DisplayLinkRecord
	closetext
	end

PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight:
	slow_step_up
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_ReceptionistStepsLeftLooksDown:
	slow_step_left
	turn_head_down
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightLooksDown:
	slow_step_right
	turn_head_down
	step_end

PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight_2:
	slow_step_up
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_ReceptionistLooksRight:
	turn_head_right
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsUp:
	step_up
	step_up
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesTwoStepsUp:
	step_up
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepUp:
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesTwoStepsUp_2:
	step_up
	step_up
	step_end

PokeCenter2FMovementData_PlayerWalksLeftAndUp:
	step_left
	step_up
	step_end

PokeCenter2FMovementData_PlayerWalksRightAndUp:
	step_right
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsDown:
	step_down
	step_down
	step_down
	step_end

PokeCenter2FMovementData_PlayerTakesTwoStepsDown:
	step_down
	step_down
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepDown:
	step_down
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightAndDown:
	slow_step_right
	slow_step_down
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_2:
	slow_step_right
	turn_head_down
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightLooksDown_3:
	slow_step_up
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight:
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	step_end

PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_left
	step_end

PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingDown:
	turn_head_down
	turn_head_left
	turn_head_up
	turn_head_right
	turn_head_down
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepDown_2:
	step_down
	step_end

PokeCenter2FMovementData_PlayerTakesTwoStepsDown_2:
	step_down
	step_down
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepUp_2:
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepRight:
	step_right
	step_end

PokeCenter2FMovementData_PlayerTakesOneStepLeft:
	step_left
	step_end

PokeCenter2FMovementData_ReceptionistStepsLeftLooksRight_2:
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightLooksLeft_2:
	slow_step_right
	turn_head_left
	step_end

Text_BattleReceptionistIntro:
	text "Welcome to Cable"
	line "Club Colosseum."

	para "You may battle a"
	line "friend here."

	para "Would you like to"
	line "battle?"
	done

Text_TradeReceptionistIntro:
	text "Welcome to Cable"
	line "Trade Center."

	para "You may trade your"
	line "#mon here with"
	cont "a friend."

	para "Would you like to"
	line "trade?"
	done

Text_TimeCapsuleReceptionistIntro:
	text "Welcome to Cable"
	line "Club Time Capsule."

	para "You can travel to"
	line "the past and trade"
	cont "your #mon."

	para "Would you like to"
	line "trade across time?"
	done

Text_FriendNotReady:
	text "Your friend is not"
	line "ready."
	prompt

Text_MustSaveGame:
	text "Before opening the"
	line "link, you must"
	cont "save your game."
	done

Text_PleaseWait:
	text "Please wait."
	done

Text_LinkTimedOut:
	text "The link has been"
	line "closed because of"
	cont "inactivity."

	para "Please contact"
	line "your friend and"
	cont "come again."
	prompt

Text_PleaseComeAgain:
	text "Please come again."
	prompt

Text_PleaseComeIn:
	text "Please come in."
	prompt

Text_TemporaryStagingInLinkRoom:
	text "We'll put you in"
	line "the link room for"
	cont "the time being."
	done

Text_CantLinkToThePast:
	text "You can't link to"
	line "the past here."
	prompt

Text_IncompatibleRooms:
	text "Incompatible rooms"
	line "were chosen."
	prompt

Text_PleaseComeIn2:
	text "Please come in."
	done

Text_PleaseEnter:
	text "Please enter."
	prompt

Text_RejectNewMon:
	text "Sorry--@"
	text_from_ram StringBuffer1
	text ""
	line "can't be taken."
	prompt

Text_RejectMonWithNewMove:
	text "You can't take the"
	line "@"
	text_from_ram StringBuffer1
	text " with a"
	cont "@"
	text_from_ram StringBuffer2
	text "."
	prompt

Text_RejectMonWithMail:
	text "You can't take the"
	line "@"
	text_from_ram StringBuffer1
	text " that"
	cont "has Mail with you."
	prompt

Text_TimeCapsuleClosed:
	text "I'm sorry--the"
	line "Time Capsule is"
	cont "being adjusted."
	done

Text_TradeRoomClosed:
	text "I'm sorry--the"
	line "Trade Machine is"
	cont "being adjusted."
	done

Text_BattleRoomClosed:
	text "I'm sorry--the"
	line "Battle Machine is"
	cont "being adjusted."
	done

Text_OhPleaseWait:
	text "Oh, please wait."
	done

Text_ChangeTheLook:
	text "We need to change"
	line "the look here…"
	done

Text_LikeTheLook:
	text "How does this"
	line "style look to you?"
	done

PokeCenter2F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $7, $0, -1, POKECENTER_2F
	warp_def $0, $5, 1, TRADE_CENTER
	warp_def $0, $9, 1, COLOSSEUM
	warp_def $2, $d, 1, TIME_CAPSULE

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 3, 7, SIGNPOST_READ, MapPokeCenter2FSignpost0Script

.PersonEvents:
	db 3
	person_event SPRITE_LINK_RECEPTIONIST, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LinkReceptionistScript_Trade, -1
	person_event SPRITE_LINK_RECEPTIONIST, 2, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LinkReceptionistScript_Battle, -1
	person_event SPRITE_LINK_RECEPTIONIST, 3, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LinkReceptionistScript_TimeCapsule, -1

CheckPokeCenter2FRegion:
	ld a, [BackupMapGroup]
	ld b, a
	ld a, [BackupMapNumber]
	ld c, a
	call GetWorldMapLocation
	ld hl, ScriptVar
	cp KANTO_LANDMARK
	jr nc, .kanto
.johto
	ld [hl], 0
	ret

.kanto
	ld [hl], 1
	ret
