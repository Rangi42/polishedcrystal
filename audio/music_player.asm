; Written by Sanqui
; https://github.com/froggestspirit/CrystalComplete/blob/master/misc/musicplayer.asm

INCLUDE "constants.asm"

MP_METER0 EQU $20
MP_METER8 EQU $28
MP_DUTY0 EQU $29


SECTION "Music Player Graphics", ROMX

MusicPlayerGFX:
INCBIN "gfx/music_player/music_player.2bpp.lz"

NotesGFX:
INCBIN "gfx/music_player/note_lines.2bpp.lz"


SECTION "Music Player", ROMX

jrbutton: MACRO
; assumes hl == hJoyPressed
	ld a, [hl]
	and \1
	jr nz, \2
ENDM

jpbutton: MACRO
; assumes hl == hJoyPressed
	ld a, [hl]
	and \1
	jmp nz, \2
ENDM

jrheldbutton: MACRO
; assumes hl == hJoyDown
	ld a, [wTextDelayFrames]
	and a
	jr nz, .no\@
	ld a, [hl]
	and \1
	jr z, .no\@
	ld a, \3
	ld [wTextDelayFrames], a
	jr \2
.no\@:
ENDM

jpheldbutton: MACRO
; assumes hl == hJoyDown
	ld a, [wTextDelayFrames]
	and a
	jr nz, .no\@
	ld a, [hl]
	and \1
	jr z, .no\@
	ld a, \3
	ld [wTextDelayFrames], a
	jmp \2
.no\@:
ENDM

MusicPlayerPals:
if !DEF(MONOCHROME)
; bg
	RGB 02, 03, 04
	RGB 02, 03, 04
	RGB 10, 12, 14
	RGB 26, 28, 30
; green
	RGB 02, 03, 04
	RGB 02, 03, 04
	RGB 06, 26, 06
	RGB 26, 28, 30
; blue
	RGB 02, 03, 04
	RGB 02, 03, 04
	RGB 07, 07, 31
	RGB 26, 28, 30
; red
	RGB 02, 03, 04
	RGB 02, 03, 04
	RGB 31, 07, 07
	RGB 26, 28, 30
else
rept 4
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
endr
endc

MusicPlayerNotePals:
if !DEF(MONOCHROME)
	RGB 02, 03, 04 ; bg
	RGB 06, 26, 06 ; green
	RGB 07, 07, 31 ; blue
	RGB 31, 07, 07 ; red
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
endc

MusicPlayer::
	call ClearTileMap

	ld a, LOW(LCDMusicPlayer)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDMusicPlayer)
	ldh [hFunctionTargetHi], a

; Load palette
	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [rSVBK]
	push af
	ld a, BANK(wBGPals2)
	ldh [rSVBK], a

	ld hl, MusicPlayerPals
	ld de, wBGPals2
	ld bc, 4 palettes
	rst CopyBytes

	ld hl, MusicPlayerNotePals
	ld de, wOBPals2
	ld bc, 1 palettes
	rst CopyBytes

	pop af
	ldh [rSVBK], a

; Apply palettes
	xor a
	hlcoord 0, 0, wAttrMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	hlcoord 3, 17, wAttrMap
	ld [hl], $3
	hlcoord 8, 17, wAttrMap
	ld [hl], $2
	hlcoord 12, 17, wAttrMap
	ld a, $1
	ld [hli], a
	ld [hl], a

	farcall ApplyAttrMapVBank0
	ld a, $1
	ldh [hCGBPalUpdate], a

	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	call DelayFrame

; Load graphics
	ld hl, MusicPlayerGFX
	ld de, vTiles2
	lb bc, BANK(MusicPlayerGFX), $45
	call DecompressRequest2bpp

	ld hl, NotesGFX
	ld de, vTiles0
	lb bc, BANK(NotesGFX), $80
	call DecompressRequest2bpp

	call DelayFrame

	ld hl, rLCDC
	set 7, [hl] ; lcd on
	ei

	call ClearSprites

; Initialize wMusicPlayerWRAM
	ld hl, wMusicPlayerWRAM
	ld bc, wMusicPlayerWRAMEnd - wMusicPlayerWRAM
	xor a
	rst ByteFill

; Clear wMPNotes
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMPNotes)
	ldh [rSVBK], a

	xor a
	ld hl, wMPNotes
	ld bc, 4 * 256
	rst ByteFill

	pop af
	ldh [rSVBK], a
; fallthrough

RenderMusicPlayer:
	ld bc, SCREEN_WIDTH * MP_HUD_HEIGHT
	ld hl, MPTilemap
	decoord 0, PIANO_ROLL_HEIGHT
	rst CopyBytes

	ld bc, 4 * 3
	ld hl, NoteOAM
	ld de, wVirtualOAM
	rst CopyBytes
	call DelayFrame
	xor a
	ldh [hOAMUpdate], a ; we will manually do it in LCD interrupt

	ld hl, wChannelSelectorSwitches
	ld a, NUM_MUSIC_CHANS - 1
.ch_label_loop:
	ld [wChannelSelector], a
	ld a, [hli]
	push hl
	call DrawChannelLabel
	pop hl
	ld a, [wChannelSelector]
	dec a
	cp -1
	jr nz, .ch_label_loop

	call DelayFrame

	ldh a, [rSVBK]
	ldh [hMPBuffer], a

	ld a, [wSongSelection]
	; let's see if a song is currently selected
	cp NUM_MUSIC_SONGS
	jr nc, .bad_selection
	and a
	jr nz, _RedrawMusicPlayer
.bad_selection
	ld a, MUSIC_MAIN_MENU
; fallthrough

_RedrawMusicPlayer:
	ld [wSongSelection], a
	ld a, -1
	ld [wChannelSelector], a
	call DrawPianoRollOverlay
; fallthrough

MusicPlayerLoop:
	ld a, BANK(wMPNotes)
	ldh [rSVBK], a

	call MPUpdateUIAndGetJoypad
	ld hl, hJoyDown
	jrheldbutton D_UP, .up, 12
	jrheldbutton D_DOWN, .down, 12
	jrheldbutton D_LEFT, .left, 12
	jrheldbutton D_RIGHT, .right, 12
	ld hl, hJoyPressed
	jrbutton A_BUTTON, .a
	jrbutton B_BUTTON, .b
	jrbutton START, .start
	jpbutton SELECT, .select

	; prioritize refreshing the note display
	ld a, 2
	ldh [hBGMapHalf], a
	jr MusicPlayerLoop

.left:
; previous song
	ld a, [wSongSelection]
	dec a
	jmp nz, _RedrawMusicPlayer
	ld a, NUM_MUSIC_SONGS - 1
	jmp _RedrawMusicPlayer

.right:
; next song
	ld a, [wSongSelection]
	inc a
	cp NUM_MUSIC_SONGS
	jmp nz, _RedrawMusicPlayer
	ld a, 1
	jmp _RedrawMusicPlayer

.down:
; 10 songs back
	ld a, [wSongSelection]
	sub MP_LIST_PAGE_SKIP
	jr z, .zerofix
	cp NUM_MUSIC_SONGS
	jmp c, _RedrawMusicPlayer
.zerofix
	ld a, NUM_MUSIC_SONGS - 1
	jmp _RedrawMusicPlayer

.up:
; 10 songs ahead
	ld a, [wSongSelection]
	add MP_LIST_PAGE_SKIP
	cp NUM_MUSIC_SONGS
	jmp c, _RedrawMusicPlayer
	ld a, 1
	jmp _RedrawMusicPlayer

.a:
; restart playing song
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	call PlayMusic2
	ld hl, wChLastNotes
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ld hl, wNoteEnded
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jmp MusicPlayerLoop

.b:
; exit music player
	xor a
	ldh [hMPState], a
	ldh [hVBlank], a
	ldh a, [hMPBuffer]
	ldh [rSVBK], a
	call ClearSprites
	ld hl, rLCDC
	res 2, [hl] ; 8x8 sprites
	ld hl, rIE
	res LCD_STAT, [hl]

	ld a, LOW(LCDGeneric)
	ldh [hFunctionTargetLo], a
	ld a, HIGH(LCDGeneric)
	ldh [hFunctionTargetHi], a
	ret

.start:
; open song selector
	xor a
	ldh [hMPState], a
	ldh a, [hMPBuffer]
	ldh [rSVBK], a
	call SongSelector
	jmp RenderMusicPlayer

.select:
	xor a
	ld [wChannelSelector], a
	hlcoord 3, MP_HUD_TOP
	ld [hl], "◀"
; fallthrough

SongEditor:
	call MPUpdateUIAndGetJoypad
	ld hl, hJoyDown
	jrheldbutton D_UP, .up, 10
	jpheldbutton D_DOWN, .down, 10
	ld hl, hJoyPressed
	jrbutton D_LEFT, .left
	jrbutton D_RIGHT, .right
	jrbutton A_BUTTON, .a
	jpbutton START, .start
	jpbutton SELECT | B_BUTTON, .select_b

	; prioritize refreshing the note display
	ld a, 2
	ldh [hBGMapHalf], a
	jr SongEditor

.left:
; previous editable field
	call ClearChannelSelector
	ld a, [wChannelSelector]
	dec a
	cp -1
	jr nz, .no_underflow
	ld a, NUM_MP_EDIT_FIELDS - 1 ; MP_EDIT_TEMPO
.no_underflow
	ld [wChannelSelector], a
	call DrawChannelSelector
	jr SongEditor

.right:
; next editable field
	call ClearChannelSelector
	ld a, [wChannelSelector]
	inc a
	cp NUM_MP_EDIT_FIELDS
	jr nz, .no_overflow
	xor a ; ld a, MP_EDIT_CH1
.no_overflow
	ld [wChannelSelector], a
	call DrawChannelSelector
	jr SongEditor

.a:
; for pitch: nothing
; for tempo: enter tempo adjustment mode
; otherwise: toggle editable field
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jr z, SongEditor
	cp MP_EDIT_TEMPO
	jmp z, AdjustTempo
	ld c, a
	ld b, 0
	ld hl, wChannelSelectorSwitches
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawChannelLabel
	jmp SongEditor

.up:
; for ch1/ch2: next duty cycle
; for wave: next waveform
; for noise: next noise set
; for pitch: increase pitch transposition
	ld a, [wChannelSelector]
	ld hl, .up_jumptable
	call JumpTable
	jmp SongEditor

.up_jumptable
	dw .up_ch1_2 ; MP_EDIT_CH1
	dw .up_ch1_2 ; MP_EDIT_CH2
	dw .up_wave  ; MP_EDIT_WAVE
	dw .up_noise ; MP_EDIT_NOISE
	dw .up_pitch ; MP_EDIT_PITCH
	dw DoNothing ; MP_EDIT_TEMPO

.down:
; for ch1/ch2: previous duty cycle
; for wave: previous waveform
; for noise: previous noise set
; for pitch: decrease pitch transposition
	ld a, [wChannelSelector]
	ld hl, .down_jumptable
	call JumpTable
	jmp SongEditor

.down_jumptable:
	dw .down_ch1_2 ; MP_EDIT_CH1
	dw .down_ch1_2 ; MP_EDIT_CH2
	dw .down_wave  ; MP_EDIT_WAVE
	dw .down_noise ; MP_EDIT_NOISE
	dw .down_pitch ; MP_EDIT_PITCH
	dw DoNothing   ; MP_EDIT_TEMPO

.start:
; toggle piano roll info overlay
	ld hl, wSongInfoSwitch
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawPianoRollOverlay
	jmp SongEditor

.select_b:
; exit song editor
	call ClearChannelSelector
	xor a ; ld a, MP_EDIT_CH1
	ld [wChannelSelector], a
	call DrawPitchTransposition
	call DrawTempoAdjustment
	jmp MusicPlayerLoop

.up_ch1_2:
; next duty cycle
	ld a, [wChannelSelector]
	ld [wTmpCh], a
	call GetDutyCycleAddr
	ld a, [hl]
	lb bc, %11000000, %01000000
	and b
	cp b
	ld a, [hl]
	jr nz, .no_ch1_2_overflow
	and %00111111
	sub c
.no_ch1_2_overflow
	add c
	jr .change_ch1_2

.down_ch1_2:
; previous duty cycle
	ld a, [wChannelSelector]
	ld [wTmpCh], a
	call GetDutyCycleAddr
	ld a, [hl]
	lb bc, %11000000, %01000000
	and b
	ld a, [hl]
	jr nz, .no_ch1_2_underflow
	add c
	and %00111111
.no_ch1_2_underflow
	sub c
.change_ch1_2:
	ld [hl], a
	ld [wCurTrackDuty], a
	ret

.up_wave:
; next waveform
	ld a, [wChannel3Intensity]
	and $f
	inc a
	cp NUM_WAVEFORMS
	jr nz, .change_wave
	xor a
	jr .change_wave

.down_wave:
; previous waveform
	ld a, [wChannel3Intensity]
	and $f
	dec a
	cp -1
	jr nz, .change_wave
	ld a, NUM_WAVEFORMS - 1
.change_wave:
	ld b, a
	ld a, [wChannel3Intensity]
	and $f0
	or b
	ld [wChannel3Intensity], a
	ld [wCurTrackIntensity], a
	farcall ReloadWaveform
	ret

.up_noise:
; next noise set
	ld a, [wMusicNoiseSampleSet]
	inc a
	cp NUM_NOISE_SETS
	jr nz, .change_noise
	xor a
	jr .change_noise

.down_noise:
; previous noise set
	ld a, [wMusicNoiseSampleSet]
	dec a
	cp -1
	jr nz, .change_noise
	ld a, NUM_NOISE_SETS - 1
.change_noise:
	ld [wMusicNoiseSampleSet], a
	ret

.up_pitch:
; increase pitch transposition
	ld a, [wPitchTransposition]
	inc a
	cp MAX_PITCH_TRANSPOSITION + 1
	jr nz, .change_pitch
	ld a, -MAX_PITCH_TRANSPOSITION
	jr .change_pitch

.down_pitch:
; decrease pitch transposition
	ld a, [wPitchTransposition]
	dec a
	cp -(MAX_PITCH_TRANSPOSITION + 1)
	jr nz, .change_pitch
	ld a, MAX_PITCH_TRANSPOSITION
.change_pitch:
	ld [wPitchTransposition], a
	call DrawPitchTransposition
	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	jmp DelayFrame

AdjustTempo:
	ld a, 1
	ld [wAdjustingTempo], a
	ld a, [wTempoAdjustment]
	ld [wTmpValue], a

	call DrawChannelSelector
	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	call DelayFrame

.loop:
	call MPUpdateUIAndGetJoypad
	ld hl, hJoyDown
	jrheldbutton D_UP, .up, 6
	jrheldbutton D_DOWN, .down, 6
	jrheldbutton D_RIGHT, .right, 18
	jrheldbutton D_LEFT, .left, 18
	ld hl, hJoyPressed
	jrbutton A_BUTTON, .a
	jrbutton B_BUTTON, .b
	jrbutton START, .start

	; prioritize refreshing the note display
	ld a, 2
	ldh [hBGMapHalf], a
	jr .loop

.up:
; increase tempo adjustment
	ld a, [wTempoAdjustment]
	inc a
	cp MAX_TEMPO_ADJUSTMENT + 1
	jr nz, .change_tempo
	ld a, -MAX_TEMPO_ADJUSTMENT
	jr .change_tempo

.down:
; decrease tempo adjustment
	ld a, [wTempoAdjustment]
	dec a
	cp -(MAX_TEMPO_ADJUSTMENT + 1)
	jr nz, .change_tempo
	ld a, MAX_TEMPO_ADJUSTMENT
	jr .change_tempo

.right:
; increase tempo adjustment by 10
	ld a, [wTempoAdjustment]
	cp MAX_TEMPO_ADJUSTMENT - 10 + 1
	jr c, .no_overflow_right
	cp -MAX_TEMPO_ADJUSTMENT
	jr nc, .no_overflow_right
	ld a, MAX_TEMPO_ADJUSTMENT - 10
.no_overflow_right
	add 10
	jr .change_tempo

.left:
; decrease tempo adjustment by 10
	ld a, [wTempoAdjustment]
	cp MAX_TEMPO_ADJUSTMENT + 1
	jr c, .no_underflow_left
	cp -(MAX_TEMPO_ADJUSTMENT - 10)
	jr nc, .no_underflow_left
	ld a, -(MAX_TEMPO_ADJUSTMENT - 10)
.no_underflow_left
	sub 10
.change_tempo:
	ld [wTempoAdjustment], a
	call DrawTempoAdjustment
	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	call DelayFrame
	jmp .loop

.a:
; apply tempo adjustment and exit tempo adjustment mode
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	call PlayMusic2
	jr .exit

.b:
; discard adjustment and exit tempo adjustment mode
	ld a, [wTmpValue]
	ld [wTempoAdjustment], a
.exit:
	xor a
	ld [wAdjustingTempo], a
	call DrawChannelSelector
	call DrawTempoAdjustment
	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	call DelayFrame
	jmp SongEditor

.start:
; toggle piano roll info overlay
	ld hl, wSongInfoSwitch
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawPianoRollOverlay
	jmp .loop

DrawPianoRollOverlay:
	; if this takes too long, don't let the user see blank fields blink in
	; disable copying the map during vblank
	ld a, 2
	ldh [hVBlank], a

	ld a, " "
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * PIANO_ROLL_HEIGHT
	rst ByteFill

	call DrawSongInfo
	call DrawChannelSelector

	ld a, 5
	ldh [hVBlank], a

	; refresh top two portions
	xor a
	ldh [hBGMapHalf], a
	jmp DelayFrame

DrawPitchTransposition:
	hlcoord 15, 1
	ld de, _EmptyPitchOrTempo
	rst PlaceString
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	ld a, [wPitchTransposition]
	jr z, .continue
	and a
	ret z
.continue
	ld [hl], "P" ; no-optimize *hl++|*hl-- = N
	inc hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	ld de, wPitchTransposition
	jr _PrintSignedNum

DrawTempoAdjustment:
	hlcoord 15, 2
	ld de, _EmptyPitchOrTempo
	rst PlaceString
	ld a, [wChannelSelector]
	cp MP_EDIT_TEMPO
	ld a, [wTempoAdjustment]
	jr z, .continue
	and a
	ret z
.continue
	ld [hl], "T" ; no-optimize *hl++|*hl-- = N
	inc hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	ld de, wTempoAdjustment
_PrintSignedNum:
	bit 7, a
	jr nz, .negative
	ld a, "+"
	jr .printnum
.negative
	cpl
	inc a
	ld de, wTmpValue
	ld [de], a
	ld a, "-"
.printnum
	ld [hli], a
	jmp PrintNum

_EmptyPitchOrTempo: db "     @"

DrawChannelSelector:
	call DrawPitchTransposition
	call DrawTempoAdjustment
	ld a, [wChannelSelector]
	cp -1
	ret z
	cp MP_EDIT_PITCH
	jr z, .pitch
	cp MP_EDIT_TEMPO
	jr z, .tempo
	call _LocateChannelSelector
	ld [hl], "◀"
	ret

.pitch:
	hlcoord 14, 1
	jr .draw
.tempo:
	hlcoord 14, 2
.draw
	ld a, [wAdjustingTempo]
	and a
	ld a, "▶"
	jr z, .ok
	ld a, "▷"
.ok
	ld [hl], a
	ret

ClearChannelSelector:
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jr z, .pitch
	cp MP_EDIT_TEMPO
	jr z, .tempo
	call _LocateChannelSelector
	ld [hl], $1e
	call DrawPitchTransposition
	jr DrawTempoAdjustment

.pitch:
	hlcoord 14, 1
	jr .clear
.tempo:
	hlcoord 14, 2
.clear
	ld [hl], " "
	ret

_LocateChannelSelector:
	ld c, 5
	call SimpleMultiply
	hlcoord 3, MP_HUD_TOP
	add l
	ld l, a
	ret nc
	inc h
	ret

DrawChannelLabel:
	and a
	jr nz, .off
	ld de, ChannelsOnTilemaps
	jr .draw
.off
	ld de, ChannelsOffTilemaps
.draw
	ld a, [wChannelSelector]
	ld l, a
	ld h, 0
	add hl, hl
	add l
	ld l, a
	add hl, de
	push hl

	hlcoord 0, MP_HUD_TOP
	ld a, [wChannelSelector]
	ld c, 5
	call SimpleMultiply
	ld e, a
	ld d, 0
	add hl, de
	push hl
	pop de
	pop hl
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	ret

DrawChData:
	hlcoord 0, MP_HUD_TOP + 1
.loop:
	ld [wTmpCh], a
	call _DrawCh1_2_3
	inc a
	ld de, 2
	add hl, de
	cp CHAN4
	jr c, .loop

	; channel 4
	hlcoord 18, MP_HUD_TOP + 1
	ld a, [wMusicNoiseSampleSet]
	add "0"
	ld [hl], a

	hlcoord 17, MP_HUD_TOP + 2
	ld a, [wChannelSelectorSwitches + CHAN4]
	and a
	jr nz, .blank_hit
	ld a, [wNoiseHit]
	and a
	ld a, MP_METER8
	jr nz, .got_hit
.blank_hit
	ld a, " "
.got_hit
	ld [hl], a
	xor a
	ld [wNoiseHit], a
	ret

_DrawCh1_2_3:
	push af
	push hl
	call CheckChannelOn
	ld a, 0
	jr c, .blank_note_name
	call GetPitchAddr
	ld a, [hl]
.blank_note_name
	add a
	ld e, a
	ld d, 0
	ld hl, NoteNames
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	push hl
	call GetOctaveAddr
	ld d, [hl]
	ld a, "8"
	sub d
	pop hl
	ld [hli], a

	ld a, [wTmpCh]
	cp CHAN3
	jr nc, .no_duty_cycle
	push hl
	ld de, SCREEN_WIDTH
	add hl, de
	push hl
	call GetDutyCycleAddr
	ld a, [hl]
	pop hl
	and %11000000
	swap a
	srl a
	srl a
	add MP_DUTY0
	ld [hl], a
	pop hl

.no_duty_cycle
	push hl
	dec hl
	dec hl
	dec hl
	ld a, MP_METER0
	ld de, SCREEN_WIDTH
	add hl, de
	ld [hli], a
	ld [hld], a

	push hl
	call CheckChannelOn
	pop hl
	ld a, 0
	jr c, .blank_volume
	push hl
	call GetPitchAddr
	ld a, [hl]
	and a
	pop hl
	ld a, 0
	jr z, .blank_volume
	push hl
	call GetIntensityAddr
	ld a, [hl]
	pop hl
.blank_volume
	and $f
	srl a
	add MP_METER0
	ld [hli], a
	ld [hld], a
	ld a, [wTmpCh]
	cp 2
	jr nz, .finish

	hlcoord 12, MP_HUD_TOP + 2
	; pick the waveform
	ld a, [wChannel3Intensity]
	and $f
	sla a
	add $2d
	ld [hli], a
	inc a
	ld [hl], a

.finish:
	pop hl
	pop af
	ret

DrawNotes:
	xor a ; ld a, CHAN1
	ld [wTmpCh], a
	call DrawNote
	call CheckForVolumeBarReset
	ld a, CHAN2
	ld [wTmpCh], a
	call DrawNote
	call CheckForVolumeBarReset
	ld a, CHAN3
	ld [wTmpCh], a
	call DrawNote
	call CheckForVolumeBarReset

	ldh a, [rSVBK]
	push af
	ld a, BANK(wMPNotes)
	ldh [rSVBK], a
	ldh a, [hMPState]
	inc a
	ldh [hMPState], a
	cp PIANO_ROLL_HEIGHT_PX + 1 + 1
	jr c, .skip
	ld a, 1
	ldh [hMPState], a
.skip
	dec a
	push af
	call .CopyNotes
	pop af
	add PIANO_ROLL_HEIGHT_PX
	call nc, .CopyNotes
	pop af
	ldh [rSVBK], a
	ret

.CopyNotes:
	ld bc, 4
	ld hl, wMPNotes
	rst AddNTimes
	ld d, h
	ld e, l
	ld hl, wPitchesTmp
	rst CopyBytes
	ret

CheckEndedNote:
; Check that the current channel is actually playing a note.

; Rests count as ends.
	call GetIntensityAddr
	ld a, [hl]
	and a
	jr z, _NoteEnded
; fallthrough

CheckNoteDuration:
	ld a, [wTmpCh]
	ld bc, wChannel2 - wChannel1

; Note duration
	ld hl, wChannel1NoteDuration
	rst AddNTimes
	ld a, [hl]
	cp 2
	jr c, _NoteEnded
; fallthrough

CheckChannelOn:
; Channel on/off flag
	ld a, [wTmpCh]
	ld bc, wChannel2 - wChannel1
	ld hl, wChannel1Flags
	rst AddNTimes
	bit SOUND_CHANNEL_ON, [hl]
	jr z, _NoteEnded

; Rest flag
; Note flags are wiped after each
; note is read, so this is pointless.
	ld a, [wTmpCh]
	ld hl, wChannel1NoteFlags
	rst AddNTimes
	bit SOUND_REST, [hl]
	jr nz, _NoteEnded

; Do an IO check too if the note's envelope is 0
; and not ramping up since the game handles rest
; notes by temporarily write 0 to hi nibble of NRx2
	ld a, [wTmpCh]
	cp 2
	jr nz, .notch3 ; NR32 does something different
	ldh a, [rNR32]
	and $60
	jr z, _NoteEnded ; 0% volume
	jr .still_going

.notch3
	ld bc, 5
	ld hl, rNR12
	rst AddNTimes
	ld a, [hl]
	ld b, a
	and $f0
	jr nz, .still_going
	ld a, b
	bit 3, a
	jr z, _NoteEnded ; ramping down
	and $7
	jr z, _NoteEnded ; no ramping
.still_going
	and a
	ret

_NoteEnded:
	scf
	ret

DrawNote:
	call CheckChannelOn
	jr c, _WriteBlankNote
	call GetPitchAddr
	ld a, [hl]
	and a
	jr z, _WriteBlankNote ; rest
	inc hl
	ld a, [hld] ; octave
	ld c, 14
	call SimpleMultiply
	add [hl] ; pitch
	ld b, a
	ld hl, wChLastNotes
	ld a, [wTmpCh]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	cp b
	jr z, DrawLongerNote
DrawChangedNote:
	ld [hl], b
	call SetVisualIntensity
DrawNewNote:
	call GetPitchAddr
	push hl
	inc hl
	ld a, [hl]
	xor $f ; octaves are in reverse order
	sub $8
	ld bc, 28
	ld hl, 8
	rst AddNTimes
	ld b, l
	pop hl
	ld a, [hl]
	dec a
	ld hl, .Pitchels
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	add b
	ld c, a
	jr WriteNotePitch

.Pitchels:
	db 1, 3, 5, 7, 9, 13, 15, 17, 19, 21, 23, 25, 27

DrawLongerNote:
	ld a,[wTmpCh]
	ld hl, wChannel1Intensity
	ld bc, wChannel2 - wChannel1
	rst AddNTimes
	ld a, [hl]
	and $f
	cp $9
	jr nc, .fading_up
	call CheckEndedNote
	jr nc, DrawNewNote
	jr _WriteBlankNote

.fading_up
	call CheckNoteDuration
	jr nc, DrawNewNote
	; fallthrough

_WriteBlankNote:
	xor a
	ld c, a

WriteNotePitch:
	ld hl, wPitchesTmp
	ld a, [wTmpCh]
	ld e, a
	ld d, 0
	add hl, de
	ld a, c
	ld [hl], a
	ret

CheckForVolumeBarReset:
	call CheckNoteDuration
	jr c, .note_ended ; not a new note, but this note just ended!
	ld hl, wNoteEnded
	ld a, [wTmpCh]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	and a
	ret z ; also not a new note
	xor a ; new note!
	ld [hl], a
	ret

.note_ended:
	ld hl, wNoteEnded
	ld a, [wTmpCh]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], 1
	ld hl, wChLastNotes
	add hl, de
	xor a
	ld [hl], a
	ret

SetVisualIntensity:
	ld a,[wTmpCh]
	ld hl, wChannel1Pitch
	ld bc, wChannel2 - wChannel1
	rst AddNTimes
	ld a, [hl]
	and a
	jr z, .skip
	ld a,[wTmpCh]
	ld hl, wChannel1Intensity
	ld bc, wChannel2 - wChannel1
	push af
	rst AddNTimes
	pop af
	cp 2
	jr z, .wave_channel
	ld a, [hl]
	ld e, a
	swap a
	and $f
	ld d, a
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	rst AddNTimes
	ld a, d
	ldi [hl], a
	ld a, e
	and $f
	ld e, a
	swap a
	or e
	and $f7
	ld [hl], a
	ret

.wave_channel:
	ld a, [hl]
	and $f0
	cp $10
	jr z, .full
	cp $20
	jr z, .half
	cp $30
	jr z, .quarter
	xor a
	jr .set_wave_vol
.full
	ld a, $f
	jr .set_wave_vol
.half
	ld a, $7
	jr .set_wave_vol
.quarter
	ld a, $3
.set_wave_vol
	ld hl, wC3Vol
	ld [hl], a
	ret

.skip:
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	rst AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

UpdateVisualIntensity:
	ld c, 4
	ld hl, wVolTimer
	ld a, [hl]
	sub 60
	ld [hl], a
	ret nc
	add 64
	ldi [hl], a
.update_channels:
	inc hl
	ld a, [hld]
	ld b, a
	and $7f
	jr z, .next_channel
	ld a, b
	dec a
	ld b, a
	and $f
	jr z, .change_envelope
	inc hl
	jr .done_ch
.change_envelope
	ld a, b
	swap a
	or b
	and $f7
	ld b, a
	ld a, [hl]
	bit 7, b
	jr nz, .increase
	dec a
	bit 7, a
	jr z, .done_inc
	xor a
	jr .done_inc
.increase
	inc a
	bit 4, a
	jr z, .done_inc
	ld a, $f
.done_inc
	ld [hli], a
.done_ch:
	ld a, b
	ld [hld], a
.next_channel
	inc hl
	inc hl
	dec c
	ret z
	ld a, c
	cp 2
	jr z, .next_channel
	jr .update_channels

AddNoteToOld:
	push hl
	ld a, [wNumNoteLines]
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, wVirtualOAM + 3 * 4
	add hl, bc
	push hl
	pop de
	pop hl
rept 3
	ld a, [hli]
	ld [de], a
	inc de
endr
	ld a, [hl]
	ld [de], a

	ld a, [wNumNoteLines]
	inc a
	cp $25
	jr nz, .finish
	xor a
.finish
	ld [wNumNoteLines], a
	ret

GetPitchAddr:
	ld hl, wChannel1Pitch
	jr _GetChannelMemberAddr

GetOctaveAddr:
	ld hl, wChannel1Octave
	jr _GetChannelMemberAddr

GetDutyCycleAddr:
	ld hl, wChannel1DutyCycle
_GetChannelMemberAddr:
	ld a, [wTmpCh]
	ld bc, wChannel2 - wChannel1
	rst AddNTimes
	ret

GetIntensityAddr:
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	rst AddNTimes
	ret

GetSongInfo:
	ld a, [wSongSelection]
	ld b, a
	ld c, 0
	ld hl, SongInfo
.loop:
	ld a, [hl]
	cp -1
	jr z, .no_name
	inc c
	ld a, c
	cp b
	jr z, .found
.loop2:
	ld a, [hli]
	cp "@"
	jr z, .nextline
	jr .loop2
.found
	xor a
	ret
.nextline
	inc hl
	inc hl
	inc hl
	jr .loop

.no_name:
	scf
	ret

DrawSongInfo:
	ld a, [wSongSelection]
	call GetSongInfo
	ret c ; no data

	ld a, [wSongInfoSwitch]
	and a
	jr z, .info
	hlcoord 0, 1
	jr DrawSongID

.info:
	call GetSongTitle
	hlcoord 0, 3
	rst PlaceString
	inc de

	push de
	call GetSongOrigin
	hlcoord 0, 1
	push de
	call DrawSongID
	pop de
	inc hl
	rst PlaceString
	pop de
	inc de

	push de
	call GetSongArtist
	hlcoord 0, 7
	rst PlaceString
	pop de
	inc de

	push de
	call GetSongArtist2
	hlcoord 0, 10
	rst PlaceString
	pop de
	ret

DrawSongID:
	ld a, "<SHARP>"
	ld [hli], a
	ld a, [wSongSelection]
	cp 10
	jr c, .print_digit
	lb bc, 1, 2
	cp 100
	jr c, .print_id
	lb bc, 1, 3
.print_id
	ld de, wSongSelection
	jmp PrintNum

.print_digit
	add "0"
	ld [hli], a
	ret

GetSongOrigin:
	ld a, [de]
	ld hl, SongOrigins
	call GetNthString
GetSongTitle:
	push hl
	pop de
	ret

GetSongArtist:
	ld a, [de]
	ld hl, SongArtists
	call GetNthString
	push hl
	ld de, .Composer
	hlcoord 0, 6
	rst PlaceString
	pop de
	ret

.Composer:
	db "Composer:@"

GetSongArtist2:
	ld a, [de]
	ld hl, SongArtists
	call GetNthString
	push hl
	ld a, [hl]
	cp "@"
	jr z, .finish
	ld de, .Arranger
	hlcoord 0, 9
	rst PlaceString
.finish
	pop de
	ret

.Arranger:
	db "Arranger:@"

SongSelector:
	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	rst ByteFill
	ld hl, rLCDC
	res 1, [hl] ; hide sprites
	call ClearSprites

	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox

	hlcoord 0, MP_LIST_CURSOR_Y
	ld [hl], "▶"
	ld a, [wSongSelection]
	ld [wSelectorTop], a ; backup, in case of B button
	cp MP_LIST_CURSOR_Y
	jr nc, .ok
	add NUM_MUSIC_SONGS - 1
.ok
	sub MP_LIST_CURSOR_Y - 1
	ld [wSongSelection], a
	call UpdateSelectorNames

.loop:
	call DelayFrame
	call MPGetJoypad
	ld hl, hJoyDown
	jrheldbutton D_UP, .up, 6
	jrheldbutton D_DOWN, .down, 6
	jrheldbutton D_LEFT, .left, 18
	jrheldbutton D_RIGHT, .right, 18
	ld hl, hJoyPressed
	jrbutton A_BUTTON, .a
	jrbutton START | B_BUTTON, .start_b
	jr .loop

.a:
; select song
	ld a, [wSongSelection]
	cp NUM_MUSIC_SONGS - MP_LIST_CURSOR_Y + 1
	jr c, .no_overflow
	sub NUM_MUSIC_SONGS - MP_LIST_CURSOR_Y
	jr .got_song
.no_overflow
	add MP_LIST_CURSOR_Y - 1
.got_song
	ld e, a
	ld d, 0
	call PlayMusic2
	jr .finish

.up
; previous song
	ld a, [wSongSelection]
	dec a
	jr nz, .no_underflow_up
	ld a, NUM_MUSIC_SONGS - 1
.no_underflow_up
	ld [wSongSelection], a
	call UpdateSelectorNames
	jmp .loop

.down:
; next song
	ld a, [wSongSelection]
	inc a
	cp NUM_MUSIC_SONGS
	jr nz, .no_overflow_down
	ld a, 1
.no_overflow_down
	ld [wSongSelection], a
	call UpdateSelectorNames
	jmp .loop

.left:
; 10 songs back
	ld a, [wSongSelection]
	cp MP_LIST_PAGE_SKIP + 1
	jr nc, .no_underflow_left
	add NUM_MUSIC_SONGS - 1
.no_underflow_left
	sub MP_LIST_PAGE_SKIP
	ld [wSongSelection], a
	call UpdateSelectorNames
	jmp .loop

.right:
; 10 songs ahead
	ld a, [wSongSelection]
	cp NUM_MUSIC_SONGS - MP_LIST_PAGE_SKIP
	jr c, .no_overflow_right
	sub NUM_MUSIC_SONGS - 1
.no_overflow_right
	add MP_LIST_PAGE_SKIP
	ld [wSongSelection], a
	call UpdateSelectorNames
	jmp .loop

.start_b:
; exit song selector
	ld a, [wSelectorTop]
.finish:
	ld [wSongSelection], a
	ld hl, rLCDC
	set 1, [hl] ; show sprites
	ret

UpdateSelectorNames:
	call GetSongInfo
	ld a, [wSongSelection]
	ld c, a
	ld b, 0
	push hl
	pop de
.loop:
	hlcoord 1, 1
	ld a, c
	ld [wSelectorCur], a
	push bc
	ld a, b
	ld bc, SCREEN_WIDTH
	rst AddNTimes
	call MPLPlaceString
rept 4
	inc de
endr
	pop bc
	inc b
	inc c
	ld a, c
	cp NUM_MUSIC_SONGS
	jr c, .noOverflow
	ld c, 1
	ld de, SongInfo
.noOverflow
	ld a, b
	cp 16 ; songs per page
	jr nz, .loop
	ret

MPUpdateUIAndGetJoypad:
	call UpdateVisualIntensity
	call DelayFrame
	call DrawChData
	call DrawNotes
MPGetJoypad:
	ld a, [wTextDelayFrames]
	and a
	jr z, .ok2
	dec a
	ld [wTextDelayFrames], a
.ok2
	jmp GetJoypad

MPLPlaceString:
	push hl
	ld a, " "
	ld hl, wStringBuffer2
	ld bc, 3
	rst ByteFill
	ld hl, wStringBuffer2
	push de
	ld de, wSelectorCur
	lb bc, 1, 3
	call PrintNum
	pop de
	ld a, " "
	ld [hli], a
	push hl
	push de
	rst PlaceString
	ld h, b
	ld l, c
	ld [hl], "@"
	pop de
	pop hl
.de_loop
	ld a, [de]
	inc de
	cp "@"
	jr nz, .de_loop
	dec de
	ld bc, 0
.loop
	inc c
	ld a, [hli]
	cp "@"
	jr nz, .loop
	ld a, c
	cp 16
	jr nc, .overflow
	dec hl
	ld a, 15
	sub c
	jr z, .ok
.loop2
	ld [hl], " " ; no-optimize *hl++|*hl-- = N
	inc hl
	dec a
	jr nz, .loop2
	ld [hl], "@"
	jr .ok
.overflow
	ld bc, 17
	ld hl, wStringBuffer2
	add hl, bc
	ld a, "…"
	ld [hli], a
	ld [hl], "@"
.ok
	pop hl
	push de
	ld de, wStringBuffer2
	rst PlaceString
	pop de
	ret

MPTilemap:
INCBIN "gfx/music_player/music_player.tilemap"
ChannelsOnTilemaps:
INCBIN "gfx/music_player/channels_on.tilemap"
ChannelsOffTilemaps:
INCBIN "gfx/music_player/channels_off.tilemap"

NoteOAM:
	; y, x, tile id, OAM attributes
	db 0, 0, $20, PRIORITY
	db 0, 0, $40, PRIORITY
	db 0, 0, $60, PRIORITY

INCLUDE "data/music_player/notes.asm"
INCLUDE "data/music_player/song_info.asm"
INCLUDE "data/music_player/song_origins.asm"
INCLUDE "data/music_player/song_artists.asm"
