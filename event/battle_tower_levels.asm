BattleTowerInitRAMAndSetLevelGroup: ; 118121
	xor a
	ld [wBattleTowerBattleEnded], a
	ld [wNrOfBeatenBattleTowerTrainers], a
	ld [wcf65], a
	ld [wcf66], a
	ld [wcd38], a

	di
	ld a, [rIE]
	ld [wcd32], a
	xor a
	ld [rIF], a
	ld [wc300], a
	ld [wc301], a
	ld [wc302], a
	ld [wcd80], a
	ld [wcd65], a
	ld [wcd66], a
	ld [wcd67], a
	ld [wcd68], a
	ld [$c31a], a
	ld [wcd89], a
	ld [wcd8a], a
	ld [wcd8b], a
	ld [wc3ec], a
	ld [wc3ed], a
	ld [wc3ee], a
	ld [wc3ef], a
	ld hl, VramState
	ld a, [hl]
	ld [wcd7f], a
	set 1, [hl]
	ld a, $f
	ld [rIE], a
	ei

	xor a
	ld [$c319], a
	ld [wc310], a
	ld [wc311], a
	ld [wc312], a
	ld [wc313], a
	ld [wc314], a
	ld [wc314 + 1], a
	ld [wc314 + 4], a
	ld [wc3f6], a
	ld [wc3f8], a
	ld [wc3f2], a
	ld [wc3f4], a

	ld a, $24
	ld [wc3f5], a

	ld a, $7
	ld [wc3f7], a

	ld a, $b0
	ld [wc30e], a
	ld [wc3f1], a

	ld a, $48
	ld [wc30f], a
	ld [wc3f3], a

	ld a, $5
	call GetSRAMBank
	xor a
	ld [$bfff], a
	call CloseSRAM

	ld a, $3
	ld [wcd33], a

	ld a, $d
	ld [wcd34], a

	ld a, $4
	ld [wc3f0], a

	ld a, [rSVBK]
	push af
	ld a, $1
	ld [rSVBK], a
	; e = maximum party level [1-100]
	ld hl, PartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [PartyCount]
	ld d, a
	ld e, 1
.loop
	add hl, bc
	ld a, [hl]
	cp e
	jr c, .ok
	ld e, a
.ok
	dec d
	ld a, d
	jr nz, .loop
	pop af
	ld [rSVBK], a

	; wBTChoiceOfLvlGroup = (e + 9) / 10 [1-10]
	ld a, 9
	add e
	ld c, 10
	call SimpleDivide

	ld a, [rSVBK]
	push af
	ld a, $3
	ld [rSVBK], a
	ld a, b
	ld [wBTChoiceOfLvlGroup], a
	ld [wc300], a ; save here to store in ScriptVar later
	pop af
	ld [rSVBK], a

	di
	xor a
	ld [hVBlank], a
	xor a
	ld [rIF], a
	ld a, [wcd32]
	ld [rIE], a
	ei

	ld a, [wcd7f]
	ld [VramState], a

	ld a, [wc300] ; saved value of wBTChoiceOfLvlGroup
	ld [ScriptVar], a
	ret
; 118473
