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
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Trade, -1
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_SCRIPT, 0, LinkReceptionistScript_Battle, -1
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, 0, OBJECTTYPE_COMMAND, jumptextfaceplayer, Text_TimeCapsuleClosed, -1

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
	callasm .CheckKanto
	iffalsefwd .done
	changemapblocks KantoPokeCenter2F_BlockData
.done
	endcallback

.CheckKanto:
	call RegionCheck
	dec e ; KANTO_REGION?
	ld a, TRUE
	jr z, .ok
	dec a ; FALSE
.ok
	ldh [hScriptVar], a
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
	reanchormap
	special Special_DisplayLinkRecord
	endtext

LinkReceptionistScript_Trade:
if !DEF(DEBUG)
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iffalsefwd Script_TradeCenterClosed
endc
	special FixPlayerEVsAndStats ; no (trivial) cheating
	opentext
	writetext Text_TradeReceptionistIntro
	yesorno
	iffalse_endtext
	callasm CheckPartyForMail
	iftruefwd LinkReceptionistScript_HasMail
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
	writetext Text_PleaseComeIn
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
	sjumpfwd .CloseLink

.OldVersionDetected:
	writetext Text_OldVersionDetected
	sjumpfwd .CloseLink

.WrongGameID
	writetext Text_WrongGameID
	sjumpfwd .CloseLink

.WrongVersion
	writetext Text_WrongVersion
	sjumpfwd .CloseLink

.WrongMinVersion
	writetext Text_WrongMinVersion
	sjumpfwd .CloseLink

.OtherPlayerWrongMinVersion
	writetext Text_OtherPlayerWrongMinVersion
	sjumpfwd .CloseLink

.WrongOptions
	writetext Text_WrongOptions
	sjumpfwd .CloseLink

.IncompatibleRooms:
	writetext Text_IncompatibleRooms
.CloseLink:
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

LinkReceptionistScript_HasMail:
	writethistext
		text "I am sorry, but"
		line "we are unable to"

		para "trade #mon"
		line "carrying mail"
		cont "at this time."
		done
	waitbutton
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
	iffalsefwd .BattleRoomClosed
endc
	special FixPlayerEVsAndStats ; no (trivial) cheating
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
	scalltable .LinkTrainerTable
	end

.LinkTrainerTable
	dw .Male
	dw .Female
	dw .Enby
.Male:
	variablesprite SPRITE_LINK_TRAINER, SPRITE_CHRIS
	end
.Female:
	variablesprite SPRITE_LINK_TRAINER, SPRITE_KRIS
	end
.Enby:
	variablesprite SPRITE_LINK_TRAINER, SPRITE_CRYS
	end

PokeCenter2FMovementData_ReceptionistWalksUpAndLeft_LookRight:
	slow_step_up
	slow_step_left
	turn_head_right
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsUp:
	step_up
	step_up
	step_up
	step_end

PokeCenter2FMovementData_PlayerTakesThreeStepsDown:
	step_down
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
	line "Polished Crystal."
	prompt

Text_WrongGameID:
	text "Your game is not"
	line "compatible with"
	cont "the other game."
	prompt

Text_WrongVersion:
	text "Your game versions"
	line "do not match."

	para "In order to play"
	line "Link Colosseum,"

	para "your game versions"
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
	text "The other game"
	line "system does not"

	para "meet the"
	line "minimum version"
	cont "requirement."
	prompt

Text_WrongOptions:
	text "Your game options"
	line "are not compatible"

	para "with the other"
	line "player."
	prompt

Text_IncompatibleRooms:
	text "Incompatible rooms"
	line "were chosen."
	prompt

Text_TimeCapsuleClosed:
	text "I'm sorry--the"
	line "Time Capsule is"
	cont "inoperative."
	done
