Music_ViridianForest:
	channel_count 4
	channel 1, Music_ViridianForest_Ch1
	channel 2, Music_ViridianForest_Ch2
	channel 3, Music_ViridianForest_Ch3
	channel 4, Music_ViridianForest_Ch4

Music_ViridianForest_Ch1:
	tempo 151
	volume 7, 7
	stereopanning $f
	vibrato $6, $23
	note_type 12, 11, 1
	note __, 16
	note __, 16
	callchannel Music_ViridianForest_branch_ed931
Music_ViridianForest_branch_ed8fb:
	volume_envelope 11, 1
	octave 3
	note B_, 4
	note B_, 4
	note B_, 4
	note B_, 4
	octave 4
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	callchannel Music_ViridianForest_branch_ed931
	callchannel Music_ViridianForest_branch_ed940
	callchannel Music_ViridianForest_branch_ed940
	callchannel Music_ViridianForest_branch_ed971
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	octave 3
	note G_, 2
	octave 4
	note C_, 2
	note F_, 2
	note D_, 2
	octave 3
	note B_, 2
	note G_, 2
	callchannel Music_ViridianForest_branch_ed971
	note G_, 2
	octave 4
	note C_, 2
	note D_, 2
	note G_, 2
	note F_, 2
	note D_, 2
	octave 3
	note B_, 2
	note G_, 2
	jumpchannel Music_ViridianForest_branch_ed8fb

Music_ViridianForest_branch_ed931:
	octave 4
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	note C_, 4
	volume_envelope 11, 7
	note C_, 4
	octave 3
	note B_, 4
	volume_envelope 11, 1
	endchannel

Music_ViridianForest_branch_ed940:
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	octave 2
	note B_, 2
	octave 3
	note E_, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note A#, 2
	note E_, 2
	note A#, 2
	note C_, 2
	note A_, 2
	note C_, 2
	note A_, 2
	note C_, 2
	note A_, 2
	note C_, 2
	note A_, 2
	note C_, 2
	note G#, 2
	note C_, 2
	note G#, 2
	volume_envelope 11, 7
	octave 2
	note B_, 2
	octave 3
	note G#, 2
	octave 2
	note B_, 2
	octave 3
	note G_, 2
	volume_envelope 11, 1
	endchannel

Music_ViridianForest_branch_ed971:
	note B_, 2
	note G_, 2
	note B_, 2
	note G_, 2
	note B_, 2
	note G#, 2
	note B_, 2
	note G#, 2
	octave 4
	note E_, 2
	note C_, 2
	note E_, 2
	note C_, 2
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note D_, 2
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	endchannel

Music_ViridianForest_Ch2:
	stereopanning $ff
	vibrato $8, $24
	note_type 12, 11, 2
	callchannel Music_ViridianForest_branch_ed9ba
Music_ViridianForest_branch_ed9a1:
	volume_envelope 11, 2
	callchannel Music_ViridianForest_branch_ed9ba
	duty_cycle 2
	volume_envelope 11, 5
	callchannel Music_ViridianForest_branch_ed9dc
	callchannel Music_ViridianForest_branch_ed9dc
	callchannel Music_ViridianForest_branch_eda02
	callchannel Music_ViridianForest_branch_eda02
	jumpchannel Music_ViridianForest_branch_ed9a1

Music_ViridianForest_branch_ed9ba:
	octave 4
	note E_, 4
	note E_, 4
	note E_, 2
	octave 2
	note C_, 2
	octave 4
	note E_, 2
	octave 2
	note C_, 2
	octave 4
	note A#, 4
	note A#, 4
	note A#, 2
	octave 2
	note G_, 2
	octave 4
	note A#, 2
	octave 2
	note G_, 2
	octave 4
	note A_, 4
	note A_, 4
	note A_, 4
	note A_, 4
	note G#, 4
	note G#, 4
	volume_envelope 11, 7
	note G#, 4
	note G_, 4
	volume_envelope 11, 2
	endchannel

Music_ViridianForest_branch_ed9dc:
	octave 2
	note C_, 4
	note __, 2
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 2
	note __, 2
	note C_, 1
	note __, 1
	note G_, 4
	note __, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	note D_, 4
	endchannel

Music_ViridianForest_branch_eda02:
	octave 2
	note E_, 4
	note __, 2
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 2
	note __, 2
	note E_, 1
	note __, 1
	note A_, 4
	note __, 2
	note A_, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 2
	note __, 2
	note G#, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F#, 1
	note __, 1
	note F#, 2
	note __, 2
	note F#, 1
	note __, 1
	note G_, 4
	note __, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	endchannel

Music_ViridianForest_Ch3:
	stereopanning $f0
	vibrato $16, $15
	note_type 12, 1, 4
	octave 4
	note B_, 1
	note __, 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 3
	note B_, 1
	note __, 3
	octave 5
	note E_, 1
	note __, 3
	note E_, 1
	note __, 3
	note E_, 1
	note __, 3
	note E_, 1
	note __, 3
	callchannel Music_ViridianForest_branch_eda9e
	octave 3
	note D_, 4
Music_ViridianForest_branch_eda4b:
	note_type 12, 1, 5
	octave 3
	note C_, 4
	note __, 2
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 2
	note __, 2
	note C_, 1
	note __, 1
	note G_, 4
	note __, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 2
	note __, 2
	note G_, 1
	note __, 1
	callchannel Music_ViridianForest_branch_eda9e
	octave 3
	note D_, 2
	volume_envelope 1, 0
	octave 6
	note C_, 1
	note D_, 1
	callchannel Music_ViridianForest_branch_edaaf
	note __, 4
	note G_, 8
	note F_, 2
	note G_, 2
	note_type 12, 1, 0
	callchannel Music_ViridianForest_branch_edaaf
	note __, 16
	volume_envelope 2, 5
	callchannel Music_ViridianForest_branch_edacb
	note __, 4
	note D#, 1
	note E_, 7
	note D_, 4
	octave 5
	note B_, 1
	octave 6
	note C_, 3
	octave 5
	note B_, 4
	note A_, 4
	note B_, 8
	note G_, 4
	octave 6
	note A_, 4
	note G_, 4
	callchannel Music_ViridianForest_branch_edacb
	note __, 4
	note G#, 1
	note A_, 7
	note B_, 4
	note F#, 1
	note G_, 16
	note G_, 15
	jumpchannel Music_ViridianForest_branch_eda4b

Music_ViridianForest_branch_eda9e:
	octave 3
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 2
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	endchannel

Music_ViridianForest_branch_edaaf:
	octave 6
	note E_, 10
	note D_, 2
	note __, 2
	note C_, 2
	note_type 6, 1, 0
	octave 5
	note F#, 1
	note G_, 15
	note A_, 4
	note A#, 4
	note __, 4
	octave 6
	note C_, 2
	note D_, 2
	note D#, 1
	note E_, 16
	note E_, 7
	note F_, 4
	note E_, 4
	note D#, 1
	note E_, 3
	note D_, 4
	note C_, 4
	note D_, 4
	endchannel

Music_ViridianForest_branch_edacb:
	octave 5
	note B_, 16
	note __, 4
	octave 6
	note C#, 1
	note D_, 7
	note E_, 4
	octave 5
	note B_, 1
	octave 6
	note C_, 16
	note C_, 3
	note D_, 4
	note __, 4
	note E_, 4
	note F_, 16
	endchannel

Music_ViridianForest_Ch4:
	togglenoise $5
	note_type 12
Music_ViridianForest_branch_edae0:
	note A_, 4
	note A_, 4
	note A_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	loopchannel 3, Music_ViridianForest_branch_edae0
	note A_, 4
	note A_, 4
	note A_, 2
	note A_, 2
	note D#, 4
Music_ViridianForest_branch_edaef:
	note A_, 4
	note A_, 4
	note A_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	loopchannel 4, Music_ViridianForest_branch_edaef
Music_ViridianForest_branch_edaf9:
	note B_, 4
	note A_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	note A_, 2
	note B_, 2
	loopchannel 7, Music_ViridianForest_branch_edaf9
	note B_, 4
	note A_, 4
	note A_, 2
	note A_, 2
	note D#, 4
Music_ViridianForest_branch_edb09:
	note B_, 4
	note C_, 4
	note B_, 2
	note B_, 2
	note C_, 4
	loopchannel 3, Music_ViridianForest_branch_edb09
	note B_, 4
	note C_, 4
	note C#, 2
	note C_, 2
	note C#, 4
Music_ViridianForest_branch_edb17:
	note B_, 4
	note C_, 4
	note B_, 2
	note B_, 2
	note C_, 4
	loopchannel 3, Music_ViridianForest_branch_edb17
	note B_, 4
	note C_, 4
	note D_, 2
	note D_, 2
	note D#, 4
	jumpchannel Music_ViridianForest_branch_edaef
