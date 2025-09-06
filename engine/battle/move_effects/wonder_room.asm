BattleCommand_wonderroom::
    ld hl, wMagicWonderRoom
    ld a, [hl]
    and FIELD_WONDER_ROOM
    jr nz, .end_room
    ld a, [hl]
    add $50
    ld [hl], a
    ld hl, WonderRoomText
    jmp StdBattleTextbox
    ret

.end_room
    farcall AnimateFailedMove
	farcall TryPrintButItFailed
	ret