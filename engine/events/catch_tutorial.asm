CatchTutorial:: ; 4e554
	ld a, [wBattleType]
	dec a
	ld c, a
	ld hl, .dw
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.dw ; 4e564 (13:6564)
	dw .DudeTutorial
	dw .DudeTutorial
	dw .DudeTutorial

.DudeTutorial: ; 4e56a (13:656a)
; Back up your name
	ld hl, wPlayerName
	ld de, wBackupName
	ld bc, NAME_LENGTH
	rst CopyBytes
; Copy Dude's name to your name
	ld hl, .Dude
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes

	call .LoadDudeData

	xor a
	ld [hJoyDown], a
	ld [hJoyPressed], a

	ld hl, .AutoInput
	ld a, BANK(.AutoInput)
	call StartAutoInput
	farcall StartBattle
	call StopAutoInput

	ld hl, wBackupName
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	rst CopyBytes
	ret

.LoadDudeData: ; 4e5b7 (13:65b7)
	ld hl, wDudeNumItems
	ld de, .DudeItems
	call .CopyDudeData
	ld hl, wDudeNumMedicine
	ld de, .DudeMedicine
	call .CopyDudeData
	ld hl, wDudeNumBalls
	ld de, .DudeBalls
.CopyDudeData:
	ld a, [de]
	inc de
	ld [hli], a
	cp -1
	jr nz, .CopyDudeData
	ret

.Dude: ; 4e5da
	db "Lyra@"
.DudeItems:
	db 2, REPEL, 1, GOLD_LEAF, 1, -1
.DudeMedicine:
	db 3, POTION, 2, ANTIDOTE, 1, FRESH_WATER, 1, -1
.DudeBalls:
	db 2, POKE_BALL, 10, PREMIER_BALL, 1, -1

.AutoInput: ; 4e5df
	db NO_INPUT, $ff ; end
