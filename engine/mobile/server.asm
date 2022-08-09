; Polished Online
DEF PO_PORT            EQU 57409

DEF PO_CMD_DISCONNECT  EQU $00
DEF PO_CMD_STATUS      EQU $01
DEF PO_CMD_WONDERTRADE EQU $02
DEF PO_CMD_SETINFO     EQU $03
DEF PO_CMD_GETINFO     EQU $04
DEF PO_CMD_LISTUSERS   EQU $05
DEF PO_CMD_BATTLEUSER  EQU $06
DEF PO_CMD_TRADEUSER   EQU $07
DEF PO_CMD_GETBATTLE   EQU $08
DEF PO_CMD_BATTLETURN  EQU $09
DEF PO_CMD_TRADETURN   EQU $0a
DEF PO_CMD_SETREPLY    EQU $0b

DEF PO_SIGNAL_ERROR       EQU $81
DEF PO_SIGNAL_ASKBATTLE   EQU $86
DEF PO_SIGNAL_ASKTRADE    EQU $87

DEF PO_STATUS_CLOSED      EQU $00

DEF PO_REPLY_ACCEPT       EQU $00
DEF PO_REPLY_REJECT       EQU $01
DEF PO_REPLY_WAIT         EQU $02

DEF PO_ERROR_OK           EQU $00 ; no error, but some functions return this
DEF PO_ERROR_UNKNCMD      EQU $01
DEF PO_ERROR_UNKNUSER     EQU $02
DEF PO_ERROR_BADINFO      EQU $03
DEF PO_ERROR_INCOMPATIBLE EQU $04
DEF PO_ERROR_UNAUTHORIZED EQU $05
DEF PO_ERROR_WITHANOTHER  EQU $06
DEF PO_ERROR_REJECTED     EQU $07

PolishedOnline_Addr:
	asciistr "fiq.se"

PolishedOnline_BackupIP:
	db 71, 19, 149, 30

PO_Connect::
; Connects to Polished Online. Returns z if we're unable to connect.
	ld hl, PolishedOnline_Addr
	ld bc, PO_PORT
	call ConnectToDomain
	jr nz, .success

	; DNS query probably failed. Try connecting by IP.
	ld hl, PolishedOnline_BackupIP
.got_ip
	call ConnectToIP
	ret z

.success
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
.start
	call LoadStandardMenuHeader
	call ClearSprites
	call ClearScreen
	xor a
	ldh [hBGMapMode], a

	hlcoord 2, 1
	ld de, .PolishedOnline
	call PlaceString

	ld b, 0
	call SafeCopyTilemapAtOnce

	; Check if we're able to connect to the server...
	ld a, PO_CMD_STATUS
	call PO_ServerCommand
	jp c, .handle_signal
	jp z, .server_closed

	; We are allowed to connect. Send user info to the server
	ld a, PO_CMD_SETINFO
	call PO_ServerCommand
	jp c, .handle_signal

.get_user_list
	call PO_PrepareUserListMenu

.user_loop
	call PO_GetUserListOnTick
	jp c, .handle_signal
	call PO_UserListInput
	jp c, .handle_signal
	jp z, .user_loop

	; Check if there's any users. If not, just go back to user loop
	ld a, [wPO_UserCount]
	and a
	jr z, .user_loop

	; Don't allow battling/trading with yourself
	ld hl, wPO_User1ServerID
	ld bc, wPO_User2 - wPO_User1
	ld a, [wMenuCursorY]
	dec a
	call AddNTimes
	ld a, [wPO_UserID]
	cp [hl]
	jr z, .user_loop

	; Attempt to battle with user
	ld b, [hl]
	call PO_RequestBattle
	jp c, .handle_signal
	jr z, .user_loop

.init_battle
	call PO_ClearInterface
	hlcoord 1, 3
	ld de, .DoBattle
	call PlaceString
	ld b, 0
	call SafeCopyTilemapAtOnce

	; Register participant IDs
	ld a, [wPO_Content]
	ld [wPO_BattlePlayer1ID], a
	ld b, a
	ld a, [wPO_Content + 1]
	ld [wPO_BattlePlayer2ID], a
	ld c, a

	ld a, LINK_MOBILE
	ld [wLinkMode], a

	; in case we need random numbers on turn "0" (entry abilities, speed ties)
	ld a, 15
	ld [wPO_RNGPointer], a

	; Check whether or not we are host and store it in SerialConnectionStatus.
	; While mobile communication doesn't use this for most things, battles still
	; rely on this variable to determine whether or not we are the host.
	ld hl, hSerialConnectionStatus
	ld [hl], USING_INTERNAL_CLOCK
	ld a, [wPO_UserID]
	cp b
	jr nz, .is_client
	ld [hl], USING_EXTERNAL_CLOCK
	ld b, c
.is_client
	ld a, PO_CMD_GETINFO
	call PO_ServerCommand
	jr c, .handle_signal

	; TODO: this is copied from link, they should probably share a function
	ld a, [wOTPlayerGender]
	dec a
	ld a, CARRIE
	jr z, .got_ot_gender
	ld a, CAL
.got_ot_gender
	ld [wOtherTrainerClass], a
	call ClearScreen
	ld hl, wOptions2
	ld a, [hl]
	push af
	and ~(BATTLE_SWITCH | BATTLE_PREDICT)
	ld [hl], a
	ld hl, wOTPlayerName
	ld de, wOTClassName
	ld bc, NAME_LENGTH
	call CopyBytes
	call ReturnToMapFromSubmenu
	ldh a, [rIE]
	push af
	ldh a, [rIF]
	push af
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	set LCD_STAT, a
	ldh [rIE], a
	pop af
	ldh [rIF], a
	predef StartBattle
	ldh a, [rIF]
	ld h, a
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	ld a, h
	ldh [rIF], a
	pop af
	ld [wOptions], a
	xor a
	ldh [hBGMapMode], a
	ld [wLinkMode], a
	farcall LoadPokemonData
	call LoadMapPart
	call LoadStandardMenuHeader
	jp .start

.handle_signal
	; Check if server connection was terminated
	ld a, b
	cp PO_CMD_DISCONNECT
	jr z, .server_terminated

	; Handle battle requests
	cp PO_SIGNAL_ASKBATTLE
	jr nz, .disconnect ; TODO: other signals

	; Just accept the invite automatically for now
	ld a, PO_CMD_SETREPLY
	ld b, PO_REPLY_ACCEPT
	call PO_ServerCommand
	jr c, .handle_signal
	jp .init_battle
.server_closed
	hlcoord 1, 3
	ld de, .ServerClosed
	call PlaceString
	ld b, 0
	call SafeCopyTilemapAtOnce
	ld c, 240
	call DelayFrames
.disconnect
	ld a, PO_CMD_DISCONNECT
	call PO_ServerCommand
	jr .close_menu
.server_terminated
	call PO_ClearInterface
	hlcoord 1, 3
	ld de, .ServerTerminated
	call PlaceString
	ld b, 0
	call SafeCopyTilemapAtOnce
	ld c, 240
	call DelayFrames
.close_menu
	call CloseSubmenu
.done
	pop af
	ld [wOptions], a
	or 1
	ret

.PolishedOnline:
	db "Polished Online@"

.ServerClosed:
	db    "The server cannot"
	next1 "accept players at"
	next1 "the moment."
	next1 ""
	next1 "Try again later."
	done

.ServerTerminated:
	db    "Your connection to"
	next1 "the server was"
	next1 "terminated."
	done

.DoBattle:
	db    "Loading battle…"
	done

PO_GetUserListOnTick:
	ld hl, wPO_RequestTimer
	dec [hl]
	ret nz
	ld [hl], 30
	; fallthrough
PO_GetUserList:
; Request an user list from the server and displays it
	; Request a list of users
	ld a, PO_CMD_LISTUSERS
	call PO_ServerCommand
	ret c

	call PO_ClearInterface

	ld a, [wPO_UserCount]
	and a
	jr z, .no_users
	ld b, a
	push bc
	hlcoord 1, 3
	ld de, .UserListHeader
	push bc
	call PlaceString
	pop bc
	hlcoord 14, 4
	ld de, wPO_User1PlayerID
.user_loop
	; Player ID
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	inc de

	; Player Name
	ld bc, -18
	add hl, bc
	push de
	push hl
	call PlaceString
	pop hl

	; Game Name
	ld bc, 8
	add hl, bc
	ld de, .GameName
	call PlaceString
	pop de

	; Go to next user
	ld a, wPO_User2PlayerID - wPO_User1Name
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld bc, SCREEN_WIDTH + 5
	add hl, bc
	pop bc
	dec b
	jr nz, .user_loop
	pop bc
	ld a, [wMenuCursorY]
	cp b
	ld a, b
	ld [w2DMenuNumRows], a
	jr c, .update_cursor
	ld [wMenuCursorY], a
.update_cursor
	farcall Place2DMenuCursor
	jr .update_screen
.no_users
	hlcoord 3, 2
	ld de, .NoOthersOnline
	call PlaceString
.update_screen
	ld b, 0
	call SafeCopyTilemapAtOnce
	xor a
	ret

.NoOthersOnline:
	db    "No other players"
	next1 "online currently"
	done

.UserListHeader:
	db "NAME    GAME ID@"

.GameName:
	db "PC-M@" ; Polished Crystal Modified

PO_UserListInput:
; Returns z if nothing special is happening, c if we pressed B, nc otherwise.
	call JoyTextDelay
	call DoMenuJoypadLoop
	ldh a, [hJoyPressed]
	and BUTTONS
	ret z

	and B_BUTTON
	scf
	ret nz
	or 1
	ret

PO_PrepareUserListMenu:
	ld a, A_BUTTON | B_BUTTON | D_UP | D_DOWN
	ld [wMenuJoypadFilter], a
	; row amount are written to elsewhere
	ld a, 1
	ld [wPO_RequestTimer], a
	ld [w2DMenuNumCols], a
	ld [wMenuCursorX], a
	ld [wMenuCursorY], a
	rrca ; ld a, $80
	ld [w2DMenuFlags1], a
	ld a, 4
	ld [w2DMenuCursorInitY], a
	xor a
	ld [w2DMenuCursorInitX], a
	ld [w2DMenuFlags2], a
	ln a, 1, 0
	ld [w2DMenuCursorOffsets], a
	ret

PO_RequestBattle:
; Request battle with user id b. Returns z if the request failed, c on signal
	ld a, PO_CMD_BATTLEUSER
	call PO_ServerCommand
	jr c, .handle_signal

	call PO_ClearInterface
	hlcoord 1, 3
	ld de, .AskingForBattle
	call PlaceString
	ld b, 0
	call SafeCopyTilemapAtOnce

.loop
	; Check if a battle is to commence
	ld a, [wPO_Content]
	and a
	jr z, .next_try
	ret ; Commence battle
.next_try
	; There's no need to flood the server, wait 1s between requests
	ld c, 60
	call DelayFrames

	; Wait for a reply
	ld a, PO_CMD_SETREPLY
	ld b, PO_REPLY_WAIT
	call PO_ServerCommand
	jr c, .handle_signal
	jr .loop

.handle_signal
	ld a, b
	cp PO_SIGNAL_ERROR ; cannot battle the user
	ret z
	scf
	ret

.AskingForBattle:
	db    "Asking user to"
	next1 "battle…"
	done

PO_ClearInterface:
	hlcoord 0, 2
	lb bc, 16, 20
	push hl
	call ClearBox
	pop hl
	ret

PO_ServerCommand:
; Returns c upon a signal (disconnect, other user is asking for a battle, etc)
	ld [wPO_Command], a
	and a
	jr z, .Disconnect
	dec a
	jr z, .GetStatus
	dec a
	jr z, .WonderTrade
	dec a
	jr z, .SetInfo
	dec a
	jp z, .GetInfo
	dec a
	jp z, .ListUsers
	dec a
	jp z, .BattleUser
	dec a
	jp z, .TradeUser
	dec a
	jr z, .GetBattle
	dec a
	jp z, .BattleTurn
	dec a
	jr z, .TradeTurn
	dec a
	jp z, .SetReply
	; failsafe fallthrough
.WonderTrade:
.GetBattle:
.TradeTurn:
.Disconnect:
	; Disconnect from server. Response content is actually 1 byte, but
	; this should ensure that we disconnect properly.
	; Server Protocol: CMD -> CMD
	ld b, 1
	call PO_ExchangeData
	ret c

	; Server didn't bother closing the connection. Do that ourselves.
	xor a
	ld [wMobilePacketContent], a
	ld b, 1
	ld a, MOBILE_COMMAND_CLOSE_TCP_CONNECTION
	call SendAndWait
	scf
	ret

.GetStatus:
	; Returns nz if we are allowed to connect.
	; Server Protocol: CMD -> CMD, User ID (0 if closed)
	ld b, 1
	call PO_ExchangeData
	ret c
	ld a, [wPO_Content]
	and a ; return z if PO_STATUS_OK
	ret z

	; Otherwise, remember our user ID
	ld [wPO_UserID], a
	ret

.SetInfo:
	; Sets user data. Done in steps
	; Server Protocol: CMD, Data Half Identifier, Data Half -> CMD
	ld de, wPO_Content
	xor a
	ld [de], a
	inc de
	ld hl, wPlayerID
	ld de, wPO_Content + 1
	ld bc, 2
	call CopyBytes
	ld a, [wPartyCount]
	ld [de], a
	inc de
	ld a, [wPlayerGender]
	ld [de], a
	inc de
	ld hl, wPlayerName
	ld c, NAME_LENGTH
	call CopyBytes
	ld hl, wPartyMons
	ld c, wPartyMon5 - wPartyMons
	call CopyBytes
	ld b, 4 + NAME_LENGTH + wPartyMon5 - wPartyMons + 2
	call PO_ExchangeData
	ret c
	ld de, wPO_Content
	ld a, 1
	ld [de], a
	inc de
	ld hl, wPartyMon5
	ld de, wPO_Content + 1
	ld bc, wPartyMonNicknamesEnd - wPartyMon5
	call CopyBytes
	ld b, wPartyMonNicknamesEnd - wPartyMon5 + 2
	jp PO_ExchangeData

.GetInfo:
	; Requests user data for user b.
	; Server Protocol: CMD, User, Data Half Identifier -> CMD, Data Half
	ld a, b
	ld [wPO_Content], a
	xor a
	push bc
	ld [wPO_Content + 1], a
	ld b, 3
	call PO_ExchangeData
	pop bc
	ret c
	push bc
	ld hl, wPO_Content
	ld de, wOTPlayerID
	ld bc, 2
	call CopyBytes
	ld a, [hli]
	ld [wOTPartyCount], a
	ld a, [hli]
	ld [wOTPlayerGender], a
	ld de, wOTPlayerName
	ld c, NAME_LENGTH
	call CopyBytes
	ld de, wOTPartyMons
	ld c, wOTPartyMon5 - wOTPartyMons
	call CopyBytes
	pop bc
	ld a, b
	ld [wPO_Content], a
	ld a, 1
	ld [wPO_Content + 1], a
	ld b, 3
	call PO_ExchangeData
	ret c
	ld hl, wPO_Content
	ld de, wOTPartyMon5
	ld bc, wOTPartyDataEnd - wOTPartyMon5
	rst CopyBytes
	ret

.ListUsers:
	; Server Protocol: CMD -> CMD, User Amount, Users
	ld b, 1
	jp PO_ExchangeData

.BattleTurn:
	; Input action for battle turn. Returns z if waiting for other player.
	; Action consist of 2 nibbles: amount of used random numbers, actual action
	; Server Protocol: CMD, RNGCount|Action -> CMD, (HostAction|ClientAction), 15 random numbers
	ld a, [wPO_RNGPointer]
	swap a
	ld b, a
	ld a, [wLinkBattleSentAction]
	or b
	ld [wPO_BattleCommand], a
	ld b, 2
	call PO_ExchangeData
	ret c
	ld a, [wPO_BattleCommand]
	ld b, a
	inc b
	ret z
	dec b
	xor a
	ld [wPO_RNGPointer], a

	; Check which one is the other player
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .got_target_command
	swap b
.got_target_command
	ld a, b
	and $f
	ld [wOtherPlayerLinkAction], a
	or 1
	ret

.BattleUser:
.TradeUser:
	; Battle or trade with user in b.
	; Server Protocol: CMD, Target -> CMD, Player1, Player2 or CMD, 0 if pending
.SetReply:
	; Set battle request reply b. 0=(still) pending, 1=reject/abort
	; Server Protocol: CMD, Reply -> CMD, Player1, Player2 (success)/CMD, 0 (fail)
	ld a, b
	ld [wPO_Content], a
	ld b, 2
	; fallthrough
PO_ExchangeData:
; Returns c upon a signal with sent command in a, received in b.
	ld hl, wPO_Data
	ld de, wPO_Data
	ld a, [wPO_Command]
	push af

	; First, get length. Then get the rest
	xor a
	ld c, 1
	call ExchangeTCPData
	jr c, .disconnected
	jr z, .got_required_data
	push af
	push bc
	ld c, a
	ld a, [wMobilePacketSize]
	dec a
	cp c
	pop bc
	jr nz, .not_enough_data
	pop af
	ld hl, wMobilePacketContent + 1
	ld de, wPO_Data
	ld b, 0
	ld a, [wMobilePacketSize]
	dec a
	ld c, a
	rst CopyBytes
	jr .got_required_data
.not_enough_data
	pop af
	call ForceContinueExchangeTCPData
	jr c, .disconnected
.got_required_data
	ld a, [wPO_Data]
	ld c, a
	push bc
	call ContinueExchangeTCPData
	pop bc
	jr c, .disconnected
	ld hl, wPO_Data + 1
	ld de, wPO_Data
	push bc
	ld bc, 254
	call CopyBytes
	pop bc
	ld a, c
	ld [wPO_ResponseSize], a
	ld a, [wPO_Command]
	ld b, a
	pop af
	cp b
	ret z
	scf
	ret
.disconnected
	pop af
	ld b, PO_CMD_DISCONNECT
	scf
	ret
