; Leafeon cry
; Demixed by regenn95

Cry_Leafeon:
	channel_count 3
	channel 5, Cry_Leafeon_Ch5
	channel 6, Cry_Leafeon_Ch6
	channel 8, Cry_Leafeon_Ch8

Cry_Leafeon_Ch5:
	duty_cycle_pattern 1, 1, 1, 0
	square_note 2, 13, -5, 1600
	square_note 1, 14, 4, 1726
	square_note 3, 15, 7, 1894
	square_note 1, 14, 0, 1890
	square_note 1, 13, 0, 1886
	square_note 1, 13, 0, 1882
	square_note 1, 12, 0, 1877
	square_note 1, 14, 0, 1877
	square_note 1, 9, 0, 1873
	square_note 1, 7, 0, 1869
	square_note 2, 5, 2, 1862
	sound_ret

Cry_Leafeon_Ch6:
	duty_cycle_pattern 0, 0, 1, 0
	square_note 2, 7, -8, 1798
	square_note 1, 6, 4, 1798
	square_note 2, 7, 4, 1858
	square_note 16, 8, 5, 1860
	sound_ret

Cry_Leafeon_Ch8:
.loop1:
	noise_note 4, 5, 5, 145
	noise_note 1, 3, 3, 214
	noise_note 3, 4, 3, 213
	noise_note 6, 3, 7, 212
	sound_loop 2, .loop1
	noise_note 4, 3, 5, 145
	noise_note 2, 4, 3, 214
	noise_note 4, 3, 5, 212
	sound_ret
