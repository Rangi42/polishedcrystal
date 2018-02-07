	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $00, $19, $1a, $00, $0a, $1b, $1c, $00, $0f, $1d, $1e
.frame2
	db $01 ; bitmask
	db $1f, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e
.frame3
	db $02 ; bitmask
	db $19, $2f, $1b, $30
.frame4
	db $03 ; bitmask
	db $19, $31, $32, $1b, $33, $34
.frame5
	db $04 ; bitmask
	db $35, $36, $37
.frame6
	db $02 ; bitmask
	db $38, $39, $3a, $3b
