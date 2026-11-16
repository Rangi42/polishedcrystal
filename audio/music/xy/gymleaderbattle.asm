; Pokémon X/Y - Battle! Gym Leader
; Demixed by Cosmic Angel
; https://soundcloud.com/cosmic-angel-685406146/kalos-leader

Music_GymLeaderBattleXY:
	channel_count 4
	channel 1, Music_GymLeaderBattleXY_Ch1
	channel 2, Music_GymLeaderBattleXY_Ch2
	channel 3, Music_GymLeaderBattleXY_Ch3
	channel 4, Music_GymLeaderBattleXY_Ch4

Music_GymLeaderBattleXY_Ch1:
	volume 7, 7
	tempo 124
	note_type 12, 15, 8
	sound_call .quadrest
	rest 16
	rest 16
	transpose 1, 0
	note_type 3, 8, 8
	sound_call .sub1
	sound_call .sub1
.loop15:
	volume_envelope 6, 1
	octave 2
	note F_, 4
	note C_, 4
	note D#, 4
	note F_, 4
	note F#, 4
	note G#, 4
	note F#, 4
	note D#, 4
	sound_loop 12, .loop15
	octave 2
	sound_call .sub1
	sound_call .sub1
.mainLoop:
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
.loop3:
	volume_envelope 8, 1
	octave 3
	note D#, 4
	octave 2
	note A#, 4
	sound_loop 16, .loop3
.loop9:
	note A#, 4
	note G_, 4
	sound_loop 16, .loop9
.loop4:
	volume_envelope 8, 1
	octave 3
	note F_, 4
	octave 2
	note A_, 4
	sound_loop 16, .loop4
.loop11:
	note A_, 4
	note C_, 4
	sound_loop 16, .loop11
	sound_call .sub2
	transpose 0, 2
	sound_call .sub2
	transpose 0, 0
	sound_call .sub2
	transpose 0, 2
	sound_call .sub2
.loop1:
	volume_envelope 8, 1
	transpose 0, 0
	octave 2
	note F_, 4
	note C_, 4
	note D#, 4
	note F_, 4
	note F#, 4
	note G#, 4
	note F#, 4
	note D#, 4
	sound_loop 32, .loop1
	sound_call .sub1
	sound_call .sub1
	sound_jump .mainLoop

.sub1:
.loop5:
	transpose 0, 0
	duty_cycle 0
	volume_envelope 8, 8
	octave 2
	note A#, 2
	octave 3
	note D#, 1
	note G_, 1
	octave 2
	note A#, 2
	octave 3
	note D#, 1
	note G_, 1
	octave 2
	note A#, 2
	octave 3
	note D#, 1
	note G_, 1
	rest 4
	sound_loop 4, .loop5
.loop6:
	note D#, 2
	note G_, 1
	note A#, 1
	note D#, 2
	note G_, 1
	note A#, 1
	note D#, 2
	note G_, 1
	note A#, 1
	rest 4
	sound_loop 4, .loop6
.loop7:
	note C_, 2
	note F_, 1
	note A_, 1
	note C_, 2
	note F_, 1
	note A_, 1
	note C_, 2
	note F_, 1
	note A_, 1
	rest 4
	sound_loop 4, .loop7
.loop8:
	note F_, 2
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note F_, 2
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note F_, 2
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	rest 4
	sound_loop 4, .loop8
	sound_ret

.sub2:
.loop10:
	octave 2
	volume_envelope 8, 8
	note A#, 1
	octave 3
	note D#, 1
	note G_, 2
	octave 2
	note A#, 1
	octave 3
	note D#, 1
	note G_, 2
	octave 2
	note A#, 1
	octave 3
	note D#, 1
	note G_, 2
	rest 4
	sound_loop 4, .loop10
.loop12:
	octave 3
	volume_envelope 8, 8
	note D#, 1
	note G_, 1
	note A#, 2
	note D#, 1
	note G_, 1
	note A#, 2
	note D#, 1
	note G_, 1
	note A#, 2
	rest 4
	sound_loop 4, .loop12
.loop13:
	volume_envelope 8, 8
	octave 3
	note G_, 1
	note A#, 1
	octave 4
	note D#, 2
	octave 3
	note G_, 1
	note A#, 1
	octave 4
	note D#, 2
	octave 3
	note G_, 1
	note A#, 1
	octave 4
	note D#, 2
	rest 4
	sound_loop 4, .loop13
.loop14:
	octave 3
	note A#, 1
	octave 4
	note D#, 1
	note G_, 2
	octave 3
	note A#, 1
	octave 4
	note D#, 1
	note G_, 2
	octave 3
	note A#, 1
	octave 4
	note D#, 1
	note G_, 2
	rest 4
	sound_loop 4, .loop14
	sound_ret

.quadrest:
	rest 16
	rest 16
	rest 16
	rest 16
	sound_ret

Music_GymLeaderBattleXY_Ch2:
	vibrato 0, 0, 0
	duty_cycle 0
	note_type 6, 15, 2
	sound_call .quadrest
.loop1:
	sound_call .wowo
	sound_loop 4, .loop1
.loop3:
	volume_envelope 12, 2
	sound_call .wowo
	sound_loop 20, .loop3
	sound_call .quadrest
.loop2:
	volume_envelope 15, 2
	sound_call .wowo
	sound_loop 8, .loop2
	note_type 12, 12, 7
	sound_call .quadrest
	sound_call .quadrest
.mainLoop:
	octave 4
	vibrato 0, 1, 2
	sound_call .sub1
	note C_, 10
	octave 2
	note F_, 6
	note C_, 10
	octave 4
	sound_call .sub1
	note A_, 10
	octave 2
	note F_, 6
	note A_, 10
	octave 4
	note A#, 12
	note A_, 4
	note A#, 4
	note A_, 4
	note G_, 4
	note F_, 4
	note A_, 12
	note F_, 4
	note C_, 16
	note A#, 12
	note A_, 4
	note A#, 4
	octave 5
	note C_, 4
	note D_, 3
	note C_, 3
	octave 4
	note A#, 2
	octave 5
	note C_, 14
	note E_, 2
	note F_, 14
	octave 3
	duty_cycle 2
	volume_envelope 10, 8
	vibrato 0, 2, 2
	note A_, 2
	note A#, 16
	volume_envelope 10, 7
	note A#, 16
	sound_call .subb
	note F_, 16
	volume_envelope 10, 7
	note F_, 16
	volume_envelope 10, 8
	note D#, 16
	volume_envelope 10, 7
	note D#, 8
	note A_, 8
	volume_envelope 10, 8
	octave 3
	sound_call .subb
	sound_call .subc
	octave 2
	note D#, 16
	volume_envelope 10, 7
	note D#, 8
	note A_, 8
	volume_envelope 10, 8
	note A#, 16
	volume_envelope 10, 7
	note A#, 8
	note F_, 8
	volume_envelope 10, 8
	note C_, 16
	volume_envelope 10, 7
	note C_, 16
	sound_call .subc
	sound_call .quadrest
	sound_call .quadrest
	sound_call .quadrest
	rest 16
	rest 16
.loop4:
	volume_envelope 12, 7
	duty_cycle 3
	note F_, 1
	note C_, 2
	note F_, 1
	note F#, 1
	note G#, 1
	note F#, 2
	sound_loop 20, .loop4
	sound_jump .mainLoop

.quadrest:
	rest 16
	rest 16
	rest 16
	rest 16
	sound_ret

.wowo:
	octave 1
	duty_cycle 3
	note F_, 2
	note C_, 2
	note F_, 2
	note F#, 4
	note G#, 2
	note F#, 2
	note D#, 2
	sound_ret

.sub1:
	note D#, 6
	octave 3
	note A#, 14
	octave 4
	note D#, 4
	note G_, 4
	note D#, 4
	note F_, 6
	sound_ret

.subb:
	volume_envelope 10, 8
	note D#, 16
	volume_envelope 10, 7
	note D#, 8
	note F_, 8
	volume_envelope 10, 8
	note C_, 16
	volume_envelope 10, 7
	note C_, 16
	volume_envelope 10, 8
	octave 2
	sound_ret

.subc:
	volume_envelope 10, 8
	note F_, 8
	volume_envelope 10, 7
	note F_, 8
	octave 1
	volume_envelope 10, 8
	note A_, 8
	volume_envelope 10, 7
	note A_, 8
	volume_envelope 10, 8
	sound_ret

Music_GymLeaderBattleXY_Ch3:
	note_type 12, 1, 0
	sound_call .quadrest
.loop1:
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	sound_loop 64, .loop1
	sound_call .sub1
	sound_call .sub1
.mainLoop:
	note_type 12, 1, 0
	transpose 0, 0
	vibrato 0, 0, 0
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
	sound_call .sub1
.loop6:
	octave 1
	volume_envelope 1, 2
	note D#, 1
	octave 3
	note D#, 1
	octave 1
	note A#, 1
	octave 3
	note D#, 1
	sound_loop 4, .loop6
.loop7:
	octave 1
	note D#, 1
	octave 2
	note G_, 1
	octave 1
	note A#, 1
	octave 2
	note G_, 1
	sound_loop 4, .loop7
.loop8:
	octave 1
	note D#, 1
	octave 2
	note A#, 1
	octave 1
	note A#, 1
	octave 2
	note A#, 1
	sound_loop 4, .loop8
.loop9:
	octave 1
	note D#, 1
	octave 3
	note D#, 1
	octave 1
	note A#, 1
	octave 3
	note D#, 1
	sound_loop 4, .loop9
.loop10:
	octave 1
	note F_, 1
	octave 2
	note F_, 1
	note C_, 1
	note F_, 1
	sound_loop 4, .loop10
.loop11:
	octave 1
	note F_, 1
	octave 2
	note A_, 1
	note C_, 1
	note A_, 1
	sound_loop 4, .loop11
.loop12:
	octave 1
	note F_, 1
	octave 2
	note F_, 1
	octave 1
	note A_, 1
	octave 2
	note F_, 1
	octave 1
	sound_loop 4, .loop12
.loop13:
	octave 1
	note F_, 1
	octave 2
	note C_, 1
	octave 1
	note A_, 1
	octave 2
	note C_, 1
	sound_loop 4, .loop13
	sound_call .sub3
	sound_call .sub3
	sound_call .quadrest
.loop2:
	sound_call .grind
	stereo_panning FALSE, TRUE
	note D_, 2
	note C#, 1
	note C_, 1
	octave 1
	stereo_panning TRUE, TRUE
	note B_, 1
	note A#, 1
	note A_, 1
	note G#, 1
	sound_call .grind
	octave 2
	note E_, 1
	note D#, 1
	note D_, 1
	stereo_panning TRUE, TRUE
	note D#, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note C#, 1
	sound_loop 6, .loop2
.loop3:
	note_type 12, 1, 0
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	octave 1
	sound_loop 16, .loop3
	sound_jump .mainLoop

.sub1:
.loop4:
	transpose 0, 0
	volume_envelope 1, 6
	octave 1
	note D#, 2
	octave 2
	note D#, 2
	sound_loop 8, .loop4
.loop5:
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	sound_loop 8, .loop5
	sound_ret

.grind:
	note_type 6, 1, 0
	stereo_panning TRUE, FALSE
	octave 1
	note G_, 1
	note F#, 1
	note F_, 2
	note F#, 2
	note G_, 2
	note G#, 1
	note A_, 1
	stereo_panning TRUE, TRUE
	note A#, 1
	note B_, 1
	octave 2
	note C_, 1
	note C#, 1
	stereo_panning FALSE, TRUE
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	note E_, 1
	note D#, 1
	note D_, 1
	note D#, 1
	sound_ret

.sub3:
.loop16:
	volume_envelope 1, 6
	octave 1
	note D#, 2
	octave 2
	note D#, 2
	sound_loop 16, .loop16
.loop17:
	octave 1
	note F_, 2
	octave 2
	note F_, 2
	sound_loop 16, .loop17
	sound_ret

.quadrest:
	rest 16
	rest 16
	rest 16
	rest 16
	sound_ret

Music_GymLeaderBattleXY_Ch4:
	toggle_noise 4
	drum_speed 6
	sound_call .sub1
	sound_call .sub1
	toggle_noise
	toggle_noise 5
	drum_note 12, 1
	drum_note 9, 7
.loop2:
	sound_call .bassbeat1
	sound_loop 7, .loop2
	sound_call .sub4
.loop3:
	drum_note 12, 4
	drum_note 4, 4
	drum_note 12, 1
	drum_note 7, 3
	drum_note 4, 4
	sound_loop 8, .loop3
.loop4:
	sound_call .bassbeat1
	sound_loop 16, .loop4
.loop5:
	sound_call .bassbeat1
	drum_note 12, 1
	drum_note 7, 1
	drum_note 11, 2
	drum_note 11, 2
	drum_note 11, 2
	sound_loop 3, .loop5
	sound_call .bassbeat1
	drum_note 12, 2
	drum_note 12, 2
	drum_note 12, 2
	drum_note 12, 2
	sound_call .sub3
.mainLoop:
	sound_call .sub2
	sound_call .sub2
	sound_call .sub2
	sound_call .sub2
	sound_call .sub3
	sound_call .sub3
	sound_call .sub3
.loop8:
	drum_note 12, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 12, 1
	drum_note 7, 1
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	sound_loop 4, .loop8
	toggle_noise
	toggle_noise 4
	sound_call .sub1
	sound_call .sub5
	sound_call .sub1
	sound_call .sub1
	sound_call .sub5
	toggle_noise
	toggle_noise 5
	sound_call .sub4
.loop6:
	drum_note 12, 4
	drum_note 4, 4
	drum_note 12, 1
	drum_note 7, 3
	drum_note 4, 4
	sound_loop 6, .loop6
	drum_note 12, 2
	drum_note 11, 2
	drum_note 12, 2
	drum_note 11, 2
	drum_note 12, 1
	drum_note 7, 1
	drum_note 11, 2
	drum_note 12, 2
	drum_note 11, 2
	drum_note 12, 2
	drum_note 12, 2
	drum_note 12, 2
	drum_note 12, 2
	drum_note 12, 1
	drum_note 7, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	drum_note 12, 1
	sound_jump .mainLoop

.sub1:
.loop7:
	drum_note 4, 2
	drum_note 7, 2
	drum_note 2, 2
	drum_note 7, 2
	drum_note 3, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 2, 2
	drum_note 4, 2
	drum_note 2, 2
	drum_note 7, 2
	drum_note 2, 2
	drum_note 3, 2
	drum_note 7, 2
	drum_note 2, 2
	drum_note 2, 2
	sound_loop 2, .loop7
	sound_ret

.sub2:
	drum_note 12, 1
	drum_note 9, 7
.loop9:
	drum_note 12, 4
	drum_note 4, 4
	sound_loop 15, .loop9
	sound_ret

.sub3:
	drum_note 12, 1
	drum_note 9, 3
	drum_note 4, 4
	drum_note 12, 1
	drum_note 7, 3
	drum_note 4, 4
.loop1:
	drum_note 12, 4
	drum_note 4, 4
	drum_note 12, 1
	drum_note 7, 3
	drum_note 4, 4
	sound_loop 15, .loop1
	sound_ret

.sub4:
.loop10:
	drum_note 12, 4
	drum_note 4, 4
	sound_loop 16, .loop10
	sound_ret

.sub5:
.loop12:
	drum_note 11, 1
	drum_note 5, 1
	drum_note 2, 2
	drum_note 3, 2
	drum_note 2, 2
	sound_loop 16, .loop12
	sound_ret

.bassbeat1:
	drum_note 12, 2
	drum_note 11, 2
	drum_note 11, 2
	drum_note 11, 2
	sound_ret
