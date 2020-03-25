BattleCommand_trickroom:
	ld hl, wTrickRoom
	ld a, [hl]
	and a
	jr nz, .failed
	ld [hl], 5
	call AnimateCurrentMove
	ld hl, TrickRoomText
	call StdBattleTextBox

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
	jp ConsumeUserItem

.failed
	call AnimateFailedMove
	jp PrintButItFailed
