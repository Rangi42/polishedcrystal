Music_ViridianForest:
	channel_count 4
	channel 1, Music_ViridianForest_Ch1
	channel 2, Music_ViridianForest_Ch2
	channel 3, Music_ViridianForest_Ch3
	channel 4, Music_ViridianForest_Ch4

Music_ViridianForest_Ch1:
	tempo 151
	volume 7, 7
	stereo_panning FALSE, TRUE
	vibrato 6, 2, 3
	note_type 12, 11, 1
	rest 16
	rest 16
	sound_call Music_ViridianForest_branch_ed931
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
	sound_call Music_ViridianForest_branch_ed931
	sound_call Music_ViridianForest_branch_ed940
	sound_call Music_ViridianForest_branch_ed940
	sound_call Music_ViridianForest_branch_ed971
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
	sound_call Music_ViridianForest_branch_ed971
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
	sound_jump Music_ViridianForest_branch_ed8fb

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
	sound_ret

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
	sound_ret

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
	sound_ret

Music_ViridianForest_Ch2:
	stereo_panning TRUE, TRUE
	vibrato 8, 2, 4
	note_type 12, 11, 2
	sound_call Music_ViridianForest_branch_ed9ba
Music_ViridianForest_branch_ed9a1:
	volume_envelope 11, 2
	sound_call Music_ViridianForest_branch_ed9ba
	duty_cycle 2
	volume_envelope 11, 5
	sound_call Music_ViridianForest_branch_ed9dc
	sound_call Music_ViridianForest_branch_ed9dc
	sound_call Music_ViridianForest_branch_eda02
	sound_call Music_ViridianForest_branch_eda02
	sound_jump Music_ViridianForest_branch_ed9a1

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
	sound_ret

Music_ViridianForest_branch_ed9dc:
	octave 2
	note C_, 4
	rest 2
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note C_, 2
	rest 2
	note C_, 1
	rest 1
	note G_, 4
	rest 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note G_, 2
	rest 2
	note G_, 1
	rest 1
	note F_, 4
	rest 2
	note F_, 1
	rest 1
	note F_, 1
	rest 1
	note F_, 2
	rest 2
	note F_, 1
	rest 1
	note F_, 4
	rest 2
	note F_, 1
	rest 1
	note F_, 4
	note D_, 4
	sound_ret

Music_ViridianForest_branch_eda02:
	octave 2
	note E_, 4
	rest 2
	note E_, 1
	rest 1
	note E_, 1
	rest 1
	note E_, 2
	rest 2
	note E_, 1
	rest 1
	note A_, 4
	rest 2
	note A_, 1
	rest 1
	note G#, 1
	rest 1
	note G#, 2
	rest 2
	note G#, 1
	rest 1
	note F_, 4
	rest 2
	note F_, 1
	rest 1
	note F#, 1
	rest 1
	note F#, 2
	rest 2
	note F#, 1
	rest 1
	note G_, 4
	rest 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note G_, 2
	rest 2
	note G_, 1
	rest 1
	sound_ret

Music_ViridianForest_Ch3:
	stereo_panning TRUE, FALSE
	vibrato 22, 1, 5
	note_type 12, 1, 4
	octave 4
	note B_, 1
	rest 3
	note B_, 1
	rest 3
	note B_, 1
	rest 3
	note B_, 1
	rest 3
	octave 5
	note E_, 1
	rest 3
	note E_, 1
	rest 3
	note E_, 1
	rest 3
	note E_, 1
	rest 3
	sound_call Music_ViridianForest_branch_eda9e
	octave 3
	note D_, 4
Music_ViridianForest_branch_eda4b:
	note_type 12, 1, 5
	octave 3
	note C_, 4
	rest 2
	note C_, 1
	rest 1
	note C_, 1
	rest 1
	note C_, 2
	rest 2
	note C_, 1
	rest 1
	note G_, 4
	rest 2
	note G_, 1
	rest 1
	note G_, 1
	rest 1
	note G_, 2
	rest 2
	note G_, 1
	rest 1
	sound_call Music_ViridianForest_branch_eda9e
	octave 3
	note D_, 2
	volume_envelope 1, 0
	octave 6
	note C_, 1
	note D_, 1
	sound_call Music_ViridianForest_branch_edaaf
	rest 4
	note G_, 8
	note F_, 2
	note G_, 2
	note_type 12, 1, 0
	sound_call Music_ViridianForest_branch_edaaf
	rest 16
	volume_envelope 2, 5
	sound_call Music_ViridianForest_branch_edacb
	rest 4
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
	sound_call Music_ViridianForest_branch_edacb
	rest 4
	note G#, 1
	note A_, 7
	note B_, 4
	note F#, 1
	note G_, 16
	note G_, 15
	sound_jump Music_ViridianForest_branch_eda4b

Music_ViridianForest_branch_eda9e:
	octave 3
	note F_, 4
	rest 2
	note F_, 1
	rest 1
	note F_, 1
	rest 1
	note F_, 2
	rest 2
	note F_, 1
	rest 1
	note F_, 4
	rest 2
	note F_, 1
	rest 1
	note F_, 4
	sound_ret

Music_ViridianForest_branch_edaaf:
	octave 6
	note E_, 10
	note D_, 2
	rest 2
	note C_, 2
	note_type 6, 1, 0
	octave 5
	note F#, 1
	note G_, 15
	note A_, 4
	note A#, 4
	rest 4
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
	sound_ret

Music_ViridianForest_branch_edacb:
	octave 5
	note B_, 16
	rest 4
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
	rest 4
	note E_, 4
	note F_, 16
	sound_ret

Music_ViridianForest_Ch4:
	toggle_noise 5
	drum_speed 12
Music_ViridianForest_branch_edae0:
	drum_note 10, 4
	drum_note 10, 4
	drum_note 10, 2
	drum_note 12, 2
	drum_note 10, 2
	drum_note 12, 2
	sound_loop 3, Music_ViridianForest_branch_edae0
	drum_note 10, 4
	drum_note 10, 4
	drum_note 10, 2
	drum_note 10, 2
	drum_note 4, 4
Music_ViridianForest_branch_edaef:
	drum_note 10, 4
	drum_note 10, 4
	drum_note 10, 2
	drum_note 10, 2
	drum_note 12, 2
	drum_note 10, 2
	sound_loop 4, Music_ViridianForest_branch_edaef
Music_ViridianForest_branch_edaf9:
	drum_note 12, 4
	drum_note 10, 2
	drum_note 12, 2
	drum_note 10, 2
	drum_note 12, 2
	drum_note 10, 2
	drum_note 12, 2
	sound_loop 7, Music_ViridianForest_branch_edaf9
	drum_note 12, 4
	drum_note 10, 4
	drum_note 10, 2
	drum_note 10, 2
	drum_note 4, 4
Music_ViridianForest_branch_edb09:
	drum_note 12, 4
	drum_note 1, 4
	drum_note 12, 2
	drum_note 12, 2
	drum_note 1, 4
	sound_loop 3, Music_ViridianForest_branch_edb09
	drum_note 12, 4
	drum_note 1, 4
	drum_note 2, 2
	drum_note 1, 2
	drum_note 2, 4
Music_ViridianForest_branch_edb17:
	drum_note 12, 4
	drum_note 1, 4
	drum_note 12, 2
	drum_note 12, 2
	drum_note 1, 4
	sound_loop 3, Music_ViridianForest_branch_edb17
	drum_note 12, 4
	drum_note 1, 4
	drum_note 3, 2
	drum_note 3, 2
	drum_note 4, 4
	sound_jump Music_ViridianForest_branch_edaef
