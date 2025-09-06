BattleCommand_magicroom::
    ld hl, wMagicWonderRoom
    ld a, [hl]
    and FIELD_MAGIC_ROOM
    jr nz, .failed
    ld a, [hl]
    add $05
    ld [hl], a
    ld hl, MagicRoomText
    jmp StdBattleTextbox
    ret

.failed
    farcall AnimateFailedMove
	farcall TryPrintButItFailed
	ret