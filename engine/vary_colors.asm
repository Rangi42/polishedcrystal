CopyHLToVideoDVBuffer:
	ld a, $5
	ld de, VideoDVBuffer
	ld bc, 3
	call FarCopyWRAM
	ret

GetColorChannelVariedByDV:
; d = color, e = DV
; a <- d + (e & %11) - (e & %1100 >> 2), clamped to [0, 15]

; TODO: vary colors (for now, return unvaried color)
	ld a, d
	ret

	ld a, e
	and %11
	add d
	ld d, a
	srl e
	srl e
	ld a, d
	sub e
	jr c, .went_below_0
	cp %10000
	ret c
	ld a, %1111
	ret

.went_below_0
	xor a
	ret


VaryBlueByDV:
;;; [hl+0] = 0bbb:bbgg
;;; [hl+1] = gggr:rrrr
;;; e = DV
; store blue in d
	ld a, [hl]
	and %01111100
	srl a
	srl a
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in blue
	ld d, a
	sla d
	sla d
	ld a, [hl]
	and %10000011
	or d
	ld [hl], a
	ret

VaryGreenByDV:
;;; [hl+0] = 0bbb:bbgg
;;; [hl+1] = gggr:rrrr
;;; e = DV
; store green in d
	ld a, [hli]
	and %00000011
	sla a
	sla a
	sla a
	ld d, a
	ld a, [hld]
	and %11100000
	swap a
	srl a
	or d
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in green
	sla a
	swap a
	ld d, a
	and %11100000
	ld e, a
	ld a, d
	and %00000011
	ld d, a
	ld a, [hl]
	and %11111100
	or d
	ld [hli], a
	ld a, [hl]
	and %00011111
	or e
	ld [hld], a
	ret

VaryRedByDV:
;;; [hl+0] = 0bbb:bbgg
;;; [hl+1] = gggr:rrrr
;;; e = DV
; store red in d
	inc hl
	ld a, [hl]
	and %00011111
	ld d, a
; vary d according to e
	call GetColorChannelVariedByDV
; store a back in red
	ld d, a
	ld a, [hl]
	and %11100000
	or d
	ld [hl], a
	dec hl
	ret


VaryColorsByDVs::
; hl = colors
; [hl+0] = 0bbb:bbgg
; [hl+1] = gggr:rrrr
; [hl+2] = 0BBB:BBGG
; [hl+3] = GGGR:RRRR

; DVs in VideoDVBuffer
; [bc+0] = hhhh:aaaa
; [bc+1] = dddd:ssss
; [bc+2] = pppp:qqqq

	ld a, [rSVBK]
	push af
	ld a, $5
	ld [rSVBK], a

	ld bc, VideoDVBuffer

;;; HiBlu ~ HPDV, aka, bbbbb ~ hhhh
; store HPDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary HiBlu by e
	call VaryBlueByDV

;;; HiGrn ~ AtkDV, aka, ggggg ~ aaaa
; store AtkDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary HiGrn by e
	call VaryGreenByDV

;;; move from HP/Atk DV to Def/Spd DV
	inc bc

;;; HiRed ~ DefDV, aka, rrrrr ~ dddd
; store DefDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary HiRed by e
	call VaryRedByDV

;;; Move from Hi color to Lo color
	inc hl
	inc hl

;;; LoBlu ~ SpdDV, aka, BBBBB ~ ssss
; store SpdDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary LoBlu by e
	call VaryBlueByDV

;;; move from Def/Spd DV to SAt/SDf DV
	inc bc

;;; LoGrn ~ SAtDV, aka, GGGGG ~ pppp
; store SAtDV in e
	ld a, [bc]
	swap a
	and %1111
	ld e, a
; vary LoGrn by e
	call VaryGreenByDV

;;; LoRed ~ SDfDV, aka, RRRRR ~ qqqq
; store SDfDV in e
	ld a, [bc]
	and %1111
	ld e, a
; vary LoRed by e
	call VaryRedByDV

	pop af
	ld [rSVBK], a

	ret
