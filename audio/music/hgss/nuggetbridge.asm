; Pokémon HG/SS - Nugget Bridge
; Demixed by FroggestSpirit
; https://github.com/froggestspirit/CrystalComplete/blob/master/audio/music/custom/nuggetbridge.asm

Music_NuggetBridgeHGSS:
	dbw $c0, Music_NuggetBridgeHGSS_Ch1
	dbw $01, Music_NuggetBridgeHGSS_Ch2
	dbw $02, Music_NuggetBridgeHGSS_Ch3
	dbw $03, Music_NuggetBridgeHGSS_Ch4

Music_NuggetBridgeHGSS_Ch1:
	tempo $A8
	volume 7, 7
	tone $0001
	duty_cycle 1
	note_type 12, 11, 5
	octave 2
	note G#, 6
	note G#, 1
	note B_, 1
	note A_, 4
	note F#, 2
	octave 3
	note C#, 2
Music_NuggetBridgeHGSS_Loop1:
	octave 2
	note B_, 3
	note G#, 1
	note A_, 6
	duty_cycle 2
	note A_, 1
	note G#, 1
	note F#, 4
	duty_cycle 1
	note G#, 6
	note G#, 1
	note B_, 1
	note A_, 4
	note F#, 2
	octave 3
	note C#, 2
	octave 2
	note B_, 3
	note G#, 1
	octave 3
	note E_, 6
	duty_cycle 2
	octave 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 4
	note A_, 2
	note E_, 2
	octave 2
	note A_, 4
	octave 3
	note G#, 2
	note E_, 2
	octave 2
	note G#, 4
	octave 3
	note F#, 2
	note C#, 2
	octave 2
	note F#, 4
	octave 3
	note E_, 2
	note C#, 2
	note D#, 2
	note C#, 2
	octave 2
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 6
	note F#, 2
	octave 3
	note D_, 4
	note E_, 3
	octave 2
	note A_, 1
	note G#, 6
	note E_, 2
	note A_, 2
	note G#, 2
	volume_envelope 11, 2
	note B_, 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note D_, 2
	note A_, 4
	note G#, 3
	note F#, 1
	note E_, 6
	volume_envelope 11, 1
	octave 2
	note E_, 1
	note F#, 1
	note G#, 2
	note F#, 1
	note E_, 1
	volume_envelope 11, 2
	note B_, 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note D_, 2
	note A_, 4
	note G#, 3
	note F#, 1
	note E_, 6
	volume_envelope 11, 1
	octave 2
	note G#, 1
	note A_, 1
	note B_, 2
	note A_, 1
	note G#, 1
	volume_envelope 11, 2
	note B_, 2
	note B_, 1
	octave 3
	note C#, 1
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 4
	octave 2
	note B_, 2
	note B_, 1
	octave 3
	note C#, 1
	note D#, 2
	note D#, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	volume_envelope 11, 5
	note A_, 4
	duty_cycle 1
	note G#, 6
	octave 2
	note G#, 1
	note B_, 1
	note A_, 4
	note F#, 2
	octave 3
	note C#, 2
	jumpchannel Music_NuggetBridgeHGSS_Loop1

Music_NuggetBridgeHGSS_Ch2:
	duty_cycle 1
	note_type 12, 12, 5
	tone $0002
	octave 3
	note E_, 6
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 6
	note A_, 2
Music_NuggetBridgeHGSS_Loop2:
	note G#, 3
	note E_, 1
	note F#, 12
	note E_, 6
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 6
	note A_, 2
	note G#, 3
	note E_, 1
	note B_, 12
	duty_cycle 0
	octave 4
	note C#, 6
	octave 3
	note B_, 1
	note A_, 1
	note B_, 6
	note A_, 1
	note G#, 1
	note A_, 6
	note G#, 1
	note F#, 1
	note G#, 4
	duty_cycle 2
	note F#, 2
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 8
	note A_, 4
	note G#, 3
	note F#, 1
	note E_, 8
	duty_cycle 1
	note F#, 2
	note E_, 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 4
	octave 4
	note C#, 4
	octave 3
	note B_, 3
	note A_, 1
	note G#, 12
	duty_cycle 0
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 4
	octave 4
	note C#, 4
	octave 3
	note B_, 3
	note A_, 1
	note G#, 12
	duty_cycle 2
	note D_, 2
	note D_, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 2
	note A_, 1
	note B_, 1
	octave 4
	note C#, 4
	octave 3
	note D#, 2
	note D#, 1
	note E_, 1
	note F#, 2
	note F#, 1
	note G#, 1
	note A_, 2
	note B_, 1
	octave 4
	note C#, 1
	note_type 6, 12, 5
	note D#, 4
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	note C#, 1
	note D#, 1
	note_type 12, 12, 5
	duty_cycle 1
	note E_, 6
	octave 2
	note B_, 1
	octave 3
	note E_, 1
	note F#, 6
	note A_, 2
	jumpchannel Music_NuggetBridgeHGSS_Loop2

Music_NuggetBridgeHGSS_Ch3:
	note_type 12, 1, 5
	octave 2
	note E_, 4
	note __, 8
	note D_, 4
Music_NuggetBridgeHGSS_Loop3:
	note E_, 1
	note __, 11
	octave 1
	note B_, 4
	octave 2
	note E_, 4
	note __, 8
	note D_, 4
	note E_, 1
	note __, 11
	note G#, 4
	note_type 4, 2, 4
	octave 3
	note A_, 2
	octave 5
	note C#, 2
	note E_, 2
	note A_, 2
	octave 6
	note C#, 2
	note E_, 2
	note A_, 2
	note E_, 2
	note C#, 2
	octave 5
	note A_, 2
	note E_, 2
	note C#, 2
	octave 3
	note G#, 2
	octave 4
	note B_, 2
	octave 5
	note E_, 2
	note G#, 2
	note B_, 2
	octave 6
	note E_, 2
	note G#, 2
	note E_, 2
	octave 5
	note B_, 2
	note G#, 2
	note E_, 2
	octave 4
	note B_, 2
	octave 3
	note F#, 2
	octave 4
	note A_, 2
	octave 5
	note C#, 2
	note F#, 2
	note A_, 2
	octave 6
	note C#, 2
	note F#, 2
	note C#, 2
	octave 5
	note A_, 2
	note F#, 2
	note C#, 2
	octave 4
	note A_, 2
	octave 3
	note C#, 2
	octave 4
	note E_, 2
	note G#, 2
	octave 5
	note C#, 2
	note E_, 2
	note G#, 2
	octave 6
	note C#, 3
	note __, 9
	note_type 12, 1, 5
	callchannel Music_NuggetBridgeHGSS_Bar7
	callchannel Music_NuggetBridgeHGSS_Bar7
	callchannel Music_NuggetBridgeHGSS_Bar7
	callchannel Music_NuggetBridgeHGSS_Bar7
	callchannel Music_NuggetBridgeHGSS_Bar8
	callchannel Music_NuggetBridgeHGSS_Bar8
	callchannel Music_NuggetBridgeHGSS_Bar8
	callchannel Music_NuggetBridgeHGSS_Bar8
	callchannel Music_NuggetBridgeHGSS_Bar9
	callchannel Music_NuggetBridgeHGSS_Bar9
	callchannel Music_NuggetBridgeHGSS_Bar9
	callchannel Music_NuggetBridgeHGSS_Bar9
	callchannel Music_NuggetBridgeHGSS_Bar10
	callchannel Music_NuggetBridgeHGSS_Bar10
	callchannel Music_NuggetBridgeHGSS_Bar10
	callchannel Music_NuggetBridgeHGSS_Bar10
	callchannel Music_NuggetBridgeHGSS_Bar11
	callchannel Music_NuggetBridgeHGSS_Bar11
	callchannel Music_NuggetBridgeHGSS_Bar11
	callchannel Music_NuggetBridgeHGSS_Bar11
	callchannel Music_NuggetBridgeHGSS_Bar12
	callchannel Music_NuggetBridgeHGSS_Bar12
	callchannel Music_NuggetBridgeHGSS_Bar12
	callchannel Music_NuggetBridgeHGSS_Bar12
	note_type 6, 1, 5
	octave 1
	note B_, 2
	note __, 16
	note __, 2
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 6
	note __, 2
	note B_, 2
	note __, 16
	note __, 2
	note B_, 1
	note __, 1
	note B_, 1
	note __, 1
	note B_, 6
	note __, 2
	note_type 12, 1, 5
	octave 2
	note E_, 4
	note __, 8
	note D_, 4
	jumpchannel Music_NuggetBridgeHGSS_Loop3

Music_NuggetBridgeHGSS_Bar7:
	octave 2
	note D_, 1
	note __, 1
	volume_envelope 2, 4
	octave 5
	note A_, 1
	octave 4
	note D_, 1
	volume_envelope 1, 5
	endchannel
Music_NuggetBridgeHGSS_Bar8:
	octave 2
	note E_, 1
	note __, 1
	volume_envelope 2, 4
	octave 5
	note B_, 1
	octave 4
	note E_, 1
	volume_envelope 1, 5
	endchannel
Music_NuggetBridgeHGSS_Bar9:
	octave 1
	note B_, 1
	note __, 1
	volume_envelope 2, 4
	octave 6
	note D_, 1
	octave 4
	note F#, 1
	volume_envelope 1, 5
	endchannel
Music_NuggetBridgeHGSS_Bar10:
	octave 2
	note E_, 1
	note __, 1
	volume_envelope 2, 4
	octave 6
	note E_, 1
	octave 4
	note B_, 1
	volume_envelope 1, 5
	endchannel
Music_NuggetBridgeHGSS_Bar11:
	octave 1
	note B_, 1
	volume_envelope 2, 4
	octave 4
	note A_, 1
	octave 6
	note F#, 1
	octave 5
	note D_, 1
	volume_envelope 1, 5
	endchannel
Music_NuggetBridgeHGSS_Bar12:
	octave 2
	note E_, 1
	volume_envelope 2, 4
	octave 4
	note B_, 1
	octave 6
	note G#, 1
	octave 5
	note E_, 1
	volume_envelope 1, 5
	endchannel

Music_NuggetBridgeHGSS_Ch4:
	note_type 4
	toggle_noise 0
	note A_, 16
	note __, 2
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
Music_NuggetBridgeHGSS_Loop4:
	note D_, 16
	note __, 2
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 16
	note __, 2
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 16
	note __, 2
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 3
	note A_, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note D_, 12
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 12
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 12
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 12
	note D_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 16
	note __, 14
	note D_, 3
	note D_, 3
	note A_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 16
	note __, 14
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 3
	note D_, 3
	note D_, 3
	note D_, 3
	note A_, 16
	note __, 2
	note D_, 3
	note D_, 3
	note D_, 12
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	jumpchannel Music_NuggetBridgeHGSS_Loop4
