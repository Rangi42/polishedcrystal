HiddenPowerDamageStats: ; fbced
; Override Hidden Power's type based on the user's DVs.

	ld hl, wBattleMonDVs
	ld a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, wEnemyMonDVs
.got_dvs

	call GetHiddenPowerType

; Overwrite the current move type.
	push af
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	pop af
	ld [hl], a

; Get the rest of the damage formula variables
; based on the new type.
	push af
	farcall BattleCommand_DamageStats ; damagestats
	pop af
	ret
; fbd54

GetHiddenPowerType::
; return Hidden Power type in a from DVs at hl
; b = %0ace0bdf (a, b, c, d, e, f = HP, Atk, Def, Spd, SAt, SDF)
	ld b, 0
	ld a, [hli]
	and %00010001
	add b
	sla a
	ld b, a
	ld a, [hli]
	and %00010001
	add b
	sla a
	ld b, a
	ld a, [hl]
	and %00010001
	add b
	ld b, a
; a = %00acebdf
	and $f
	sla a
	ld c, a
	ld a, b
	and $f0
	or c
	srl a
; get type
	ld hl, .Types
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ret

.Types:
if DEF(FAITHFUL)
; type = %fedcba * 15 / 63
	db FIGHTING ; 00
	db STEEL    ; 32
	db FLYING   ; 08
	db WATER    ; 40
	db FIGHTING ; 02
	db FIRE     ; 34
	db POISON   ; 10
	db GRASS    ; 42
	db GROUND   ; 16
	db ELECTRIC ; 48
	db BUG      ; 24
	db ICE      ; 56
	db ROCK     ; 18
	db ELECTRIC ; 50
	db GHOST    ; 26
	db ICE      ; 58
	db FIGHTING ; 04
	db FIRE     ; 36
	db POISON   ; 12
	db GRASS    ; 44
	db FLYING   ; 06
	db WATER    ; 38
	db GROUND   ; 14
	db GRASS    ; 46
	db ROCK     ; 20
	db PSYCHIC  ; 52
	db GHOST    ; 28
	db DRAGON   ; 60
	db BUG      ; 22
	db PSYCHIC  ; 54
	db STEEL    ; 30
	db DRAGON   ; 62
	db FIGHTING ; 01
	db STEEL    ; 33
	db POISON   ; 09
	db WATER    ; 41
	db FIGHTING ; 03
	db FIRE     ; 35
	db POISON   ; 11
	db GRASS    ; 43
	db ROCK     ; 17
	db ELECTRIC ; 49
	db BUG      ; 25
	db ICE      ; 57
	db ROCK     ; 19
	db PSYCHIC  ; 51
	db GHOST    ; 27
	db DRAGON   ; 59
	db FLYING   ; 05
	db FIRE     ; 37
	db GROUND   ; 13
	db GRASS    ; 45
	db FLYING   ; 07
	db WATER    ; 39
	db GROUND   ; 15
	db ELECTRIC ; 47
	db BUG      ; 21
	db PSYCHIC  ; 53
	db GHOST    ; 29
	db DRAGON   ; 61
	db BUG      ; 23
	db ICE      ; 55
	db STEEL    ; 31
	db DARK     ; 63
else
; type = %fedcba * 16 / 63
	db FIGHTING ; 00
	db FIRE     ; 32
	db POISON   ; 08
	db GRASS    ; 40
	db FIGHTING ; 02
	db FIRE     ; 34
	db POISON   ; 10
	db GRASS    ; 42
	db ROCK     ; 16
	db PSYCHIC  ; 48
	db GHOST    ; 24
	db DRAGON   ; 56
	db ROCK     ; 18
	db PSYCHIC  ; 50
	db GHOST    ; 26
	db DRAGON   ; 58
	db FLYING   ; 04
	db WATER    ; 36
	db GROUND   ; 12
	db ELECTRIC ; 44
	db FLYING   ; 06
	db WATER    ; 38
	db GROUND   ; 14
	db ELECTRIC ; 46
	db BUG      ; 20
	db ICE      ; 52
	db STEEL    ; 28
	db DARK     ; 60
	db BUG      ; 22
	db ICE      ; 54
	db STEEL    ; 30
	db DARK     ; 62
	db FIGHTING ; 01
	db FIRE     ; 33
	db POISON   ; 09
	db GRASS    ; 41
	db FIGHTING ; 03
	db FIRE     ; 35
	db POISON   ; 11
	db GRASS    ; 43
	db ROCK     ; 17
	db PSYCHIC  ; 49
	db GHOST    ; 25
	db DRAGON   ; 57
	db ROCK     ; 19
	db PSYCHIC  ; 51
	db GHOST    ; 27
	db DRAGON   ; 59
	db FLYING   ; 05
	db WATER    ; 37
	db GROUND   ; 13
	db ELECTRIC ; 45
	db FLYING   ; 07
	db WATER    ; 39
	db GROUND   ; 15
	db ELECTRIC ; 47
	db BUG      ; 21
	db ICE      ; 53
	db STEEL    ; 29
	db DARK     ; 61
	db BUG      ; 23
	db ICE      ; 55
	db STEEL    ; 31
	db FAIRY    ; 63
endc
