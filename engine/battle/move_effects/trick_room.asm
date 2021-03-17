BattleCommand_trickroom:
	call AnimateCurrentMove

	ld hl, wTrickRoom
	ld a, [hl]
	and a
	ld [hl], 5
	jr z, .new_trick_room
	ld [hl], 0

	ld hl, TrickRoomEndedText
	jp StdBattleTextbox

.new_trick_room
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
	jp ConsumeUserItem
