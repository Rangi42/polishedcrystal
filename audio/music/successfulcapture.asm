Music_SuccessfulCapture:
	channel_count 3
	channel 1, Music_SuccessfulCapture_Ch1
	channel 2, Music_SuccessfulCapture_Ch2
	channel 3, Music_SuccessfulCapture_Ch3

Music_SuccessfulCapture_Ch1:
	tempo 126
	volume $77
	dutycycle $3
	tone $0001
	notetype $c, $a1
	jumpchannel Music_SuccessfulCapture_branch_f4536

Music_SuccessfulCapture_Ch2:
	vibrato $12, $24
	notetype $c, $c1
	dutycycle $2
	jumpchannel Music_SuccessfulCapture_branch_f4585

Music_SuccessfulCapture_Ch3:
	notetype $c, $25
	jumpchannel Music_SuccessfulCapture_branch_f45cf
