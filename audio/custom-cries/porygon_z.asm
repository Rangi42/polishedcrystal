; Porygon-Z cry
; Demixed by regenn95

Cry_Porygon_Z:
	channel_count 3
	channel 5, Cry_Porygon_Z_Ch5
	channel 6, Cry_Porygon_Z_Ch6
	channel 8, Cry_Porygon_Z_Ch8

Cry_Porygon_Z_Ch5:
	duty_cycle_pattern 3, 1, 3, 3
	square_note 18, 15, 5, 1992
	square_note 2, 13, 5, 1935
	square_note 2, 13, 5, 1939
	square_note 2, 14, 5, 1943
	square_note 2, 14, 5, 1947
	square_note 2, 14, 5, 1952
	square_note 5, 15, 1, 1993
	square_note 30, 10, 6, 2005
	sound_ret

Cry_Porygon_Z_Ch6:
	duty_cycle_pattern 1, 0, 0, 3
	square_note 6, 0, 1, 1340
	square_note 4, 11, 5, 1340
	square_note 10, 13, 2, 1600
	square_note 8, 13, 2, 1650
	square_note 3, 9, 3, 1340
	square_note 4, 14, 2, 1834
	square_note 20, 13, 3, 1873
	sound_ret

Cry_Porygon_Z_Ch8:
	noise_note 10, 10, -1, 41
	noise_note 8, 10, 2, 46
	noise_note 10, 10, 2, 44
	noise_note 8, 10, 2, 46
	noise_note 12, 10, 2, 42
	noise_note 2, 10, 2, 46
	noise_note 28, 11, 4, 37
	noise_note 11, 11, 2, 14
	noise_note 11, 10, 2, 13
	noise_note 12, 10, 2, 13
	noise_note 3, 11, -1, 13
	noise_note 2, 8, 1, 13
	noise_note 5, 10, 2, 13
	noise_note 10, 11, 1, 13
	sound_ret
