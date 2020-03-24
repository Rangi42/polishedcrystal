	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c
	db $3d, $3e
.frame2
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36, $3f, $38, $39, $3a, $3b, $3c
	db $3d, $3e
.frame3
	db $01 ; bitmask
	db $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b
	db $4c, $4d, $4e, $4f, $50, $00, $51, $00, $00
.frame4
	db $02 ; bitmask
	db $52, $53, $54, $55
.frame5
	db $03 ; bitmask
	db $56, $57, $58, $59
