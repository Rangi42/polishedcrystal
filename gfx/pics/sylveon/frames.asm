	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $00, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42
.frame2
	db $01 ; bitmask
	db $00, $43, $44, $00, $45, $46, $47, $35, $48, $49, $4a, $38, $4b, $39, $3a, $4c, $4d, $4e, $3e, $3f, $4f, $50, $00
.frame3
	db $02 ; bitmask
	db $00, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $49, $5c, $5d, $4b, $39, $3a, $5e, $5f, $60, $3e, $3f, $61, $62, $63
.frame4
	db $03 ; bitmask
	db $00, $64, $65, $66, $67, $35, $68, $49, $69, $6a, $4b, $6b, $6c, $6d, $6e, $6f
.frame5
	db $04 ; bitmask
	db $49, $4b
.frame6
	db $05 ; bitmask
	db $00, $00, $70, $71
