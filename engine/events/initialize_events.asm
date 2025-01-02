InitializeEvents:
; initialize events
	ld hl, wEventChecksumFlags
	res EVENT_CHECKSUM_FULL_DONE_F, [hl]
	res EVENT_CHECKSUM_VBLANK_ROUTINE_RUNNING_F, [hl]
	ld hl, InitialEvents
.events_loop
	call .GetDWInDE
	jr z, .events_done
	ld b, SET_FLAG
	push hl
	call EventFlagAction
	pop hl
	jr .events_loop
.events_done
	farcall RecalculateEventChecksum

; initialize engine flags
	ld hl, InitialEngineFlags
.flags_loop
	call .GetDWInDE
	jr z, .flags_done
	ld b, SET_FLAG
	push hl
	farcall EngineFlagAction
	pop hl
	jr .flags_loop
.flags_done

; initialize variable sprites and map scenes
	ld hl, InitialVariableSpritesAndMapScenes
.sprites_scenes_loop
	call .GetDWInDE
	ret z
	ld a, [hli]
	ld [de], a
	jr .sprites_scenes_loop

.GetDWInDE:
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	and e
	inc a
	ret

INCLUDE "data/events/initialize_events.asm"
