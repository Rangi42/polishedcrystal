; Glaceon cry
; Demixed by regenn95

Cry_Glaceon:
	channel_count 2
	channel 5, Cry_Glaceon_Ch5
	channel 6, Cry_Glaceon_Ch6

Cry_Glaceon_Ch5:
	duty_cycle_pattern 2, 2, 2, 1
	square_note 3, 12, -3, 1856
	square_note 2, 14, 3, 1860
	square_note 5, 13, -3, 1833
	square_note 1, 14, -3, 1856
	square_note 1, 15, 0, 1860
	square_note 1, 13, 0, 1859
	square_note 1, 12, 0, 1864
	square_note 1, 9, 0, 1888
	square_note 1, 10, 0, 1920
	square_note 2, 12, 4, 1931
	pitch_sweep 3, -7	
	square_note 10, 8, 6, 1931
	pitch_sweep 8, 8
	sound_ret

Cry_Glaceon_Ch6:
	duty_cycle_pattern 0, 0, 2, 2
	square_note 2, 8, 2, 1924
	square_note 2, 8, 7, 1966
	square_note 3, 8, 7, 1958
	square_note 1, 0, 7, 1930
	square_note 5, 8, 3, 1930
	square_note 1, 0, 7, 1930
	square_note 1, 8, 7, 1924
	square_note 1, 8, 7, 1940
	square_note 3, 8, 2, 1958
	square_note 2, 8, 3, 1957
	square_note 7, 8, 2, 1946
	sound_ret
