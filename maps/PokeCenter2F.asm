PokeCenter2F_MapScriptHeader:

.MapTriggers: db 3
	dw PokeCenter2FDummyTrigger
	dw PokeCenter2FLeftTradeCenterTrigger
	dw PokeCenter2FLeftColosseumTrigger

.MapCallbacks: db 1
	dbw MAPCALLBACK_TILES, PokeCenter2FTileCallback

PokeCenter2F_MapEventHeader:

.Warps: db 3
	warp_def 7, 0, -1, POKECENTER_2F
	warp_def 0, 5, 1, TRADE_CENTER
	warp_def 0, 9, 1, COLOSSEUM

.XYTriggers: db 0

.Signposts: db 1
	signpost 3, 7, SIGNPOST_READ, PokeCenter2FLinkRecordSign

.PersonEvents: db 3
	person_event SPRITE_LINK_RECEPTIONIST, 2, 5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LinkReceptionistScript_Trade, -1
	person_event SPRITE_LINK_RECEPTIONIST, 2, 9, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, LinkReceptionistScript_Battle, -1
	person_event SPRITE_LINK_RECEPTIONIST, 3, 13, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, jumptextfaceplayer, Text_TimeCapsuleClosed, -1

const_value set 1
	const POKECENTER2F_TRADE_RECEPTIONIST
	const POKECENTER2F_BATTLE_RECEPTIONIST

PokeCenter2FLeftTradeCenterTrigger:
	priorityjump Script_LeftCableTradeCenter
PokeCenter2FDummyTrigger:
	end

PokeCenter2FLeftColosseumTrigger:
	priorityjump Script_LeftCableColosseum
	end

PokeCenter2FTileCallback:
	callasm .CheckPokeCenter2FRegion
	if_equal $0, .done
	if_equal $2, .shamouti2f
	changemap KantoPokeCenter2F_BlockData
.done
	return

.shamouti2f
	changemap KantoPokeCenter2F_BlockData
	changeblock 0, 6, $3c
	changeblock 2, 0, $4a
	return

.CheckPokeCenter2FRegion:
	call GetBackupLandmark
	ld hl, ScriptVar
	cp SHAMOUTI_LANDMARK
	jr nc, .shamouti
	cp KANTO_LANDMARK
	jr nc, .kanto
.johto
	ld [hl], JOHTO_REGION
	ret

.kanto
	ld [hl], KANTO_REGION
	ret

.shamouti
	ld [hl], ORANGE_REGION
	ret

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

Script_WalkOutOfLinkTradeRoom:
	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iftrue .Female
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

.Female:
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applyonemovement PLAYER, step_down
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte ((1 << 3) | PAL_OW_BLUE) << 4
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special ReplaceKrisSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

Script_WalkOutOfLinkBattleRoom:
	checkflag ENGINE_KRIS_IN_CABLE_CLUB
	iftrue .Female
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

.Female:
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applyonemovement PLAYER, step_down
	clearflag ENGINE_KRIS_IN_CABLE_CLUB
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte ((1 << 3) | PAL_OW_BLUE) << 4
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special ReplaceKrisSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

PokeCenter2FLinkRecordSign:
	refreshscreen
	special Special_DisplayLinkRecord
	endtext

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
	endtext

.LinkedToFirstGen:
	special Special_FailedLinkToPast
	writetext Text_CantLinkToThePast
	special Special_CloseLink
	endtext

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	endtext

.LinkTimedOut:
	writetext Text_LinkTimedOut
	jump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	endtext

Script_TradeCenterClosed:
	thistextfaceplayer

	text "I'm sorry--the"
	line "Trade Machine is"
	cont "being adjusted."
	done

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
	endtext

.LinkedToFirstGen:
	special Special_FailedLinkToPast
	writetext Text_CantLinkToThePast
	special Special_CloseLink
	endtext

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	endtext

.LinkTimedOut:
	writetext Text_LinkTimedOut
	jump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	endtext

Script_BattleRoomClosed:
	thistextfaceplayer

	text "I'm sorry--the"
	line "Battle Machine is"
	cont "being adjusted."
	done

PokeCenter2F_CheckGender:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	applymovement2 PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsUp
	end

.Female:
	applymovement2 PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsUp
	showtext Text_OhPleaseWait
	applymovement2 PokeCenter2FMovementData_ReceptionistLooksRight
	spriteface PLAYER, LEFT
	showtext Text_ChangeTheLook
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	writebyte ((1 << 3) | PAL_OW_RED) << 4
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	setflag ENGINE_KRIS_IN_CABLE_CLUB
	special ReplaceKrisSprite
	showtext Text_LikeTheLook
	showemote EMOTE_SHOCK, PLAYER, 15
	applyonemovement PLAYER, step_up
	end

PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight:
	slow_step_up
	slow_step_left
PokeCenter2FMovementData_ReceptionistLooksRight:
	turn_head_right
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsUp:
	step_up
PokeCenter2FMovementData_PlayerTakesTwoStepsUp:
	step_up
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsDown:
	step_down
PokeCenter2FMovementData_PlayerTakesTwoStepsDown:
	step_down
	step_down
	step_end

PokeCenter2FMovementData_ReceptionistStepsRightAndDown:
	slow_step_right
	slow_step_down
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

Text_TimeCapsuleClosed:
	text "I'm sorry--the"
	line "Time Capsule is"
	cont "inoperative."
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
