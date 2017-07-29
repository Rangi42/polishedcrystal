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

MAX_PITCH_TRANSPOSITION EQU 12

jbutton: MACRO
	ld a, [hJoyPressed]
	and \1
	jp nz, \2 ; TODO jx
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
	RGB 31, 31, 31 ; white
	RGB 07, 31, 07 ; green
	RGB 07, 07, 31 ; blue
	RGB 31, 07, 07 ; red
else
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
endc

MusicPlayer::
	;ld de, 1
	;call PlayMusic
	;call WhiteBGMap
	di
	call DoubleSpeed
	xor a
	ld [rIF], a
	ld a, $f
	ld [rIE], a
	ei

	ld hl, TextBoxFrame
	ld a, [hl]
	push af
	xor a
	ld [hl], a

	call ClearTileMap
	call MPLoadPalette

	hlcoord 6, 5
	ld de, LoadingText
	call PlaceString

	xor a
	ld [hBGMapThird], a
	call DelayFrame

	farcall LoadFrame

	ld b, BANK(MusicTestGFX)
	ld c, 9
	ld de, MusicTestGFX
	ld hl, VTiles0 tile $d9
	call Request2bpp

	ld de, PianoGFX
	ld b, BANK(PianoGFX)
	ld c, $20
	ld hl, VTiles2
	call Request2bpp

	ld de, NotesGFX
	ld b, BANK(NotesGFX)
	ld c, $80
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

	xor a
	ld [wNumNoteLines], a
	ld [wChLastNotes], a
	ld [wChLastNotes+1], a
	ld [wChLastNotes+2], a
	ld [wChannelSelectorSwitches], a
	ld [wChannelSelectorSwitches+1], a
	ld [wChannelSelectorSwitches+2], a
	ld [wChannelSelectorSwitches+3], a
	ld [wTranspositionInterval], a
	ld [wSpecialWaveform], a
	ld [hMPState], a
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

	call RenderMusicPlayer

	pop af
	ld hl, TextBoxFrame
	ld [hl], a
	ret

RenderMusicPlayer:
	ld bc, SCREEN_WIDTH * 5
	ld hl, MPTilemap
	decoord 0, 13
	call CopyBytes

	ld bc, 4 * 3
	ld hl, NoteOAM
	ld de, Sprites
	call CopyBytes
	call DelayFrame
	xor a
	ld [hOAMUpdate], a ; we will manually do it in LCD interrupt

	ld hl, wChannelSelectorSwitches
	ld a, 3
.chlabelloop
	ld [wChannelSelector], a
	ld a, [hli]
	push hl
	call DrawChannelLabel
	pop hl
	ld a, [wChannelSelector]
	dec a
	cp $ff
	jr nz, .chlabelloop

	call DelayFrame

	ld a, [wSongSelection]
	; let's see if a song is currently selected
	cp NUM_MUSIC
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
	jbutton B_BUTTON, .exit
	jbutton D_LEFT, .left
	jbutton D_RIGHT, .right
	jbutton D_DOWN, .down
	jbutton D_UP, .up
	jbutton A_BUTTON, .a
	jbutton SELECT, .select
	jbutton START, .start

	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
	jr .loop

.left
	ld a, [wSongSelection]
	dec a
	cp $0
	jr nz, .redraw
	ld a, NUM_MUSIC - 1
	jr .redraw

.right
	ld a, [wSongSelection]
	inc a
	cp NUM_MUSIC
	jr nz, .redraw
	ld a, 1
	jr .redraw

.down
	ld a, [wSongSelection]
	sub 10
	jr z, .zerofix
	cp NUM_MUSIC
	jr c, .redraw

.zerofix
	ld a, NUM_MUSIC - 1
	jr .redraw

.up
	ld a, [wSongSelection]
	add 10
	cp NUM_MUSIC
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

	; if this takes too long, don't let the user see blank fields blink in
	; disable copying the map during vblank
	ld a, 2
	ld [hVBlank], a

	ld a, " "
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * 13
	call ByteFill

	call DrawSongInfo
	call DrawTranspositionInterval

	ld a, 5
	ld [hVBlank], a

	; refresh top two portions
	xor a
	ld [hBGMapThird], a
	call DelayFrame
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
	hlcoord 0, 12
	ld a, "▼"
	ld [hl], a
	;jp .songEditorLoop

.songEditorLoop
	call UpdateVisualIntensity
	call DelayFrame

	call DrawChData
	call DrawNotes

	ld a, [wChangingPitch]
	and a
	jr nz, .changingPitch
	call GetJoypad
	jbutton D_LEFT, .songEditorleft
	jbutton D_RIGHT, .songEditorright
	jbutton A_BUTTON, .songEditora
	jbutton B_BUTTON, .songEditorb
	jbutton D_UP, .songEditorup
	jbutton D_DOWN, .songEditordown
	jbutton SELECT, .songEditorselect

	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
	jr .songEditorLoop

.changingPitch
	call GetJoypad
	jbutton D_DOWN | D_LEFT, .ChangingPitchdownleft
	jbutton D_UP | D_RIGHT, .ChangingPitchupright
	jbutton A_BUTTON, .ChangingPitchb
	jbutton B_BUTTON, .ChangingPitchb
	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
	jr .songEditorLoop

.songEditorleft
	call .channelSelectorloadhl
	ld a, $7f
	ld [hl], a
	ld a, [wChannelSelector]
	dec a
	cp -1
	jr nz, .noOverflow
	ld a, 4
.noOverflow
	ld [wChannelSelector], a
	call .channelSelectorloadhl
	ld [hl], a
	jp .songEditorLoop

.songEditorright
	call .channelSelectorloadhl
	ld a, $7f
	ld [hl], a
	ld a, [wChannelSelector]
	inc a
	cp 5
	jr nz, .noOverflow2
	xor a
.noOverflow2
	ld [wChannelSelector], a
	call .channelSelectorloadhl
	ld [hl], a
	jp .songEditorLoop

.songEditora
	ld a, [wChannelSelector]
	cp 4
	jr z, .changePitch
	ld c, a
	ld b, 0
	ld hl, wChannelSelectorSwitches
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
	call DrawChannelLabel
	jp .songEditorLoop

.changePitch
	ld a, 1
	ld [wChangingPitch], a
	hlcoord 16, 1
	ld a, "▷"
	ld [hl], a
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	jp .songEditorLoop

.songEditorup
	ld a, [wChannelSelector]
	cp 2
	jp nz, .songEditorLoop
	ld a, [Channel3Intensity]
	dec a
	ld b, a
	and $f
	cp $f
	jr z, .waveunderflow
	ld a, b
	jr .changed

.songEditordown
	ld a, [wChannelSelector]
	cp 2
	jp nz, .songEditorLoop
	ld a, [Channel3Intensity]
	inc a
	ld b, a
	and $f
	jr z, .waveoverflow
	ld a, b
	jr .changed

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

.songEditorselect
.songEditorb
	call .channelSelectorloadhl
	ld a, $7f
	ld [hl], a
	jp .loop

.channelSelectorloadhl
	ld a, [wChannelSelector]
	cp 4
	jr z, .channelSelectorloadhlpitch
	ld c, 5
	call SimpleMultiply
	hlcoord 0, 12
	add l
	ld l, a
	ld a, "▼"
	ret nc
	inc h
	ret

.channelSelectorloadhlpitch
	hlcoord 16, 1
	ld a, "▶"
	ret

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

.ChangingPitchdownleft
	ld a, [wTranspositionInterval]
	dec a
	cp -(MAX_PITCH_TRANSPOSITION + 1)
	jr nz, .ChangingPitchChangePitch
	ld a, MAX_PITCH_TRANSPOSITION
	jr .ChangingPitchChangePitch

.ChangingPitchupright
	ld a, [wTranspositionInterval]
	inc a
	cp MAX_PITCH_TRANSPOSITION + 1
	jr nz, .ChangingPitchChangePitch
	ld a, -MAX_PITCH_TRANSPOSITION
.ChangingPitchChangePitch
	ld [wTranspositionInterval], a
	call DrawTranspositionInterval
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	jp .songEditorLoop

.ChangingPitchb
	xor a
	ld [wChangingPitch], a
	hlcoord 16, 1
	ld a, "▶"
	ld [hl], a
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	jp .songEditorLoop

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
	ld de, wTmp
	ld [de], a
	ld a, "-"
.printnum
	hlcoord 17, 1
	ld [hl], a
	lb bc, 1, 3
	jp PrintNum

.EmptyPitch: db "   @"

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

	hlcoord 0, 13
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
	ld a, [wSpecialWaveform]
	and a
	jr z, .notspecial
	call RenderSpecialWaveform
	xor a
	ld [wSpecialWaveform], a
.notspecial

	ld a, 0
	hlcoord 0, 14
.ch
	ld [wTmpCh], a
	call .Draw
	inc a
	ld de, 2
	add hl, de
	cp 3
	jr c, .ch

	; Ch4 handling goes here.
	hlcoord 17, 15
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
	hlcoord 19, 14
	ld a, [MusicNoiseSampleSet]
	add $f6
	ld [hl], a
	hlcoord 16, 16
	ld a, [wC4Vol]
	and $f
	cp 8
	jr c, .okc4

	push af
	ld a, $e1
	ld [hli], a
	ld [hld], a
	pop af
	ld de, -20
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
	ld a, $fe
	sub d
	pop hl
	inc hl
	inc hl
	ld [hli], a

	push hl
	dec hl
	dec hl
	dec hl
	ld a, $d9
	ld de, 20
	add hl, de
	ld [hli], a
	ld [hld], a
	add hl, de
	ld [hli], a
	ld [hld], a

	push hl
	call CheckChannelOn
	pop hl
	ld a, 0
	jr c, .isNotPlaying2

	push hl
	call GetPitchAddr
	ld a, [hl]
	and a
	pop hl
	ld a, 0
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
	ld de, -20
	add hl, de

.ok
	and 7
	add $d9
	ld [hli], a
	ld [hld], a
	ld a, [wTmpCh]
	cp 2
	jr nz, .notch3
	hlcoord 12, 15
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
;	ld a, [wCurTrackIntensity]
;	and $f ; only 0-9 are valid (+10 for RBY Lavender Town)
;	ld b, a
;	ld a, [wRenderedWaveform]
;	cp b
;	ret z
;	ld a, b
	ld [wRenderedWaveform], a

	ld a, [wRenderedWaveform]
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
RenderSpecialWaveform:
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
	sla a
	sla a
	sla a
	sla a
	sla a
	ld l, a
	jr nc, .gothl
	inc h
.gothl
	ld b, 0
	ld c, 2
	ld de, TempMPWaveform
	call Request2bpp
	ret

DrawNotes:
	ld a, 0
	ld [wTmpCh], a
	call DrawNote
	call CheckForVolumeBarReset
	ld a, 1
	ld [wTmpCh], a
	call DrawNote
	call CheckForVolumeBarReset
	ld a, 2
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
	cp 145 + 1
	jr c, .skip
	ld a, 1
	ld [hMPState], a
.skip
	dec a
	push af
	call .copynotes
	pop af
	add 144
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
	ld hl, wWaveformTmp
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
	bit 0, [hl]
	jr z, NoteEnded

; Rest flag
; Note flags are wiped after each
; note is read, so this is pointless.
	ld a, [wTmpCh]
	ld hl, Channel1NoteFlags
	call AddNTimes
	bit 5, [hl]
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
	; spillover

DrawNewNote:
	call GetPitchAddr
	push hl
	inc hl
	ld a, [hl]
	xor $f ; why are lower octaves higher.
	sub $8
	ld bc, 28
	ld hl, 8
	call AddNTimes
	ld b, l
	pop hl
	ld a, [hl]
	dec a
	ld hl, Pitchels
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	add b
	ld c, a
	jp WriteNotePitch

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
	ld hl, wWaveformTmp ; recycle
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
	cp 0
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
	and $F0
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
	ld hl, Sprites + 4 * 3
	add hl, bc
	push hl
	pop de
	pop hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
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

Pitchels:
	db 1, 3, 5, 7, 9, 13, 15, 17, 19, 21, 23, 25, 27

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
	call AddNTimes
	ret

GetIntensityAddr:
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	call AddNTimes
	ret

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
	inc hl
	inc hl
	inc hl
	jr .loop
.noname
	scf
	ret

DrawSongInfo:
	ld a, [wSongSelection]
	call GetSongInfo
	ret c ; no data

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
	ld b, a
	ld hl, Origin
.loop
	ld a, [hli]
	cp -1
	jr z, GetBlankName
	cp b
	jr nz, .loop
GetSongTitle:
	push hl
	pop de
	ret

GetSongArtist:
	ld a, [de]
	ld b, a
	ld hl, Artist
.loop
	ld a, [hli]
	cp -1
	jr z, GetBlankName
	cp b
	jr nz, .loop
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
	ld b, a
	ld hl, Artist
.loop
	ld a, [hli]
	cp -1
	jr z, GetBlankName
	cp b
	jr nz, .loop
	push hl
	ld de, .Arranger
	hlcoord 0, 9
	call PlaceString
	pop de
	ret

.Arranger:
	db "Arranger:@"

GetBlankName:
	ld de, BlankName
	ret

SongSelector:
	ld bc, SCREEN_WIDTH
	ld hl, MPKeymap
	decoord 0, 17
	call CopyBytes
	ld a, " "
	hlcoord 0, 0
	ld bc, 340
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
	ld a, NUM_MUSIC - 1
	add b
.noOverflow
	sub 7
	ld [wSongSelection], a
	call UpdateSelectorNames
.loop
	call DelayFrame
	call GetJoypad
	jbutton A_BUTTON, .a
	jbutton B_BUTTON, .exit
	jbutton D_DOWN, .down
	jbutton D_UP, .up
	jbutton D_LEFT, .left
	jbutton D_RIGHT, .right
	jr .loop
.a
	ld a, [wSongSelection]
	cp NUM_MUSIC - 7
	jr c, .noOverflow2
	sub NUM_MUSIC - 8
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
	cp NUM_MUSIC
	jr c, .noOverflowD
	ld a, 1
.noOverflowD
	ld [wSongSelection], a
	call UpdateSelectorNames
	jr .loop
.up
	ld a, [wSongSelection]
	dec a
	cp 0
	jr nz, .noOverflowU
	ld a, NUM_MUSIC - 1
.noOverflowU
	ld [wSongSelection], a
	call UpdateSelectorNames
	jr .loop
.left
	ld a, [wSongSelection]
	sub 10
	jr nc, .noOverflowL
	ld a, NUM_MUSIC - 1
.noOverflowL
	ld [wSongSelection], a
	call UpdateSelectorNames
	jp .loop
.right
	ld a, [wSongSelection]
	add 10
	cp NUM_MUSIC
	jr c, .noOverflowR
	ld a, 1
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
	cp NUM_MUSIC
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
	ld [hl], "│"
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

LoadingText:
	db "Loading…@"

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

; ┌─┐│└┘
MPTilemap:
; Ch1 ─ Ch2 ─ Wave ─ Noise ──
db $08, $09, $0a, "─", $1f, $08, $09, $0b, "─", $1f, $0c, $0d, $0e, "─", $1f, $0f, $10, $11, "──"
db "    │    │    │Set  "
db "    │    │    │     "
db "    │    │    │     "
MPKeymap:
db $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05

ChannelsOnTilemaps:
	db $08, $09, $0a
	db $08, $09, $0b
	db $0c, $0d, $0e
	db $0f, $10, $11

ChannelsOffTilemaps:
	db $12, $13, $14
	db $12, $13, $15
	db $16, $17, $18
	db $19, $1a, $1b

NoteOAM:
	; y, x, tile id, OAM attributes
	db 0, 0, $20, BEHIND_BG
	db 0, 0, $40, BEHIND_BG
	db 0, 0, $60, BEHIND_BG

BlankName:
	db "@"

SongInfo:
	; title, origin, composer, additional credits
	db "Opening@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, 0
	db "Title Screen@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, 0
	db "Main Menu@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "New Bark Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, 0
	db "Mom@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Elm's Lab@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Lyra Appears@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Rival@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Lyra Departs@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Route 29@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Johto Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Johto Wild Night@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Victory! Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Cherrygrove City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Follow Me!@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Pokémon Center@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Heal Pokémon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Captured Pokémon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Youngster@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Johto Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Victory! Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 30@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Violet City@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Sprout Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Sage@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Poké Mart@", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_FROGGESTSPIRIT
	db "Union Cave@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Ruins of Alph@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Unown Radio@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Azalea Town@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Spotted! Team Rocket@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Vs.Team Rocket@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 34@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Rival Appears@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Rival@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Rival Departs@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Evolution@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Goldenrod City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "PokéCom Center@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, 0
	db "Gym@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Johto Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Final Pokémon@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Victory! Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Pokémon Channel@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Buena's Password@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, 0
	db "Game Corner@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Bicycle@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Lass@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "National Park@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Bug-Catching Contest@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Bug-Catching ContestRanking@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Ecruteak City@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Dance Theater@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Spotted! Kimono Girl@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Burned Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Eusine Appears@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, 0
	db "Prof.Oak's Pokémon   Talk@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 38@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Pokémon March@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Olivine Lighthouse@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Surfing@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Cianwood City@", ORIGIN_HGSS, COMPOSER_GO_ICHINOSE, COMPOSER_MMMMMM
	db "Route 47@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Jessie & James      Appear@", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, 0
	db "Safari Zone Gate@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Surfing Pikachu@", ORIGIN_Y, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 42@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Stark Mountain@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Rocket Radio@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Rocket Hideout@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Pokémaniac@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Radio Tower Occu-   pied!@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Ice Path@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Dragon's Den@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Clair@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, 0
	db "Route 4@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Bell Tower@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Suicune@", ORIGIN_C, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 26@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Indigo Plateau@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Victory Road@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Indigo Plateau@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Elite Four@", ORIGIN_SM, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Hall of Fame@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "S.S.Aqua@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Vermilion City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Kanto Gym Leader@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Black City@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Lavender Town@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Pokémon Tower@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Lavender Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, 0
	db "Vs.Kanto Wild@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Cerulean City@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Route 24@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Magnet Train@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Pokémon Lullaby@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Celadon City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Game Corner@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Canalave City@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Bicycle@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db "Route 11@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Poké Flute@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 209@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Route 210@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Diglett's Cave@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Viridian Forest@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, 0
	db "Spotted! Hiker@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Pewter City@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 3@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Officer@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Mt.Moon@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Mt.Moon Square@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Route 1@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Pallet Town@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Oak's Lab@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Spotted! Beauty@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Kanto Trainer@", ORIGIN_GS, COMPOSER_JUNICHI_MASUDA, 2
	db "Cinnabar Island@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Cinnabar Mansion@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Trainer@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Eterna Forest@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Mt.Chimney@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Mt.Pyre@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Battle Tower@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, 0
	db "Battle Tower Lobby@", ORIGIN_C, COMPOSER_MORIKAZU_AOKI, 0
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
	db "Lugia's Song@", ORIGIN_ANIME, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Lugia@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Summoning Dance@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Ho-Oh@", ORIGIN_HGSS, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Cerulean Cave@", ORIGIN_RB, COMPOSER_JUNICHI_MASUDA, 0
	db "Vs.Kanto Legend@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Vs.Gym Leader@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Gym Leader@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Gym Leader@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Gym Leader@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_PUM
	db "Vs.Elite Four@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Celestial Tower@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Mt.Coronet@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_DPPT, COMPOSER_JUNICHI_MASUDA, COMPOSER_FROGGESTSPIRIT
	db "Vs.World Champion-  ship Finals@", ORIGIN_BW, COMPOSER_JUNICHI_MASUDA, COMPOSER_PIGU
	db "Abandoned Ship@", ORIGIN_RSE, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Vs.Champion@", ORIGIN_B2W2, COMPOSER_JUNICHI_MASUDA, COMPOSER_MMMMMM
	db "Credits@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Post-Credits@", ORIGIN_GS, COMPOSER_GO_ICHINOSE, 0
	db "Title@", ORIGIN_XY, COMPOSER_JUNICHI_MASUDA, COMPOSER_SHANTYTOWN
	db -1

Origin:
	db ORIGIN_RB, "R/B@"
	db ORIGIN_Y, "Y@"
	db ORIGIN_GS, "G/S@"
	db ORIGIN_C, "C@"
	db ORIGIN_RSE, "R/S/E@"
	db ORIGIN_FRLG, "FR/LG@"
	db ORIGIN_DPPT, "D/P/Pt@"
	db ORIGIN_HGSS, "HG/SS@"
	db ORIGIN_BW, "B/W@"
	db ORIGIN_B2W2, "B2/W2@"
	db ORIGIN_XY, "X/Y@"
	db ORIGIN_ORAS, "OR/AS@"
	db ORIGIN_SM, "S/M@"
	db ORIGIN_ANIME, "M02@"
	db -1

Artist:
	db COMPOSER_JUNICHI_MASUDA, "Junichi Masuda@"
	db COMPOSER_GO_ICHINOSE, "Go Ichinose@"
	db COMPOSER_JUNICHI_MASUDA_GO_ICHINOSE, "Junichi Masuda,     Go Ichinose@"
	db COMPOSER_MORIKAZU_AOKI, "Morikazu Aoki@"
	db COMPOSER_ICHIRO_SHIMAKURA, "Ichiro Shimakura@"
	db COMPOSER_SHOTA_KAGEYAMA, "Shota Kageyama@"
	db COMPOSER_FROGGESTSPIRIT, "FroggestSpirit@"
	db COMPOSER_MMMMMM, "Mmmmmm@"
	db COMPOSER_PUM, "Pum@"
	db COMPOSER_SHANTYTOWN, "ShantyTown@"
	db COMPOSER_PIGU, "Pigu@"
	db COMPOSER_END, "@"
	db -1
