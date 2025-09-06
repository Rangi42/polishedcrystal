BattleCommand_wonderroom::
    ld hl, wMagicWonderRoom
    ld a, [hl]
    and FIELD_WONDER_ROOM
    ld a, [hl]
    jr nz, .end_room
    add $50
    ld [hl], a
    ld hl, WonderRoomText
    jmp StdBattleTextbox

.end_room
    and ~FIELD_WONDER_ROOM
    ld [hl], a
    ld hl, WonderRoomEndedText
    jmp StdBattleTextbox