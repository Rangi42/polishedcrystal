; 	Shows a menu to set pokewalker val
Pokewalker:
	call LoadStandardMenuHeader
	ld hl, .SetBadgeFreqText
	call MenuTextbox
	ld hl, Pokewalker_MenuHeader
	call LoadMenuHeader
	; loop with joypad input
	jr SetBadgeFreqLoop
	call ExitMenu
	jr nc, .done

.done:
	and a
	ret

.SetBadgeFreqText:
	text "Set badge"
	line "frequency"
	done

SetBadgeFreqLoop:
	ld a, [wPokewalker]
	ld [wPokewalkerChangeBuffer], a
	call GetNumBadges
.loop
	call Pokewalker_UpdateQuantityDisplay
	call Pokewalker_InterpretJoypad
	jr nc, .loop
	cp -1
	jr nz, .nope ; pressed B
	scf
	ret

.nope
	and a
	ret

Pokewalker_InterpretJoypad:
	call JoyTextDelay_ForcehJoyDown
	bit B_BUTTON_F, c
	jr nz, .b
	bit A_BUTTON_F, c
	jr nz, .a
	bit D_DOWN_F, c
	jr nz, .dec
	bit D_LEFT_F, c
	jr nz, .dec
	bit D_UP_F, c
	jr nz, .inc
	bit D_RIGHT_F, c
	jr nz, .inc
	and a
	ret

.b
	ld a, -1
	scf
	ret

.a
	ld a, [wPokewalkerChangeBuffer]
	ld [wPokewalker], a
	xor a
	scf
	ret

.dec
    ld hl, wPokewalkerChangeBuffer
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done_dec
	ld a, [wNumSetBits] ; num badges
	ld [hl], a

.done_dec
	and a
	ret

.inc
	ld hl, wPokewalkerChangeBuffer
	inc [hl]
	ld a, [wNumSetBits] ; num badges
	cp [hl]
	jr nc, .done_inc
	ld [hl], 0

.done_inc
	and a
	ret

Pokewalker_UpdateQuantityDisplay:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	inc hl
	ld de, wPokewalkerChangeBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	dec hl
	ld a, [wMenuDataPointer]
	ld e, a
	ld a, [wMenuDataPointer + 1]
	ld d, a
	ld a, [wMenuDataBank]
	jmp FarCall_de

Pokewalker_MenuHeader:
	db $48 ; flags
	db 09, 15 ; start coords
	db 11, 19 ; end coords
	dw DoNothing
	db 0 ; default option

GetNumBadges:
	ld hl, wBadges
	ld b, wBadgesEnd - wBadges
	call CountSetBits
	ret
