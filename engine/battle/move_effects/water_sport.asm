BattleCommand_watersport::
    ld hl, wFieldSports
    ld a, [hl]
    and FIELD_WATER_SPORT
    jr nz, .failed
    ld a, [hl]
    add $05
    ld [hl], a
    ld hl, WaterSportText
    jmp StdBattleTextbox
    ret

.failed
    farcall AnimateFailedMove
	farcall TryPrintButItFailed
	ret