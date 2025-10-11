; Audio interfaces.

InitSound::

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSound)
	rst Bankswitch

	call _InitSound ; far-ok

	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

UpdateSound::

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	rst Bankswitch

	call _UpdateSound ; far-ok

	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

LoadMusicByte::
; input:
;   de = current music address
; output:
;   a = wCurMusicByte
	ld a, [wMusicBank]
; fallthrough
_LoadMusicByte::
; wCurMusicByte = [a:de]
	rst Bankswitch
	ld a, [de]
	ld [wCurMusicByte], a
	ld a, BANK(GetMusicByte)
	rst Bankswitch
	ld a, [wCurMusicByte]
	ret

_LoadMusicWord::
	rst Bankswitch
	ld a, [de]
	ld l, a
	inc de
	ld a, [de]
	ld h, a
	inc de
	ld [wCurMusicByte], a
	ld a, BANK(GetMusicByte)
	rst Bankswitch
	ret

CheckSpecialMapMusic:
; Returns z if the current map has a special music handler.

	ldh a, [hROMBank]
	push af
	ld a, BANK(GetOvercastIndex)
	rst Bankswitch
	call GetOvercastIndex ; far-ok
	ld b, a
	pop af
	rst Bankswitch
	ld a, b
	and a
	jr z, .check_special
	ld hl, .OvercastMusicHandler
	xor a
	ret

.OvercastMusicHandler:
	dw GetMapMusic

.check_special
	ld hl, SpecialMusicMaps
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
.loop:
	ld a, [hli]
	and a
	jr z, .ret_nz
	cp b
	jr nz, .wrong_group
	ld a, [hli]
	cp c
	jr nz, .wrong_map
	ret

.ret_nz
	or 1
	ret

.wrong_group:
	inc hl
.wrong_map:
	inc hl
	inc hl
	jr .loop

PlayBikeMusic:
; Play bike music unless we're in a map with special music handling.
	call CheckSpecialMapMusic
	ret z
	call .get_bike_music
	ld a, e
	ld [wMapMusic], a
	jr PlayMusic

.get_bike_music
	call RegionCheck
	ld a, e
	ld e, MUSIC_BICYCLE_RB
	cp KANTO_REGION
	ret z
	ld e, MUSIC_BICYCLE_RSE
	cp ORANGE_REGION
	ret z
	ld e, MUSIC_BICYCLE
	ret

PlayMusicAfterDelay::
	push de
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	pop de
	ld a, e
	ld [wMapMusic], a
PlayMusic::
; Play music e.
	ld d, 0

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic) ; and BANK(_InitSound)
	rst Bankswitch

	ld a, e
	and a
	jr z, .nomusic

	call _PlayMusic ; far-ok
	jr .end

.nomusic
	call _InitSound ; far-ok

.end
	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

PlayMusic2::
; Stop playing music, then play music e.
	ld d, 0

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	ld a, BANK(_PlayMusic)
	rst Bankswitch
	push de
	ld e, MUSIC_NONE
	call _PlayMusic ; far-ok
	call DelayFrame
	pop de
	call _PlayMusic ; far-ok

	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

PlayCry::
; Play cry de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	ld a, BANK(PokemonCries)
	rst Bankswitch
	call _LoadCry

	ld a, BANK(_PlayCry)
	rst Bankswitch
	call _PlayCry ; far-ok

	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

WaitPlaySFX::
	call WaitSFX
	; fallthrough
PlaySFX::
; Play sound effect de.
; Sound effects are ordered by priority (highest to lowest)

	push hl
	push de
	push bc
	push af

	; Is something already playing?
	call CheckSFX
	jr z, .play

	; Does it have priority?
	ld a, [wCurSFX]
	cp e
	jr c, .done

.play
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	rst Bankswitch

	ld a, e
	ld [wCurSFX], a
	call _PlaySFX ; far-ok

	pop af
	rst Bankswitch

.done
	jmp PopAFBCDEHL

PlayWaitSFX:
	call PlaySFX
	; fallthrough
Script_waitsfx::
WaitSFX::
; infinite loop until sfx is done playing

	push hl
	jr .handleLoop
.wait
	call DelayFrame
.handleLoop
	call CheckSFX
	jr nz, .wait

	pop hl
	ret

MaxVolume::
	ld a, MAX_VOLUME
	ld [wVolume], a
	ret

LowVolume::
	ld a, $33 ; 40%
	ld [wVolume], a
	ret

MinVolume::
	xor a
	ld [wVolume], a
	ret

FadeInToMusic::
	ld a, 4 | 1 << 7
	ld [wMusicFade], a
	ret

SkipMusic::
; Skip a frames of music.
	push bc
	ld b, a
	ld a, [wMusicPlaying]
	ld c, a
	xor a
	ld [wMusicPlaying], a
.loop
	call UpdateSound
	dec b
	jr nz, .loop
	ld a, c
	ld [wMusicPlaying], a
	pop bc
	ret

FadeToMapMusic::
	push hl
	push de
	push bc
	push af

	call GetMapMusic_MaybeSpecial
	ld a, [wMapMusic]
	cp e
	jr z, .done

	ld a, 8
	ld [wMusicFade], a
	ld a, e
	ld [wMusicFadeIDLo], a
	xor a ; music hi byte is always 0
	ld [wMusicFadeIDHi], a
	ld a, e
	ld [wMapMusic], a

.done
	jmp PopAFBCDEHL

Script_playmapmusic::
PlayMapMusic::
	push hl
	push de
	push bc
	push af

	call GetMapMusic_MaybeSpecial
	ld a, [wMapMusic]
	cp e
	call nz, PlayMusicAfterDelay

	jmp PopAFBCDEHL

PlayMapMusicBike::
	push hl
	push de
	push bc
	push af

	xor a
	ld [wDontPlayMapMusicOnReload], a
	call GetMapMusic_MaybeSpecial
	call PlayMusicAfterDelay

	jmp PopAFBCDEHL

TryRestartMapMusic::
	ld a, [wDontPlayMapMusicOnReload]
	and a
	jmp z, RestoreMusic
	xor a
	ld [wMapMusic], a
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ret

RestartMapMusic::
	push hl
	push de
	push bc
	push af
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld a, [wMapMusic]
	ld e, a
	ld d, 0
	call PlayMusic
	jmp PopAFBCDEHL

GetMapMusic_MaybeSpecial::
	call CheckSpecialMapMusic
	jmp z, IndirectHL
	jr GetPlayerStateMusic

GetCyclingRoadMusic:
	ld e, MUSIC_BICYCLE_XY
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ret z
	jr GetPlayerStateMusic

GetBugCatchingContestMusic:
	ld e, MUSIC_BUG_CATCHING_CONTEST_RANKING
	ld a, [wStatusFlags2]
	bit 2, a ; ENGINE_BUG_CONTEST_TIMER
	ret nz
	; fallthrough

GetPlayerStateMusic:
	ld a, [wPlayerState]
	cp PLAYER_SURF_PIKA
	ld e, MUSIC_SURFING_PIKACHU
	ret z
	cp PLAYER_SURF
	jmp nz, GetMapMusic
	call RegionCheck
	ld a, e
	ld e, MUSIC_SURF_KANTO
	cp KANTO_REGION
	ret z
	ld e, MUSIC_SURF_HOENN
	cp ORANGE_REGION
	ret z
	ld e, MUSIC_SURF
	ret

CheckSFX::
; Return nz if any SFX channels are active.
	xor a
	ld hl, wChannel5Flags
	or [hl]
	ld hl, wChannel6Flags
	or [hl]
	ld hl, wChannel7Flags
	or [hl]
	ld hl, wChannel8Flags
	or [hl]
	bit SOUND_CHANNEL_ON, a
	ret

TerminateExpBarSound::
	xor a
	ld [wChannel5Flags], a
	ld [wSoundInput], a
	ldh [rAUD1SWEEP], a
	ldh [rAUD1LEN], a
	ldh [rAUD1ENV], a
	ldh [rAUD1LOW], a
	ldh [rAUD1HIGH], a
	ret

ChannelsOff::
; Quickly turn off music channels
	xor a
	ld [wChannel1Flags], a
	ld [wChannel2Flags], a
	ld [wChannel3Flags], a
	ld [wChannel4Flags], a
	ld [wSoundInput], a
	ret

SFXChannelsOff::
; Quickly turn off sound effect channels
	xor a
	ld [wChannel5Flags], a
	ld [wChannel6Flags], a
	ld [wChannel7Flags], a
	ld [wChannel8Flags], a
	ld [wSoundInput], a
	ret
