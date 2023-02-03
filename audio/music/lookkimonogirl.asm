Music_LookKimonoGirl:
	channel_count 3
	channel 1, Music_LookKimonoGirl_Ch1
	channel 2, Music_LookKimonoGirl_Ch2
	channel 3, Music_LookKimonoGirl_Ch3

Music_LookKimonoGirl_Ch1:
	tempo 160
	volume 7, 7
	stereopanning $f
	duty_cycle 1
	note_type 6, 8, 7
	tone $0001
	callchannel Music_LookKimonoGirl_branch_f7aa8
	tone 0
Music_LookKimonoGirl_branch_f79d7:
	note_type 12, 11, 2
	callchannel Music_LookKimonoGirl_branch_f7a13
	callchannel Music_LookKimonoGirl_branch_f7a13
	callchannel Music_LookKimonoGirl_branch_f7a34
	callchannel Music_LookKimonoGirl_branch_f7a34
	callchannel Music_LookKimonoGirl_branch_f7a13
	callchannel Music_LookKimonoGirl_branch_f7a13
	callchannel Music_LookKimonoGirl_branch_f7a34
	intensity $b4
	octave 3
	note E_, 1
	intensity $54
	octave 4
	note E_, 1
	intensity $b4
	octave 3
	note D_, 1
	intensity $54
	octave 4
	note D_, 1
	intensity $b4
	octave 2
	note B_, 1
	intensity $54
	octave 3
	note B_, 1
	intensity $b4
	octave 2
	note A_, 1
	intensity $54
	octave 3
	note A_, 1
	jumpchannel Music_LookKimonoGirl_branch_f79d7

Music_LookKimonoGirl_branch_f7a13:
	intensity $b4
	octave 2
	note F_, 1
	intensity $74
	octave 3
	note F_, 1
	intensity $b4
	octave 2
	note A_, 1
	intensity $74
	octave 3
	note A_, 1
	intensity $b4
	octave 2
	note B_, 1
	intensity $74
	octave 3
	note B_, 1
	intensity $b4
	octave 3
	note D_, 1
	intensity $74
	octave 4
	note D_, 1
	endchannel

Music_LookKimonoGirl_branch_f7a34:
	intensity $b4
	octave 2
	note E_, 1
	intensity $74
	octave 3
	note E_, 1
	intensity $b4
	octave 2
	note A_, 1
	intensity $74
	octave 3
	note A_, 1
	intensity $b4
	octave 2
	note B_, 1
	intensity $74
	octave 3
	note B_, 1
	intensity $b4
	octave 3
	note D_, 1
	intensity $74
	octave 4
	note D_, 1
	endchannel

Music_LookKimonoGirl_Ch2:
	duty_cycle 0
	note_type 6, 10, 7
	stereopanning $f0
	callchannel Music_LookKimonoGirl_branch_f7aa8
Music_LookKimonoGirl_branch_f7a5f:
	duty_cycle 3
	note_type 12, 9, 1
	octave 5
	note E_, 1
	note D_, 1
	octave 4
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note D_, 1
	octave 3
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note E_, 1
	note D_, 1
	callchannel Music_LookKimonoGirl_branch_f7a94
	octave 5
	note F_, 1
	note D_, 1
	octave 4
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note F_, 1
	note D_, 1
	note F_, 1
	note D_, 1
	octave 3
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note E_, 1
	note D_, 1
	callchannel Music_LookKimonoGirl_branch_f7a94
	jumpchannel Music_LookKimonoGirl_branch_f7a5f

Music_LookKimonoGirl_branch_f7a94:
	octave 5
	note B_, 1
	note A_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note D_, 1
	octave 4
	note B_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note D_, 1
	octave 3
	note B_, 1
	note E_, 1
	endchannel

Music_LookKimonoGirl_branch_f7aa8:
	octave 4
	note E_, 1
	octave 5
	note E_, 16
	note __, 1
	note E_, 2
	note __, 3
	intensity $b7
	note E_, 2
	note __, 2
	intensity $b7
	note E_, 2
	note __, 1
	intensity $a7
	note E_, 2
	note __, 1
	note_type 6, 6, 5
	note E_, 2
	note __, 1
	intensity $54
	note E_, 2
	note __, 1
	intensity $63
	note E_, 2
	note E_, 2
	intensity $91
	note E_, 2
	intensity $a1
	note E_, 1
	note_type 8, 11, 1
	note E_, 1
	note E_, 1
	endchannel

Music_LookKimonoGirl_Ch3:
	stereopanning $ff
	vibrato $12, $24
	note_type 6, 1, 3
	note __, 1
	note __, 16
	octave 5
	note E_, 1
	note F_, 1
	note E_, 2
	note_type 12, 1, 3
	note E_, 12
	note_type 6, 1, 3
	octave 5
	note D_, 2
	note E_, 2
Music_LookKimonoGirl_branch_f7aec:
	octave 5
	note D_, 4
	note E_, 4
	note F_, 4
	note A_, 4
	note B_, 4
	note A_, 4
	note B_, 4
	octave 6
	note D_, 4
	note E_, 8
	note F_, 1
	note F#, 1
	note F_, 2
	note D_, 4
	note E_, 8
	note D_, 4
	note E_, 4
	note F_, 8
	note A_, 8
	note B_, 1
	octave 7
	note C_, 1
	octave 6
	note B_, 2
	note A_, 4
	note F_, 4
	note D_, 4
	note E_, 1
	note F_, 1
	note E_, 10
	note F_, 2
	note E_, 2
	note D_, 8
	note E_, 8
	jumpchannel Music_LookKimonoGirl_branch_f7aec
