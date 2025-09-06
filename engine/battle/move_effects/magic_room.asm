BattleCommand_magicroom::
    ld hl, wMagicWonderRoom
    ld a, [hl]
    and FIELD_MAGIC_ROOM
    ld a, [hl]
    jr nz, .end_room
    add $05
    ld [hl], a
    ld hl, MagicRoomText
    jmp StdBattleTextbox

.end_room
    and ~FIELD_MAGIC_ROOM
    ld [hl], a
    ld hl, MagicRoomEndedText
    jmp StdBattleTextbox