PokeCenter2F_MapScriptHeader:
	def_scene_scripts
	scene_script PokeCenter2FDummyTrigger
	scene_script PokeCenter2FLeftTradeCenterTrigger
	scene_script PokeCenter2FLeftColosseumTrigger

	def_callbacks
	callback MAPCALLBACK_TILES, PokeCenter2FTileCallback

	def_warp_events
	warp_event  0,  7, POKECENTER_2F, -1
	warp_event  5,  0, TRADE_CENTER, 1
	warp_event  9,  0, COLOSSEUM, 1

	def_coord_events

	def_bg_events
	bg_event  7,  3, BGEVENT_READ, PokeCenter2FLinkRecordSign

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Trade, -1
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Battle, -1
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_TimeCapsuleClosed, -1

	object_const_def
	const POKECENTER2F_TRADE_RECEPTIONIST
	const POKECENTER2F_BATTLE_RECEPTIONIST

PokeCenter2FLeftTradeCenterTrigger:
	sdefer Script_LeftCableTradeCenter
PokeCenter2FDummyTrigger:
	end

PokeCenter2FLeftColosseumTrigger:
	sdefer Script_LeftCableColosseum
	end

PokeCenter2FTileCallback:
	callasm .CheckPokeCenter2FRegion
	ifequal $0, .done
	ifequal $2, .shamouti2f
	changemapblocks KantoPokeCenter2F_BlockData
.done
	endcallback

.shamouti2f
	changemapblocks KantoPokeCenter2F_BlockData
	changeblock 0, 6, $3c
	changeblock 2, 0, $4a
	endcallback

.CheckPokeCenter2FRegion:
	call GetBackupLandmark
	ld hl, hScriptVar
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
	scall Script_WalkOutOfLinkRoom
	setscene $0
	setmapscene TRADE_CENTER, $0
	end

Script_LeftCableColosseum:
	special WaitForOtherPlayerToExit
	scall Script_WalkOutOfLinkRoom
	setscene $0
	setmapscene COLOSSEUM, $0
	end

Script_WalkOutOfLinkRoom:
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
	setval (PAL_NPC_BLUE) << 4
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	special UpdatePlayerSprite
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsDown
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	end

PokeCenter2FLinkRecordSign:
	refreshscreen
	special Special_DisplayLinkRecord
	endtext

LinkReceptionistScript_Trade:
if !DEF(DEBUG)
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalse Script_TradeCenterClosed
endc
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
	readmem wOtherPlayerLinkMode
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
	sjump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	endtext

Script_TradeCenterClosed:
	jumpthistextfaceplayer

	text "I'm sorry--the"
	line "Trade Machine is"
	cont "being adjusted."
	done

LinkReceptionistScript_Battle:
if !DEF(DEBUG)
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalse Script_BattleRoomClosed
endc
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
	readmem wOtherPlayerLinkMode
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
	sjump .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
.Cancel:
	endtext

Script_BattleRoomClosed:
	jumpthistextfaceplayer

	text "I'm sorry--the"
	line "Battle Machine is"
	cont "being adjusted."
	done

PokeCenter2F_CheckGender:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .Female
	applymovementlasttalked PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsUp
	end

.Female:
	applymovementlasttalked PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesTwoStepsUp
	showtext Text_OhPleaseWait
	applymovementlasttalked PokeCenter2FMovementData_ReceptionistLooksRight
	turnobject PLAYER, LEFT
	showtext Text_ChangeTheLook
	playsound SFX_TINGLE
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingRight
	setval (PAL_NPC_RED) << 4
	special Special_SetPlayerPalette
	applymovement PLAYER, PokeCenter2FMovementData_PlayerSpinsClockwiseEndsFacingLeft
	setflag ENGINE_KRIS_IN_CABLE_CLUB
	special UpdatePlayerSprite
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
