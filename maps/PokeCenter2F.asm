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
	ifequalfwd $0, .done
	ifequalfwd $2, .shamouti2f
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
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_TRADE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	setscene $0
	setmapscene TRADE_CENTER, $0
	end

Script_LeftCableColosseum:
	special WaitForOtherPlayerToExit
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsDown
	applymovement POKECENTER2F_BATTLE_RECEPTIONIST, PokeCenter2FMovementData_ReceptionistStepsRightAndDown
	setscene $0
	setmapscene COLOSSEUM, $0
	end

PokeCenter2FLinkRecordSign:
	refreshscreen
	special Special_DisplayLinkRecord
	endtext

LinkReceptionistScript_Trade:
if !DEF(DEBUG)
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalsefwd Script_TradeCenterClosed
endc
	opentext
	writetext Text_TradeReceptionistIntro
	yesorno
	iffalse_endtext
	special Special_SetBitsForLinkTradeRequest
	; fallthrough
LinkReceptionistScript_DoTradeOrBattle:
	writetext Text_PleaseWait
	special Special_WaitForLinkedFriend
	iffalsefwd .FriendNotReady
	writetext Text_MustSaveGame
	yesorno
	iffalsefwd .DidNotSave
	special Special_TryQuickSave
	iffalsefwd .DidNotSave
	writetext Text_PleaseWait
	special Special_CheckLinkTimeout
	iffalsefwd .LinkTimedOut
	readmem wOtherPlayerLinkMode
	iffalsefwd .LinkedToFirstGen
	special PerformLinkChecks
	iffalsefwd .OldVersionDetected ; LINK_ERR_OLD_PC_DETECT
	ifequalfwd LINK_ERR_MISMATCH_GAME_ID, .WrongGameID
	ifequalfwd LINK_ERR_MISMATCH_VERSION, .WrongVersion
	ifequalfwd LINK_ERR_VERSION_TOO_LOW, .WrongMinVersion
	ifequalfwd LINK_ERR_OTHER_VERSION_TOO_LOW, .OtherPlayerWrongMinVersion
	ifequalfwd LINK_ERR_MISMATCH_GAME_OPTIONS, .WrongOptions
	ifequalfwd LINK_ERR_INCOMPATIBLE_ROOMS, .IncompatibleRooms
	writetext Text_PleaseComeIn2
	waitbutton
	closetext
	scall PokeCenter2F_EnterRoom
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

.OldVersionDetected:
	writetext Text_OldVersionDetected
	special Special_CloseLink
	endtext

.WrongGameID
	writetext Text_WrongGameID
	special Special_CloseLink
	endtext

.WrongVersion
	writetext Text_WrongVersion
	special Special_CloseLink
	endtext

.WrongMinVersion
	writetext Text_WrongMinVersion
	special Special_CloseLink
	endtext

.OtherPlayerWrongMinVersion
	writetext Text_OtherPlayerWrongMinVersion
	special Special_CloseLink
	endtext

.WrongOptions
	writetext Text_WrongOptions
	special Special_CloseLink
	endtext

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
	special Special_CloseLink
	endtext

.LinkTimedOut:
	writetext Text_LinkTimedOut
	sjumpfwd .AbortLink

.DidNotSave:
	writetext Text_PleaseComeAgain
.AbortLink:
	special WaitForOtherPlayerToExit
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
	iftruefwd .BattleRoomClosed
endc
	opentext
	writetext Text_BattleReceptionistIntro
	yesorno
	iffalse_endtext
	special Special_SetBitsForBattleRequest
	sjump LinkReceptionistScript_DoTradeOrBattle

.BattleRoomClosed:
	jumpthistextfaceplayer

	text "I'm sorry--the"
	line "Battle Machine is"
	cont "being adjusted."
	done

PokeCenter2F_EnterRoom:
	applymovementlasttalked PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight
	applymovement PLAYER, PokeCenter2FMovementData_PlayerTakesThreeStepsUp
	readmem wLinkOtherPlayerGender
	iftruefwd .Female
	variablesprite SPRITE_LINK_TRAINER, SPRITE_CHRIS
	end
.Female
	variablesprite SPRITE_LINK_TRAINER, SPRITE_KRIS
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

Text_OldVersionDetected:
	text "You are connected"
	line "to an old"

	para "version of"
	line "polished crystal."
	prompt

Text_WrongGameID:
	text "Your Game is not"
	line "compatible with"
	cont "the other game."
	prompt

Text_WrongVersion:
	text "Your game versions"
	line "do not match."

	para "In order to play"
	line "Link Colosseum"

	para "Your game versions"
	line "must match."
	prompt

Text_WrongMinVersion:
	text "Your game does not"
	line "meet the minimum"
	cont "version"

	para "requirement for"
	line "the other game."
	prompt

Text_OtherPlayerWrongMinVersion:
	text "The other Game"
	line "system does not"

	para "meet the"
	line "minimum version"
	cont "requirement."
	prompt

Text_WrongOptions:
	text "Your Game Options"
	line "are not compatible"

	para "with the other"
	line "player."
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
