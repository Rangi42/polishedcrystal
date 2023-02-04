; Pokémon B2/W2 - Road to Reversal Mountain
; Demixed by Mmmmmm
; https://pastebin.com/27rkdjmk
; https://hax.iimarckus.org/topic/6777/

Music_RoadToReversalMountainB2W2:
	channel_count 4
	channel 1, Music_RoadToReversalMountainB2W2_Ch1
	channel 2, Music_RoadToReversalMountainB2W2_Ch2
	channel 3, Music_RoadToReversalMountainB2W2_Ch3
	channel 4, Music_RoadToReversalMountainB2W2_Ch4

Music_RoadToReversalMountainB2W2_Ch1:
	tempo 140
	volume 7, 7
	duty_cycle 3
	pitch_offset 2
	vibrato 16, 2, 2
	note_type 12, 6, 0
	sound_call Music_RoadToReversalMountainB2W2_Ch1_branch_1
	sound_call Music_RoadToReversalMountainB2W2_Ch1_branch_1
	octave 3
	note A_, 15
	volume_envelope 6, 7
	note A_, 3
	volume_envelope 6, 0
	note A_, 12
	note A#, 6
	sound_call Music_RoadToReversalMountainB2W2_Ch1_branch_1
	sound_call Music_RoadToReversalMountainB2W2_Ch1_branch_1
	note D_, 15
	volume_envelope 6, 7
	note D_, 3
	rest 16
	rest 16
	rest 16
	rest 6
	sound_jump Music_RoadToReversalMountainB2W2_Ch1

Music_RoadToReversalMountainB2W2_Ch1_branch_1:
	octave 2
	note A_, 12
	note A#, 6
	note A_, 12
	note G_, 6
	sound_ret

Music_RoadToReversalMountainB2W2_Ch2:
	duty_cycle 0
	pitch_offset 1
	vibrato 28, 1, 2
	note_type 6, 10, 4
	rest 4
	octave 3
	note D_, 2
	note C#, 2
	note D_, 4
	note C#, 1
	note D_, 1
	note C#, 2
	octave 2
	note A_, 8
	note G#, 4
	note A_, 4
	note A#, 8
	octave 3
	note C#, 2
	note C_, 2
	note C#, 4
	note C#, 1
	note C_, 1
	note C#, 2
	octave 2
	note A_, 8
	note A#, 4
	octave 3
	note C_, 4
	note C#, 8
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 4
	note D#, 1
	note D_, 1
	note C#, 10
	octave 2
	note A#, 4
	note A_, 8
	octave 3
	note D#, 2
	note D_, 2
	note D#, 4
	note D_, 4
	note C_, 12
	note C#, 4
	note D#, 4
	note D_, 1
	note D#, 1
	note_type 12, 10, 0
	note D_, 6
	volume_envelope 10, 7
	note D_, 11
	duty_cycle 3
	volume_envelope 7, 0
	note C_, 12
	volume_envelope 7, 7
	note C_, 6
	duty_cycle 0
	octave 2
	note_type 6, 10, 4
	note G#, 4
	note A#, 4
	octave 3
	note C_, 4
	note C_, 1
	note C#, 7
	note C_, 1
	note C#, 1
	note C_, 2
	octave 2
	note A#, 4
	note A_, 4
	note A#, 4
	octave 3
	note C_, 4
	note C#, 4
	note C#, 1
	note D_, 3
	note D#, 8
	note D_, 4
	note C#, 4
	note C_, 4
	note C#, 4
	note D_, 4
	note D#, 4
	note D_, 4
	note_type 8, 10, 4
	note C#, 1
	note D_, 1
	note C#, 1
	note_type 12, 10, 6
	octave 2
	note A_, 10
	volume_envelope 10, 4
	octave 3
	note C_, 2
	note C#, 2
	note C_, 2
	note_type 8, 10, 4
	octave 2
	note B_, 1
	octave 3
	note C_, 1
	octave 2
	note B_, 1
	note_type 12, 10, 7
	note G#, 10
	note A_, 16
	rest 16
	rest 4
	octave 3
	note_type 3, 10, 4
	note A_, 8
	note A_, 4
	note G_, 4
	note A_, 8
	octave 4
	note C_, 8
	note C#, 1
	note D_, 1
	note C#, 1
	note D_, 1
	note C#, 12
	note_type 6, 10, 4
	note D#, 12
	note D_, 4
	octave 3
	note A_, 2
	note G_, 2
	note A_, 4
	octave 4
	note C_, 4
	note C#, 8
	note C_, 1
	note C#, 1
	note C_, 10
	sound_jump Music_RoadToReversalMountainB2W2_Ch2

Music_RoadToReversalMountainB2W2_Ch3:
	note_type 12, 2, 5
	octave 2
	sound_call Music_RoadToReversalMountainB2W2_Ch3_branch_1
	note D_, 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	sound_call Music_RoadToReversalMountainB2W2_Ch3_branch_1
	note C_, 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	sound_jump Music_RoadToReversalMountainB2W2_Ch3

Music_RoadToReversalMountainB2W2_Ch3_branch_1:
	note D_, 2
	rest 2
	note A_, 2
	rest 2
	note A_, 2
	rest 2
	sound_ret

Music_RoadToReversalMountainB2W2_Ch4:
	stereo_panning FALSE, TRUE
	toggle_noise 3
	drum_speed 12
Music_RoadToReversalMountainB2W2_Ch4_loop:
	drum_note 1, 4
	drum_note 4, 2
	drum_note 4, 2
	drum_note 1, 2
	drum_note 4, 1
	drum_note 4, 1
	drum_note 1, 2
	drum_note 1, 2
	drum_note 4, 2
	sound_jump Music_RoadToReversalMountainB2W2_Ch4_loop
