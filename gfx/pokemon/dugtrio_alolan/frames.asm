	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36
.frame2
	db $01 ; bitmask
	db $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f, $50, $51, $52, $53, $54
.frame3
	db $01 ; bitmask
	db $55, $56, $57, $58, $59, $3c, $5a, $5b, $5c, $5d, $5e, $42, $5f, $44, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $6b, $6c, $6d, $6e, $00
.frame4
	db $02 ; bitmask
	db $33, $35
.frame5
	db $03 ; bitmask
	db $31, $32
.frame6
	db $04 ; bitmask
	db $34, $36
