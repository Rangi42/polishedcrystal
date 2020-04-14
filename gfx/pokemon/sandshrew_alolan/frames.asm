	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
.frame1
	db $00 ; bitmask
	db $19, $1a, $1b, $1c, $1d
.frame2
	db $01 ; bitmask
	db $19, $1a, $1b, $1e, $1c, $1d
.frame3
	db $02 ; bitmask
	db $00, $1f, $1a, $1b, $1e, $1c, $1d
.frame4
	db $03 ; bitmask
	db $1e
.frame5
	db $04 ; bitmask
	db $20, $1f
