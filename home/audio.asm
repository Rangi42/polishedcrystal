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

_LoadMusicByte::
; wCurMusicByte = [a:de]
	rst Bankswitch
	ld a, [de]
	ld [wCurMusicByte], a
	ld a, BANK(LoadMusicByte)
	rst Bankswitch
	ret

CheckSpecialMapMusic:
; Returns z if the current map has a special music handler.
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
	ld de, MUSIC_BICYCLE_RB
	cp KANTO_REGION
	ret z
	ld de, MUSIC_BICYCLE_RSE
	cp ORANGE_REGION
	ret z
	ld de, MUSIC_BICYCLE
	ret

PlayMusicAfterDelay::
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	pop de
	ld a, e
	ld [wMapMusic], a
PlayMusic::
; Play music de.

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
; Stop playing music, then play music de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic)
	rst Bankswitch

	push de
	ld de, MUSIC_NONE
	call _PlayMusic ; far-ok
	call DelayFrame
	pop de
	call _PlayMusic ; far-ok

	pop af
	rst Bankswitch

	jmp PopAFBCDEHL

PlayCryHeader::
; Play cry header de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	; Cry headers are stuck in one bank.
	ld a, BANK(PokemonCries)
	rst Bankswitch

	ld hl, PokemonCries
rept 6
	add hl, de
endr

	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	ld a, BANK(_PlayCryHeader)
	rst Bankswitch

	call _PlayCryHeader ; far-ok

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
	jr nc, .play

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
	ld hl, wChannel5Flags
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel6Flags
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel7Flags
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel8Flags
	bit 0, [hl]
	jr nz, .wait

	pop hl
	ret

IsSFXPlaying::
; Return carry if no sound effect is playing.
; The inverse of CheckSFX.
	push hl

	ld hl, wChannel5Flags
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel6Flags
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel7Flags
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel8Flags
	bit 0, [hl]
	jr nz, .playing

	pop hl
	scf
	ret

.playing
	pop hl
	and a
	ret

MaxVolume::
	ld a, $77 ; max
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
	ldh [hBuffer], a
	ld a, [wMusicPlaying]
	push af
	xor a
	ld [wMusicPlaying], a
	ldh a, [hBuffer]
.loop
	call UpdateSound
	dec a
	jr nz, .loop
	pop af
	ld [wMusicPlaying], a
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
	ld a, d
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
	ld de, MUSIC_NONE
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
	ld de, MUSIC_NONE
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
	ld de, MUSIC_BICYCLE_XY
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ret z
	jr GetPlayerStateMusic

GetBugCatchingContestMusic:
	ld de, MUSIC_BUG_CATCHING_CONTEST_RANKING
	ld a, [wStatusFlags2]
	bit 2, a ; ENGINE_BUG_CONTEST_TIMER
	ret nz
	; fallthrough

GetPlayerStateMusic:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surf
	cp PLAYER_SURF_PIKA
	jr z, .surf_pikachu
	jmp GetMapMusic

.surf:
	call RegionCheck
	ld a, e
	ld de, MUSIC_SURF_KANTO
	cp KANTO_REGION
	ret z
	ld de, MUSIC_SURF_HOENN
	cp ORANGE_REGION
	ret z
	ld de, MUSIC_SURF
	ret

.surf_pikachu:
	ld de, MUSIC_SURFING_PIKACHU
	ret

CheckSFX::
; Return carry if any SFX channels are active.
	ld a, [wChannel5Flags]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel6Flags]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel7Flags]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel8Flags]
	bit 0, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

TerminateExpBarSound::
	xor a
	ld [wChannel5Flags], a
	ld [wSoundInput], a
	ldh [rNR10], a
	ldh [rNR11], a
	ldh [rNR12], a
	ldh [rNR13], a
	ldh [rNR14], a
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
