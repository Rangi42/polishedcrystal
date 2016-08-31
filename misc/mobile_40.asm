Function10032e: ; 10032e
	call Function10034d
	ld e, a
	ret nc
	ld [wcd2b], a
	ret
; 100337

Function10034d: ; 10034d
	ld a, [wc821]
	bit 1, a
	jr nz, .asm_10036a
	bit 2, a
	jr nz, .asm_10037e
	bit 3, a
	jr nz, .asm_100366
	bit 0, a
	jr nz, .asm_100364
	ld a, $01
	and a
	ret

.asm_100364
	xor a
	ret

.asm_100366
	ld a, $02
	and a
	ret

.asm_10036a
	ld a, 0
	call Function3e32
	ld [wcd2c], a
	ld a, h
	ld [wcd2d], a
	ld a, l
	ld [wcd2e], a
	ld a, $ff
	scf
	ret

.asm_10037e
	ld a, $fe
	scf
	ret
; 100382

_LinkBattleSendReceiveAction: ; 100a09
	call .StageForSend
	ld [wd431], a
	callba PlaceWaitingText
	call .LinkBattle_SendReceiveAction
	ret
; 100a2e

.StageForSend: ; 100a2e
	ld a, [wPlayerAction]
	and a
	jr nz, .switch
	ld a, [CurPlayerMove]
	ld b, BATTLEACTION_E
	cp STRUGGLE
	jr z, .struggle
	ld b, BATTLEACTION_D
	cp $ff
	jr z, .struggle
	ld a, [CurMoveNum]
	jr .use_move

.switch
	ld a, [CurPartyMon]
	add BATTLEACTION_SWITCH1
	jr .use_move

.struggle
	ld a, b

.use_move
	and $0f
	ret
; 100a53

.LinkBattle_SendReceiveAction: ; 100a53
	ld a, [wd431]
	ld [wPlayerLinkAction], a
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
.waiting
	call LinkTransfer
	call DelayFrame
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .waiting

	ld b, 10
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	ld b, 10
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	ld a, [wOtherPlayerLinkAction]
	ld [wBattleAction], a
	ret
; 100a87
