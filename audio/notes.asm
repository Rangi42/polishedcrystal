FrequencyTable:
	table_width 2, FrequencyTable
	dw 0     ; __
	dw $f82c ; C_
	dw $f89d ; C#
	dw $f907 ; D_
	dw $f96b ; D#
	dw $f9ca ; E_
	dw $fa23 ; F_
	dw $fa77 ; F#
	dw $fac7 ; G_
	dw $fb12 ; G#
	dw $fb58 ; A_
	dw $fb9b ; A#
	dw $fbda ; B_
	assert_table_length NUM_NOTES + 1
	dw $fc16 ; C_
	dw $fc4e ; C#
	dw $fc83 ; D_
	dw $fcb5 ; D#
	dw $fce5 ; E_
	dw $fd11 ; F_
	dw $fd3b ; F#
	dw $fd63 ; G_
	dw $fd89 ; G#
	dw $fdac ; A_
	dw $fdcd ; A#
	dw $fded ; B_
	assert_table_length NUM_NOTES * 2 + 1
