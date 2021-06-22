ClearJoypad::
	xor a
; Pressed this frame (delta)
	ldh [hJoyPressed], a
; Currently pressed
	ldh [hJoyDown], a
	ret

Joypad::
; Read the joypad register and translate it to something more
; workable for use in-game. There are 8 buttons, so we can use
; one byte to contain all player input.

; Updates:

; hJoypadReleased: released this frame (delta)
; hJoypadPressed: pressed this frame (delta)
; hJoypadDown: currently pressed
; hJoypadSum: pressed so far

; Any of these three bits can be used to disable input.
	ld a, [wInputFlags]
	and %11010000
	ret nz

; If we're saving, input is disabled.
	ld a, [wGameLogicPaused]
	and a
	ret nz

; We can only get four inputs at a time.
; We take d-pad first for no particular reason.
	ld a, R_DPAD
	ldh [rJOYP], a
; Read twice to give the request time to take.
	ldh a, [rJOYP]
	ldh a, [rJOYP]

; The Joypad register output is in the lo nybble (inversed).
; We make the hi nybble of our new container d-pad input.
	cpl
	and $f
	swap a

; We'll keep this in b for now.
	ld b, a

; Buttons make 8 total inputs (A, B, Select, Start).
; We can fit this into one byte.
	ld a, R_BUTTONS
	ldh [rJOYP], a
; Wait for input to stabilize.
rept 6
	ldh a, [rJOYP]
endr
; Buttons take the lo nybble.
	cpl
	and $f
	or b
	ld b, a

; Reset the joypad register since we're done with it.
	ld a, $30
	ldh [rJOYP], a

; To get the delta we xor the last frame's input with the new one.
	ldh a, [hJoypadDown] ; last frame
	ld e, a
	xor b
	ld d, a
; Released this frame:
	and e
	ldh [hJoypadReleased], a
; Pressed this frame:
	ld a, d
	and b
	ldh [hJoypadPressed], a

; Add any new presses to the list of collective presses:
	ld c, a
	ldh a, [hJoypadSum]
	or c
	ldh [hJoypadSum], a

; Currently pressed:
	ld a, b
	ldh [hJoypadDown], a

; Now that we have the input, we can do stuff with it.

; For example, soft reset:
	and A_BUTTON | B_BUTTON | SELECT | START
	cp  A_BUTTON | B_BUTTON | SELECT | START
	jmp z, SoftReset

	ret

GetJoypad::
; Update mirror joypad input from hJoypadDown (real input)

; hJoyReleased: released this frame (delta)
; hJoyPressed: pressed this frame (delta)
; hJoyDown: currently pressed

; bit 0 A
;     1 B
;     2 SELECT
;     3 START
;     4 RIGHT
;     5 LEFT
;     6 UP
;     7 DOWN

	push hl
	push de
	push bc
	push af

; The player input can be automated using an input stream.
; See more below.
	ld a, [wInputType]
	cp AUTO_INPUT
	jr z, .auto

; To get deltas, take this and last frame's input.
	ldh a, [hJoypadDown] ; real input
	ld b, a
	ldh a, [hJoyDown] ; last frame mirror
	ld e, a

; Released this frame:
	xor b
	ld d, a
	and e
	ldh [hJoyReleased], a

; Pressed this frame:
	ld a, d
	and b
	ldh [hJoyPressed], a

; It looks like the collective presses got commented out here.
	ld c, a

; Currently pressed:
	ld a, b
	ldh [hJoyDown], a ; frame input

.quit
	jmp PopAFBCDEHL

.auto
; Use a predetermined input stream (used in the catching tutorial).

; Stream format: [input][duration]
; A value of $ff will immediately end the stream.

; Read from the input stream.
	ldh a, [hROMBank]
	push af
	ld a, [wAutoInputBank]
	rst Bankswitch

	ld hl, wAutoInputAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a

; We only update when the input duration has expired.
	ld a, [wAutoInputLength]
	and a
	jr z, .updateauto

; Until then, don't change anything.
	dec a
	ld [wAutoInputLength], a
	pop af
	rst Bankswitch
	jr .quit

.updateauto
; An input of $ff will end the stream.
	ld a, [hli]
	cp -1
	jr z, .stopauto
	ld b, a

; A duration of $ff will end the stream indefinitely.
	ld a, [hli]
	ld [wAutoInputLength], a
	cp -1
	jr nz, .next

; The current input is overwritten.
	dec hl
	dec hl
	ld b, NO_INPUT
	jr .finishauto

.next
; On to the next input...
	ld a, l
	ld [wAutoInputAddress], a
	ld a, h
	ld [wAutoInputAddress+1], a
	jr .finishauto

.stopauto
	call StopAutoInput
	ld b, NO_INPUT

.finishauto
	pop af
	rst Bankswitch
	ld a, b
	ldh [hJoyPressed], a ; pressed
	ldh [hJoyDown], a ; input
	jr .quit

StartAutoInput::
; Start reading automated input stream at a:hl.

	ld [wAutoInputBank], a
	ld a, l
	ld [wAutoInputAddress], a
	ld a, h
	ld [wAutoInputAddress+1], a
; Start reading the stream immediately.
	xor a
	ld [wAutoInputLength], a
; Reset input mirrors.
	xor a
	ldh [hJoyPressed], a ; pressed this frame
	ldh [hJoyReleased], a ; released this frame
	ldh [hJoyDown], a ; currently pressed

	ld a, AUTO_INPUT
	ld [wInputType], a
	ret

StopAutoInput::
; Clear variables related to automated input.
	xor a
	ld [wAutoInputBank], a
	ld [wAutoInputAddress], a
	ld [wAutoInputAddress+1], a
	ld [wAutoInputLength], a
; Back to normal input.
	ld [wInputType], a
	ret

JoyWaitAorB::
.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and A_BUTTON | B_BUTTON
	ret nz
	call CheckAutoscroll
	ret nz
	call RTC
	jr .loop

CheckIfAOrBPressed:
	call JoyTextDelay
	ldh a, [hJoyLast]
_Autoscroll:
	and A_BUTTON | B_BUTTON
	ret nz
	; fallthrough
CheckAutoscroll:
; Returns nz if we should autoscroll
	ld a, [wOptions1]
	and AUTOSCROLL_MASK
	ret z

	cp AUTOSCROLL_START
	ldh a, [hJoyDown]
	jr z, .start

	; Check A+B. If both are held, autoscroll for both A&B and A|B.
	; Otherwise, autoscroll if the option is set to A or B, not A and B
	and A_BUTTON | B_BUTTON
	ret z
	cp A_BUTTON | B_BUTTON
	jr z, _Autoscroll
	ld a, [wOptions1]
	; nz if AORB, z if AANDB
	and %100
	ret

.start
	and START
	ret

Script_waitbutton::
WaitButton::
	ldh a, [hOAMUpdate]
	push af
	ld a, 1
	ldh [hOAMUpdate], a
	call ApplyTilemapInVBlank
	call JoyWaitAorB
	pop af
	ldh [hOAMUpdate], a
	ret

JoyTextDelay::
	call GetJoypad
	ldh a, [hInMenu]
	and a
	ldh a, [hJoyPressed]
	jr z, .ok
	ldh a, [hJoyDown]
.ok
	ldh [hJoyLast], a
	ldh a, [hJoyPressed]
	and a
	jr z, .checkframedelay
	ld a, 15
	ld [wTextDelayFrames], a
	ret

.checkframedelay
	ld a, [wTextDelayFrames]
	and a
	jr z, .restartframedelay
	xor a
	ldh [hJoyLast], a
	ret

.restartframedelay
	ld a, 5
	ld [wTextDelayFrames], a
	ret

WaitPressAorB_BlinkCursor::
	ldh a, [hMapObjectIndexBuffer]
	push af
	ldh a, [hObjectStructIndexBuffer]
	push af
	xor a
	ldh [hMapObjectIndexBuffer], a
	ld a, 6
	ldh [hObjectStructIndexBuffer], a

.loop
	push hl
	hlcoord 18, 17
	call BlinkCursor
	pop hl

	call CheckIfAOrBPressed
	jr z, .loop

	pop af
	ldh [hObjectStructIndexBuffer], a
	pop af
	ldh [hMapObjectIndexBuffer], a
	ret

SimpleWaitPressAorB::
.loop
	call CheckIfAOrBPressed
	ret nz
	call DelayFrame
	jr .loop

ButtonSound::
	ld a, [wLinkMode]
	and a
	jr nz, .link
	call .wait_input
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

.link
	ld c, 65
	jmp DelayFrames

.wait_input
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a
	ld a, [wInputType]
	or a
	jr z, .input_wait_loop
	ld hl, .autoinput_a
	ld a, BANK(.autoinput_a)
	call StartAutoInput

.input_wait_loop
	call .blink_cursor
	call CheckIfAOrBPressed
	jr nz, .received_input
	call RTC
	ld a, $1
	ldh [hBGMapMode], a
	call DelayFrame
	jr .input_wait_loop

.received_input
	pop af
	ldh [hOAMUpdate], a
	ret

.autoinput_a
	db NO_INPUT, $50
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end

.blink_cursor
	ldh a, [hVBlankCounter]
	and %00010000 ; bit 4, a
	ld a, "▼"
	jr nz, .load_cursor_state
	ld a, [wTileMap + 17 + 17 * SCREEN_WIDTH]
.load_cursor_state
	ld [wTileMap + 18 + 17 * SCREEN_WIDTH], a
	ret

BlinkCursor::
	push bc
	ld a, [hl]
	ld b, a
	ld a, "▼"
	cp b
	pop bc
	jr nz, .place_arrow
	ldh a, [hMapObjectIndexBuffer]
	dec a
	ldh [hMapObjectIndexBuffer], a
	ret nz
	ldh a, [hObjectStructIndexBuffer]
	dec a
	ldh [hObjectStructIndexBuffer], a
	ret nz
	ld [hl], "─"
	ld a, -1
	ldh [hMapObjectIndexBuffer], a
	ld a, 6
	ldh [hObjectStructIndexBuffer], a
	ret

.place_arrow
	ldh a, [hMapObjectIndexBuffer]
	and a
	ret z
	dec a
	ldh [hMapObjectIndexBuffer], a
	ret nz
	dec a
	ldh [hMapObjectIndexBuffer], a
	ldh a, [hObjectStructIndexBuffer]
	dec a
	ldh [hObjectStructIndexBuffer], a
	ret nz
	ld a, 6
	ldh [hObjectStructIndexBuffer], a
	ld [hl], "▼"
	ret
