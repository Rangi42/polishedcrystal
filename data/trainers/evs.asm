WriteTrainerEVs:
; Writes EVs to hl with the EV identifier in a.
; For classic EVs, writes (EV total / 2) to all stats.
; For modern EVs, writes the table data directly.
	push hl
	push de
	push bc
	push hl
	call SwapHLDE
	ld hl, EVTable
	ld bc, 6
	rst AddNTimes
	rst CopyBytes
	pop hl

	; If modern EVs are enabled, we're done.
	ld a, [wInitialOptions2]
	and EV_OPTMASK
	cp EVS_OPT_MODERN
	jr z, .done

	; Otherwise, calculate total and set EV to total/2.
	push hl
	farcall _GetEVTotal
	pop hl
	srl b
	rr c
	ld a, c
	cp 252
	jr c, .got_evs
	ld a, 252

.got_evs
	ld bc, 6
	rst ByteFill

.done
	jmp PopBCDEHL

EVTable:
; TODO: fill this
