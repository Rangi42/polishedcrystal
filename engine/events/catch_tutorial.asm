CatchTutorial::
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
	ldh [hJoyDown], a
	ldh [hJoyPressed], a

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

.LoadDudeData:
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

.Dude:
	db "Lyra@"
.DudeItems:
	db 2, REPEL, 1, GOLD_LEAF, 1, -1
.DudeMedicine:
	db 3, POTION, 2, ANTIDOTE, 1, FRESH_WATER, 1, -1
.DudeBalls:
	db 2, POKE_BALL, 10, PREMIER_BALL, 1, -1

.AutoInput:
	db NO_INPUT, $ff ; end
