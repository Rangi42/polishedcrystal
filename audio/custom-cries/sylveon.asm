; Sylveon cry
; Demixed by regenn95

Cry_Sylveon:
	channel_count 3
	channel 5, Cry_Sylveon_Ch5
	channel 6, Cry_Sylveon_Ch6
	channel 8, Cry_Sylveon_Ch8

Cry_Sylveon_Ch5:
	duty_cycle_pattern 0, 0, 0, 0
	pitch_sweep 6, 7
	square_note 1, 14, -3, 1920
	pitch_sweep 8, 8
	square_note 2, 15, 5, 2000
	pitch_sweep 3, -7
	square_note 5, 12, 4, 2000
	pitch_sweep 8, 8
	square_note 1, 10, 0, 1950
	square_note 1, 13, -1, 1953
	square_note 1, 14, 0, 1959
	square_note 1, 14, 0, 1968
	square_note 1, 14, 0, 1975
	square_note 1, 14, 0, 1981
	square_note 1, 14, 0, 1988
	square_note 7, 12, 1, 1991
	sound_ret

Cry_Sylveon_Ch6:
	duty_cycle_pattern 0, 1, 1, 0
	square_note 2, 11, -3, 1933
	square_note 9, 13, 5, 2000
	square_note 15, 7, 4, 1951
	sound_ret

Cry_Sylveon_Ch8:
	noise_note 12, 9, 0, 24
	noise_note 12, 0, -5, 17
	noise_note 16, 4, 0, 17
	noise_note 16, 4, 0, 18
	noise_note 8, 4, 0, 19
	noise_note 26, 3, 7, 19
	sound_ret
