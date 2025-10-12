; Save/Restore Music code by TPP Anniversary Crystal 251
; https://github.com/TwitchPlaysPokemon/tppcrystal251pub/blob/public/misc/restoremusic.asm

SaveMusic::
	; back up old music state
	push hl
	push de
	push bc
	push af

	ldh a, [rWBK]
	push af
	ld a, BANK("Sound Stack")
	ldh [rWBK], a

	ld a, [wMapMusic]
	ld [wBackupMapMusic], a

	ld de, wSoundEngineBackup
	ld a, [de]
	and a
	jr nz, .skip
	call DelayFrame

	di
	ld bc, wChannelsEnd - wMusic
	ld hl, wMusic
	rst CopyBytes
	ei

.skip
	pop af
	ldh [rWBK], a

	jmp PopAFBCDEHL

RestoreMusic::
	push hl
	push de
	push bc
	push af

	ldh a, [rWBK]
	push af
	ld a, BANK("Sound Stack")
	ldh [rWBK], a

	ld a, [wBackupMapMusic]
	ld [wMapMusic], a

	ld hl, wSoundEngineBackup
	ld a, [hl]
	and a
	jr nz, .copy
	ld a, $1
	ldh [rWBK], a
	call PlayMapMusic
	jr .done

.copy
	ld e, MUSIC_NONE
	call PlayMusic
	call DelayFrame

	di
	ld hl, wSoundEngineBackup
	ld bc, wChannelsEnd - wMusic
	ld de, wMusic
	rst CopyBytes
	ei

	xor a
	ld [wSoundEngineBackup], a

.done
	pop af
	ldh [rWBK], a

	jmp PopAFBCDEHL

DeleteSavedMusic::
	push af
	ldh a, [rWBK]
	push af

	ld a, BANK("Sound Stack")
	ldh [rWBK], a
	xor a
	ld [wSoundEngineBackup], a

	pop af
	ldh [rWBK], a
	pop af
	ret
