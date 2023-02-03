Music_MtMoon:
	channel_count 4
	channel 1, Music_MtMoon_Ch1
	channel 2, Music_MtMoon_Ch2
	channel 3, Music_MtMoon_Ch3
	channel 4, Music_MtMoon_Ch4

Music_MtMoon_Ch1:
	tempo 208
	volume 7, 7
	dutycycle $2
	tone $0001
	vibrato $8, $14
	stereopanning $f0
	note_type 12, 4, 5
	note __, 2
	jumpchannel Music_MtMoon_branch_edb56

Music_MtMoon_Ch2:
	vibrato $b, $15
	dutycycle $2
	note_type 12, 8, 4
	stereopanning $f
Music_MtMoon_branch_edb56:
	octave 4
	note D#, 6
	note C#, 6
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	note G_, 2
	note D#, 2
	note C#, 6
	octave 3
	note B_, 2
	octave 4
	note C#, 2
	note D#, 2
	note G_, 2
	note D#, 2
	note C#, 6
	octave 3
	note B_, 2
	note A#, 2
	note B_, 6
	octave 4
	note C#, 10
	note G#, 6
	note F#, 6
	note E_, 2
	note F#, 2
	note G#, 2
	octave 5
	note C_, 2
	octave 4
	note G#, 2
	note F#, 6
	note E_, 2
	note F#, 2
	note G#, 2
	octave 5
	note C_, 2
	octave 4
	note G#, 2
	note F#, 6
	note E_, 2
	note D#, 2
	note E_, 6
	note F#, 6
	note E_, 4
	jumpchannel Music_MtMoon_branch_edb56

Music_MtMoon_Ch3:
Music_MtMoon_branch_edb8a:
	note_type 12, 2, 8
Music_MtMoon_branch_edb8d:
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	loopchannel 3, Music_MtMoon_branch_edb8d
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G_, 2
	octave 2
	note B_, 2
	octave 3
	note D#, 2
	note G_, 2
	note D#, 2
	note E_, 2
Music_MtMoon_branch_edbab:
	note E_, 2
	note G#, 2
	octave 4
	note C_, 2
	octave 3
	note E_, 2
	note G#, 2
	octave 4
	note C_, 2
	octave 3
	note E_, 2
	note G#, 2
	loopchannel 4, Music_MtMoon_branch_edbab
	jumpchannel Music_MtMoon_branch_edb8a

Music_MtMoon_Ch4:
	togglenoise $5
	note_type 12
Music_MtMoon_branch_edbc3:
	stereopanning $f
	note A#, 4
	note A#, 8
	note A#, 4
	stereopanning $f0
	note A#, 4
	note A#, 4
	note A#, 4
	stereopanning $f
	note A#, 4
	note A#, 4
	stereopanning $f0
	note A#, 8
	jumpchannel Music_MtMoon_branch_edbc3
