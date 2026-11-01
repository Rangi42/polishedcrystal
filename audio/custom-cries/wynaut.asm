; Wynaut cry
; Demixed by regenn95

Cry_Wynaut:
	channel_count 3
	channel 5, Cry_Wynaut_Ch5
	channel 6, Cry_Wynaut_Ch6
	channel 8, Cry_Wynaut_Ch8

Cry_Wynaut_Ch5:
	duty_cycle_pattern 3, 1, 3, 2
	square_note 8, 15, 1, 1946
	square_note 11, 8, 1, 1945
	square_note 24, 13, 2, 1935
	sound_ret

Cry_Wynaut_Ch6:
	duty_cycle_pattern 0, 0, 1, 3
	square_note 8, 10, 7, 1666
	square_note 4, 7, 1, 1666
	square_note 5, 10, 1, 1666
	square_note 1, 0, 1, 1666
	square_note 16, 8, 3, 1643
	sound_ret

Cry_Wynaut_Ch8:
	noise_note 4, 14, -5, 86
	noise_note 4, 12, 8, 86
	noise_note 7, 11, 8, 87
	noise_note 4, 10, 8, 86
	noise_note 16, 10, 3, 86
	sound_ret
