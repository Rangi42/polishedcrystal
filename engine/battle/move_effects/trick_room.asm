BattleCommand_trickroom:
	call AnimateCurrentMove

	ld hl, wTrickRoom
	ld a, [hl]
	and a
	ld [hl], 5
	jr z, .new_trick_room
	ld [hl], 0

	ld hl, TrickRoomEndedText
	jmp StdBattleTextbox

.new_trick_room
	ld hl, TrickRoomText
	call StdBattleTextbox
	ldh a, [hBattleTurn]
	push af
	call HandleRoomService
	pop af
	ldh [hBattleTurn], a
	ret

HandleRoomService:
	call SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_ROOM_SERVICE
	ret nz
	; fallthrough
RoomServiceItem:
	ld b, SPEED
	ld a, STAT_SKIPTEXT
	call _ForceLowerStat
	ld a, [wFailedMessage]
	and a
	ret nz

	farcall UseStatItemText
	jmp ConsumeUserItem
