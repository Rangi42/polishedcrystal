Music_JohtoWildBattleNight:
	channel_count 3
	channel 1, Music_JohtoWildBattleNight_Ch1
	channel 2, Music_JohtoWildBattleNight_Ch2
	channel 3, Music_JohtoWildBattleNight_Ch3

Music_JohtoWildBattleNight_Ch1:
	tempo 107
	volume 7, 7
	dutycycle $3
	tone $0002
	vibrato $10, $25
	jumpchannel Music_JohtoWildBattleNight_branch_f5ddb

Music_JohtoWildBattleNight_Ch2:
	dutycycle $3
	vibrato $20, $36
	tone $0001
	callchannel Music_JohtoWildBattleNight_branch_f5f5d
	note_type 12, 12, 2
	octave 4
	note G_, 6
	tone $0001
	dutycycle $2
	jumpchannel Music_JohtoWildBattleNight_branch_f5eb2

Music_JohtoWildBattleNight_Ch3:
	note_type 12, 1, 1
	jumpchannel Music_JohtoWildBattleNight_branch_f5f94
