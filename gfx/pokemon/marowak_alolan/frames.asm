	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32
.frame2
	db $01 ; bitmask
	db $33, $34, $35, $36, $37, $38, $39, $3a, $05, $05, $3b, $3c, $3d, $05, $3e, $3f, $40, $05
.frame3
	db $02 ; bitmask
	db $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $05, $4e, $4f, $05, $05, $05
.frame4
	db $03 ; bitmask
	db $05, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e
.frame5
	db $04 ; bitmask
	db $6f, $70, $71, $73
.frame6
	db $05 ; bitmask
	db $74, $75, $76, $77
