	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
.frame1
	db $00 ; bitmask
	db $24, $25, $26, $27, $28
.frame2
	db $01 ; bitmask
	db $24, $25, $29, $2a, $27, $2b, $2c
.frame3
	db $02 ; bitmask
	db $2d, $2e, $2f, $25, $30, $31, $27, $28
.frame4
	db $02 ; bitmask
	db $32, $33, $2f, $25, $34, $31, $27, $28
