; Save/Restore Music code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/misc/restoremusic.asm

SaveMusic::
	; back up old music state
	push hl
	push de
	push bc
	push af

	ld a, [rSVBK]
	push af
	ld a, $4
	ld [rSVBK], a

	ld de, SoundEngineBackup
	ld a, [de]
	and a
	jr nz, .skip
	call DelayFrame

	di
	ld bc, ChannelsEnd - wMusic
	ld hl, wMusic
	call CopyBytes
	ei

.skip
	pop af
	ld [rSVBK], a

	pop af
	pop bc
	pop de
	pop hl
	ret

RestoreMusic::
	push hl
	push de
	push bc
	push af

	ld a, [rSVBK]
	push af
	ld a, $4
	ld [rSVBK], a

	ld hl, SoundEngineBackup
	ld a, [hl]
	and a
	jr nz, .copy
	ld a, $1
	ld [rSVBK], a
	call PlayMapMusic
	jr .done

.copy
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame

	di
	ld hl, SoundEngineBackup
	ld bc, ChannelsEnd - wMusic
	ld de, wMusic
	call CopyBytes
	ei

	xor a
	ld [SoundEngineBackup], a

.done
	pop af
	ld [rSVBK], a

	pop af
	pop bc
	pop de
	pop hl
	ret

DeleteSavedMusic::
	push af
	ld a, [rSVBK]
	push af

	ld a, $4
	ld [rSVBK], a
	xor a
	ld [SoundEngineBackup], a

	pop af
	ld [rSVBK], a
	pop af
	ret
