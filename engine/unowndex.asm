UpdateUnownDex: ; fba18
	ld a, [wMonVariant]
	ld c, a
	ld b, NUM_UNOWN
	ld hl, wUnownDex
.loop
	ld a, [hli]
	and a
	jr z, .done
	cp c
	ret z
	dec b
	jr nz, .loop
	ret

.done
	dec hl
	ld [hl], c
	ret
; fba2e


PrintUnownWord: ; fba2e (3e:7a2e)
	hlcoord 4, 15
	ld bc, 12
	ld a, " "
	call ByteFill
	ld a, [wDexCurrentUnownIndex]
	ld e, a
	ld d, 0
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld e, a
	ld d, 0
	ld hl, UnownWords
rept 2
	add hl, de
endr
	ld a, [hli]
	ld e, a
	ld d, [hl]
	hlcoord 4, 15
.loop
	ld a, [de]
	cp "@"
	ret z
	inc de
	ld [hli], a
	jr .loop
; fba5a (3e:7a5a)

UnownWords: ; fba5a
	dw UnownWord1
	dw UnownWord1
	dw UnownWord2
	dw UnownWord3
	dw UnownWord4
	dw UnownWord5
	dw UnownWord6
	dw UnownWord7
	dw UnownWord8
	dw UnownWord9
	dw UnownWord10
	dw UnownWord11
	dw UnownWord12
	dw UnownWord13
	dw UnownWord14
	dw UnownWord15
	dw UnownWord16
	dw UnownWord17
	dw UnownWord18
	dw UnownWord19
	dw UnownWord20
	dw UnownWord21
	dw UnownWord22
	dw UnownWord23
	dw UnownWord24
	dw UnownWord25
	dw UnownWord26
	dw UnownWord27
	dw UnownWord28
; fba90

UnownWord1:  db "ANGER@"
UnownWord2:  db "BEAR@"
UnownWord3:  db "CHASE@"
UnownWord4:  db "DIRECT@"
UnownWord5:  db "ENGAGE@"
UnownWord6:  db "FIND@"
UnownWord7:	 db "GIVE@"
UnownWord8:  db "HELP@"
UnownWord9:  db "INCREASE@"
UnownWord10: db "JOIN@"
UnownWord11: db "KEEP@"
UnownWord12: db "LAUGH@"
UnownWord13: db "MAKE@"
UnownWord14: db "NUZZLE@"
UnownWord15: db "OBSERVE@"
UnownWord16: db "PERFORM@"
UnownWord17: db "QUICKEN@"
UnownWord18: db "REASSURE@"
UnownWord19: db "SEARCH@"
UnownWord20: db "TELL@"
UnownWord21: db "UNDO@"
UnownWord22: db "VANISH@"
UnownWord23: db "WANT@"
UnownWord24: db "XXXXX@"
UnownWord25: db "YIELD@"
UnownWord26: db "ZOOM@"
UnownWord27: db "!!!!!@"
UnownWord28: db "?????@"
; fbb32
