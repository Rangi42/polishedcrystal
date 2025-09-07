BattleCommand_mudsport::
    ld hl, wFieldSports
    ld a, [hl]
    and FIELD_MUD_SPORT
    jr nz, .failed
    ld a, [hl]
    add $50
    ld [hl], a
    ld hl, MudSportText
    jmp StdBattleTextbox

.failed
    farcall AnimateFailedMove
	jmp TryPrintButItFailed
