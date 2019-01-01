	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36, $37, $38, $39
.frame2
	db $01 ; bitmask
	db $3a, $3b
.frame3
	db $02 ; bitmask
	db $3a, $3b, $00, $3c, $3d, $3e, $34, $3f, $40, $41, $42, $43, $44
.frame4
	db $03 ; bitmask
	db $45, $46, $47, $48, $49
