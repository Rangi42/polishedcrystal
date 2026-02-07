; The entire sound engine. Uses section "audio" in WRAM.

; Interfaces are in bank 0.

; Notable functions:
; 	FadeMusic
; 	PlayStereoSFX

_InitSound::
; restart sound operation
; clear all relevant hardware registers & wram
	push hl
	push de
	push bc
	push af
	call MusicOff

	ld hl, rAUDVOL ; channel control registers
	xor a
	ld [hli], a ; rAUDVOL  ; volume/vin
	ld [hli], a ; rAUDTERM ; sfx channels
	; all channels on
	ld [hl], $80 ; rAUDENA ; music channels

	ld hl, AUD1RAM ; sound channel registers
	ld e, NUM_MUSIC_CHANS
.clearsound
	; channel     AUD1RAM,    AUD2RAM,   AUD3RAM,    AUD4RAM
	xor a
	ld [hli], a ; rAUD1SWEEP, unused,    rAUD3ENA,   unused    ; sweep = 0

	ld [hli], a ; rAUD1LEN,   rAUD2LEN,  rAUD3LEN,   rAUD4LEN  ; length/wavepattern = 0
	ld a, $8
	ld [hli], a ; rAUD1ENV,   rAUD2ENV,  rAUD3LEVEL, rAUD4ENV  ; envelope = 0
	xor a
	ld [hli], a ; rAUD1LOW,   rAUD2LOW,  rAUD3LOW,   rAUD4POLY ; frequency lo = 0
	ld a, $80
	ld [hli], a ; rAUD1HIGH,  rAUD2HIGH, rAUD3HIGH,  rAUD4GO   ; restart sound (freq hi = 0)
	dec e
	jr nz, .clearsound

	ld hl, wChannels ; start of channel data
	ld bc, wChannelsEnd - wChannels ; length of area to clear (entire sound wram area)
	xor a
	rst ByteFill

	dec a
	ld [wCh3LoadedWaveform], a ; initializes to -1 so title music can use sample 0
	ldh [rAUD3ENA], a ; ch3 dac on
	ld a, MAX_VOLUME
	ld [wVolume], a
	call MusicOn
	jmp PopAFBCDEHL

MusicFadeRestart:
; restart but keep the music id to fade in to
	ld a, [wMusicFadeIDHi]
	push af
	ld a, [wMusicFadeIDLo]
	push af
	call _InitSound
	pop af
	ld [wMusicFadeIDLo], a
	pop af
	ld [wMusicFadeIDHi], a
	ret

MusicOn:
	ld a, TRUE
	ld [wMusicPlaying], a
	ret

MusicOff:
	xor a
	ld [wMusicPlaying], a
	ret

_UpdateSound::
; called once per frame
	; no use updating audio if it's not playing
	ld a, [wMusicPlaying]
	and a
	ret z
	; start at ch1
	xor a
	ld [wCurChannel], a ; just
	ld [wSoundOutput], a ; off
	ld bc, wChannel1
.loop
	; is the channel active?
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .nextchannel
	; check time left in the current note
	ld hl, wChannel1NoteDuration - wChannel1
	add hl, bc
	ld a, [hl]
	cp $2 ; 1 or 0?
	jr c, .noteover
	dec [hl]
	jr .continue_sound_update

.noteover
	; reset vibrato delay
	ld hl, wChannel1VibratoDelay - wChannel1
	add hl, bc
	ld a, [hli]
	ld [hl], a ; VibratoDelayCount
	; turn vibrato off for now
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	res SOUND_PITCH_SLIDE, [hl]
	; get next note
	call ParseMusic
.continue_sound_update
	call ApplyPitchWheel
	; duty cycle
	ld hl, wChannel1DutyCycle - wChannel1
	add hl, bc
	ld a, [hli]
	and $c0
	ld [wCurTrackDuty], a
	; intensity
	ld a, [hli]
	ld [wCurTrackIntensity], a
	; frequency
	ld a, [hli]
	ld [wCurTrackFrequency], a
	ld a, [hl]
	ld [wCurTrackFrequency + 1], a
	; vibrato, noise
	call HandleTrackVibrato ; handle vibrato and other things
	call HandleNoise
	; turn off music when playing sfx?
	ld a, [wSFXPriority]
	and a
	jr z, .next
	; are we in a sfx channel right now?
	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .next
	; are any sfx channels active?
	; if so, mute
	call CheckSFX
	jr z, .next
.restnote
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_REST, [hl] ; Rest
.next
	; are we in a sfx channel right now?
	ld a, [wCurChannel]
	cp CHAN5 ; sfx
	jr nc, .sfx_channel
	ld hl, wChannel5Flags - wChannel1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .sound_channel_on
.sfx_channel
	call UpdateChannels
	ld hl, wChannel1Tracks - wChannel1
	add hl, bc
	ld a, [wSoundOutput]
	or [hl]
	ld [wSoundOutput], a
.sound_channel_on
	; clear note flags
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	xor a
	ld [hl], a
.nextchannel
	; next channel
	ld hl, wChannel2 - wChannel1
	add hl, bc
	ld c, l
	ld b, h
	ld hl, wCurChannel
	inc [hl]
	ld a, [hl]
	cp $8 ; are we done?
	jmp nz, .loop ; do it all again

	call PlayDanger
	; fade music in/out
	call FadeMusic
	; write volume to hardware register
	ld a, [wVolume]
	ldh [rAUDVOL], a
	; write SO on/off to hardware register
	ld hl, wSoundOutput
	ld a, [wOptions1]
	bit STEREO, a ; stereo
	ld a, [hl]
	jr nz, .stereo
	; No stereo, or left and right masks
	swap a
	or [hl]
.stereo
	ldh [rAUDTERM], a
	ret

UpdateChannels:
	ld a, [wCurChannel]
	and $7
	call StackJumpTable

.Jumptable:
	table_width 2
; music channels
	dw .Channel1
	dw .Channel2
	dw .Channel3
	dw .Channel4
	assert_table_length NUM_MUSIC_CHANS
; sfx channels
; identical to music channels, except .Channel5 is not disabled by the low-HP danger sound
; (instead, PlayDanger does not play the danger sound if sfx is playing)
	dw .Channel5
	dw .Channel6
	dw .Channel7
	dw .Channel8
	assert_table_length NUM_CHANNELS

.Channel1:
	ld a, [wLowHealthAlarm]
	cp 255
	jr z, .Channel5
	bit 7, a
	ret nz
.Channel5:
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	bit NOTE_PITCH_SWEEP, [hl]
	jr z, .noPitchSweep
	ld a, [wSoundInput]
	ldh [rAUD1SWEEP], a
.noPitchSweep
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch1_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch1_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	jr nz, .ch1_frequency_override
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	jr nz, .ch1_vibrato_override
	jr .ch1_check_duty_override

.ch1_frequency_override
	ld a, [wCurTrackFrequency]
	ldh [rAUD1LOW], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rAUD1HIGH], a
.ch1_check_duty_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	ret z
	ld a, [wCurTrackDuty]
	ldh [rAUD1LEN], a
	ret

.ch1_vibrato_override
	ld a, [wCurTrackDuty]
	ldh [rAUD1LEN], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD1LOW], a
	ret

.ch1_rest
	xor a
	ldh [rAUD1SWEEP], a
	ld a, AUD1ENV_UP
	ldh [rAUD1ENV], a
	ld a, AUD1HIGH_RESTART
	ldh [rAUD1HIGH], a
	ret

.ch1_noise_sampling
	ld a, [wCurTrackDuty]
	ldh [rAUD1LEN], a
	ld a, [wCurTrackIntensity]
	ldh [rAUD1ENV], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD1LOW], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rAUD1HIGH], a
	ret

.Channel2:
.Channel6:
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch2_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch2_noise_sampling
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	jr nz, .ch2_vibrato_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	ret z
	ld a, [wCurTrackDuty]
	ldh [rAUD2LEN], a
	ret

.ch2_vibrato_override
	ld a, [wCurTrackDuty]
	ldh [rAUD2LEN], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD2LOW], a
	ret

.ch2_rest
	ld a, AUD2ENV_UP
	ldh [rAUD2ENV], a
	ld a, AUD2HIGH_RESTART
	ldh [rAUD2HIGH], a
	ret

.ch2_noise_sampling
	ld a, [wCurTrackDuty]
	ldh [rAUD2LEN], a
	ld a, [wCurTrackIntensity]
	ldh [rAUD2ENV], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD2LOW], a
	ld a, [wCurTrackFrequency + 1]
	or $80 ; initial (restart)
	ldh [rAUD2HIGH], a
	ret

.Channel3:
.Channel7:
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch3_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch3_noise_sampling
	bit NOTE_VIBRATO_OVERRIDE, [hl]
	ret z

	ld a, [wCurTrackFrequency]
	ldh [rAUD3LOW], a
	ret

.ch3_rest
	; mute ch3
	xor a
	ldh [rAUD3LEVEL], a
	ret

.ch3_noise_sampling
	ld hl, wCh3LoadedWaveform
	ld a, [wCurTrackIntensity]
	ld d, a
	maskbits NUM_WAVEFORMS
	cp [hl] ; Loaded waveform == this notes waveform?
	ld [hl], a
	call nz, ReloadWaveform

	ld a, d
	rlca
	ldh [rAUD3LEVEL], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD3LOW], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rAUD3HIGH], a
	ret

.Channel4:
.Channel8:
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	bit NOTE_REST, [hl] ; rest
	jr nz, .ch4_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch4_noise_sampling
	ret

.ch4_rest
	ld a, AUD4ENV_UP
	ldh [rAUD4ENV], a
	ld a, AUD4GO_RESTART
	ldh [rAUD4GO], a
	ret

.ch4_noise_sampling
	ld a, [wCurTrackIntensity]
	ldh [rAUD4ENV], a
	ld a, [wCurTrackFrequency]
	ldh [rAUD4POLY], a
	ld a, $80
	ldh [rAUD4GO], a
	ret

PlayDanger:
	ld a, [wLowHealthAlarm]
	bit 7, a
	ret z
	cp 255
	ret z
	ld d, a
	call CheckSFX
	jr nz, .increment
	ld a, d
	and $1f
	jr z, .begin
	cp 16 ; halfway
	jr nz, .increment
	ld hl, DangerSoundLow
	jr .updatehw

.begin
	ld hl, DangerSoundHigh
.updatehw
	xor a
	ldh [rAUD1SWEEP], a ; sweep off
	ld a, [hli]
	ldh [rAUD1LEN], a ; sound length / duty cycle
	ld a, [hli]
	ldh [rAUD1ENV], a ; ch1 volume envelope
	ld a, [hli]
	ldh [rAUD1LOW], a ; ch1 frequency lo
	ld a, [hli]
	ldh [rAUD1HIGH], a ; ch1 frequency hi
.increment
	ld a, d
	and $e0
	ld e, a
	ld a, d
	and $1f
	inc a
	cp 30
	jr c, .noreset
	add 2
.noreset
	add e
	jr nz, .load
	dec a
.load
	ld [wLowHealthAlarm], a
	; is hw ch1 on?
	ld a, [wSoundOutput]
	and $11
	ret nz
	; if not, turn it on
	ld a, [wSoundOutput]
	or $11
	ld [wSoundOutput], a
	ret

DangerSoundHigh:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $50 ; frequency: $750
	db $87 ; restart sound

DangerSoundLow:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $ee ; frequency: $6ee
	db $86 ; restart sound

FadeMusic:
; fade music if applicable
; usage:
;	write to wMusicFade
;	song fades out at the given rate
;	load song id in wMusicFadeID
;	fade new song in
; notes:
;	max # frames per volume level is $3f

	; fading?
	ld a, [wMusicFade]
	and a
	ret z
	; has the count ended?
	ld a, [wMusicFadeCount]
	and a
	jr z, .update
	; count down
	dec a
	ld [wMusicFadeCount], a
	ret

.update
	ld a, [wMusicFade]
	ld d, a
	; get new count
	and $3f
	ld [wMusicFadeCount], a
	; get SO1 volume
	ld a, [wVolume]
	and $7
	; which way are we fading?
	bit 7, d
	jr nz, .fadein
	; fading out
	and a
	jr z, .novolume
	dec a
	jr .updatevolume

.novolume
	; make sure volume is off
	xor a
	ld [wVolume], a
	; did we just get on a bike?
	ld a, [wPlayerState]
	dec a ; bicycle = 1
	jr z, .bicycle
	push bc
	; restart sound
	call MusicFadeRestart
	; get new song id
	ld a, [wMusicFadeIDLo]
	and a
	jr z, .quit ; this assumes there are fewer than 256 songs!
	ld e, a
	ld a, [wMusicFadeIDHi]
	ld d, a
	; load new song
	call _PlayMusic
.quit
	; cleanup
	pop bc
	; stop fading
	xor a
	ld [wMusicFade], a
	ret

.bicycle
	push bc
	; restart sound
	call MusicFadeRestart
	; this turns the volume up
	; turn it back down
	xor a
	ld [wVolume], a
	; get new song id
	ld hl, wMusicFadeID
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; load new song
	call _PlayMusic
	pop bc
	; fade in
	ld hl, wMusicFade
	set 7, [hl]
	ret

.fadein
	; are we done?
	cp $7
	jr nc, .maxvolume
	; inc volume
	inc a
	jr .updatevolume

.maxvolume
	; we're done
	xor a
	ld [wMusicFade], a
	ret

.updatevolume
	; hi = lo
	ld d, a
	swap a
	or d
	ld [wVolume], a
	ret

LoadNote:
	; wait for pitch wheel to finish
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_PITCH_SLIDE, [hl]
	ret z
	; get note duration
	ld hl, wChannel1NoteDuration - wChannel1
	add hl, bc
	ld a, [hl]
	; prevent 0-duration notes causing infinite loops
	; (possible with tempo adjustment)
	and a
	jr nz, .ok1
	ld a, 1
.ok1
	ld hl, wCurNoteDuration
	sub [hl]
	jr nc, .ok2
	ld a, 1
.ok2
	ld [hl], a
	; get frequency
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; get direction of pitch wheel
	ld hl, wChannel1PitchWheelTarget - wChannel1
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	sbc a
	add d
	ld d, a
	ld hl, wChannel1PitchWheelTarget + 1 - wChannel1
	add hl, bc
	sub [hl]
	jr nc, .greater_than
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	set SOUND_PITCH_SLIDE_DIR, [hl]
	; get frequency
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wChannel1PitchWheelTarget - wChannel1
	add hl, bc
	ld a, [hli]
	sub e
	ld e, a
	sbc a
	add d
	ld d, a
	ld a, [hl]
	sub d
	ld d, a
	jr .resume

.greater_than
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	res SOUND_PITCH_SLIDE_DIR, [hl]
	; get frequency
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	; get distance from pitch wheel target
	ld hl, wChannel1PitchWheelTarget - wChannel1
	add hl, bc
	sub [hl]
	ld e, a
	sbc a
	add d
	ld d, a
	inc hl
	sub [hl]
	ld d, a
.resume
	; de = x * [wCurNoteDuration] + y
	; x + 1 -> d
	; y -> a
	push bc
	ld hl, wCurNoteDuration
	ld b, 0 ; quotient
.loop
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .loop
	ld a, d
	and a
	jr z, .quit
	dec d
	jr .loop

.quit
	ld a, e ; remainder
	add [hl]
	ld d, b ; quotient
	pop bc
	ld hl, wChannel1PitchWheelAmountFraction - wChannel1
	add hl, bc
	ld [hld], a ; remainder
	ld [hl], d ; quotient, PitchWheelAmount
	ld hl, wChannel1Field0x25 - wChannel1
	add hl, bc
	ld [hl], 0
	ret

HandleTrackVibrato:
; handle duty, cry pitch, and vibrato
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_DUTY_LOOP, [hl] ; duty
	jr z, .next
	ld hl, wChannel1DutyCycle - wChannel1
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld [wCurTrackDuty], a
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_DUTY_OVERRIDE, [hl]
.next
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_PITCH_OFFSET, [hl]
	jr z, .vibrato
	ld hl, wChannel1PitchOffset - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wCurTrackFrequency
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, wCurTrackFrequency
	ld a, e
	ld [hli], a
	ld [hl], d
.vibrato
	; is vibrato on?
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_VIBRATO, [hl] ; vibrato
	ret z
	; is vibrato active for this note yet?
	; is the delay over?
	ld hl, wChannel1VibratoDelayCount - wChannel1
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .subexit
	; is the extent nonzero?
	inc hl
	ld a, [hli] ; VibratoExtent
	and a
	ret z
	; save it for later
	ld d, a
	; is it time to toggle vibrato up/down?
	ld a, [hl] ; VibratoRate
	and $f ; count
	jr z, .toggle
.subexit
	dec [hl]
	ret

.toggle
	; refresh count
	ld a, [hl]
	swap a
	or [hl]
	ld [hl], a
	; ????
	ld a, [wCurTrackFrequency]
	ld e, a
	; toggle vibrato up/down
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_VIBRATO_DIR, [hl] ; vibrato up/down
	jr z, .down
; up
	; vibrato down
	res SOUND_VIBRATO_DIR, [hl]
	; get the delay
	ld a, d
	and $f ; lo
	;
	ld d, a
	ld a, e
	sub d
	jr nc, .no_carry
	xor a
	jr .no_carry

.down
	; vibrato up
	set SOUND_VIBRATO_DIR, [hl]
	; get the delay
	ld a, d
	and $f0 ; hi
	swap a ; move it to lo
	;
	add e
	jr nc, .no_carry
	ld a, $ff
.no_carry
	ld [wCurTrackFrequency], a
	;
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_VIBRATO_OVERRIDE, [hl]
	ret

ApplyPitchWheel:
	; quit if pitch wheel inactive
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_PITCH_SLIDE, [hl]
	ret z
	; de = Frequency
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; check whether pitch wheel is going up or down
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	bit SOUND_PITCH_SLIDE_DIR, [hl]
	jr z, .decreasing
	; frequency += [Channel*PitchWheelAmount]
	ld hl, wChannel1PitchWheelAmount - wChannel1
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, de
	ld d, h
	ld e, l
	; [Channel*Field0x25] += [Channel*PitchWheelAmountFraction]
	; if rollover: Frequency += 1
	ld hl, wChannel1PitchWheelAmountFraction - wChannel1
	add hl, bc
	ld a, [hl]
	ld hl, wChannel1Field0x25 - wChannel1
	add hl, bc
	add [hl]
	ld [hl], a
	jr nc, .no_increment
	inc de
.no_increment
	; Compare the dw at [Channel*PitchWheelTarget] to de.
	; If frequency is greater, we're finished.
	; Otherwise, load the frequency and set two flags.
	ld hl, wChannel1PitchWheelTarget + 1 - wChannel1
	add hl, bc
	ld a, [hld]
	cp d
	jr c, .finished_pitch_wheel
	jr nz, .continue_pitch_wheel
	ld a, [hl]
	cp e
	jr c, .finished_pitch_wheel
	jr .continue_pitch_wheel

.decreasing
	; frequency -= [Channel*PitchWheelAmount]
	ld a, e
	ld hl, wChannel1PitchWheelAmount - wChannel1
	add hl, bc
	sub [hl]
	ld e, a
	sbc a
	add d
	ld d, a
	; [Channel*Field0x25] *= 2
	; if rollover: Frequency -= 1
	inc hl
	sla [hl] ; PitchWheelAmountFraction
	jr nc, .no_decrement
	dec de
.no_decrement
	; Compare the dw at [Channel*PitchWheelTarget] to de.
	; If frequency is lower, we're finished.
	; Otherwise, load the frequency and set two flags.
	ld hl, wChannel1PitchWheelTarget + 1 - wChannel1
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .finished_pitch_wheel
	jr nz, .continue_pitch_wheel
	dec hl
	ld a, e
	cp [hl]
	jr nc, .continue_pitch_wheel
.finished_pitch_wheel
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	res SOUND_PITCH_SLIDE, [hl]
	res SOUND_PITCH_SLIDE_DIR, [hl]
	ret

.continue_pitch_wheel
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_FREQ_OVERRIDE, [hl]
	set NOTE_DUTY_OVERRIDE, [hl]
	ret

HandleNoise:
	; is noise sampling on?
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_NOISE, [hl] ; noise sampling
	ret z
	; are we in a sfx channel?
	ld a, [wCurChannel]
	bit NOISE_CHAN_F, a ; sfx
	jr nz, .next
	; is ch8 on? (noise)
	ld hl, wChannel8Flags
	bit SOUND_CHANNEL_ON, [hl] ; on?
	jr z, .next
	; is ch8 playing noise?
	bit SOUND_NOISE, [hl]
	ret nz ; quit if so
.next
	ld a, [wNoiseSampleDelay]
	and a
	jr z, ReadNoiseSample
	dec a
	ld [wNoiseSampleDelay], a
	ret

ReadNoiseSample:
; sample struct:
;	[wx] [yy] [zz]
;	w: ? either 2 or 3
;	x: duration
;	zz: intensity
;       yy: frequency

	; hl = [wNoiseSampleAddress]
	ld hl, wNoiseSampleAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; is it empty?
	or h
	ret z

	ld a, [hli]

	cp $ff
	ret z

	and $f
	inc a
	ld [wNoiseSampleDelay], a
	ld a, [hli]
	ld [wCurTrackIntensity], a
	ld a, [hli]
	ld [wCurTrackFrequency], a
	xor a
	ld [wCurTrackFrequency + 1], a

	ld d, h
	ld a, l
	ld hl, wNoiseSampleAddress
	ld [hli], a
	ld [hl], d

	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	ret

ParseMusic:
; parses until a note is read or the song is ended
	call GetMusicByte ; store next byte in a
	cp FIRST_MUSIC_CMD ; is it a note?
	jr c, .readnote
	; then it's a command
	inc a ; is the song over?
	jr z, .endchannel
.readcommand
	; get command #
	sub FIRST_MUSIC_CMD + 1
	ld hl, MusicCommands
	call JumpTable
	jr ParseMusic ; start over

.readnote
	ld a, [wCurChannel]
	cp CHAN4
	jr nz, .notnoise
	ld a, [wChannelSelectorSwitches+3]
	and a
	jr nz, .notnoise
	ld a, [wCurMusicByte]
	and $f0
	ld [wNoiseHit], a
.notnoise
; wCurMusicByte contains current note
; special notes
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_SFX, [hl]
	jmp nz, ParseSFXOrCry
	bit SOUND_CRY, [hl]
	jmp nz, ParseSFXOrCry
	bit SOUND_NOISE, [hl] ; noise sample
	jmp nz, GetNoiseSample
; normal note
	; set note duration (bottom nybble)
	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration

	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .notMuted
	ld e, a
	ld d, 0
	ld hl, wChannelSelectorSwitches
	add hl, de
	ld a, [hl]
	and a
	jr z, .notMuted
	xor a
	jr .rest

.notMuted
	; get note pitch (top nybble)
	ld a, [wCurMusicByte]
	swap a
	and $f
	jr z, .rest ; pitch 0-> rest
	; update pitch
	ld hl, wChannel1Pitch - wChannel1
	add hl, bc
	ld [hl], a
	; store pitch in e
	ld e, a
	; store octave in d
	ld hl, wChannel1Octave - wChannel1
	add hl, bc
	ld d, [hl]
	; update frequency
	call GetFrequency
	ld hl, wChannel1Frequency - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	; ????
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	jmp LoadNote

;
.endchannel
; $ff is reached in music data
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_SUBROUTINE, [hl] ; in a subroutine?
	jr nz, .readcommand ; execute
	ld a, [wCurChannel]
	cp CHAN5 ; channels 0-3?
	jr nc, .chan_5to8
	; ????
	ld hl, wChannel5Flags - wChannel1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .ok
.chan_5to8
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_CRY, [hl]
	call nz, RestoreVolume
	; end music
	ld a, [wCurChannel]
	cp CHAN5 ; channel 5?
	jr nz, .ok
	; ????
	xor a
	ldh [rAUD1SWEEP], a ; sweep = 0
.ok
; stop playing
	; turn channel off
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	res SOUND_CHANNEL_ON, [hl]
	; clear music id & bank
	ld hl, wChannel1MusicID - wChannel1
	add hl, bc
	xor a
	ld [hli], a ; id hi
	ld [hli], a ; id lo
	ld [hl], a  ; bank
	; fallthrough

.rest
; note = rest
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_REST, [hl] ; Rest
	ret

RestoreVolume:
	; ch5 only
	ld a, [wCurChannel]
	cp CHAN5
	ret nz
	xor a
	ld hl, wChannel6PitchOffset
	ld [hli], a
	ld [hl], a
	ld hl, wChannel8PitchOffset
	ld [hli], a
	ld [hl], a
	ld a, [wLastVolume]
	ld [wVolume], a
	xor a
	ld [wLastVolume], a
	ld [wSFXPriority], a
	ret

ParseSFXOrCry:
	; turn noise sampling on
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl] ; noise sample
	; update note duration
	ld a, [wCurMusicByte]
	call SetNoteDuration ; top nybble doesnt matter?
	; update intensity from next param
	call GetMusicByte
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hl], a
	; update lo frequency from next param
	call GetMusicByte
	ld hl, wChannel1FrequencyLo - wChannel1
	add hl, bc
	ld [hl], a
	; are we on the last channel? (noise sampling)
	ld a, [wCurChannel]
	or ~$3
	inc a
	ret z
	; update hi frequency from next param
	call GetMusicByte
	ld hl, wChannel1FrequencyHi - wChannel1
	add hl, bc
	ld [hl], a
	ret

GetNoiseSample:
; load ptr to sample header in wNoiseSampleAddress
	; are we on the last channel?
	ld a, [wCurChannel]
	or ~$3
	inc a
	; ret if not
	ret nz
	; update note duration
	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration
	; check current channel
	ld a, [wCurChannel]
	bit NOISE_CHAN_F, a ; are we in a sfx channel?
	ld a, [wSFXNoiseSampleSet]
	jr nz, .next
	; check wChannelSelectorSwitches
	ld a, [wChannelSelectorSwitches+3]
	and a
	ret nz
	ld hl, wChannel8Flags
	bit SOUND_CHANNEL_ON, [hl] ; is ch8 on? (noise)
	ret nz
	ld a, [wMusicNoiseSampleSet]
.next
	; load noise sample set id into de
	ld e, a
	ld d, 0
	; load ptr to noise sample set in hl
	ld hl, Drumkits
	add hl, de
	ld e, [hl]
	add hl, de
	; get pitch
	ld a, [wCurMusicByte]
	; non-rest note?
	and $f0
	jr z, .rest
	swap a
	; use 'pitch' to seek noise sample set
	ld e, a
	ld d, 0
	add hl, de
	ld e, [hl]
	add hl, de
	; load sample pointer into wNoiseSampleAddress
	ld a, l
	ld [wNoiseSampleAddressLo], a
	ld a, h
	ld [wNoiseSampleAddressHi], a
	; clear ????
	xor a
	ld [wNoiseSampleDelay], a
	ret

.rest
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_REST, [hl]
	ret

MusicCommands:
; entries correspond to audio constants (see macros/scripts/audio.asm)
	table_width 2
	dw Music_Octave8 ; octave 8
	dw Music_Octave7 ; octave 7
	dw Music_Octave6 ; octave 6
	dw Music_Octave5 ; octave 5
	dw Music_Octave4 ; octave 4
	dw Music_Octave3 ; octave 3
	dw Music_Octave2 ; octave 2
	dw Music_Octave1 ; octave 1
	dw Music_DutyCycle0 ; duty cycle 0
	dw Music_DutyCycle1 ; duty cycle 1
	dw Music_DutyCycle2 ; duty cycle 2
	dw Music_DutyCycle3 ; duty cycle 3
	dw Music_NoteType ; note length + intensity
	dw Music_ForceOctave ; set starting octave
	dw Music_Tempo ; tempo
	dw Music_Intensity ; intensity
	dw Music_SoundStatus ; update sound status
	dw Music_SoundDuty ; sfx duty
	dw Music_ToggleSFX ; sound on/off
	dw Music_SlidePitchTo ; pitch wheel
	dw Music_Vibrato ; vibrato
	dw Music_ToggleNoise ; music noise sampling
	dw Music_Volume ; volume
	dw Music_Tone ; tone
	dw Music_TempoRelative ; global tempo
	dw Music_RestartChannel ; restart current channel from header
	dw Music_NewSong ; new song
	dw Music_SFXPriorityOn ; sfx priority on
	dw Music_SFXPriorityOff ; sfx priority off
	dw Music_PanLeft ; stereo panning
	dw Music_PanRight
	dw Music_PanCenter
	dw DoNothing ; $F0
	dw DoNothing ; $F1
	dw DoNothing ; $F2
	dw DoNothing ; $F3
	dw DoNothing ; $F4
	dw DoNothing ; $F5
	dw DoNothing ; $F6
	dw DoNothing ; $F7
	dw DoNothing ; $F8
	dw Music_ChangeNoiseSampleSet ; noisesampleset
	dw Music_SetCondition ; setcondition
	dw Music_JumpIf ; jumpif
	dw Music_JumpChannel ; jump
	dw Music_LoopChannel ; loop
	dw Music_CallChannel ; call
	dw Music_EndChannel ; return
	assert_table_length $100 - FIRST_MUSIC_CMD


Music_EndChannel:
; called when $ff is encountered w/ subroutine flag set
; end music stream
; return to caller of the subroutine
	; reset subroutine flag
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	res SOUND_SUBROUTINE, [hl]
	; copy LastMusicAddress to MusicAddress
	ld hl, wChannel1LastMusicAddress + 1 - wChannel1
	add hl, bc
	ld a, [hld]
	ld e, [hl]
	dec hl ; no-optimize b|c|d|e = *hl++|*hl--
	ld [hld], a
	ld [hl], e
	ret

Music_CallChannel:
; call music stream (subroutine)
; parameters: ll hh ; pointer to subroutine
	; get pointer from next 2 bytes
	call GetMusicWord
	push de
	; copy MusicAddress to LastMusicAddress
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	inc hl ; no-optimize b|c|d|e = *hl++|*hl--
	ld [hli], a
	ld [hl], d
	; load pointer into MusicAddress
	pop de
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	; set subroutine flag
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	set SOUND_SUBROUTINE, [hl]
	ret

Music_JumpChannel:
; jump
; parameters: ll hh ; pointer
	; get pointer from next 2 bytes
	call GetMusicWord
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

Music_LoopChannel:
; loops xx - 1 times
; 	00: infinite
; params: 3
;	xx ll hh
;		xx : loop count
;   	ll hh : pointer

	; get loop count
	call GetMusicByte
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_LOOPING, [hl] ; has the loop been initiated?
	jr nz, .checkloop
	and a ; loop counter 0 = infinite
	jr z, Music_JumpChannel
	; initiate loop
	dec a
	set SOUND_LOOPING, [hl] ; set loop flag
	ld hl, wChannel1LoopCount - wChannel1
	add hl, bc
	ld [hl], a ; store loop counter
.checkloop
	ld hl, wChannel1LoopCount - wChannel1
	add hl, bc
	ld a, [hl]
	and a ; are we done?
	jr z, .endloop
	dec [hl]
	jr Music_JumpChannel

.endloop
	; reset loop flag
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	res SOUND_LOOPING, [hl]
	; skip to next command
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	inc de ; skip
	inc de ; pointer
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

Music_SetCondition:
; set condition for a jump
; used with FB
; params: 1
;	xx ; condition

	; set condition
	call GetMusicByte
	ld hl, wChannel1Condition - wChannel1
	add hl, bc
	ld [hl], a
	ret

Music_JumpIf:
; conditional jump
; used with FA
; params: 3
; 	xx: condition
;	ll hh: pointer

; check condition
	; a = condition
	call GetMusicByte
	; if existing condition matches, jump to new address
	ld hl, wChannel1Condition - wChannel1
	add hl, bc
	cp [hl]
	jr z, Music_JumpChannel
; skip to next command
	; get address
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; skip pointer
	inc de
	inc de
	; update address
	ld a, d
	ld [hld], a
	ld [hl], e
	ret

Music_Vibrato:
; vibrato
; params: 2
;	1: [xx]
	; delay in frames
;	2: [yz]
	; y: extent
	; z: rate (# frames per cycle)

	; set vibrato flag?
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	set SOUND_VIBRATO, [hl]
	; start at lower frequency (extent is positive)
	res SOUND_VIBRATO_DIR, [hl]
	; get args
	call GetMusicWord
; update delay
	ld hl, wChannel1VibratoDelay - wChannel1
	add hl, bc
	ld [hl], e
; update delay count
	ld hl, wChannel1VibratoDelayCount - wChannel1
	add hl, bc
	ld [hl], e
; update extent
; this is split into halves only to get added back together at the last second
	ld hl, wChannel1VibratoExtent - wChannel1
	add hl, bc
	; get top nybble
	ld a, $f0
	and d
	swap a
	srl a ; halve
	ld e, a
	adc 0 ; round up
	swap a
	or e
	ld [hl], a
; update rate
	ld hl, wChannel1VibratoRate - wChannel1
	add hl, bc
	; get bottom nybble
	ld a, d
	and $f
	ld d, a
	swap a
	or d
	ld [hl], a
	ret

Music_SlidePitchTo:
; set the target for pitch wheel
; params: 2
; note duration
; target note
	call GetMusicWord
	ld a, e
	ld [wCurNoteDuration], a

	; pitch in e
	ld a, $f
	and d
	ld e, a

	; octave in d
	ld a, d
	swap a
	and $f
	ld d, a
	call GetFrequency
	ld hl, wChannel1PitchWheelTarget - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	set SOUND_PITCH_SLIDE, [hl]
	ret

Music_Tone:
; tone
; params: 1 (dw)
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	set SOUND_PITCH_OFFSET, [hl]
	ld hl, wChannel1PitchOffset - wChannel1
	add hl, bc
	call GetMusicWord
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

Music_SoundDuty:
; sequence of 4 duty cycles to be looped
; params: 1 (4 2-bit duty cycle arguments)
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	set SOUND_DUTY_LOOP, [hl] ; duty cycle
	; sound duty sequence
	call GetMusicByte
	rrca
	rrca
	ld hl, wChannel1DutyCycle - wChannel1
	add hl, bc
	ld [hl], a
	ret

Music_ToggleSFX:
; toggle something
; params: none
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	ld a, 1 << SOUND_SFX
	xor [hl]
	ld [hl], a
	ret

Music_ToggleNoise:
; toggle music noise sampling
; can't be used as a straight toggle since the param is not read from on->off
; params:
; 	noise on: 1
; 	noise off: 0
	; check if noise sampling is on
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	bit SOUND_NOISE, [hl]
	; turn noise sampling off
	res SOUND_NOISE, [hl]
	ret nz
	; was off, turn noise sampling on instead
	set SOUND_NOISE, [hl]
; fallthrough

Music_ChangeNoiseSampleSet:
	ld a, [wCurChannel]
	cp CHAN5
	ld hl, wMusicNoiseSampleSet
	jr c, .music
; Channel 8 uses sfx sample set
	inc hl ; wSFXNoiseSampleSet
.music
	call GetMusicByte
	ld [hl], a
	ret

Music_NoteType:
; note length
;	# frames per 16th note
; intensity: see Music_Intensity
; params: 2
	; note length
	call GetMusicByte
	ld hl, wChannel1NoteLength - wChannel1
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	and $3
	cp CHAN4 ; CHAN8 & $3
	ret z
	; fallthough

Music_Intensity:
; intensity
; params: 1
;   hi: pressure
;   lo: velocity
	call GetMusicByte
	ld hl, wChannel1Intensity - wChannel1
	add hl, bc
	ld [hl], a
	ret

Music_SoundStatus:
; update sound status
; params: 1
	call GetMusicByte
	ld [wSoundInput], a
	ld hl, wChannel1NoteFlags - wChannel1
	add hl, bc
	set NOTE_PITCH_SWEEP, [hl]
	ret

Music_DutyCycle0:
Music_DutyCycle1:
Music_DutyCycle2:
Music_DutyCycle3:
; duty cycle
	ld hl, wChannel1Flags2 - wChannel1
	add hl, bc
	res SOUND_DUTY_LOOP, [hl]
	ld a, [wCurMusicByte]
	rrca
	rrca
	and $c0
	ld hl, wChannel1DutyCycle - wChannel1
	add hl, bc
	ld [hl], a
	ret

Music_Tempo:
; global tempo
; params: 2
;	de: tempo
	call GetMusicWord
	ld a, [wCurChannel]
	cp CHAN5
	jmp nc, SetGlobalTempo
	push hl
	ld a, [wTempoAdjustment]
	ld l, a
	bit 7, a
	ld h, 0
	jr z, .ok
	dec h ; negative
.ok
	add hl, de
	push hl
	pop de
	pop hl
	jmp SetGlobalTempo

Music_Octave8:
Music_Octave7:
Music_Octave6:
Music_Octave5:
Music_Octave4:
Music_Octave3:
Music_Octave2:
Music_Octave1:
; set octave based on lo nybble of the command
	ld hl, wChannel1Octave - wChannel1
	add hl, bc
	ld a, [wCurMusicByte]
	and 7
	ld [hl], a
	ret

Music_ForceOctave:
; set starting octave
; this forces all notes up by the starting octave
; params: 1
	call GetMusicByte
	ld hl, wChannel1Transposition - wChannel1
	add hl, bc
	ld [hl], a
	ret

; stereo panning
Music_PanLeft:
	ld a, $F0
	jr _ForcePanning

Music_PanRight:
	ld a, $0F
	jr _ForcePanning

Music_PanCenter:
	ld a, $FF
	; fallthrough
_ForcePanning:
	ld d, a
	call SetLRTracks
	ld a, d
	ld hl, wChannel1Tracks - wChannel1
	add hl, bc
	and [hl]
	ld [hl], a
	ret

Music_Volume:
; set volume
; params: 1
;	see wVolume
	; read param even if it's not used
	call GetMusicByte
	; is the song fading?
	ld a, [wMusicFade]
	and a
	ret nz
	; reload param
	ld a, [wCurMusicByte]
	; set volume
	ld [wVolume], a
	ret

Music_TempoRelative:
; set global tempo to current channel tempo +- param
; params: 1 signed
	call GetMusicByte
	ld e, a
	; check sign
	cp $80
	; d = carry ? 0 (positive) : -1 (negative)
	ccf
	sbc a
	ld d, a
	ld hl, wChannel1Tempo - wChannel1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	jmp SetGlobalTempo

Music_SFXPriorityOn:
; turn sfx priority on
; params: none
	ld a, 1
	ld [wSFXPriority], a
	ret

Music_SFXPriorityOff:
; turn sfx priority off
; params: none
	xor a
	ld [wSFXPriority], a
	ret

Music_RestartChannel:
; restart current channel from channel header (same bank)
; params: 2 (5)
; ll hh: pointer to new channel header
;	header format: 0x yy zz
;		x: channel # (0-3)
;		zzyy: pointer to new music data

	; update music id
	ld hl, wChannel1MusicID - wChannel1
	add hl, bc
	ld a, [hli]
	ld [wMusicIDLo], a
	ld a, [hli]
	ld [wMusicIDHi], a
	; update music bank
	ld a, [hl]
	ld [wMusicBank], a
	; get pointer to new channel header
	call GetMusicWord
	ld l, e
	ld h, d
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push bc ; save current channel
	call LoadChannel
	call StartChannel
	pop bc ; restore current channel
	ret

Music_NewSong:
; new song
; params: 2
;	de: song id
	call GetMusicWord
	push bc
	call _PlayMusic
	pop bc
	ret

GetMusicByte:
; returns byte from current address in a
; advances to next byte in music data
; input: bc = start of current channel
	push hl
	push de
	; load address into de
	ld hl, wChannel1MusicAddress + 1 - wChannel1
	add hl, bc
	ld a, [hld]
	ld d, a
	ld a, [hld]
	ld e, a
	; load bank into a
	ld a, [hli]
	; get byte
	call _LoadMusicByte ; load data into wCurMusicByte
	inc de ; advance to next byte for next time this is called
	; update channeldata address
	ld [hl], e
	inc hl ; no-optimize *hl++|*hl-- = b|c|d|e
	ld [hl], d
	; cleanup
	pop de
	pop hl
	ret

GetMusicWord:
; returns word from current address in de
; advances to next byte in music data
; input: bc = start of current channel
	push hl
	; load address into de
	ld hl, wChannel1MusicAddress + 1 - wChannel1
	add hl, bc
	ld a, [hld]
	ld d, a
	ld a, [hld]
	ld e, a
	; load bank into a
	ld a, [hl]
	; get byte
	call _LoadMusicWord ; load data into hl
	push hl
	; update channeldata address
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	; cleanup
	pop de
	pop hl
	ret

GetFrequency:
; generate frequency
; input:
; 	d: octave
;	e: pitch
; output:
; 	de: frequency

; get octave
	ld a, [wPitchTransposition]
	bit 7, a
	jr nz, .negative
	add e
	ld e, a
	cp 13
	jr c, .added
	sub 12
	ld e, a
	dec d
	jr .added
.negative
	dec e
	add e
	jr c, .c
	inc a
	add 12
	ld e, a
	inc d
	jr .added
.c
	inc a
	ld e, a
.added
	; get starting octave
	ld hl, wChannel1Transposition - wChannel1
	add hl, bc
	ld a, [hl]
	swap a ; hi nybble
	and $f
	; add current octave
	add d
	push af ; we'll use this later
	; reload starting octave
	ld a, [hl]
	and $f ; lo nybble
	ld l, a ; ok
	ld d, 0
	ld h, d
	add hl, de ; add current pitch
	add hl, hl ; skip 2 bytes for each
	ld de, FrequencyTable
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	; get our octave
	pop af
	; shift right by [7 - octave] bits
.loop
	; [7 - octave] loops
	cp $7
	jr nc, .ok
	; sra de
	sra d
	rr e
	inc a
	jr .loop

.ok
	ld a, d
	and $7 ; top 3 bits for frequency (11 total)
	ld d, a
	ret

SetNoteDuration:
; input: a = note duration in 16ths
	; store delay units in de
	inc a
	ld e, a
	ld d, 0
	; store NoteLength in a
	ld hl, wChannel1NoteLength - wChannel1
	add hl, bc
	ld a, [hl]
	; multiply NoteLength by delay units
	ld l, 0 ; just multiply
	call .Multiply
	ld a, l
	; store Tempo in de
	ld hl, wChannel1Tempo - wChannel1
	add hl, bc
	ld e, [hl] ; no-optimize b|c|d|e = *hl++|*hl--
	inc hl
	ld d, [hl]
	; add ???? to the next result
	ld hl, wChannel1Field0x16 - wChannel1
	add hl, bc
	ld l, [hl]
	; multiply Tempo by last result (NoteLength * delay % $100)
	call .Multiply
	; copy result to de
	ld e, l
	ld d, h
	; store result in ????
	ld hl, wChannel1Field0x16 - wChannel1
	add hl, bc
	ld a, e
	ld [hld], a
	; store result in NoteDuration
	ld [hl], d
	ret

.Multiply:
; multiplies a and de
; adds the result to l
; stores the result in hl
	ld h, 0
.loop
	; halve a
	srl a
	; is there a remainder?
	jr nc, .skip
	; add it to the result
	add hl, de
.skip
	; add de, de
	sla e
	rl d
	; are we done?
	and a
	jr nz, .loop
	ret

SetGlobalTempo:
	push bc ; save current channel
	; are we dealing with music or sfx?
	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .sfxchannels
	ld bc, wChannel1
	call Tempo
	ld bc, wChannel2
	call Tempo
	ld bc, wChannel3
	call Tempo
	ld bc, wChannel4
	call Tempo
	jr .end

.sfxchannels
	ld bc, wChannel5
	call Tempo
	ld bc, wChannel6
	call Tempo
	ld bc, wChannel7
	call Tempo
	ld bc, wChannel8
	call Tempo
.end
	pop bc ; restore current channel
	ret

Tempo:
; input:
; 	de: note length
	; update Tempo
	ld hl, wChannel1Tempo - wChannel1
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	; clear ????
	xor a
	ld hl, wChannel1Field0x16 - wChannel1
	add hl, bc
	ld [hl], a
	ret

StartChannel:
	call SetLRTracks
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	set SOUND_CHANNEL_ON, [hl] ; turn channel on
	ret

SetLRTracks:
; set tracks for a the current channel to default
; seems to be redundant since this is overwritten by stereo data later
	push de
	; store current channel in de
	ld a, [wCurChannel]
	and $3
	ld e, a
	ld d, 0
	; get this channel's lr tracks
	ld hl, MonoOrStereoTracks
	add hl, de ; de = channel 0-3
	ld a, [hl]
	; load lr tracks into Tracks
	ld hl, wChannel1Tracks - wChannel1
	add hl, bc
	ld [hl], a
	pop de
	ret

_PlayMusic::
; load music
	call MusicOff
	ld hl, wMusicID
	ld a, e
	ld [hli], a ; song number
	ld [hl], d ; wMusicIDHi (always 0)
	ld hl, Music
	add hl, de ; three
	add hl, de ; byte
	add hl, de ; pointer
	ld a, [hli]
	ld [wMusicBank], a
	ld a, [hli]
	ld e, a
	ld d, [hl] ; music header address
	call LoadMusicByte ; store first byte of music header in a
	rlca
	rlca
	and $3 ; get number of channels
	inc a
.loop
; start playing channels
	push af
	call LoadChannel
	call StartChannel
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wNoiseSampleAddressLo], a
	ld [wNoiseSampleAddressHi], a
	ld [wNoiseSampleDelay], a
	ld [wMusicNoiseSampleSet], a
	jmp MusicOn

_PlayCry::
; Play cry de using parameters:
;	wCryPitch
;	wCryLength

	call MusicOff

; Initialize the pitch sweep
	xor a
	ld [wSoundInput], a
	ldh [rAUD1SWEEP], a

; Overload the music id with the cry id
	ld hl, wMusicID
	ld a, e
	ld [hli], a
	ld [hl], d

	ld hl, Cries
	add hl, de
	add hl, de

	ld a, BANK("Cries")
	ld [wMusicBank], a

	ld a, [hli]
	ld d, [hl]
	ld e, a

; Read the cry's sound header
	call LoadMusicByte
	; Top 2 bits contain the number of channels
	rlca
	rlca
	and 3

; For each channel:
	inc a
.loop
	push af
	call LoadChannel

	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	set SOUND_CRY, [hl]

	inc hl ; Flags2
	set SOUND_PITCH_OFFSET, [hl]

	ld hl, wChannel1PitchOffset - wChannel1
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a

; No tempo for channel 4
	ld a, [wCurChannel]
	or ~$3
	inc a
	jr z, .start

; Tempo is effectively length
	ld hl, wChannel1Tempo - wChannel1
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength+1]
	ld [hl], a
.start
	call StartChannel
	ld a, [wStereoPanningMask]
	and a
	jr z, .next

; Play cry from the monster's side.
; This only applies in-battle.
; [Tracks] &= [wCryTracks]
	ld hl, wChannel1Tracks - wChannel1
	add hl, bc
	ld a, [wCryTracks]
	and [hl]
	ld [hl], a

.next
	pop af
	dec a
	jr nz, .loop

; Cries play at max volume, so we save the current volume for later.
	ld a, [wLastVolume]
	and a
	jr nz, .end

	ld a, [wVolume]
	ld [wLastVolume], a
	ld a, $77
	ld [wVolume], a

.end
	ld a, 1 ; stop playing music
	ld [wSFXPriority], a
	jmp MusicOn

_PlaySFX::
	ld hl, wStereoPanningMask
	ld [hl], $ff

PlayStereoSFX::
; play sfx de

; clear channels if they aren't already
	call MusicOff
	ld hl, wChannel5Flags
	bit SOUND_CHANNEL_ON, [hl]
	res SOUND_CHANNEL_ON, [hl]
	call nz, UpdateChannels.ch1_rest

	ld hl, wChannel6Flags
	bit SOUND_CHANNEL_ON, [hl]
	res SOUND_CHANNEL_ON, [hl]
	call nz, UpdateChannels.ch2_rest

	ld hl, wChannel7Flags
	bit SOUND_CHANNEL_ON, [hl]
	res SOUND_CHANNEL_ON, [hl]
	call nz, UpdateChannels.ch3_rest

	ld hl, wChannel8Flags
	bit SOUND_CHANNEL_ON, [hl]
	res SOUND_CHANNEL_ON, [hl]
	jr z, .chscleared
	call UpdateChannels.ch4_rest

	xor a
	ld [wNoiseSampleAddressLo], a
	ld [wNoiseSampleAddressHi], a

.chscleared
	ld hl, wMusicID
	ld a, e
	ld [hli], a
	ld [hl], d

; get sfx ptr
	ld hl, SFX
	add hl, de
	add hl, de

; address
	ld a, [hli]
	ld d, [hl]
	ld e, a
; bank
	ld a, BANK("Sound Effects")
	ld [wMusicBank], a

; bit 2-3
	call LoadMusicByte
	rlca
	rlca
	and 3 ; ch1-4
	inc a

.loop
	push af
	call LoadChannel
	call StartChannel

; Apply stereo mask
	ld hl, wChannel1Tracks - wChannel1
	add hl, bc
	ld a, [wStereoPanningMask]
	and [hl]
	ld [hl], a

; set sfx flag
	ld hl, wChannel1Flags - wChannel1
	add hl, bc
	set SOUND_SFX, [hl]

; done?
	pop af
	dec a
	jr nz, .loop

; Clear sfx priority
	ld [wSFXPriority], a

; we're done
	jmp MusicOn

LoadChannel:
; prep channel for use
; input:
; 	de:
	; get pointer to current channel
	call LoadMusicByte
	inc de
	and $7 ; bit 0-2 (current channel)
	ld [wCurChannel], a
	ld c, a
	ld b, 0
	ld hl, ChannelPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld c, a
	ld b, [hl] ; bc = channel pointer
	call ChannelInit
	; load music pointer
	ld hl, wChannel1MusicAddress - wChannel1
	add hl, bc
	call LoadMusicByte
	ld [hli], a
	inc de
	call LoadMusicByte
	ld [hl], a
	inc de
	; load music id
	ld hl, wChannel1MusicID - wChannel1
	add hl, bc
	ld a, [wMusicIDLo]
	ld [hli], a
	ld a, [wMusicIDHi]
	ld [hli], a
	; load music bank
	ld a, [wMusicBank]
	ld [hl], a
	ret

ChannelInit:
; make sure channel is cleared
; set default tempo and note length in case nothing is loaded
; input:
;   bc = channel struct pointer
	push de
	push bc
	ld l, c
	ld h, b
	ld bc, wChannel2 - wChannel1 ; channel struct length
	xor a
	rst ByteFill
	pop bc
	; set tempo to default ($100)
	ld hl, wChannel1Tempo - wChannel1
	add hl, bc
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	; set note length to default ($1) (fast)
	ld hl, wChannel1NoteLength - wChannel1
	add hl, bc
	ld [hl], a
	pop de
	ret

ReloadWaveform:
	; each wavepattern is $f bytes long, so seeking is done in $10s
	swap a ; a << 4
	add LOW(WaveSamples)
	ld l, a
	adc HIGH(WaveSamples)
	sub l
	ld h, a
	xor a
	; Cycle the dac, this stops the channel so we can write to wave ram
	ldh [rAUD3ENA], a
	cpl
	ldh [rAUD3ENA], a
	; load wavepattern into AUD3WAVERAM
for x, AUD3WAVE_SIZE
	ld a, [hli]
	ldh [rAUD3WAVE_{X:x}], a
endr
	ret

INCLUDE "audio/notes.asm"

INCLUDE "audio/wave_samples.asm"

INCLUDE "audio/drumkits.asm"

MonoOrStereoTracks:
; bit corresponds to track #
; hi: left channel
; lo: right channel
	db $11, $22, $44, $88

ChannelPointers:
	table_width 2
; music channels
	dw wChannel1
	dw wChannel2
	dw wChannel3
	dw wChannel4
	assert_table_length NUM_MUSIC_CHANS
; sfx channels
	dw wChannel5
	dw wChannel6
	dw wChannel7
	dw wChannel8
	assert_table_length NUM_CHANNELS

PlayTrainerEncounterMusic::
; input: e = trainer type
	call SaveMusic
	; no encounter music for null trainers
	ld a, [wOtherTrainerClass]
	and a
	ret z
	; turn fade off
	xor a
	ld [wMusicFade], a
	; play nothing for one frame
	push de
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	; play new song
	call MaxVolume
	pop de
	ld d, $00
	ld hl, TrainerEncounterMusic
	add hl, de
	ld e, [hl]
	jmp PlayMusic
