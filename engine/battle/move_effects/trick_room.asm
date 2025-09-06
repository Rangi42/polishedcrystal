BattleCommand_trickroom:
	call AnimateCurrentMove

	ld hl, wGravityTrickRoom
	ld a, [hl]
	and FIELD_TRICK_ROOM
	jr z, .new_trick_room
	ld [hl], 0

	ld hl, TrickRoomEndedText
	jmp StdBattleTextbox

.new_trick_room
	ld a, [hl]
	add 5
	ld [hl], a
	ld hl, TrickRoomText
	call StdBattleTextbox

	predef GetUserItemAfterUnnerve
	ld a, b
	cp HELD_ROOM_SERVICE
	ret nz

	ld b, SPEED
	ld a, STAT_SKIPTEXT
	call _ForceLowerStat
	ld a, [wFailedMessage]
	and a
	ret nz

	farcall UseStatItemText
	jmp ConsumeUserItem
