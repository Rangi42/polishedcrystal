; Pokémon R/B/Y - Bicycle
; Ported by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/RBY/bikeriding.asm

Music_BicycleRB::
	dbw $C0, Music_BikeRiding_Ch1
	dbw $01, Music_BikeRiding_Ch2
	dbw $02, Music_BikeRiding_Ch3
	dbw $03, Music_BikeRiding_Ch4

Music_BikeRiding_Ch1:
	tempo 144
	volume 7, 7
	duty_cycle 3
	vibrato $8, $14
	note_type 12, 11, 5
	octave 3
	note G_, 2
Music_BikeRiding_branch_7dbc9:
	octave 4
	note C_, 4
	note D_, 4
	note E_, 2
	note C_, 2
	note E_, 2
	note G_, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 4
	note E_, 2
	note D_, 2
	note F_, 4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	note F_, 4
	note D_, 4
	note E_, 2
	note F_, 2
	note G_, 2
	note C_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	note E_, 2
	volume_envelope 11, 6
	note F_, 10
	volume_envelope 10, 6
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 10
	note E_, 2
	note D_, 2
	note E_, 2
	note F_, 6
	volume_envelope 11, 3
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F_, 2
	note E_, 1
	note F_, 1
	volume_envelope 11, 5
	note G_, 6
	note G_, 6
	note A_, 2
	note F_, 2
	note G_, 6
	volume_envelope 11, 4
	note G_, 2
	note F_, 4
	volume_envelope 10, 4
	note E_, 2
	note D_, 2
	volume_envelope 9, 3
	octave 3
	note A_, 2
	octave 4
	note C_, 4
	note C_, 2
	octave 3
	note B_, 2
	note A_, 1
	note B_, 1
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	note C_, 4
	note C_, 2
	octave 3
	note A_, 2
	note B_, 2
	note B_, 2
	note A_, 2
	octave 4
	note C_, 4
	octave 3
	note A_, 2
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note B_, 2
	octave 4
	note D_, 4
	octave 3
	note B_, 2
	octave 4
	note C_, 4
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	volume_envelope 3, -5
	note C_, 4
	volume_envelope 11, 4
	note F_, 6
	note G_, 4
	note F_, 1
	note G_, 1
	note F_, 4
	note E_, 6
	note F_, 2
	note E_, 2
	note D_, 1
	note E_, 1
	note D_, 2
	note C_, 2
	volume_envelope 11, 5
	octave 3
	note A_, 4
	octave 4
	note D_, 4
	octave 3
	note B_, 4
	octave 4
	note E_, 4
	note C_, 4
	note F_, 4
	note D_, 4
	note F#, 4
	vibrato $a, $26
	volume_envelope 8, 0
	note G_, 16
	note G_, 4
	volume_envelope 8, 7
	note G_, 12
	volume_envelope 11, 5
	vibrato $8, $14
	jumpchannel Music_BikeRiding_branch_7dbc9
Music_BikeRiding_Ch2:
	duty_cycle 2
	vibrato $6, $15
	note_type 12, 12, 3
	octave 4
	note C_, 2
Music_BikeRiding_branch_7dc75:
	note E_, 4
	note F_, 4
	note G_, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 6
	note A_, 1
	note B_, 1
	note A_, 10
	note F_, 2
	note G_, 2
	note A_, 2
	octave 5
	note D_, 2
	note C_, 2
	octave 4
	note B_, 2
	note A_, 1
	note B_, 1
	octave 5
	note C_, 6
	octave 4
	note A_, 2
	note G_, 4
	duty_cycle 3
	note_type 12, 8, 4
	note A#, 6
	duty_cycle 2
	note_type 12, 12, 5
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note A_, 10
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	octave 4
	note G_, 10
	note_type 12, 12, 3
	octave 5
	note C_, 4
	note E_, 2
	note D_, 2
	note C_, 2
	octave 4
	note B_, 2
	octave 5
	note C_, 2
	note_type 12, 11, 0
	note D_, 4
	note_type 12, 12, 7
	note D_, 10
	note D_, 1
	note C_, 1
	note_type 12, 11, 0
	octave 4
	note B_, 4
	note_type 12, 12, 7
	note B_, 12
	note_type 12, 12, 4
	note F_, 6
	note F_, 2
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note E_, 6
	note E_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note F_, 2
	note G_, 4
	note A_, 2
	note F_, 2
	note E_, 2
	note G_, 4
	note F_, 2
	note E_, 6
	note_type 6, 12, 2
	note F_, 1
	note G_, 1
	note A_, 1
	note B_, 1
	note_type 12, 12, 3
	octave 5
	note C_, 2
	octave 4
	note B_, 2
	note A_, 2
	octave 5
	note C_, 2
	octave 4
	note B_, 4
	note A_, 4
	note G_, 2
	note A#, 4
	note A_, 2
	note G_, 4
	note F_, 2
	note E_, 2
	note_type 8, 12, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note B_, 4
	note A_, 4
	note G_, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 4
	note A_, 4
	octave 5
	note D_, 4
	note E_, 4
	note C_, 4
	note_type 12, 12, 7
	note D_, 12
	note C_, 4
	note_type 12, 11, 0
	octave 4
	note B_, 4
	note_type 12, 12, 7
	note B_, 12
	note_type 12, 12, 3
	jumpchannel Music_BikeRiding_branch_7dc75
Music_BikeRiding_Ch3:
	note_type 12, 1, 3
	note __, 2
Music_BikeRiding_branch_7dd17:
	octave 4
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 3
	note G_, 1
	note __, 1
	octave 4
	note E_, 1
	note __, 1
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note C_, 1
	note __, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note E_, 1
	note __, 1
	note A_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 1
	octave 4
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note C_, 1
	note __, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 1
	octave 4
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 1
	note __, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 1
	octave 4
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 3
	note A_, 1
	note __, 1
	octave 4
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note E_, 1
	note __, 1
	note C_, 1
	note __, 1
	note G_, 1
	note __, 1
	note C_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note C_, 1
	note __, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note E_, 1
	note __, 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	note E_, 1
	note __, 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	note A_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note B_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note A_, 1
	note __, 1
	note G_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 1
	octave 5
	note C_, 1
	note __, 1
	octave 4
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	note G_, 1
	note __, 1
	note B_, 1
	note __, 1
	note F_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 3
	note B_, 1
	note __, 1
	octave 4
	note F_, 1
	note __, 1
	jumpchannel Music_BikeRiding_branch_7dd17
Music_BikeRiding_Ch4:
	toggle_noise 1
	note_type 12
	note __, 2
Music_BikeRiding_branch_7de6a:
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7deb4
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dec2
	callchannel Music_BikeRiding_branch_7deb4
	callchannel Music_BikeRiding_branch_7deb4
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7deb4
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dec2
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7deb4
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	callchannel Music_BikeRiding_branch_7dea7
	jumpchannel Music_BikeRiding_branch_7de6a
Music_BikeRiding_branch_7dea7:
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	endchannel
Music_BikeRiding_branch_7deb4:
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note G#, 2
	note G#, 2
	endchannel
Music_BikeRiding_branch_7dec2:
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 2
	note __, 2
	note G#, 1
	note G#, 1
	endchannel
