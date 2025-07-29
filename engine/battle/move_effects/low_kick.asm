BattleCommand_lowkick:
	push bc
	push de
	farcall GetOpponentWeight
	ld d, h
	ld e, l
	ld hl, LowKickPowerByWeight
.loop2
	ld a, [hli]
	ld c, a
	ld a, [hli]
	sub e
	ld a, [hli]
	sbc d
	jr nc, .loop2
.got_power
	pop de
	ld d, c
	pop bc
	ret

INCLUDE "data/moves/low_kick_power.asm"
