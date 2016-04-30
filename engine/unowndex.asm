UpdateUnownDex: ; fba18
	ld a, [UnownLetter]
	ld c, a
	ld b, 26
	ld hl, UnownDex
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
	ld hl, UnownDex
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
	cp -1
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
; fba90

unownword: macro
x = 1
	rept STRLEN(\1)
	db STRSUB(\1, x, 1) - $40
x = x + 1
	endr
	db -1
endm


UnownWord1:	 unownword "Angry"
UnownWord2:	 unownword "Bear"
UnownWord3:	 unownword "Chase"
UnownWord4:	 unownword "Direct"
UnownWord5:	 unownword "Engage"
UnownWord6:	 unownword "Find"
UnownWord7:	 unownword "Give"
UnownWord8:	 unownword "Help"
UnownWord9:	 unownword "Increase"
UnownWord10: unownword "Join"
UnownWord11: unownword "Keep"
UnownWord12: unownword "Laugh"
UnownWord13: unownword "Make"
UnownWord14: unownword "Nuzzle"
UnownWord15: unownword "Observe"
UnownWord16: unownword "Perform"
UnownWord17: unownword "Quicken"
UnownWord18: unownword "Reassure"
UnownWord19: unownword "Search"
UnownWord20: unownword "Tell"
UnownWord21: unownword "Undo"
UnownWord22: unownword "Vanish"
UnownWord23: unownword "Want"
UnownWord24: unownword "XXXXX"
UnownWord25: unownword "Yield"
UnownWord26: unownword "Zoom"
; fbb32
