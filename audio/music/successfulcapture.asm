Music_SuccessfulCapture:
	channel_count 3
	channel 1, Music_SuccessfulCapture_Ch1
	channel 2, Music_SuccessfulCapture_Ch2
	channel 3, Music_SuccessfulCapture_Ch3

Music_SuccessfulCapture_Ch1:
	tempo 126
	volume 7, 7
	duty_cycle 3
	tone $0001
	note_type 12, 10, 1
	jumpchannel Music_SuccessfulCapture_branch_f4536

Music_SuccessfulCapture_Ch2:
	vibrato $12, $24
	note_type 12, 12, 1
	duty_cycle 2
	jumpchannel Music_SuccessfulCapture_branch_f4585

Music_SuccessfulCapture_Ch3:
	note_type 12, 2, 5
	jumpchannel Music_SuccessfulCapture_branch_f45cf
