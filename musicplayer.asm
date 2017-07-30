; Written by Sanqui
; https://github.com/froggestspirit/CrystalComplete/blob/master/misc/musicplayer.asm

INCLUDE "includes.asm"


SECTION "Music Player Graphics", ROMX

MusicTestGFX:
INCBIN "gfx/music_player/music_test.2bpp"
PianoGFX:
INCBIN "gfx/music_player/piano.2bpp"
NotesGFX:
INCBIN "gfx/music_player/note_lines.2bpp"


SECTION "Music Player", ROMX

jrbutton: MACRO
	ld a, [hJoyPressed]
	and \1
	jr nz, \2
	ENDM

jpbutton: MACRO
	ld a, [hJoyPressed]
	and \1
	jp nz, \2
	ENDM

MPLoadPalette:
	ld a, [rSVBK]
	push af
	ld a, 5
	ld [rSVBK], a

	ld hl, .PlayerPals
	ld de, BGPals
	ld bc, 1 palettes
	call CopyBytes

	ld hl, .NotePals
	ld de, OBPals
	ld bc, 1 palettes
	call CopyBytes

	pop af
	ld [rSVBK], a

; Request palette update
	ld a, 1
	ld [hCGBPalUpdate], a
	ret

.PlayerPals:
if !DEF(MONOCHROME)
	RGB 02, 03, 04
	RGB 02, 03, 04
	RGB 26, 28, 30
	RGB 26, 28, 30
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc

.NotePals:
if !DEF(MONOCHROME)
	RGB 02, 03, 04 ; bg
	RGB 07, 31, 07 ; green
	RGB 07, 07, 31 ; blue
	RGB 31, 07, 07 ; red
else
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
endc

MusicPlayer::
	di
	call DoubleSpeed
	xor a
	ld [rIF], a
	ld a, $f
	ld [rIE], a
	ei

	call ClearTileMap
	call MPLoadPalette

	xor a
	ld [hBGMapThird], a
	call DelayFrame

	ld de, MusicTestGFX
	lb bc, BANK(MusicTestGFX), 13
	ld hl, VTiles0 tile $d9
	call Request2bpp

	ld de, PianoGFX
	lb bc, BANK(PianoGFX), 30
	ld hl, VTiles2
	call Request2bpp

	ld de, NotesGFX
	lb bc, BANK(NotesGFX), $80
	ld hl, VTiles0
	call Request2bpp

	; Prerender all waveforms
	ld a, 0
.waveform_loop
	push af
	call RenderWaveform
	pop af
	inc a
	cp 16
	jr nz, .waveform_loop

	call DelayFrame

	ld hl, rLCDC
	set 7, [hl]
	ei

	call ClearSprites

	ld hl, MusicPlayerWRAM
	ld bc, MusicPlayerWRAMEnd - MusicPlayerWRAM
	xor a
	call ByteFill

	ld a, $ff
	ld [wRenderedWaveform], a

	ld a, [rSVBK]
	push af
	ld a, 4
	ld [rSVBK], a
	xor a
	ld hl, wMPNotes
	ld bc, 4 * 256
	call ByteFill
	pop af
	ld [rSVBK], a
; fallthrough

RenderMusicPlayer:
	ld bc, SCREEN_WIDTH * MP_HUD_HEIGHT
	ld hl, MPTilemap
	decoord 0, PIANO_ROLL_HEIGHT
	call CopyBytes

	ld bc, 4 * 3
	ld hl, NoteOAM
	ld de, Sprites
	call CopyBytes
	call DelayFrame
	xor a
	ld [hOAMUpdate], a ; we will manually do it in LCD interrupt

	ld hl, wChannelSelectorSwitches
	ld a, NUM_MUSIC_CHANS - 1
.chlabelloop
	ld [wChannelSelector], a
	ld a, [hli]
	push hl
	call DrawChannelLabel
	pop hl
	ld a, [wChannelSelector]
	dec a
	cp -1
	jr nz, .chlabelloop

	call DelayFrame

	ld a, [wSongSelection]
	; let's see if a song is currently selected
	cp NUM_SONGS
	jr nc, .bad_selection
	and a
	jp nz, .redraw
.bad_selection
	ld a, MUSIC_MAIN_MENU
	jp .redraw

	ld a, [rSVBK]
	ld [hBuffer2], a
.loop
	ld a, 4
	ld [rSVBK], a
	call UpdateVisualIntensity
	call DelayFrame

	call DrawChData
	call DrawNotes

	call GetJoypad
	jpbutton B_BUTTON, .exit
	jrbutton D_LEFT, .left
	jrbutton D_RIGHT, .right
	jrbutton D_DOWN, .down
	jrbutton D_UP, .up
	jrbutton A_BUTTON, .a
	jrbutton SELECT, .select
	jrbutton START, .start

	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
	jr .loop

.left
	ld a, [wSongSelection]
	dec a
	jr nz, .redraw
	ld a, NUM_SONGS - 1
	jr .redraw

.right
	ld a, [wSongSelection]
	inc a
	cp NUM_SONGS
	jr nz, .redraw
	ld a, 1
	jr .redraw

.down
	ld a, [wSongSelection]
	sub 10
	jr z, .zerofix
	cp NUM_SONGS
	jr c, .redraw

.zerofix
	ld a, NUM_SONGS - 1
	jr .redraw

.up
	ld a, [wSongSelection]
	add 10
	cp NUM_SONGS
	jr c, .redraw
	ld a, 1
	jr .redraw

.start
	xor a
	ld [hMPState], a
	ld a, [hBuffer2]
	ld [rSVBK], a
	call SongSelector
	jp RenderMusicPlayer

.redraw
	ld [wSongSelection], a
	ld a, -1
	ld [wChannelSelector], a
	call DrawPianoRollOverlay
	jp .loop

.a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	farcall PlayMusic2
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
	jp .loop

.select
	xor a
	ld [wChannelSelector], a
	hlcoord 3, MP_HUD_TOP
	ld a, "◀"
	ld [hl], a

.songEditorLoop
	call UpdateVisualIntensity
	call DelayFrame

	call DrawChData
	call DrawNotes

	call GetJoypad
	jrbutton D_LEFT, .songEditorleft
	jrbutton D_RIGHT, .songEditorright
	jrbutton A_BUTTON, .songEditora
	jpbutton B_BUTTON | SELECT, .songEditorselectb
	jrbutton D_UP, .songEditorup
	jrbutton D_DOWN, .songEditordown
	jpbutton START, .songEditorstart

	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
	jr .songEditorLoop

.songEditorleft
	call ClearChannelSelector
	ld a, [wChannelSelector]
	dec a
	cp -1
	jr nz, .noOverflow
	ld a, NUM_MP_EDIT_FIELDS - 1 ; MP_EDIT_PITCH
.noOverflow
	ld [wChannelSelector], a
	call DrawChannelSelector
	jp .songEditorLoop

.songEditorright
	call ClearChannelSelector
	ld a, [wChannelSelector]
	inc a
	cp NUM_MP_EDIT_FIELDS
	jr nz, .noOverflow2
	xor a ; ld a, MP_EDIT_CH1
.noOverflow2
	ld [wChannelSelector], a
	call DrawChannelSelector
	jp .songEditorLoop

.songEditora
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jp z, .songEditorLoop
	ld c, a
	ld b, 0
	ld hl, wChannelSelectorSwitches
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawChannelLabel
	jp .songEditorLoop

.songEditorup
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jp z, .ChangingPitchup
	cp MP_EDIT_WAVE
	jp nz, .songEditorLoop
	ld a, [Channel3Intensity]
	dec a
	ld b, a
	and $f
	cp $f
	jr z, .waveunderflow
	ld a, b
	jr .changed

.ChangingPitchup
	ld a, [wTranspositionInterval]
	inc a
	cp MAX_PITCH_TRANSPOSITION + 1
	jr nz, .ChangingPitchChangePitch
	ld a, -MAX_PITCH_TRANSPOSITION
	jr .ChangingPitchChangePitch

.songEditordown
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jp z, .ChangingPitchdown
	cp MP_EDIT_WAVE
	jp nz, .songEditorLoop
	ld a, [Channel3Intensity]
	inc a
	ld b, a
	and $f
	jr z, .waveoverflow
	ld a, b
	jr .changed

.ChangingPitchdown
	ld a, [wTranspositionInterval]
	dec a
	cp -(MAX_PITCH_TRANSPOSITION + 1)
	jr nz, .ChangingPitchChangePitch
	ld a, MAX_PITCH_TRANSPOSITION
.ChangingPitchChangePitch
	ld [wTranspositionInterval], a
	call DrawTranspositionInterval
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	jp .songEditorLoop

.waveunderflow
	ld a, [Channel3Intensity]
	and $f0
	add $e
	jr .changed

.waveoverflow
	ld a, [Channel3Intensity]
	and $f0
.changed
	ld [Channel3Intensity], a
	ld [wCurTrackIntensity], a
	farcall ReloadWaveform
	jp .songEditorLoop

.songEditorselectb
	call ClearChannelSelector
	xor a ; ld a, MP_EDIT_CH1
	ld [wChannelSelector], a
	jp .loop

.songEditorstart
	ld hl, wSongInfoSwitch
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawPianoRollOverlay
	jp .songEditorLoop

.exit
	xor a
	ld [hMPState], a
	ld [hVBlank], a
	ld a, [hBuffer2]
	ld [rSVBK], a
	call ClearSprites
	ld hl, rLCDC
	res 2, [hl] ; 8x8 sprites
	di
	call NormalSpeed
	xor a
	ld [rIF], a
	ld a, $f
	ld [rIE], a
	ei
	ret

DrawPianoRollOverlay:
	; if this takes too long, don't let the user see blank fields blink in
	; disable copying the map during vblank
	ld a, 2
	ld [hVBlank], a

	ld a, " "
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * PIANO_ROLL_HEIGHT
	call ByteFill

	call DrawSongInfo
	call DrawTranspositionInterval
	call DrawChannelSelector

	ld a, 5
	ld [hVBlank], a

	; refresh top two portions
	xor a
	ld [hBGMapThird], a
	jp DelayFrame

DrawTranspositionInterval:
	hlcoord 17, 1
	ld de, .EmptyPitch
	call PlaceString
	ld a, [wTranspositionInterval]
	and a
	ret z
	bit 7, a
	jr nz, .negative
	ld de, wTranspositionInterval
	ld a, "+"
	jr .printnum

.negative
	xor $ff
	inc a
	ld de, wTmpValue
	ld [de], a
	ld a, "-"
.printnum
	hlcoord 17, 1
	ld [hli], a
	lb bc, PRINTNUM_RIGHTALIGN | 1, 2
	jp PrintNum

.EmptyPitch: db "   @"

DrawChannelSelector:
	ld a, [wChannelSelector]
	cp -1
	ret z
	cp MP_EDIT_PITCH
	jr z, .pitch
	call _LocateChannelSelector
	ld [hl], "◀"
	ret

.pitch:
	hlcoord 16, 1
	ld [hl], "▶"
	ret

ClearChannelSelector:
	ld a, [wChannelSelector]
	cp MP_EDIT_PITCH
	jr z, .pitch
	call _LocateChannelSelector
	ld [hl], $1c
	ret

.pitch
	hlcoord 16, 1
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
	add hl
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
.ch
	ld [wTmpCh], a
	call .Draw
	inc a
	ld de, 2
	add hl, de
	cp 3
	jr c, .ch

	; Ch4 handling goes here.
	hlcoord 17, MP_HUD_TOP + 2
	ld a, [wNoiseHit]
	and a
	jr nz, .hit
	ld a, " "
	jr .pickedhitchar
.hit
	ld a, $e1
.pickedhitchar
	ld [hl], a
	xor a
	ld [wNoiseHit], a
	hlcoord 19, MP_HUD_TOP + 1
	ld a, [MusicNoiseSampleSet]
	add $f6
	ld [hl], a
	hlcoord 16, MP_HUD_TOP + 3
	ld a, [wC4Vol]
	and $f
	cp 8
	jr c, .okc4

	push af
	ld a, $e1
	ld [hli], a
	ld [hld], a
	pop af
	ld de, -SCREEN_WIDTH
	add hl, de

.okc4
	and 7
	add $d9
	ld [hli], a
	ld [hld], a
	ret

.Draw
	push af
	push hl
	call CheckChannelOn
	ld a, 0
	ld hl, NoteNames
	jr c, .isNotPlaying
	call GetPitchAddr
	ld a, [hl]
	ld hl, NoteNames
	call GetNthString
.isNotPlaying
	ld e, l
	ld d, h
	pop hl
	push hl
	call PlaceString
	call GetOctaveAddr
	ld d, [hl]
	ld a, "8"
	sub d
	pop hl
	inc hl
	inc hl
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
	add $e2
	ld [hl], a
	pop hl
.no_duty_cycle

	push hl
	dec hl
	dec hl
	dec hl
	ld a, $d9
	ld de, SCREEN_WIDTH
	add hl, de
	ld [hli], a
	ld [hld], a
	add hl, de
	ld [hli], a
	ld [hld], a

	push hl
	call CheckChannelOn
	pop hl
	ld a, 0 ; not xor a; preserve carry flag
	jr c, .isNotPlaying2

	push hl
	call GetPitchAddr
	ld a, [hl]
	and a
	pop hl
	ld a, 0 ; not xor a; preserve carry flag
	jr z, .isNotPlaying2

	push hl
	call GetIntensityAddr
	ld a, [hl]
	pop hl
.isNotPlaying2
	and $f
	cp 8
	jr c, .ok

	push af
	ld a, $e1
	ld [hli], a
	ld [hld], a
	pop af
	ld de, -SCREEN_WIDTH
	add hl, de

.ok
	and 7
	add $d9
	ld [hli], a
	ld [hld], a
	ld a, [wTmpCh]
	cp 2
	jr nz, .notch3
	hlcoord 12, MP_HUD_TOP + 2
	; pick the waveform
	ld a, [Channel3Intensity]
	and $f
	sla a
	add $40
	ld [hli], a
	inc a
	ld [hl], a
.donewaveform
.notch3
	pop hl
	pop af
	ret

RenderWaveform:
	ld [wRenderedWaveform], a
	ld l, a
	ld h, $0
	; hl << 4
	; each wavepattern is $f bytes long
	; so seeking is done in $10s
rept 4
	add hl, hl
endr
	ld de, WaveSamples
	add hl, de
	; load wavepattern into wWaveformTmp
	ld de, wWaveformTmp
	ld bc, 16
	ld a, BANK(WaveSamples)
	call FarCopyBytes ; copy bc bytes from a:hl to de
	ld hl, TempMPWaveform
	ld bc, BOXMON_STRUCT_LENGTH
	xor a
	call ByteFill

	ld hl, TempMPWaveform
	ld de, wWaveformTmp
	ld b, 1

.drawloop
	ld a, [de]
	push de

	swap a
	and $f
	xor $f
	sra a
	sla a
	ld c, a
	add l
	ld l, a
	jr nc, .nc
	inc h
.nc
	ld a, b
	and $7
	ld d, a
	; c = row
	; b = (d) = column
	ld a, $1
.rotatea
	rrc a
	dec d
	jr nz, .rotatea
	or [hl]
	ld [hli], a
	ld [hl], a

	pop de
	inc de
	inc b
	ld a, b
	cp $11
	jr z, .done
	cp $9
	jr nc, .secondtile
	ld hl, TempMPWaveform
	jr .drawloop
.secondtile
	ld hl, TempMPWaveform + 16
	jr .drawloop
.done
	ld hl, VTiles2 tile $40
	ld a, [wRenderedWaveform]
rept 5
	sla a
endr
	ld l, a
	jr nc, .gothl
	inc h
.gothl
	lb bc, 0, 2
	ld de, TempMPWaveform
	call Request2bpp
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

	ld a, [rSVBK]
	push af
	ld a, 4
	ld [rSVBK], a
	ld a, [hMPState]
	inc a
	ld [hMPState], a
	cp PIANO_ROLL_HEIGHT_PX + 1 + 1
	jr c, .skip
	ld a, 1
	ld [hMPState], a
.skip
	dec a
	push af
	call .copynotes
	pop af
	add PIANO_ROLL_HEIGHT_PX
	call nc, .copynotes
	pop af
	ld [rSVBK], a
	ret

.copynotes
	ld bc, 4
	ld hl, wMPNotes
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wPitchesTmp
	jp CopyBytes

CheckEndedNote:
; Check that the current channel is actually playing a note.

; Rests count as ends.
	call GetIntensityAddr
	ld a, [hl]
	and a
	jr z, NoteEnded

CheckNoteDuration:
	ld a, [wTmpCh]
	ld bc, Channel2 - Channel1

; Note duration
	ld hl, Channel1NoteDuration
	call AddNTimes
	ld a, [hl]
	cp 2
	jr c, NoteEnded

CheckChannelOn:
; Channel on/off flag
	ld a, [wTmpCh]
	ld bc, Channel2 - Channel1
	ld hl, Channel1Flags
	call AddNTimes
	bit SOUND_CHANNEL_ON, [hl]
	jr z, NoteEnded

; Rest flag
; Note flags are wiped after each
; note is read, so this is pointless.
	ld a, [wTmpCh]
	ld hl, Channel1NoteFlags
	call AddNTimes
	bit SOUND_REST, [hl]
	jr nz, NoteEnded

; Do an IO check too if the note's envelope is 0
; and not ramping up since the game handles rest
; notes by temporarily write 0 to hi nibble of NRx2
	ld a, [wTmpCh]
	cp 2
	jr nz, .notch3 ; NR32 does something different
	ld a, [rNR32]
	and $60
	jr z, NoteEnded ; 0% volume
	jr .still_going
.notch3
	ld bc, 5
	ld hl, rNR12
	call AddNTimes
	ld a, [hl]
	ld b, a
	and $f0
	jr nz, .still_going
	ld a, b
	bit 3, a
	jr z, NoteEnded ; ramping down
	and $7
	jr z, NoteEnded ; no ramping

.still_going
	and a
	ret

NoteEnded:
	scf
	ret

DrawNote:
	call CheckChannelOn
	jp c, WriteBlankNote
	call GetPitchAddr
	ld a, [hl]
	and a
	jp z, WriteBlankNote ; rest
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
	jp z, DrawLongerNote
	jp DrawChangedNote

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
	call AddNTimes
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
	jp WriteNotePitch

.Pitchels:
	db 1, 3, 5, 7, 9, 13, 15, 17, 19, 21, 23, 25, 27

DrawLongerNote:
	ld a,[wTmpCh]
	ld hl, Channel1Intensity
	ld bc, Channel2 - Channel1
	call AddNTimes
	ld a, [hl]
	and $f
	cp $9
	jr nc, .fadingUp
	call CheckEndedNote
	jp c, WriteBlankNote
	jr .notFadingUp

.fadingUp
	call CheckNoteDuration
	jp c, WriteBlankNote
.notFadingUp
	jp DrawNewNote

WriteBlankNote:
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
	jr c, .noteEnded ; not a new note, but this note just ended!
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

.noteEnded
	ld hl, wNoteEnded
	ld a, [wTmpCh]
	ld e, a
	ld d, 0
	add hl, de
	ld a, 1
	ld [hl], a
	ld hl, wChLastNotes
	add hl, de
	xor a
	ld [hl], a
	ret

SetVisualIntensity:
	ld a,[wTmpCh]
	ld hl, Channel1Pitch
	ld bc, Channel2 - Channel1
	call AddNTimes
	ld a, [hl]
	and a
	jr z, .skip
	ld a,[wTmpCh]
	ld hl, Channel1Intensity
	ld bc, Channel2 - Channel1
	push af
	call AddNTimes
	pop af
	cp 2
	jr z, .wavChannel
	ld a, [hl]
	ld e, a
	swap a
	and $f
	ld d, a

	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	call AddNTimes
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
.wavChannel
	ld a, [hl]
	and $f0
	cp $10
	jr z, .full
	cp $20
	jr z, .half
	cp $30
	jr z, .quarter
	xor a
	jr .setWavVol
.full
	ld a, $f
	jr .setWavVol
.half
	ld a, $7
	jr .setWavVol
.quarter
	ld a, $3
.setWavVol
	ld hl, wC3Vol
	ld [hl], a
	ret
.skip
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	call AddNTimes
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
.timerup
	add 64
	ldi [hl], a
.updateChannels
	inc hl
	ld a, [hld]
	ld b, a
	and $7f
	jr z, .nextChannel
	ld a, b
	dec a
	ld b, a
	and $f
	jr z, .changeEnvelope
	inc hl
	jr .doneCh
.changeEnvelope
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
	jr z, .doneInc
	xor a
	jr .doneInc
.increase
	inc a
	bit 4, a
	jr z, .doneInc
	ld a, $f
.doneInc
	ld [hli], a
.doneCh
	ld a, b
	ld [hld], a
.nextChannel
	inc hl
	inc hl
	dec c
	ret z
	ld a, c
	cp 2
	jr z, .nextChannel
	jr .updateChannels

AddNoteToOld:
	push hl
	ld a, [wNumNoteLines]
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, Sprites + 3 * 4
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
	jr z, .startover
	ld [wNumNoteLines], a
	ret
.startover
	xor a
	ld [wNumNoteLines], a
	ret

GetPitchAddr:
	ld a, [wTmpCh]
	add a
	ld hl, PitchAddrs
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

PitchAddrs:
	dw Channel1Pitch
	dw Channel2Pitch
	dw Channel3Pitch

GetOctaveAddr:
	ld a, [wTmpCh]
	ld hl, Channel1Octave
	ld bc, Channel2 - Channel1
	jp AddNTimes

GetIntensityAddr:
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	jp AddNTimes

GetDutyCycleAddr:
	ld a, [wTmpCh]
	ld hl, Channel1DutyCycle
	ld bc, Channel2 - Channel1
	jp AddNTimes

GetSongInfo:
	ld a, [wSongSelection]
	ld b, a
	ld c, 0
	ld hl, SongInfo
.loop
	ld a, [hl]
	cp -1
	jr z, .noname
	inc c
	ld a, c
	cp b
	jr z, .found
.loop2
	ld a, [hli]
	cp "@"
	jr z, .nextline
	jr .loop2
.found
	xor a
	ret
.nextline
rept 3
	inc hl
endr
	jr .loop
.noname
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

.info
	call GetSongTitle
	hlcoord 0, 3
	call PlaceString
	inc de

	push de
	call GetSongOrigin
	hlcoord 0, 1
	push de
	call DrawSongID
	pop de
	inc hl
	call PlaceString
	pop de
	inc de

	push de
	call GetSongArtist
	hlcoord 0, 7
	call PlaceString
	pop de
	inc de

	push de
	call GetSongArtist2
	hlcoord 0, 10
	call PlaceString
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
	jp PrintNum

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
	call PlaceString
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
	call PlaceString
.finish
	pop de
	ret

.Arranger:
	db "Arranger:@"

SongSelector:
	hlcoord 0, 0
	ld a, " "
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill
	call ClearSprites

	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call TextBox

	hlcoord 0, 8
	ld [hl], "▶"
	ld a, [wSongSelection]
	ld [wSelectorTop], a ; backup, in case of B button
	cp 8
	jr nc, .noOverflow
	ld b, a
	ld a, NUM_SONGS - 1
	add b
.noOverflow
	sub 7
	ld [wSongSelection], a
	call UpdateSelectorNames
.loop
	call DelayFrame

	call GetJoypad
	jrbutton A_BUTTON, .a
	jrbutton B_BUTTON | START, .exit
	jrbutton D_DOWN, .down
	jrbutton D_UP, .up
	jrbutton D_LEFT, .left
	jrbutton D_RIGHT, .right
	jr .loop

.a
	ld a, [wSongSelection]
	cp NUM_SONGS - 7
	jr c, .noOverflow2
	sub NUM_SONGS - 8
	jr .finish
.noOverflow2
	add 7
.finish
	ld [wSongSelection], a
	ld e, a
	ld d, 0
	farcall PlayMusic2
	ret

.down
	ld a, [wSongSelection]
	inc a
	cp NUM_SONGS
	jr c, .noOverflowD
	ld a, 1
.noOverflowD
	ld [wSongSelection], a
	call UpdateSelectorNames
	jr .loop

.up
	ld a, [wSongSelection]
	dec a
	jr nz, .noOverflowU
	ld a, NUM_SONGS - 1
.noOverflowU
	ld [wSongSelection], a
	call UpdateSelectorNames
	jp .loop

.left
	ld a, [wSongSelection]
	sub 10
	jr nc, .noOverflowL
	add NUM_SONGS
.noOverflowL
	ld [wSongSelection], a
	call UpdateSelectorNames
	jp .loop

.right
	ld a, [wSongSelection]
	add 10
	cp NUM_SONGS
	jr c, .noOverflowR
	sub NUM_SONGS
.noOverflowR
	ld [wSongSelection], a
	call UpdateSelectorNames
	jp .loop

.exit
	ld a, [wSelectorTop]
	ld [wSongSelection], a
	ret

UpdateSelectorNames:
	call GetSongInfo
	ld a, [wSongSelection]
	ld c, a
	ld b, 0
	push hl
	pop de
.loop
	hlcoord 1, 1
	ld a, c
	ld [wSelectorCur], a
	push bc
	ld a, b
	ld bc, SCREEN_WIDTH
	call AddNTimes
	call MPLPlaceString
	inc de
	inc de
	inc de
	inc de
	pop bc
	inc b
	inc c
	ld a, c
	cp NUM_SONGS
	jr c, .noOverflow
	ld c, 1
	ld de, SongInfo
.noOverflow
	ld a, b
	cp 16 ; songs per page
	jr nz, .loop
	ret

MPLPlaceString:
	push hl
	ld a, " "
	ld hl, StringBuffer2
	ld bc, 3
	call ByteFill
	ld hl, StringBuffer2
	push de
	ld de, wSelectorCur
	lb bc, 1, 3
	call PrintNum
	pop de
	ld [hl], " "
	inc hl
	ld b, 0
.loop
	ld a, [de]
	ld [hl], a
	cp "@"
	jr nz, .next
	ld [hl], " "
	dec de
.next
	inc hl
	inc de
	inc b
	ld a, b
	cp 14
	jr c, .loop
	ld a, [de]
	cp "@"
	jr nz, .notend
	ld [hl], a
	jr .last
.notend
	dec hl
	ld [hl], "…"
	inc hl
	ld [hl], "@"
.loop2
	inc de
	ld a, [de]
	cp "@"
	jr nz, .loop2
.last
	pop hl
	push de
	ld de, StringBuffer2
	call PlaceString
	pop de
	ret

NoteNames:
	db "- @"
	db "C @"
	db "C<SHARP>@"
	db "D @"
	db "D<SHARP>@"
	db "E @"
	db "F @"
	db "F<SHARP>@"
	db "G @"
	db "G<SHARP>@"
	db "A @"
	db "A<SHARP>@"
	db "B @"
	db "--@"

MPTilemap:
db $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05
db $07, $08, $09, $1c, $1d, $07, $08, $0a, $1c, $1d, $0b, $0c, $0d, $1c, $1d, $0e, $0f, $10, $1c, $1c
db "    ", $1b, "    ", $1b, "    ", $1b, "Set  "
db "    ", $1b, "    ", $1b, "    ", $1b, "     "
db "    ", $1b, "    ", $1b, "    ", $1b, "     "

ChannelsOnTilemaps:
	db $07, $08, $09
	db $07, $08, $0a
	db $0b, $0c, $0d
	db $0e, $0f, $10

ChannelsOffTilemaps:
	db $11, $12, $13
	db $11, $12, $14
	db $15, $16, $17
	db $18, $19, $1a

NoteOAM:
	; y, x, tile id, OAM attributes
	db 0, 0, $20, BEHIND_BG
	db 0, 0, $40, BEHIND_BG
	db 0, 0, $60, BEHIND_BG

SongInfo:
	; title, origin, composer, additional credits
	db "Opening@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Title Screen@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Main Menu@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "New Bark Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	db "Mom@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Elm's Lab@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Lyra Appears@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Rival@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Lyra Departs@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 29@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Johto Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Johto Wild Night@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Victory! Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Cherrygrove City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Follow Me!@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pokémon Center@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Heal Pokémon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Captured Pokémon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Youngster@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Johto Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Victory! Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 30@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Violet City@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Sprout Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Sage@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Poké Mart@", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	db "Union Cave@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Ruins of Alph@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Unown Radio@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Azalea Town@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Spotted! Team Rocket@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Vs.Team Rocket@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 34@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Rival Appears@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Rival@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Rival Departs@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Evolution@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Goldenrod City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "PokéCom Center@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Gym@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Johto Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Final Pokémon@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Victory! Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pokémon Channel@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Buena's Password@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	db "Game Corner@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Bicycle@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Lass@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "National Park@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Bug-Catching Contest@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Bug-Catching ContestRanking@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Ecruteak City@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Dance Theater@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Spotted! Kimono Girl@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Burned Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Eusine Appears@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	db "Prof.Oak's Pokémon   Talk@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 38@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pokémon March@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Olivine Lighthouse@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Surfing@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Cianwood City@", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	db "Route 47@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Jessie & James      Appear@", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Safari Zone Gate@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Surfing Pikachu@", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 42@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Stark Mountain@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Rocket Radio@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Rocket Hideout@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Pokémaniac@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Radio Tower Occu-   pied!@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Ice Path@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Dragon's Den@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Clair@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	db "Route 4@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Bell Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Suicune@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 26@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Indigo Plateau@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Victory Road@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Indigo Plateau@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Elite Four@", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Hall of Fame@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "S.S.Aqua@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Vermilion City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Kanto Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Black City@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Lavender Town@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pokémon Tower@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Lavender Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	db "Vs.Kanto Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Cerulean City@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Route 24@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Magnet Train@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Pokémon Lullaby@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Celadon City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Game Corner@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Canalave City@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Bicycle@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db "Route 11@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Poké Flute@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 209@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Route 210@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Route 225@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Diglett's Cave@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Viridian Forest@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, COMPOSER_NONE
	db "Spotted! Hiker@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pewter City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 3@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Officer@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Mt.Moon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Mt.Moon Square@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Route 1@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Pallet Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Prof.Oak Appears@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Spotted! Beauty@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Kanto Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Cinnabar Island@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Cinnabar Mansion@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Trainer@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Eterna Forest@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Mt.Chimney@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Mt.Pyre@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Battle Tower@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	db "Battle Tower Lobby@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, COMPOSER_NONE
	db "Vs.Trainer@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Frontier Brain@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Zinnia Appears@", ORIGIN_ORAS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 205@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Vs.Wild@", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Sunyshore City@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Vs.Trainer@", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 203@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "White Treehollow@", ORIGIN_B2W2, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Laverre City@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 101@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Dewford Town@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db "Oreburgh Gate@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 12@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Road to Reversal    Mountain@", ORIGIN_B2W2, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Zinnia@", ORIGIN_ORAS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Wally Appears@", ORIGIN_ORAS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Wally@", ORIGIN_ORAS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Spiky-Eared Pichu@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Mother Beast@", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Frost Cavern@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Power Plant@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db "Reversal Mountain@", ORIGIN_B2W2, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Meteor Falls@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Lugia's Song@", ORIGIN_M02, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Lugia@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Summoning Dance@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Ho-Oh@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Cerulean Cave@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, COMPOSER_NONE
	db "Vs.Kanto Legend@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_GACT_PIGU
	db "Vs.Gym Leader@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Gym Leader@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Gym Leader@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Gym Leader@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Elite Four@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Celestial Tower@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Mt.Coronet@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Vs.World Champion-  ship Finals@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU_PIKALAXALT
	db "Abandoned Ship@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_B2W2, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Credits@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Post-Credits@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, COMPOSER_NONE
	db "Title@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db -1

SongOrigins:
	db "R/B@"
	db "Y@"
	db "G/S@"
	db "C@"
	db "R/S/E@"
	db "FR/LG@"
	db "D/P/Pt@"
	db "HG/SS@"
	db "B/W@"
	db "B2/W2@"
	db "X/Y@"
	db "OR/AS@"
	db "S/M@"
	db "M02@"

SongArtists:
	db "@"
	db "Junichi Masuda@"
	db "Go Ichinose@"
	db "Junichi Masuda,     Go Ichinose@"
	db "Morikazu Aoki@"
	db "Ichiro Shimakura@"
	db "Shota Kageyama@"
	db "FroggestSpirit@"
	db "Mmmmmm@"
	db "Pum@"
	db "ShantyTown@"
	db "Pigu@"
	db "Pigu, PikalaxALT@"
	db "GACT, Pigu@"
