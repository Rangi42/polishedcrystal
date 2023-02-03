; Pokémon White 2 - Reversal Mountain
; Demixed by Mmmmmm
; https://pastebin.com/mUzX8S44
; https://hax.iimarckus.org/topic/6777/2/

Music_ReversalMountainWhite2:
	channel_count 4
	channel 1, Music_ReversalMountainWhite2_Ch1
	channel 2, Music_ReversalMountainWhite2_Ch2
	channel 3, Music_ReversalMountainWhite2_Ch3
	channel 4, Music_ReversalMountainWhite2_Ch4

Music_ReversalMountainWhite2_Ch1:
	tempo 176
	volume 7, 7
	duty_cycle 2
	tone $0002
	vibrato $10, $22
	note_type 12, 6, 2
	note __, 1
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
Music_ReversalMountainWhite2_Ch1_loop:
	octave 4
	note C_, 2
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
	duty_cycle 0
	note_type 6, 9, 4
	octave 3
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	volume_envelope 9, 0
	note G_, 6
	volume_envelope 9, 7
	note G_, 6
	volume_envelope 9, 4
	note F#, 6
	volume_envelope 9, 6
	note F#, 4
	note __, 10
	volume_envelope 9, 0
	note F#, 6
	volume_envelope 9, 7
	note F#, 6
	volume_envelope 9, 4
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	volume_envelope 9, 0
	note G_, 2
	volume_envelope 9, 4
	note G_, 4
	volume_envelope 9, 0
	note G_, 2
	volume_envelope 9, 4
	note G_, 4
	volume_envelope 9, 4
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	volume_envelope 9, 0
	note F#, 2
	volume_envelope 9, 4
	note F#, 4
	volume_envelope 9, 0
	note F#, 2
	volume_envelope 9, 4
	note F#, 4
	volume_envelope 9, 0
	note F_, 2
	volume_envelope 9, 4
	note F_, 4
	;;;;;;;;;;;;;;;
	note F_, 4
	note __, 10
	volume_envelope 9, 0
	note F_, 2
	volume_envelope 9, 4
	note F_, 4
	volume_envelope 9, 0
	note A_, 2
	volume_envelope 9, 4
	note A_, 4
	;;;;;;;;;;;
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	note G_, 4
	note __, 2
	note G_, 4
	note __, 2
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	volume_envelope 9, 0
	note G_, 6
	volume_envelope 9, 7
	note G_, 6
	volume_envelope 9, 4
	note F#, 4
	note __, 2
	note F#, 4
	note __, 10
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 9, 4
	note D_, 4
	volume_envelope 9, 0
	note C#, 2
	volume_envelope 9, 4
	note C#, 4
;;;;;;;;;;;;;;;;mark
	volume_envelope 9, 0
	note C_, 16
	volume_envelope 9, 7
	note C_, 16
	octave 2
	volume_envelope 9, 0
	note A_, 8
	volume_envelope 9, 7
	note A_, 8
	octave 3
	volume_envelope 9, 0
	note D_, 8
	volume_envelope 9, 7
	note D_, 8
	volume_envelope 9, 0
	note C_, 8
	volume_envelope 9, 7
	note C_, 8
	volume_envelope 9, 0
	note E_, 8
	volume_envelope 9, 7
	note E_, 8
	volume_envelope 9, 0
	note D_, 16
	volume_envelope 9, 7
	note D_, 8
	volume_envelope 10, 4
	note D_, 2
	note E_, 4
	note E_, 2
;;;;;;;;;;;;;;;mark
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	note F_, 4
	note __, 2
	volume_envelope 10, 0
	note F_, 2
	volume_envelope 10, 4
	note F_, 4
	note E_, 4
	note __, 2
	note E_, 4
	note __, 10
	note E_, 4
	note __, 2
	volume_envelope 10, 0
	note E_, 2
	volume_envelope 10, 4
	note E_, 4
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	note A_, 4
	note __, 2
	volume_envelope 10, 0
	note A_, 2
	volume_envelope 10, 4
	note A_, 4
	volume_envelope 10, 0
	note B_, 10
	volume_envelope 10, 7
	note B_, 6
	volume_envelope 10, 0
	note A#, 10
	volume_envelope 10, 7
	note A#, 6
	volume_envelope 10, 4
	note A_, 4
	note __, 2
	note A_, 4
	note __, 10
	volume_envelope 10, 0
	note F_, 6
	volume_envelope 10, 7
	note F_, 6
	volume_envelope 10, 4
	note B_, 4
	note __, 2
	note B_, 4
	note __, 10
	volume_envelope 10, 0
	note G_, 6
	note_type 3, 12, 0
	duty_cycle 2
	octave 4
	note E_, 3
	note G#, 1
	note A_, 4
	note G_, 8
	volume_envelope 9, 0
	note G_, 4
	volume_envelope 3, 0
	note G_, 4
	volume_envelope 12, 0
	note G#, 4
	note A_, 4
	note C_, 4
	volume_envelope 9, 0
	note C_, 4
	volume_envelope 12, 0
	note D_, 4
	note E_, 16
	note F_, 14
	note __, 2
	note G_, 3
	note __, 1
	note G_, 4
	volume_envelope 3, 0
	note G_, 4
	note __, 12
	volume_envelope 12, 0
	note G_, 3
	note __, 1
	note G_, 4
	volume_envelope 3, 0
	note G_, 4
	note __, 4
	note_type 6, 10, 4
	duty_cycle 0
	octave 3
	note B_, 2
	note B_, 2
	note __, 8
	volume_envelope 10, 7
	note A_, 16
	duty_cycle 2
	note_type 12, 6, 2
	note __, 2
	octave 4
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	jumpchannel Music_ReversalMountainWhite2_Ch1_loop

Music_ReversalMountainWhite2_Ch1_branch_1:
	octave 4
	note D_, 2
	note G_, 2
	note E_, 2
	note G_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	endchannel

Music_ReversalMountainWhite2_Ch2:
	duty_cycle 3
	vibrato $1c, $12
	note_type 12, 6, 2
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
Music_ReversalMountainWhite2_Ch2_loop:
	octave 4
	note C_, 2
	callchannel Music_ReversalMountainWhite2_Ch1_branch_1
	octave 4
	note C_, 1
	duty_cycle 0
	note_type 6, 9, 4
	octave 3
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	volume_envelope 9, 0
	note C_, 6
	volume_envelope 9, 7
	note C_, 6
	volume_envelope 9, 4
	note D_, 6
	volume_envelope 9, 6
	note D_, 4
	note __, 10
	volume_envelope 9, 0
	note D_, 6
	volume_envelope 9, 7
	note D_, 6
	volume_envelope 9, 4
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	volume_envelope 9, 0
	note C_, 2
	volume_envelope 9, 4
	note C_, 4
	volume_envelope 9, 0
	note C_, 2
	volume_envelope 9, 4
	note C_, 4
	volume_envelope 9, 4
	note F#, 4
	note __, 2
	note F#, 4
	note __, 10
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 9, 4
	note D_, 4
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 9, 4
	note D_, 4
	volume_envelope 9, 0
	note D_, 2
	volume_envelope 9, 4
	note D_, 4
	;;;;;;;;;;;;;;;
	note D_, 4
	note __, 10
	volume_envelope 9, 0
	note C_, 2
	volume_envelope 9, 4
	note C_, 4
	volume_envelope 9, 0
	note F_, 2
	volume_envelope 9, 4
	note F_, 4
	;;;;;;;;;;;;
	note E_, 4
	note __, 2
	note E_, 4
	note __, 10
	note D_, 4
	note __, 2
	note D_, 4
	note __, 2
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	volume_envelope 9, 0
	note C_, 6
	volume_envelope 9, 7
	note C_, 6
	volume_envelope 9, 4
	note D_, 4
	note __, 2
	note D_, 4
	note __, 10
	octave 2
	volume_envelope 9, 0
	note A_, 2
	volume_envelope 9, 4
	note A_, 4
	volume_envelope 9, 0
	note G#, 2
	volume_envelope 9, 4
	note G#, 4
;;;;;;;;;;;;;;;;mark
	volume_envelope 9, 0
	note G_, 16
	volume_envelope 9, 7
	note G_, 16
	volume_envelope 9, 0
	note F#, 8
	volume_envelope 9, 7
	note F#, 8
	volume_envelope 9, 0
	note A_, 8
	volume_envelope 9, 7
	note A_, 8
	volume_envelope 9, 0
	note G_, 8
	volume_envelope 9, 7
	note G_, 8
	octave 3
	volume_envelope 9, 0
	note C_, 8
	volume_envelope 9, 7
	note C_, 8
	volume_envelope 9, 0
	octave 2
	note A_, 16
	volume_envelope 9, 7
	note A_, 8
	volume_envelope 10, 4
	note A_, 2
	note B_, 4
	note B_, 2
;;;;;;;;;;;;;;;mark
	octave 3
	note D_, 4
	note __, 2
	note D_, 4
	note __, 10
	note D_, 4
	note __, 2
	volume_envelope 10, 0
	note D_, 2
	volume_envelope 10, 4
	note D_, 4
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	note C_, 4
	note __, 2
	volume_envelope 10, 0
	note C_, 2
	volume_envelope 10, 4
	note C_, 4
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	note F_, 4
	note __, 2
	volume_envelope 10, 0
	note F_, 2
	volume_envelope 10, 4
	note F_, 4
	volume_envelope 11, 4
	octave 2
	note E_, 2
	note __, 2
	octave 3
	note E_, 2
	octave 2
	note E_, 2
	note __, 2
	volume_envelope 11, 5
	note E_, 6
	volume_envelope 11, 4
	note D#, 2
	note __, 2
	octave 3
	note D#, 2
	octave 2
	note D#, 2
	note __, 2
	volume_envelope 11, 5
	note D#, 6
	octave 3
	volume_envelope 10, 4
	note F_, 4
	note __, 2
	note F_, 4
	note __, 10
	volume_envelope 10, 0
	note C_, 6
	volume_envelope 10, 7
	note C_, 6
	volume_envelope 10, 4
	note G_, 4
	note __, 2
	note G_, 4
	note __, 10
	volume_envelope 10, 0
	note D_, 6
	volume_envelope 10, 7
	note D_, 6
	octave 4
	volume_envelope 10, 4
	note C_, 4
	note __, 2
	note C_, 4
	note __, 10
	octave 3
	volume_envelope 10, 7
	note A_, 6
	octave 4
	note C_, 6
	volume_envelope 10, 4
	note C_, 2
	note C_, 2
	note __, 8
	note C_, 2
	note C_, 2
	note __, 4
	note D_, 2
	note D_, 2
	note __, 8
	volume_envelope 10, 7
	note C_, 16
	note_type 12, 6, 2
	note __, 1
	duty_cycle 3
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 2
	note E_, 2
	note D_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A_, 2
	jumpchannel Music_ReversalMountainWhite2_Ch2_loop

Music_ReversalMountainWhite2_Ch3:
	stereopanning $f0
	note_type 12, 1, 4
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 4
Music_ReversalMountainWhite2_Ch3_loop:
	note __, 8
	octave 4
	note_type 3, 1, 4
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note D_, 12
	note E_, 8
	note __, 3
	note G_, 1
	note A_, 4
	note G_, 8
	note F_, 4
	note E_, 4
	note F_, 4
	note G_, 8
	note D_, 4
	note E_, 4
	note __, 3
	octave 4
	note G#, 1
	note A_, 4
	note_type 12, 1, 4
	octave 5
	note C_, 4
	volume_envelope 2, 4
	note C_, 3
	note_type 3, 3, 4
	note C_, 3
	volume_envelope 1, 5
	note C#, 1
	note D_, 4
	note C_, 4
	volume_envelope 2, 5
	note C_, 4
	volume_envelope 1, 5
	octave 4
	note E_, 4
	note G_, 12
	note D_, 4
	note E_, 4
	note A_, 4
	note F#, 1
	note G_, 3
	note F#, 4
	note E_, 4
	note D_, 4
	volume_envelope 2, 5
	note D_, 4
	volume_envelope 1, 5
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	note E_, 4
	note F#, 4
	note G_, 4
	note A_, 4
	note_type 12, 1, 5
	octave 5
	note D_, 4
	volume_envelope 2, 5
	note D_, 3
	note_type 3, 3, 5
	note D_, 3
	volume_envelope 1, 4
	note D#, 1
	note E_, 4
	note D_, 8
	note C_, 4
	octave 4
	note B_, 4
	note A_, 4
	volume_envelope 2, 4
	note A_, 4
	volume_envelope 1, 4
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C#, 1
	note D_, 11
	note E_, 4
	volume_envelope 2, 4
	note E_, 4
	volume_envelope 3, 4
	note E_, 4
	volume_envelope 1, 4
	note A_, 4
	note G_, 7
	note E_, 1
	note F_, 4
	note E_, 4
	note F_, 3
	note F#, 1
	note G_, 8
	note D_, 4
	note E_, 4
	note __, 4
	octave 4
	note G_, 4
	note_type 12, 1, 4
	octave 5
	note C_, 3
	volume_envelope 2, 4
	note C_, 2
	note_type 3, 3, 4
	note C_, 3
	volume_envelope 1, 5
	octave 4
	note D#, 1
	note E_, 4
	note B_, 4
	note A_, 4
	volume_envelope 2, 5
	note A_, 4
	volume_envelope 1, 5
	note C_, 4
	note E_, 8
	volume_envelope 2, 5
	note E_, 4
	volume_envelope 3, 5
	note E_, 3
	octave 3
	volume_envelope 1, 5
	note D#, 1
	note E_, 4
	octave 4
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 4
	note D_, 4
	note E_, 4
	octave 3
	note A_, 8
	octave 4
	note C_, 4
	note D_, 4
	note D#, 4
	note E_, 4
	note A_, 4
	note_type 12, 1, 5
	note A_, 4
	volume_envelope 2, 5
	note A_, 5
	volume_envelope 3, 5
	note A_, 2
	note_type 3, 1, 5
	note __, 7
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	note E_, 4
	note A_, 4
	note B_, 4
	octave 5
	note C_, 4
	note D_, 4
	note D#, 8
	volume_envelope 3, 5
	note D#, 3
	volume_envelope 1, 5
	note C#, 1
	note D_, 4
	note C_, 4
	note D_, 4
	octave 4
	note E_, 4
	note G_, 4
	note A_, 8
	note G#, 4
	note G_, 4
	note F#, 4
	note F_, 4
	note E_, 4
	volume_envelope 2, 5
	note E_, 4
	octave 3
	volume_envelope 1, 5
	note G#, 3
	octave 4
	note C#, 1
	note D_, 4
	note C_, 16
	volume_envelope 2, 5
	note C_, 8
	volume_envelope 3, 5
	note C_, 8
	volume_envelope 1, 5
	octave 2
	note G#, 4
	note A_, 3
	octave 3
	note D#, 1
	note E_, 8
	note G_, 4
	note G#, 4
	volume_envelope 1, 5
	note A_, 16
	volume_envelope 2, 5
	note A_, 7
	volume_envelope 1, 5
	octave 4
	note C#, 1
	note D_, 4
	note C_, 16
	volume_envelope 2, 5
	note C_, 16
	volume_envelope 3, 5
	note C_, 8
	note __, 11
	volume_envelope 2, 7
	octave 3
	note G#, 1
	note A_, 4
	octave 4
	note D_, 4
	note C_, 4
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	note E_, 4
	note G_, 4
	note G#, 4
	note A_, 4
	volume_envelope 3, 7
	note A_, 3
	volume_envelope 2, 7
	note G#, 1
	note A_, 4
	volume_envelope 3, 7
	note A_, 4
	volume_envelope 2, 7
	note G#, 3
	note __, 1
	note G#, 4
	volume_envelope 3, 7
	note G#, 4
	volume_envelope 2, 7
	note G_, 3
	note __, 1
	note G_, 4
	volume_envelope 3, 7
	note G_, 3
	volume_envelope 2, 7
	note F#, 1
	note G_, 4
	note G#, 4
	note A_, 4
	note C_, 4
	note C#, 4
	note D_, 4
	octave 3
	note A_, 4
	volume_envelope 3, 7
	note A_, 4
	volume_envelope 2, 7
	octave 4
	note C_, 3
	note D#, 1
	note E_, 4
	note D#, 4
	note D_, 4
	note C_, 4
	note C#, 4
	note D_, 4
	note E_, 4
	note G_, 4
	note A_, 4
	octave 5
	note C_, 4
	volume_envelope 3, 7
	note C_, 4
	volume_envelope 2, 7
	note E_, 3
	note G#, 1
	note A_, 4
	note G_, 8
	note A_, 4
	octave 6
	note C_, 4
	octave 5
	note G_, 4
	note A_, 4
	note C_, 3
	note D#, 1
	note E_, 4
	note D#, 8
	volume_envelope 3, 7
	note D#, 4
	volume_envelope 2, 7
	note D_, 4
	note G_, 4
	note A_, 4
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 8
	volume_envelope 3, 7
	note C_, 4
	volume_envelope 1, 5
	octave 4
	note G_, 3
	note G#, 1
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	note E_, 8
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 3
	octave 4
	note D#, 1
	note E_, 4
	note A_, 4
	note G_, 8
	volume_envelope 2, 5
	note G_, 4
	volume_envelope 3, 5
	note G_, 4
	volume_envelope 1, 5
	note G_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	note E_, 8
	note D#, 4
	note D_, 4
	note C#, 4
	note C_, 4
	volume_envelope 1, 4
	note C_, 4
	note F_, 4
	note E_, 8
	volume_envelope 2, 4
	note E_, 4
	volume_envelope 3, 4
	note E_, 4
	volume_envelope 1, 4
	note E_, 4
	note F_, 4
	octave 4
	note G_, 4
	volume_envelope 2, 4
	note G_, 4
	volume_envelope 1, 4
	note A_, 4
	octave 5
	note C_, 16
	note D_, 14
	note __, 2
	note D_, 3
	note __, 1
	note D_, 4
	volume_envelope 3, 4
	note D_, 4
	note __, 12
	volume_envelope 1, 4
	note D_, 3
	note __, 1
	note D_, 4
	volume_envelope 3, 4
	note D_, 4
	volume_envelope 1, 4
	octave 4
	note G_, 4
	note G#, 4
	note A_, 4
	octave 5
	note C_, 4
	note E_, 4
	note G_, 4
	octave 6
	note C_, 4
	octave 5
	note G_, 2
	note A_, 2
	note B_, 12
	volume_envelope 2, 4
	note B_, 8
	volume_envelope 1, 4
	note G_, 16
	volume_envelope 2, 4
	note G_, 16
	volume_envelope 3, 4
	note G_, 16
	note_type 12, 2, 5
	note __, 11
	octave 2
	note E_, 1
	note __, 1
	note E_, 1
	note A_, 1
	volume_envelope 3, 5
	note A_, 1
	note __, 1
	volume_envelope 2, 5
	note A_, 1
	volume_envelope 3, 5
	note A_, 1
	volume_envelope 2, 5
	note __, 16
	note __, 8
	note E_, 1
	note __, 1
	note E_, 1
	note A_, 1
	volume_envelope 3, 5
	note A_, 1
	note __, 1
	volume_envelope 2, 5
	note A_, 1
	volume_envelope 3, 5
	note A_, 1
	jumpchannel Music_ReversalMountainWhite2_Ch3_loop

Music_ReversalMountainWhite2_Ch4:
	stereopanning $f
	togglenoise $3
	note_type 12
	note __, 16
	note __, 16
	note __, 16
	note __, 15
Music_ReversalMountainWhite2_Ch4_loop:
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_2
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	callchannel Music_ReversalMountainWhite2_Ch4_branch_1
	note D#, 3
	note D#, 2
	note __, 11
	note __, 16
	note __, 16
	note __, 16
	jumpchannel Music_ReversalMountainWhite2_Ch4_loop

Music_ReversalMountainWhite2_Ch4_branch_1:
	note D#, 2
	note D#, 1
	note D#, 2
	note C_, 3
	endchannel

Music_ReversalMountainWhite2_Ch4_branch_2:
	note D#, 3
	note D#, 2
	note C_, 3
	endchannel

Music_ReversalMountainWhite2_Ch4_branch_3:
	note D#, 4
	note C_, 4
	endchannel
