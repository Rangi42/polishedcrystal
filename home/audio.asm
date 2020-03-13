; Audio interfaces.

MapSetup_Sound_Off::

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_MapSetup_Sound_Off)
	rst Bankswitch

	call _MapSetup_Sound_Off

	pop af
	rst Bankswitch

	jp PopAFBCDEHL

UpdateSound::

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	rst Bankswitch

	call _UpdateSound

	pop af
	rst Bankswitch

	jp PopAFBCDEHL

_LoadMusicByte::
; wCurMusicByte = [a:de]
GLOBAL LoadMusicByte
	rst Bankswitch
	ld a, [de]
	ld [wCurMusicByte], a
	ld a, BANK(LoadMusicByte)
	rst Bankswitch
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
	ld a, BANK(_PlayMusic) ; and BANK(_MapSetup_Sound_Off)
	rst Bankswitch

	ld a, e
	and a
	jr z, .nomusic

	call _PlayMusic
	jr .end

.nomusic
	call _MapSetup_Sound_Off

.end
	pop af
	rst Bankswitch

	jp PopAFBCDEHL

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
	call _PlayMusic
	call DelayFrame
	pop de
	call _PlayMusic

	pop af
	rst Bankswitch

	jp PopAFBCDEHL

PlayCryHeader::
; Play cry header de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	; Cry headers are stuck in one bank.
	ld a, BANK(CryHeaders)
	rst Bankswitch

	ld hl, CryHeaders
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

	call _PlayCryHeader

	pop af
	rst Bankswitch

	jp PopAFBCDEHL

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
	call _PlaySFX

	pop af
	rst Bankswitch

.done
	jp PopAFBCDEHL

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

VolumeOff::
	xor a
	ld [wVolume], a
	ret

FadeInMusic::
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

	call GetMapMusic
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
	jp PopAFBCDEHL

PlayMapMusic::
	push hl
	push de
	push bc
	push af

	call GetMapMusic
	ld a, [wMapMusic]
	cp e
	call nz, PlayMusicAfterDelay

	jp PopAFBCDEHL

EnterMapMusic::
	push hl
	push de
	push bc
	push af

	xor a
	ld [wDontPlayMapMusicOnReload], a
	call GetMapMusic
	call PlayMusicAfterDelay

	jp PopAFBCDEHL

TryRestartMapMusic::
	ld a, [wDontPlayMapMusicOnReload]
	and a
	jp z, RestoreMusic
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
	jp PopAFBCDEHL

GetMapMusic::
	ld hl, SpecialMusicMaps
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
.loop:
	ld a, [hli]
	and a
	jr z, GetPlayerStateMusic
	cp b
	jr nz, .wrong_group
	ld a, [hli]
	cp c
	jr nz, .wrong_map
	jp IndirectHL

.wrong_group:
	inc hl
.wrong_map:
	inc hl
	inc hl
	jr .loop

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
	cp PLAYER_BIKE
	jr z, .bike
	cp PLAYER_SURF
	jr z, .surf
	cp PLAYER_SURF_PIKA
	jr z, .surf_pikachu
	jp GetMapHeaderMusic

.bike:
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

SpecialMusicMaps:
music_map: MACRO
	map_id \1
	dw \2
ENDM
	music_map ROUTE_23, GetMapHeaderMusic
	music_map INDIGO_PLATEAU, GetMapHeaderMusic
	music_map QUIET_CAVE_1F, GetMapHeaderMusic
	music_map QUIET_CAVE_B1F, GetMapHeaderMusic
	music_map QUIET_CAVE_B2F, GetMapHeaderMusic
	music_map QUIET_CAVE_B3F, GetMapHeaderMusic
	music_map SCARY_CAVE_SHIPWRECK, GetMapHeaderMusic
	music_map WHIRL_ISLAND_LUGIA_CHAMBER, GetMapHeaderMusic
	music_map TIN_TOWER_ROOF, GetMapHeaderMusic
	music_map ROUTE_16_SOUTH, GetCyclingRoadMusic
	music_map ROUTE_17, GetCyclingRoadMusic
	music_map ROUTE_18_WEST, GetCyclingRoadMusic
	music_map ROUTE_35_NATIONAL_PARK_GATE, GetBugCatchingContestMusic
	music_map ROUTE_36_NATIONAL_PARK_GATE, GetBugCatchingContestMusic
	db 0 ; end

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
