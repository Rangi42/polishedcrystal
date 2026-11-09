GetEusineState:
; Permanent milestones take precedence over earlier story/visibility flags.
; In particular, EVENT_FOUGHT_HO_OH can be cleared by RespawnOneOffs.
; Return the state in a and hScriptVar.
	ld a, EUSINE_TRAVELING
	eventflagcheck EVENT_EUSINE_HO_OH_FAREWELL
	jr nz, .done
	assert EUSINE_FAREWELL_PENDING == EUSINE_TRAVELING - 1
	dec a
	eventflagcheck EVENT_EUSINE_HO_OH_ENCOUNTER
	jr nz, .done
	assert EUSINE_LEFT_CELADON == EUSINE_FAREWELL_PENDING - 1
	dec a
	eventflagcheck EVENT_EUSINE_LEFT_CELADON
	jr nz, .done
	assert EUSINE_RESEARCHING == EUSINE_LEFT_CELADON - 1
	dec a
	eventflagcheck EVENT_FOUGHT_SUICUNE
	jr nz, .done
	assert EUSINE_SEARCHING == EUSINE_RESEARCHING - 1
	dec a
.done
	ldh [hScriptVar], a
	ret

UpdateEusineVisibility:
; Reconcile both standing NPCs, including when their maps aren't loaded.
; Call before LoadObjectMasks in map callbacks. In an active scene, changing
; these flags doesn't remove the live object: its departure uses disappear.
	call GetEusineState
	eventflagset EVENT_EUSINES_HOUSE_EUSINE
	eventflagset EVENT_TIN_TOWER_1F_EUSINE
	assert EUSINE_SEARCHING == 0
	and a
	ret z

; Suicune's tower scene supersedes any skipped early Eusine conversations.
	eventflagset EVENT_BURNED_TOWER_1F_EUSINE
	eventflagset EVENT_EUSINE_IN_BURNED_TOWER
	eventflagset EVENT_CIANWOOD_CITY_EUSINE
	cp EUSINE_RESEARCHING
	jr nz, .not_home
	eventflagreset EVENT_EUSINES_HOUSE_EUSINE
	ret
.not_home
	cp EUSINE_FAREWELL_PENDING
	ret nz
	eventflagreset EVENT_TIN_TOWER_1F_EUSINE
	ret
