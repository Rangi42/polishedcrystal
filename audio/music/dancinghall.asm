Music_DancingHall:
	channel_count 3
	channel 1, Music_DancingHall_Ch1
	channel 2, Music_DancingHall_Ch2
	channel 3, Music_DancingHall_Ch3

Music_DancingHall_Ch1:
	tempo 208
	volume 7, 7
	stereopanning $f
	note_type 6, 11, 7
	note __, 3
	duty_cycle 0
Music_DancingHall_branch_ef9d3:
	note_type 12, 11, 7
	callchannel Music_DancingHall_branch_efa17
	note __, 16
	callchannel Music_DancingHall_branch_efa17
	note __, 16
	note __, 16
	note __, 16
	volume_envelope 11, 1
	octave 2
	note B_, 1
	octave 3
	note D_, 1
	note F_, 1
	note A_, 1
	note B_, 1
	note A_, 1
	note B_, 1
	octave 4
	note D_, 1
	note F_, 2
	note_type 8, 11, 1
	note D_, 1
	note E_, 1
	note D_, 1
	octave 3
	note B_, 3
	note A_, 3
	note_type 12, 11, 1
	note B_, 1
	note A_, 1
	note D_, 1
	note E_, 1
	octave 4
	note F_, 2
	note_type 8, 11, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	octave 3
	note B_, 1
	note_type 12, 11, 5
	note A_, 1
	note __, 1
	note B_, 1
	note B_, 1
	note A_, 1
	note __, 1
	note F_, 2
	jumpchannel Music_DancingHall_branch_ef9d3

Music_DancingHall_branch_efa17:
	octave 3
	note B_, 1
	note __, 1
	note A_, 1
	note __, 1
	note B_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note E_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note D_, 1
	note __, 1
	endchannel

Music_DancingHall_Ch2:
	stereopanning $f0
	note_type 6, 10, 1
	duty_cycle 0
	vibrato $10, $24
	note __, 3
Music_DancingHall_branch_efa37:
	note_type 6, 10, 2
	callchannel Music_DancingHall_branch_efa7a
	callchannel Music_DancingHall_branch_efa7a
	volume_envelope 10, 7
	octave 2
	note D_, 16
	note F_, 16
	note_type 12, 10, 7
	note E_, 16
	octave 3
	note F_, 1
	note A_, 1
	note B_, 1
	octave 4
	note D_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note A_, 1
	note B_, 2
	note_type 8, 10, 7
	note A_, 1
	note B_, 1
	note A_, 1
	note F_, 3
	note D_, 3
	note_type 12, 10, 7
	note E_, 1
	note D_, 1
	octave 3
	note A_, 1
	note B_, 1
	octave 4
	note A_, 2
	note_type 8, 10, 7
	note F_, 1
	note A_, 1
	note F_, 1
	note_type 12, 10, 7
	note E_, 1
	note __, 1
	note F_, 1
	note F_, 1
	note E_, 1
	note __, 1
	note D_, 2
	jumpchannel Music_DancingHall_branch_efa37

Music_DancingHall_branch_efa7a:
	volume_envelope 10, 1
	octave 4
	note E_, 4
	octave 2
	note E_, 4
	octave 4
	note E_, 4
	octave 2
	note E_, 4
	octave 4
	note B_, 4
	note A_, 4
	note F_, 4
	note A_, 4
	volume_envelope 3, 3
	note D_, 1
	note F_, 1
	volume_envelope 6, 3
	note D_, 1
	note F_, 1
	volume_envelope 9, 3
	note D_, 1
	note F_, 1
	volume_envelope 12, 3
	note D_, 1
	note F_, 1
	volume_envelope 14, 3
	note D_, 1
	note F_, 1
	volume_envelope 10, 3
	note D_, 1
	note F_, 1
	volume_envelope 8, 3
	note D_, 1
	note F_, 1
	volume_envelope 5, 3
	note D_, 1
	note F_, 1
	volume_envelope 7, 3
	octave 3
	note B_, 1
	octave 4
	note E_, 1
	volume_envelope 10, 3
	octave 3
	note B_, 1
	octave 4
	note E_, 1
	volume_envelope 11, 3
	octave 3
	note A_, 1
	octave 4
	note D_, 1
	volume_envelope 12, 3
	octave 3
	note A_, 1
	octave 4
	note D_, 1
	volume_envelope 13, 3
	octave 3
	note E_, 1
	note B_, 1
	volume_envelope 14, 3
	note E_, 1
	note B_, 1
	volume_envelope 15, 3
	note A_, 1
	octave 4
	note D_, 1
	volume_envelope 15, 3
	octave 3
	note A_, 1
	octave 4
	note D_, 1
	endchannel

Music_DancingHall_Ch3:
	stereopanning $ff
	vibrato $16, $24
	note_type 6, 1, 0
	octave 5
	note A_, 1
	note B_, 1
	octave 6
	note D_, 1
Music_DancingHall_branch_efae3:
	note E_, 13
	note D_, 1
	note E_, 1
	note A_, 1
	note B_, 16
	volume_envelope 1, 4
	octave 3
	note F_, 16
	note E_, 14
	volume_envelope 1, 0
	octave 6
	note E_, 1
	note F_, 1
	note E_, 13
	note D_, 1
	note E_, 1
	note A_, 1
	note B_, 16
	volume_envelope 1, 4
	octave 3
	note F_, 16
	note E_, 16
	volume_envelope 1, 3
	octave 4
	note F_, 2
	note A_, 2
	note B_, 2
	octave 5
	note D_, 2
	note E_, 2
	note D_, 2
	note E_, 2
	note A_, 2
	note A#, 1
	note B_, 3
	note_type 8, 1, 3
	note A_, 1
	note B_, 1
	note A_, 1
	note F_, 3
	note D_, 3
	note_type 12, 1, 3
	note E_, 1
	note D_, 1
	octave 4
	note A_, 1
	note B_, 1
	octave 5
	note A_, 2
	note_type 8, 1, 3
	note F_, 1
	note A_, 1
	note F_, 1
	note_type 6, 1, 3
	note D#, 1
	note E_, 3
	note D_, 4
	octave 4
	note B_, 4
	octave 5
	note D_, 4
	volume_envelope 1, 4
	octave 3
	note D_, 16
	note F_, 16
	note E_, 16
	note E_, 13
	volume_envelope 1, 0
	octave 5
	note A_, 1
	note B_, 1
	octave 6
	note D_, 1
	jumpchannel Music_DancingHall_branch_efae3
