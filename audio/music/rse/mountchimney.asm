; Pokémon R/S/E - Mount Chimney
; Demixed by Mmmmmm
; https://pastebin.com/Yivqb9Tq
; https://hax.iimarckus.org/topic/6777/4/

Music_MountChimneyRSE:
	channel_count 4
	channel 1, Music_MountChimneyRSE_Ch1
	channel 2, Music_MountChimneyRSE_Ch2
	channel 3, Music_MountChimneyRSE_Ch3
	channel 4, Music_MountChimneyRSE_Ch4

Music_MountChimneyRSE_Ch1:
	tempo 160
	volume 7, 7
	duty_cycle 0
	pitch_offset 2
	vibrato $8, $15
	note_type 12, 8, 0
	octave 1
	note G_, 4
	octave 2
	note D#, 4
	octave 1
	note A#, 4
	octave 2
	note G_, 4
	note A#, 8
	volume_envelope 8, 7
	note A#, 9
Music_MountChimneyRSE_Ch1_loop_main:
	callchannel Music_MountChimneyRSE_Ch1_branch_1
	octave 4
	volume_envelope 10, 2
	note F#, 2
	note F_, 1
	note E_, 1
	note D#, 1
	note C#, 1
	octave 3
	note B_, 1
	note __, 1
	note_type 8, 5, 2
	duty_cycle 1
Music_MountChimneyRSE_Ch1_loop_1:
	octave 2
	note B_, 1
	octave 3
	note D#, 1
	note F#, 1
	note A#, 1
	note F#, 1
	note D#, 1
	loopchannel 3, Music_MountChimneyRSE_Ch1_loop_1
Music_MountChimneyRSE_Ch1_loop_2:
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	note F_, 1
	note G#, 1
	note F_, 1
	note C#, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_2
	duty_cycle 0
	note_type 6, 10, 2
	note G#, 2
	octave 4
	note C#, 4
	octave 3
	note F_, 2
	octave 4
	note D#, 2
	note C#, 1
	note C_, 1
	octave 3
	note A#, 1
	note G#, 3
	octave 4
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 4
	note C#, 4
	note C#, 2
	note_type 8, 5, 2
	duty_cycle 1
Music_MountChimneyRSE_Ch1_loop_3:
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note G#, 1
	note E_, 1
	note C#, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_3
Music_MountChimneyRSE_Ch1_loop_4:
	octave 2
	note G#, 1
	octave 3
	note C_, 1
	note D#, 1
	note G_, 1
	note D#, 1
	note C_, 1
	loopchannel 2, Music_MountChimneyRSE_Ch1_loop_4
	duty_cycle 0
	note_type 6, 10, 2
	note G#, 2
	octave 4
	note C_, 4
	octave 3
	note G#, 2
	octave 4
	note D#, 2
	note C#, 1
	note C_, 1
	octave 3
	note A#, 1
	note G#, 3
	duty_cycle 1
	volume_envelope 10, 7
	octave 2
	note A#, 12
	note G#, 2
	note A#, 2
	octave 3
	note C_, 8
	octave 2
	note G#, 2
	note D#, 2
	octave 3
	note C_, 2
	note C#, 2
	note D#, 12
	note D#, 2
	note E_, 2
	duty_cycle 0
	volume_envelope 10, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note __, 10
	note F_, 4
	note D_, 2
	note F_, 2
	note D_, 2
	note F_, 2
	note G#, 4
	callchannel Music_MountChimneyRSE_Ch1_branch_1
	octave 3
	volume_envelope 10, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	volume_envelope 10, 4
	note G#, 4
	volume_envelope 10, 2
	note G_, 4
	note G_, 2
	note G#, 4
	note G#, 2
	volume_envelope 10, 7
	note G_, 8
	volume_envelope 10, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	volume_envelope 10, 4
	note G#, 4
	volume_envelope 10, 2
	note G_, 4
	note G_, 2
	note G#, 4
	note G#, 2
	volume_envelope 10, 7
	note B_, 8
	volume_envelope 10, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	volume_envelope 10, 4
	note G#, 4
	volume_envelope 10, 2
	note G_, 4
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	volume_envelope 10, 4
	note G#, 4
	volume_envelope 10, 2
	note G_, 4
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	callchannel Music_MountChimneyRSE_blank
	note __, 2
	sound_jump Music_MountChimneyRSE_Ch1_loop_main

Music_MountChimneyRSE_Ch1_branch_1:
	note_type 6, 10, 2
	octave 3
	note F_, 1
	note E_, 1
	note D#, 4
	note G#, 4
	note G_, 4
	note A_, 2
	note A#, 4
	note A#, 2
	volume_envelope 10, 5
	note G#, 4
	note F_, 4
	volume_envelope 10, 2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 6
	octave 4
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 4
	volume_envelope 10, 4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	volume_envelope 10, 2
	note D_, 5
	octave 3
	note E_, 1
	note D#, 4
	note G#, 4
	note G_, 4
	volume_envelope 10, 5
	note A#, 8
	note G#, 4
	note F_, 4
	volume_envelope 10, 2
	note F#, 2
	note G#, 4
	note G#, 6
	octave 4
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G#, 2
	note B_, 2
	note B_, 2
	octave 5
	note D#, 1
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note A_, 1
	note G_, 16
	note __, 3
	volume_envelope 10, 3
	note D_, 2
	note D#, 8
	octave 3
	volume_envelope 10, 2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	octave 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 2
	octave 3
	volume_envelope 10, 0
	note D#, 16
	volume_envelope 10, 7
	note D#, 16
	note __, 16
	note __, 16
	note __, 4
	volume_envelope 10, 2
	note A#, 2
	note A_, 2
	note G#, 4
	note G_, 4
	note A_, 2
	note A#, 4
	note A#, 2
	volume_envelope 10, 5
	note G#, 4
	note F_, 4
	volume_envelope 10, 2
	note B_, 2
	note B_, 2
	note A#, 2
	note B_, 6
	octave 4
	note D#, 2
	note D#, 2
	note D#, 4
	note D#, 4
	volume_envelope 10, 4
	note D_, 4
	octave 3
	volume_envelope 10, 2
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note D#, 2
	note D#, 2
	note A#, 2
	note A_, 2
	note G#, 4
	note G_, 4
	volume_envelope 10, 5
	note A#, 8
	note G#, 4
	note F_, 4
	volume_envelope 10, 2
	note F#, 2
	note G#, 4
	note G#, 6
	octave 4
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 2
	note G#, 2
	note G#, 2
	note G_, 2
	note G#, 2
	note B_, 2
	note B_, 2
	octave 5
	note D#, 1
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note A_, 1
	note G_, 16
	note __, 3
	note D_, 2
	note D#, 8
	octave 3
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	octave 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 2
	octave 3
	volume_envelope 10, 0
	note D#, 16
	volume_envelope 10, 7
	note D#, 16
	note __, 16
	note __, 16
	endchannel

Music_MountChimneyRSE_blank:
	note __, 16
	loopchannel 8, Music_MountChimneyRSE_blank
	endchannel

Music_MountChimneyRSE_Ch2:
	duty_cycle 3
	vibrato $12, $25
	pitch_offset 1
	note_type 12, 8, 0
	octave 2
	note D#, 4
	note A#, 4
	note G_, 4
	octave 3
	note C#, 4
	note D#, 8
	volume_envelope 8, 7
	note D#, 9
Music_MountChimneyRSE_Ch2_loop:
	callchannel Music_MountChimneyRSE_Ch2_branch_1
	octave 4
	volume_envelope 12, 0
	note D#, 8
	volume_envelope 12, 6
	note D#, 12
	volume_envelope 12, 2
	note C#, 8
	octave 3
	note G#, 4
	volume_envelope 12, 0
	note A#, 16
	volume_envelope 12, 7
	note A#, 16
	octave 4
	volume_envelope 12, 0
	note C#, 16
	volume_envelope 12, 4
	note C#, 8
	volume_envelope 12, 2
	octave 3
	note B_, 4
	octave 4
	note C#, 2
	octave 3
	note B_, 2
	volume_envelope 12, 5
	note A#, 2
	octave 4
	note C_, 1
	octave 3
	note A#, 1
	volume_envelope 12, 0
	note G#, 16
	volume_envelope 12, 5
	note G#, 12
	volume_envelope 12, 0
	note F#, 4
	volume_envelope 12, 5
	note F#, 8
	note F_, 2
	note F#, 2
	note G#, 8
	note D#, 8
	volume_envelope 12, 7
	note G#, 12
	note G_, 2
	note G#, 2
	volume_envelope 12, 0
	note A#, 8
	volume_envelope 10, 0
	note G#, 1
	note G_, 1
	volume_envelope 9, 0
	note F_, 1
	volume_envelope 7, 0
	note D#, 1
	volume_envelope 5, 0
	note C#, 1
	volume_envelope 4, 0
	note C_, 1
	octave 2
	volume_envelope 3, 0
	note A#, 1
	note __, 3
	volume_envelope 12, 2
	octave 3
	note A#, 4
	note F_, 2
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	octave 4
	note D_, 2
	note F_, 4
	volume_envelope 10, 2
	callchannel Music_MountChimneyRSE_Ch2_branch_1
	octave 3
	volume_envelope 10, 2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	volume_envelope 10, 4
	note D#, 4
	volume_envelope 10, 2
	note D_, 4
	note D_, 2
	note D#, 4
	note D#, 2
	volume_envelope 10, 7
	note D_, 8
	duty_cycle 0
	octave 3
	volume_envelope 10, 2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	volume_envelope 10, 4
	note D#, 4
	volume_envelope 10, 2
	note D_, 4
	note D_, 2
	note D#, 4
	note D#, 2
	volume_envelope 10, 7
	note F#, 8
	duty_cycle 1
	octave 3
	volume_envelope 10, 2
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	volume_envelope 10, 4
	note D#, 4
	volume_envelope 10, 2
	note D_, 4
	duty_cycle 0
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	volume_envelope 10, 4
	note D#, 4
	volume_envelope 10, 2
	note D_, 4
	duty_cycle 1
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	duty_cycle 0
	octave 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	octave 3
	note G#, 2
	note G#, 2
	note G#, 2
	note G#, 1
	note G#, 1
	callchannel Music_MountChimneyRSE_blank
	duty_cycle 3
	note __, 2
	sound_jump Music_MountChimneyRSE_Ch2_loop

Music_MountChimneyRSE_Ch2_branch_1:
	note_type 6, 10, 2
	octave 3
	note A#, 1
	note A_, 1
	note G#, 4
	octave 4
	note D#, 4
	note D_, 4
	note F_, 2
	note F#, 4
	note F#, 2
	volume_envelope 10, 5
	note F_, 4
	note C#, 4
	volume_envelope 10, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 6
	duty_cycle 0
	octave 3
	note B_, 2
	note B_, 2
	note B_, 4
	note B_, 4
	volume_envelope 10, 4
	note A#, 4
	note G_, 2
	volume_envelope 10, 2
	note A#, 5
	duty_cycle 3
	note A_, 1
	note G#, 4
	octave 4
	note D#, 4
	note D_, 3
	note G_, 1
	volume_envelope 10, 5
	note F#, 8
	note F_, 4
	note C#, 4
	volume_envelope 10, 2
	note D_, 2
	note D#, 4
	note D#, 5
	note G_, 1
	volume_envelope 10, 0
	note G#, 8
	volume_envelope 10, 6
	note G#, 12
	volume_envelope 10, 2
	note D#, 2
	octave 3
	note A#, 2
	note G_, 2
	volume_envelope 10, 1
	note D#, 4
	note C#, 4
	octave 2
	note A#, 4
	note G_, 4
	note D#, 2
	octave 3
	volume_envelope 10, 3
	note D_, 2
	note D#, 8
	duty_cycle 0
	octave 2
	volume_envelope 10, 2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	duty_cycle 3
	octave 3
	note D#, 2
	note D_, 2
	note D#, 2
	note G_, 2
	note_type 12, 10, 0
	note A#, 8
	volume_envelope 10, 7
	note A#, 9
	note_type 6, 10, 2
	duty_cycle 0
	octave 4
	note D#, 4
	note C#, 2
	note D#, 1
	note E_, 1
	note C#, 2
	octave 3
	note A#, 2
	note G_, 2
	note A#, 2
	note A#, 2
	note A#, 2
	note A#, 2
	octave 4
	note D#, 1
	note D_, 1
	note C_, 1
	octave 3
	note A#, 1
	note A_, 1
	note G_, 7
	duty_cycle 3
	octave 4
	note F#, 2
	note F_, 2
	note D#, 4
	note D_, 4
	note F_, 2
	note F#, 4
	note F#, 2
	volume_envelope 10, 5
	note F_, 4
	note C#, 4
	volume_envelope 10, 2
	note D#, 2
	note D#, 2
	note D_, 2
	note D#, 6
	duty_cycle 0
	octave 3
	note B_, 2
	note B_, 2
	note B_, 4
	note B_, 4
	volume_envelope 10, 4
	note A#, 4
	volume_envelope 10, 2
	note G_, 2
	note A#, 2
	duty_cycle 3
	note G#, 2
	note G#, 2
	octave 4
	note F#, 2
	note F_, 2
	note D#, 4
	note D_, 3
	note G_, 1
	volume_envelope 10, 5
	note F#, 8
	note F_, 4
	note C#, 4
	volume_envelope 10, 2
	note D_, 2
	note D#, 4
	note D#, 5
	note G_, 1
	volume_envelope 10, 0
	note G#, 8
	volume_envelope 10, 7
	note G#, 12
	volume_envelope 10, 2
	note D#, 2
	octave 3
	note A#, 2
	note G_, 2
	volume_envelope 10, 1
	note D#, 4
	note C#, 4
	octave 2
	note A#, 4
	note G_, 4
	note D#, 2
	octave 3
	volume_envelope 10, 3
	note D_, 2
	note D#, 8
	octave 2
	duty_cycle 0
	volume_envelope 10, 2
	note G_, 4
	note D#, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note A#, 10
	duty_cycle 3
	octave 3
	note D#, 2
	note D_, 2
	note D#, 2
	note G_, 2
	volume_envelope 10, 0
	note A#, 16
	volume_envelope 10, 7
	note A#, 16
	volume_envelope 6, 0
	octave 2
	note D#, 8
	volume_envelope 7, 0
	note A#, 8
	octave 3
	volume_envelope 8, 0
	note G_, 8
	octave 4
	volume_envelope 9, 0
	note C#, 8
	endchannel

Music_MountChimneyRSE_Ch3:
	note_type 6, 2, 5
	vibrato $12, $15
	octave 2
	note D#, 4
	note __, 12
	octave 1
	note A#, 4
	note __, 8
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	octave 2
	note D#, 4
	note __, 4
	octave 1
	note A#, 4
	note __, 4
	note D#, 4
	note __, 4
	octave 4
	note C#, 1
	octave 3
	note A#, 1
	note G_, 1
	note D#, 1
	note C#, 1
	octave 2
	note A#, 1
	note G_, 1
	note D#, 1
Music_MountChimneyRSE_Ch3_loop:
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	octave 1
	note B_, 3
	note F#, 3
	octave 2
	note F#, 2
	note __, 4
	note A#, 2
	note __, 4
	note A#, 2
	note D#, 4
	note F#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note A#, 3
	note F_, 3
	octave 2
	note F_, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note C#, 4
	note F#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 1
	note A#, 4
	octave 1
	note A_, 3
	note E_, 3
	octave 2
	note E_, 2
	note __, 4
	note G#, 2
	note __, 4
	note G#, 2
	note C#, 4
	note E_, 2
	note __, 2
	octave 1
	note A_, 2
	note __, 2
	octave 1
	note G#, 3
	note D#, 3
	octave 2
	note D#, 2
	note __, 4
	note G_, 2
	note __, 4
	note G_, 2
	note C_, 4
	note D#, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 1
	note G#, 4
	note F#, 6
	note A#, 2
	note __, 4
	octave 2
	note C#, 2
	note __, 2
	octave 1
	note F_, 2
	note G#, 2
	octave 2
	note C_, 2
	note D#, 2
	note __, 2
	note F_, 2
	note __, 2
	note G_, 2
	octave 1
	note E_, 6
	note B_, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 2
	octave 1
	note D_, 2
	note F_, 2
	note G#, 2
	note A#, 2
	octave 2
	note D_, 2
	note F_, 2
	note G#, 2
	note A#, 2
	note __, 2
	note D_, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note A#, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 1
	note A_, 1
	note __, 1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_1
	callchannel Music_MountChimneyRSE_Ch3_branch_2
	callchannel Music_MountChimneyRSE_Ch3_branch_2
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 2
	note G#, 4
	octave 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	callchannel Music_MountChimneyRSE_blank
	sound_jump Music_MountChimneyRSE_Ch3_loop

Music_MountChimneyRSE_Ch3_branch_1:
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 1
	note B_, 4
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 2
	note __, 2
	note C#, 2
	note __, 2
	octave 1
	note G#, 6
	octave 2
	note D#, 2
	note __, 4
	note B_, 2
	note __, 4
	note B_, 1
	note __, 1
	octave 1
	note B_, 4
	octave 2
	note D#, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	octave 2
	note A#, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	note A#, 1
	note __, 1
	octave 2
	note D#, 1
	note __, 1
	octave 1
	note G_, 4
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	octave 2
	note A#, 2
	note __, 2
	note G_, 2
	note __, 2
	octave 1
	note D#, 6
	note A#, 2
	note __, 4
	octave 2
	note D#, 2
	note __, 4
	note D#, 1
	note __, 1
	octave 1
	note D#, 4
	note G_, 1
	note __, 1
	octave 2
	note C#, 1
	note __, 1
	note D#, 1
	note G_, 1
	note A#, 1
	octave 3
	note C#, 1
	endchannel

Music_MountChimneyRSE_Ch3_branch_2:
	octave 2
	note G#, 4
	octave 1
	note G#, 4
	note __, 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note B_, 1
	octave 2
	note C#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note F_, 1
	note F_, 1
	endchannel

Music_MountChimneyRSE_Ch4:
	toggle_noise 4
	note_type 6
	note B_, 4
	note E_, 2
	note C#, 1
	note G_, 1
	note E_, 2
	note E_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
Music_MountChimneyRSE_Ch4_loop:
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	note A_, 16
	note D_, 2
	note C#, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 4
	note E_, 2
	note C#, 2
	note C#, 2
	note D_, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note C#, 2
	note C#, 2
	note D_, 1
	note C#, 1
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note B_, 4
	note E_, 6
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 2
	note D_, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note C#, 1
	note C#, 1
	note E_, 4
	note E_, 4
	note D_, 2
	note E_, 2
	note D_, 4
	note E_, 2
	note D_, 2
	note E_, 4
	note E_, 4
	note E_, 2
	note C#, 1
	note C#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 4
	note C#, 4
	note C#, 2
	note C#, 2
	note C#, 2
	note B_, 4
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	callchannel Music_MountChimneyRSE_Ch4_branch_1
	note E_, 4
	note A#, 8
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 8
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note B_, 8
	note E_, 4
	note A#, 4
	note E_, 4
	note A#, 4
	note E_, 4
	note A#, 4
	note E_, 4
	note E_, 2
	note E_, 1
	note E_, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note E_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note D_, 1
	note E_, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note __, 2
	note E_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note A_, 2
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note E_, 2
	note E_, 2
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	sound_jump Music_MountChimneyRSE_Ch4_loop

Music_MountChimneyRSE_Ch4_branch_1:
	note B_, 6
	note C#, 4
	note G_, 2
	note C#, 4
	note F_, 2
	note F_, 2
	note C#, 2
	note F_, 2
	note E_, 4
	note F_, 4
	note E_, 2
	note E_, 2
	note A#, 4
	note C#, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 4
	note C#, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note A#, 2
	note C#, 4
	note G_, 2
	note C#, 8
	note D_, 2
	note D_, 2
	note E_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note A#, 4
	note D_, 4
	note E_, 2
	note E_, 2
	note D_, 2
	note D_, 2
	note A#, 3
	note C#, 1
	note D_, 4
	note A#, 4
	note B_, 6
	note C#, 4
	note G_, 2
	note C#, 4
	note F_, 2
	note F_, 2
	note C#, 4
	note E_, 4
	note D_, 2
	note D_, 2
	note E_, 4
	note D#, 2
	note C#, 4
	note G_, 2
	note D_, 2
	note D_, 2
	note E_, 4
	note D#, 2
	note C#, 2
	note E_, 4
	note E_, 4
	note D_, 4
	note A_, 2
	note D_, 4
	note A_, 2
	note D_, 4
	note A_, 2
	note D#, 2
	note D#, 4
	note E_, 4
	note D#, 4
	note B_, 16
	note F_, 2
	note F_, 2
	note F_, 2
	note F_, 2
	note G#, 2
	note A_, 2
	note D_, 2
	note E_, 2
	endchannel
