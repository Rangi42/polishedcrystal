; Pokémon HG/SS - Route 47
; Demixed by Mmmmmm
; https://pastebin.com/aSDuVfDW
; https://hax.iimarckus.org/topic/6777/4/

Music_Route47HGSS:
	channel_count 4
	channel 1, Music_Route47HGSS_Ch1
	channel 2, Music_Route47HGSS_Ch2
	channel 3, Music_Route47HGSS_Ch3
	channel 4, Music_Route47HGSS_Ch4

Music_Route47HGSS_Ch1:
	tempo 192
	volume 7, 7
	duty_cycle 0
	pitch_offset 2
	vibrato $8, $15
	note_type 6, 8, 2
	note __, 16
Music_Route47HGSS_Ch1_loop_main:
	note_type 6, 8, 2
Music_Route47HGSS_Ch1_loop_1:
	sound_call Music_Route47HGSS_Ch1_branch_1
	sound_call Music_Route47HGSS_Ch1_branch_1
	sound_call Music_Route47HGSS_Ch1_branch_1
	sound_call Music_Route47HGSS_Ch1_branch_1
	volume_envelope 8, 2
	octave 4
	note C_, 2
	volume_envelope 6, 2
	octave 3
	note C_, 2
	volume_envelope 4, 2
	note C_, 2
	volume_envelope 2, 2
	note C_, 2
	sound_loop 4, Music_Route47HGSS_Ch1_loop_1
	volume_envelope 8, 2
	octave 4
	note C_, 2
	volume_envelope 6, 2
	octave 3
	note C_, 2
	volume_envelope 4, 2
	note C_, 2
	volume_envelope 2, 2
	note C_, 2
	note_type 12, 9, 3
	duty_cycle 2
	octave 3
	note E_, 2
	note C_, 2
	note F_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	note A_, 2
	note F_, 2
	octave 4
	note C_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	octave 4
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note F_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	octave 2
	note G_, 2
	note F_, 2
	octave 3
	note D_, 2
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	note G_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	octave 3
	note C_, 2
	note D_, 2
	note E_, 4
	note F_, 2
	note G_, 2
	note A_, 2
	sound_call Music_Route47HGSS_Ch1_branch_2
	note G_, 2
	note F_, 2
	octave 2
	note G_, 2
	note A_, 2
	note A#, 2
	octave 3
	note C_, 2
	note C#, 2
	duty_cycle 0
	volume_envelope 6, 2
	octave 2
	note C_, 1
	note C_, 1
	duty_cycle 2
	volume_envelope 9, 3
	octave 3
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	duty_cycle 0
	volume_envelope 6, 2
	octave 3
	note C_, 1
	note C_, 3
	octave 2
	note A_, 1
	note A_, 3
	octave 3
	note F_, 1
	note F_, 3
	note C_, 1
	note C_, 3
	note A_, 1
	note A_, 3
	note F_, 1
	note F_, 1
	note_type 3, 7, 2
	octave 3
	note C_, 2
	note F_, 2
	note G_, 2
	note A#, 2
	note A_, 2
	octave 4
	note C_, 2
	note F_, 2
	note C_, 2
	note G_, 2
	note A#, 2
	note A_, 2
	octave 5
	note C_, 2
	note F_, 2
	note G_, 2
	note C_, 2
	note A#, 2
	octave 4
	note A_, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	octave 3
	note A#, 4
	note A_, 4
	octave 4
	note F_, 4
	note C_, 4
	octave 3
	note A#, 4
	note A_, 4
	note A#, 4
	note A_, 4
	note F_, 4
	note C_, 4
	octave 4
	note A_, 4
	note E_, 4
	note C_, 4
	octave 3
	note A_, 4
	octave 4
	note E_, 4
	note C_, 4
	octave 3
	note G_, 4
	note E_, 4
	octave 4
	note E_, 4
	note C_, 4
	octave 3
	note G_, 4
	note E_, 4
	note A_, 4
	note G_, 4
	note E_, 4
	note C_, 4
	octave 4
	note A_, 4
	note F_, 4
	note D_, 4
	note C_, 4
	note D_, 4
	note C_, 4
	octave 3
	note A_, 4
	note F_, 4
	octave 4
	note D_, 4
	note C_, 4
	octave 3
	note A_, 4
	note F_, 4
	note A_, 4
	note F_, 4
	note D_, 4
	note C_, 4
	octave 4
	note A_, 4
	note G_, 4
	note F_, 4
	note D_, 4
	note G_, 4
	note D_, 4
	octave 3
	note A_, 4
	note G_, 4
	octave 4
	note F_, 4
	note D_, 4
	octave 3
	note A_, 4
	note G_, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note D_, 4
	octave 4
	note A#, 4
	note G_, 4
	note F_, 4
	note D_, 4
	note F_, 4
	note D_, 4
	octave 3
	note A#, 4
	note G_, 4
	octave 4
	note F_, 4
	note D_, 4
	octave 3
	note A#, 4
	note G_, 4
	note A#, 4
	note G_, 4
	note F_, 4
	note D_, 4
	octave 4
	note G#, 4
	note G_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	octave 3
	note G#, 4
	note G_, 4
	octave 4
	note F_, 4
	note C_, 4
	octave 3
	note G#, 4
	note G_, 4
	note G#, 4
	note G_, 4
	note F_, 4
	note C_, 4
	octave 2
	note G_, 4
	note A#, 4
	octave 3
	note C_, 4
	octave 2
	note A#, 4
	octave 3
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note C_, 4
	note F_, 4
	note G_, 4
	note F_, 4
	note G_, 4
	octave 4
	note C_, 4
	octave 3
	note G_, 4
	octave 4
	note C_, 4
	octave 3
	note G_, 4
	note A#, 4
	octave 4
	note C_, 4
	octave 3
	note A#, 4
	octave 4
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	note E_, 4
	note A#, 4
	octave 5
	note C_, 4
	octave 4
	note A#, 4
	octave 5
	note C_, 4
	note G_, 4
	note C_, 4
	note G_, 4
	duty_cycle 2
	note_type 12, 8, 2
	octave 3
	note F_, 1
	note C_, 1
	note F_, 1
	note G_, 1
	octave 4
	note C_, 1
	note F_, 1
	note G_, 1
	octave 5
	note C_, 1
	octave 4
	note C_, 1
	octave 3
	note F_, 1
	note G_, 1
	octave 4
	note C_, 1
	note F_, 1
	note G_, 1
	octave 5
	note C_, 1
	note F_, 1
	octave 3
	note F_, 1
	note C_, 1
	note F_, 1
	note G_, 1
	octave 4
	note C_, 1
	note F_, 1
	note G_, 1
	octave 5
	note C_, 1
	octave 4
	note D_, 1
	octave 3
	note F_, 1
	note G_, 1
	octave 4
	note D_, 1
	note E_, 1
	note A_, 1
	octave 5
	note D_, 1
	note E_, 1
	octave 3
	note G_, 1
	octave 2
	note B_, 1
	octave 3
	note F_, 1
	note G_, 1
	note B_, 1
	octave 4
	note D_, 1
	note B_, 1
	octave 5
	note D_, 1
	octave 4
	note D_, 1
	octave 3
	note G_, 1
	note B_, 1
	octave 4
	note D_, 1
	note F_, 1
	note G_, 1
	note B_, 1
	octave 5
	note F_, 1
	octave 3
	note G_, 1
	octave 2
	note A#, 1
	octave 3
	note C#, 1
	note G_, 1
	note A#, 1
	octave 4
	note C#, 1
	note F_, 1
	note A#, 1
	note C#, 1
	octave 3
	note F_, 1
	note A#, 1
	octave 4
	note C#, 1
	note F_, 1
	note A#, 1
	octave 5
	note C#, 1
	note F_, 1
	octave 3
	note C_, 1
	note F_, 1
	note G_, 1
	note F_, 1
	note A#, 1
	octave 4
	note C_, 1
	note G_, 1
	note F_, 1
	note G_, 1
	note A#, 1
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	octave 5
	note C_, 1
	note F_, 1
	note G_, 1
	octave 6
	note C_, 1
	octave 3
	note C_, 1
	note D_, 1
	note A_, 1
	note D_, 1
	note A_, 1
	note F_, 1
	note A_, 1
	octave 4
	note C_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	note A_, 1
	note F_, 1
	note A_, 1
	octave 5
	note C_, 1
	note F_, 1
	octave 3
	duty_cycle 0
	note_type 6, 8, 2
	note A_, 1
	octave 4
	note A_, 1
	note __, 2
	octave 3
	volume_envelope 5, 2
	note A_, 1
	octave 4
	note A_, 1
	note __, 2
	octave 3
	volume_envelope 2, 2
	note A_, 1
	octave 4
	note A_, 1
	note __, 2
	octave 3
	volume_envelope 8, 2
	note C_, 1
	octave 4
	note C_, 1
	note __, 2
	octave 3
	volume_envelope 5, 2
	note C_, 1
	octave 4
	note C_, 1
	note __, 2
	octave 3
	volume_envelope 2, 2
	note C_, 1
	octave 4
	note C_, 1
	note __, 2
	octave 3
	volume_envelope 1, 2
	note C_, 1
	octave 4
	note C_, 1
	note __, 2
	octave 3
	volume_envelope 1, 2
	note C_, 1
	octave 4
	note C_, 1
	note __, 2
	octave 3
	volume_envelope 8, 2
	note G_, 1
	octave 4
	note G_, 1
	note __, 2
	octave 3
	volume_envelope 5, 2
	note G_, 1
	octave 4
	note G_, 1
	note __, 2
	octave 3
	volume_envelope 2, 2
	note G_, 1
	octave 4
	note G_, 1
	note __, 2
	octave 2
	volume_envelope 8, 2
	note A#, 1
	octave 3
	note A#, 1
	note __, 2
	octave 2
	volume_envelope 5, 2
	note A#, 1
	octave 3
	note A#, 1
	note __, 2
	octave 2
	volume_envelope 2, 2
	note A#, 1
	octave 3
	note A#, 1
	note __, 2
	volume_envelope 8, 2
	note G_, 1
	octave 2
	note G_, 1
	note __, 2
	volume_envelope 5, 2
	note G_, 1
	octave 3
	note G_, 1
	note __, 2
	sound_jump Music_Route47HGSS_Ch1_loop_main

Music_Route47HGSS_Ch1_branch_1:
	volume_envelope 8, 2
	octave 4
	note C_, 2
	volume_envelope 6, 2
	octave 3
	note C_, 1
	volume_envelope 4, 2
	octave 4
	note C_, 2
	volume_envelope 2, 2
	octave 3
	note C_, 1
	endchannel

Music_Route47HGSS_Ch1_branch_2:
	duty_cycle 0
	volume_envelope 6, 2
	octave 3
	note C_, 1
	note C_, 1
	duty_cycle 2
	volume_envelope 9, 3
	endchannel

Music_Route47HGSS_Ch2:
	duty_cycle 2
	vibrato $12, $25
	pitch_offset 1
	note_type 8, 5, 2
	octave 6
	note C_, 1
	octave 5
	note G_, 1
	volume_envelope 6, 2
	note F_, 1
	note G_, 1
	volume_envelope 7, 2
	note F_, 1
	note C_, 1
	volume_envelope 8, 2
	note F_, 1
	note C_, 1
	volume_envelope 9, 2
	octave 4
	note A#, 1
	octave 5
	note C_, 1
	volume_envelope 10, 2
	octave 4
	note G_, 1
	note C_, 1
Music_Route47HGSS_Ch2_loop:
	note_type 12, 10, 4
	octave 3
	note C_, 1
	note F_, 1
	note G_, 1
	note A#, 1
	note A_, 1
	octave 4
	note C_, 1
	note F_, 7
	note E_, 1
	note F_, 1
	note G_, 1
	note F_, 4
	octave 5
	note C_, 5
	octave 4
	note A#, 1
	note A_, 1
	note A#, 1
	note A_, 1
	note G_, 1
	note F_, 1
	note E_, 1
	note F_, 1
	note G_, 1
	note F_, 1
	note C_, 5
	note F_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 2
	note C_, 2
	octave 3
	note A#, 1
	octave 4
	note C_, 1
	note F_, 3
	note E_, 1
	note F_, 1
	note G_, 1
	note F_, 4
	note G_, 4
	note A_, 1
	note G_, 1
	note F_, 2
	duty_cycle 3
	volume_envelope 11, 7
	octave 3
	note G_, 4
	note A_, 4
	octave 4
	note C_, 4
	note F_, 8
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note A#, 2
	octave 4
	note C_, 4
	octave 3
	note F_, 8
	note E_, 2
	note F_, 2
	note G_, 4
	note D_, 4
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	octave 4
	note C_, 8
	note F_, 4
	note C_, 4
	octave 3
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	note G_, 8
	note F_, 5
	volume_envelope 8, 4
	octave 5
	note C_, 1
	octave 4
	note A#, 1
	note A_, 1
	note __, 4
	octave 5
	note C_, 1
	octave 4
	note G_, 1
	note F_, 1
	note C_, 1
	note __, 4
	note A_, 1
	note F_, 1
	octave 3
	note A#, 1
	note A_, 1
	note __, 4
	duty_cycle 2
	octave 4
	volume_envelope 10, 7
	note C_, 4
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 3
	volume_envelope 11, 3
	note G_, 3
	volume_envelope 6, 3
	note G_, 1
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 2
	octave 5
	note C_, 3
	volume_envelope 6, 3
	note C_, 1
	octave 4
	volume_envelope 11, 3
	note A#, 3
	volume_envelope 6, 3
	note A#, 1
	volume_envelope 11, 3
	note A_, 3
	volume_envelope 6, 3
	note A_, 1
	volume_envelope 11, 3
	note G_, 3
	volume_envelope 6, 3
	note G_, 1
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 3
	volume_envelope 11, 3
	note G_, 3
	volume_envelope 6, 3
	note G_, 1
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 2
	note A_, 3
	volume_envelope 6, 3
	note A_, 1
	volume_envelope 11, 3
	note G_, 3
	volume_envelope 6, 3
	note G_, 1
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 3
	volume_envelope 6, 3
	note E_, 1
	volume_envelope 11, 3
	note D_, 3
	volume_envelope 6, 3
	note D_, 3
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 3
	volume_envelope 6, 3
	note E_, 1
	volume_envelope 11, 3
	note F_, 2
	note C_, 3
	volume_envelope 6, 3
	note C_, 3
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 3
	volume_envelope 6, 3
	note E_, 1
	volume_envelope 11, 3
	note F_, 2
	note G#, 3
	volume_envelope 6, 3
	note G#, 1
	volume_envelope 11, 3
	note A#, 3
	volume_envelope 6, 3
	note A#, 1
	octave 5
	volume_envelope 11, 3
	note C_, 3
	volume_envelope 6, 3
	note C_, 1
	octave 4
	volume_envelope 11, 3
	note C_, 3
	volume_envelope 6, 3
	note C_, 1
	volume_envelope 11, 3
	note F_, 3
	volume_envelope 6, 3
	note F_, 1
	volume_envelope 11, 3
	note E_, 3
	volume_envelope 6, 3
	note E_, 1
	volume_envelope 11, 3
	note A_, 3
	volume_envelope 6, 3
	note A_, 1
	volume_envelope 11, 3
	note G_, 3
	volume_envelope 6, 3
	note G_, 1
	octave 1
	volume_envelope 7, 0
	note F_, 8
	volume_envelope 7, 7
	note F_, 8
	volume_envelope 7, 0
	octave 2
	note D_, 4
	volume_envelope 7, 7
	note D_, 4
	volume_envelope 7, 0
	note C_, 4
	volume_envelope 7, 7
	note C_, 4
	octave 1
	volume_envelope 7, 0
	note B_, 8
	volume_envelope 7, 7
	note B_, 8
	volume_envelope 7, 0
	note A#, 8
	volume_envelope 7, 7
	note A#, 8
	volume_envelope 7, 0
	note A_, 8
	volume_envelope 7, 7
	note A_, 8
	volume_envelope 7, 0
	octave 2
	note D_, 8
	volume_envelope 7, 7
	note D_, 8
	note_type 3, 10, 2
	note D_, 2
	octave 5
	volume_envelope 8, 2
	note D_, 2
	octave 4
	volume_envelope 5, 2
	note A_, 3
	note F_, 3
	note D_, 2
	octave 3
	note A_, 4
	octave 4
	volume_envelope 10, 2
	note C_, 2
	octave 5
	volume_envelope 8, 2
	note C_, 2
	octave 4
	volume_envelope 5, 2
	note A_, 3
	note F_, 3
	note C_, 2
	octave 3
	note A_, 4
	volume_envelope 10, 2
	note F_, 2
	octave 4
	volume_envelope 8, 2
	note F_, 2
	volume_envelope 5, 2
	note C_, 3
	octave 3
	note A_, 3
	note F_, 2
	note D_, 4
	volume_envelope 10, 2
	note G_, 2
	octave 4
	volume_envelope 8, 2
	note G_, 2
	volume_envelope 5, 2
	note D_, 3
	octave 3
	note A#, 3
	note G_, 2
	note D_, 4
	octave 4
	volume_envelope 10, 2
	note C#, 2
	octave 5
	volume_envelope 8, 2
	note C#, 2
	octave 4
	volume_envelope 5, 2
	note G_, 3
	note C#, 3
	octave 3
	note A#, 2
	note G_, 4
	volume_envelope 10, 2
	note A#, 2
	octave 4
	volume_envelope 8, 2
	note A#, 2
	volume_envelope 5, 2
	note F_, 3
	note C#, 3
	octave 3
	note A#, 2
	note F_, 4
	volume_envelope 10, 2
	note D_, 2
	octave 4
	volume_envelope 8, 2
	note D_, 2
	octave 3
	volume_envelope 5, 2
	note A#, 3
	note G_, 3
	note D_, 2
	octave 2
	note A#, 4
	octave 3
	volume_envelope 10, 2
	note E_, 2
	octave 4
	volume_envelope 8, 2
	note E_, 2
	volume_envelope 5, 2
	note C_, 3
	octave 3
	note A#, 3
	note G_, 2
	note E_, 4
	sound_jump Music_Route47HGSS_Ch2_loop

Music_Route47HGSS_Ch3:
	note_type 12, 2, 5
	vibrato $12, $15
	note __, 8
Music_Route47HGSS_Ch3_loop:
	octave 1
	note F_, 12
	note A_, 4
	note A#, 12
	volume_envelope 3, 5
	note A#, 4
	volume_envelope 2, 5
	octave 2
	note D_, 12
	note C_, 4
	octave 1
	note G#, 8
	note A#, 4
	octave 2
	note C_, 4
	octave 1
	note F_, 12
	volume_envelope 3, 5
	note F_, 4
	volume_envelope 2, 5
	note A#, 8
	octave 2
	note C_, 8
	note D_, 8
	octave 1
	note A_, 8
	note A#, 4
	note G_, 4
	octave 2
	note C_, 4
	octave 1
	note A#, 4
	note A_, 8
	octave 2
	note D_, 8
	octave 1
	note G_, 8
	note A#, 8
	note F_, 16
	volume_envelope 3, 5
	note F_, 12
	volume_envelope 2, 5
	octave 2
	note C_, 4
	octave 1
	note F_, 12
	volume_envelope 3, 5
	note F_, 4
	volume_envelope 2, 5
	note F_, 12
	volume_envelope 3, 5
	note F_, 4
	volume_envelope 2, 5
	octave 2
	note D_, 12
	volume_envelope 3, 5
	note D_, 4
	volume_envelope 2, 5
	octave 1
	note B_, 12
	volume_envelope 3, 5
	note B_, 4
	volume_envelope 2, 5
	note A#, 12
	volume_envelope 3, 5
	note A#, 4
	volume_envelope 2, 5
	note G#, 12
	volume_envelope 3, 5
	note G#, 4
	volume_envelope 2, 5
	note A#, 12
	volume_envelope 3, 5
	note A#, 4
	volume_envelope 2, 5
	octave 2
	note C_, 12
	volume_envelope 3, 5
	note C_, 4
	volume_envelope 1, 3
	vibrato $12, $24
	octave 5
	note F_, 6
	note G_, 4
	note F_, 4
	note C_, 2
	octave 6
	note C_, 4
	octave 5
	note A_, 4
	octave 6
	note D_, 4
	note E_, 4
	note F_, 6
	octave 5
	note F_, 4
	note G_, 4
	note F_, 2
	octave 6
	note C_, 4
	octave 5
	note A#, 4
	note F_, 4
	note C#, 4
	note C_, 6
	note F_, 6
	note A#, 6
	octave 6
	note_type 4, 1, 3
	note C_, 16
	note D#, 1
	note E_, 1
	note_type 12, 1, 3
	note F_, 4
	octave 5
	note F_, 4
	vibrato $12, $15
	volume_envelope 2, 5
	octave 1
	note G_, 16
	octave 2
	note C_, 16
	sound_jump Music_Route47HGSS_Ch3_loop

Music_Route47HGSS_Ch4:
	toggle_noise 3
	note_type 12
Music_Route47HGSS_Ch4_loop_main:
	note __, 5
	sound_call Music_Route47HGSS_Ch4_branch_1
	note B_, 16
	note __, 16
	note B_, 16
	note __, 13
	sound_call Music_Route47HGSS_Ch4_branch_1
	note B_, 3
	sound_call Music_Route47HGSS_Ch4_branch_2
Music_Route47HGSS_Ch4_loop_1:
	note C_, 1
	note C#, 1
	note C#, 1
	sound_call Music_Route47HGSS_Ch4_branch_2
	sound_loop 6, Music_Route47HGSS_Ch4_loop_1
	note C_, 1
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note __, 2
	note C#, 1
	note C#, 1
	note __, 4
	note B_, 3
	sound_call Music_Route47HGSS_Ch4_branch_2
Music_Route47HGSS_Ch4_loop_2:
	note C_, 1
	note C#, 1
	note C#, 1
	sound_call Music_Route47HGSS_Ch4_branch_2
	sound_loop 7, Music_Route47HGSS_Ch4_loop_2
	note B_, 3
	note C#, 1
	note C#, 2
	note C#, 1
	note C#, 9
	sound_call Music_Route47HGSS_Ch4_branch_3
	sound_call Music_Route47HGSS_Ch4_branch_3
	sound_call Music_Route47HGSS_Ch4_branch_3
	sound_call Music_Route47HGSS_Ch4_branch_4
	note __, 8
	sound_call Music_Route47HGSS_Ch4_branch_4
	note __, 8
	sound_call Music_Route47HGSS_Ch4_branch_4
	note __, 8
	sound_call Music_Route47HGSS_Ch4_branch_4
	sound_jump Music_Route47HGSS_Ch4_loop_main

Music_Route47HGSS_Ch4_branch_1:
	note_type 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note_type 12
	endchannel

Music_Route47HGSS_Ch4_branch_2:
	note C_, 1
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 3
	note C#, 1
	note C#, 1
	note C_, 1
	note C#, 1
	note C#, 2
	endchannel

Music_Route47HGSS_Ch4_branch_3:
	note C#, 1
	note C#, 2
	note C#, 1
	note C#, 2
	note C#, 1
	note C#, 9
	endchannel

Music_Route47HGSS_Ch4_branch_4:
	note C#, 2
	note C#, 1
	note C#, 2
	note C#, 3
	endchannel
