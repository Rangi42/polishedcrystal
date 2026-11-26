; UpdateChannels writes each channel to the APU within VBlank. Match the
; processing time of ParseSFXOrCry so retriggers keep their waveform phase.
MACRO delta_note_delay ; SM83 machine cycles; delays of eight or more clobber af
	if \1 >= 8
		ld a, (\1 - 1) / 4
	.wait\@
		dec a
		jr nz, .wait\@
		rept (\1 - 1) % 4
			nop ; no-optimize nops (remainder of the four-cycle loop)
		endr
	else
		rept \1
			nop ; no-optimize nops (sub-loop APU timing)
		endr
	endc
ENDM

; ParseSFXOrCry enters here with the next tag from a continued packet.
DecodeDeltaNote:
	delta_note_delay 29
	jr Music_DeltaNotes.read
; ParseMusic dispatches a packet marker through MusicCommands. It starts a
; timed note, so SetNoteDuration returns directly to the caller of ParseMusic.
Music_DeltaNotes:
	pop hl ; command dispatch's return to the ParseMusic loop
	; ParseMusic.readnote checks channel 4's music-player selector.
	ld a, [wCurChannel]
	cp CHAN4
	jr nz, .flags
	ld a, [wChannelSelectorSwitches+3]
	and a
	jr nz, .flags
	delta_note_delay 10
.flags
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_SFX, [hl]
	jr nz, .read
	delta_note_delay 7
.read
	; ParseSFXOrCry sets the note flags, intensity, frequency and duration.
	; Fetch the packed note's operands together from the channel's ROM bank.
	inc hl
	inc hl ; NoteFlags
	set NOTE_NOISE_SAMPLING, [hl]
	ld hl, wChannel1MusicBank - wChannel1
	add hl, bc
	ld a, [hli]
	ld e, a ; stream bank
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, e
	call ReadDeltaNoteOperands
	; GetMusicByte advances the channel's address past its operands.
	push de ; tag and absolute note's volume/high frequency
	ld a, l
	ld d, h
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld [hli], a
	ld [hl], d
	pop de
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	res SOUND_DELTA_NOTES, [hl]
	ld a, d
	cp delta_absolute_cmd
	jr nc, .absolute
	cp DELTA_NOTE_MORE
	jr nc, .more
	delta_note_delay 4
	jr .type
.more
	set SOUND_DELTA_NOTES, [hl]
	sub DELTA_NOTE_MORE
.type
	ld d, a
	swap a
	and DELTA_NOTE_DURATION_MASK
	push af ; duration
	ld a, d
	cp DELTA_NOTE_NIBBLE
	jr c, .wide
	and DELTA_NOTE_NIBBLE_MASK
	xor DELTA_NOTE_SIGN
	sub DELTA_NOTE_SIGN
	ld d, a ; signed nibble
	ld a, e ; intensity
	ld e, d
	jr .delta
.wide
	delta_note_delay 5
	swap a
	and AUD1ENV_INIT_VOLUME
	or DELTA_NOTE_ENVELOPE
	; e holds the signed byte delta.
.delta
	; ParseSFXOrCry writes one frequency byte for noise and two for tone.
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hli], a
	ld a, [wCurChannel]
	ld d, a
	and NUM_MUSIC_CHANS - 1
	cp CHAN4
	jr z, .noise
	; ParseMusic.readnote also exposes channel 4 hits to the music player.
	ld a, e
	add [hl]
	ld [hli], a
	ld a, 0 ; no-optimize a = 0 (adc needs the low byte's carry)
	adc [hl]
	bit 7, e
	jr z, .high
	dec a
.high
	ld [hl], a
	jr .tone
.absolute
	bit DELTA_NOTE_ABS_MORE_F, e
	jr nz, .absolute_more
	delta_note_delay 2
	jr .absolute_duration
.absolute_more
	set SOUND_DELTA_NOTES, [hl]
.absolute_duration
	sub delta_absolute_cmd
	srl a
	push af ; duration
	sbc a
	and DELTA_NOTE_ENVELOPE ^ DELTA_NOTE_ALT_ENV
	xor DELTA_NOTE_ENVELOPE
	ld d, a ; envelope
	ld a, e
	and AUD1ENV_INIT_VOLUME
	or d
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hli], a
	ld a, [wCurMusicByte]
	ld [hli], a
	ld a, e
	and HIGH((1 << DELTA_NOTE_PITCH_BITS) - 1)
	ld [hl], a

	ld [wCurMusicByte], a
	delta_note_delay 23
	jr .tone_delay
.tone
	; GetMusicByte leaves the last uncompressed operand in wCurMusicByte.
	ld [wCurMusicByte], a
.tone_delay
	delta_note_delay 105
	jr .duration

.noise
	; ParseMusic.readnote also exposes channel 4 hits to the music player.
	ld a, e
	add [hl]
	ld [hl], a
	ld [wCurMusicByte], a
	ld a, d
	cp CHAN4
	jr nz, .sfx_noise
	ld a, [wChannelSelectorSwitches+3]
	and a
	jr nz, .muted_noise
	ld [wNoiseHit], a ; packed durations fit in the low nibble
.duration
	delta_note_delay 1
	pop af
	jmp SetNoteDuration
.sfx_noise
	delta_note_delay 7
.muted_noise
	jr .duration ; no-optimize stub jump (matches the wNoiseHit write)
