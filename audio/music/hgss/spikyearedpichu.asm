; Pokémon HG/SS - Spiky-Eared Pichu
; Demixed by Mmmmmm
; https://pastebin.com/stpKurZA
; https://hax.iimarck.us/topic/6777/3/

Music_SpikyEaredPichuHGSS:
	dbw $c0, Music_SpikyEaredPichuHGSS_Ch1
	dbw $01, Music_SpikyEaredPichuHGSS_Ch2
	dbw $02, Music_SpikyEaredPichuHGSS_Ch3
	dbw $03, Music_SpikyEaredPichuHGSS_Ch4

Music_SpikyEaredPichuHGSS_Ch1:
	tempo 160
	volume $77
	callchannel Music_SpikyEaredPichuHGSS_Ch1_branch_1
	callchannel Music_SpikyEaredPichuHGSS_Ch1_branch_1
	dutycycle 1
	intensity $b3
	note F_, 2
	note F_, 2
	note F_, 1
	note E_, 1
	note D_, 1
	note E_, 1
	note F_, 4
	note A_, 4
	note G_, 2
	note G_, 2
	note G_, 1
	note A_, 1
	note A#, 1
	note G_, 1
	note A_, 4
	octave 4
	note C_, 4
	octave 3
	note B_, 2
	note B_, 2
	note B_, 1
	octave 4
	note C_, 1
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 4
	note E_, 4
	note D_, 2
	octave 3
	note A_, 2
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note B_, 4
	octave 4
	note C_, 4
	loopchannel 0, Music_SpikyEaredPichuHGSS_Ch1

Music_SpikyEaredPichuHGSS_Ch1_branch_1:
	notetype $4, $92
	dutycycle 0
	octave 3
	note __, 6
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 1
	octave 4
	note C_, 1
	notetype $C, $92
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	note A#, 2
	notetype $8, $92
	note A_, 1
	note A#, 1
	note A_, 1
	notetype $C, $92
	note G_, 2
	note F_, 2
	note E_, 2
	note F_, 2
	note G_, 2
	note A_, 2
	note A#, 2
	note G_, 2
	notetype $6, $92
	note A#, 1
	octave 4
	note D#, 1
	octave 3
	note A#, 1
	octave 4
	note D#, 1
	octave 3
	note A#, 1
	octave 4
	note D#, 3
	notetype $C, $92
	octave 4
	note D_, 2
	octave 3
	note A#, 2
	note G_, 2
	octave 4
	note D_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note A#, 2
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note E_, 4
	endchannel

Music_SpikyEaredPichuHGSS_Ch2:
	volume $77
	dutycycle 2
	notetype $c, $b3
	octave 3
	note C_, 2
	note C_, 2
	note C_, 1
	octave 2
	note A#, 1
	note A_, 1
	note A#, 1
	octave 3
	note C_, 2
	note F_, 2
	note F_, 2
	note C_, 2
	note D_, 2
	notetype $8, $b3
	note C_, 1
	note D_, 1
	note C_, 1
	notetype $c, $b3
	octave 2
	note A#, 2
	note A_, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note F_, 2
	note G_, 2
	note D#, 2
	note A#, 2
	note G_, 2
	octave 3
	note D_, 2
	octave 2
	note A#, 2
	note G_, 2
	octave 3
	note D_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 2
	note A#, 2
	note A_, 2
	octave 3
	note C_, 2
	octave 2
	note E_, 4
	intensity $93
Music_SpikyEaredPichuHGSS_Ch2_loop_1:
	octave 1
	note F_, 2
	octave 2
	note C_, 2
	note __, 2
	note C_, 2
	loopchannel 4, Music_SpikyEaredPichuHGSS_Ch2_loop_1
	octave 1
	note D#, 2
	note A#, 4
	note A#, 2
	note A#, 2
	note G_, 2
	note D_, 2
	note B_, 2
	octave 2
	note C_, 2
	octave 1
	note A#, 2
	note A_, 2
	note G_, 2
	note F_, 2
	note A_, 2
	note C_, 4
	note D_, 2
	note A_, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note D_, 2
	note A#, 2
	octave 2
	note D_, 2
	octave 1
	note A_, 2
	note C_, 2
	note G_, 2
	octave 2
	note E_, 2
	octave 1
	note G_, 2
	note C_, 2
	note F_, 2
	octave 2
	note C_, 2
	octave 1
	note F_, 2
	note D_, 2
	note B_, 2
	octave 2
	note D_, 2
	octave 1
	note F_, 2
	note C_, 2
	note G_, 2
	octave 2
	note C_, 2
	octave 1
	note E_, 2
	note D_, 4
	note D_, 4
	note B_, 4
	note __, 4
	loopchannel 0, Music_SpikyEaredPichuHGSS_Ch2

Music_SpikyEaredPichuHGSS_Ch3:
	notetype $6, $15
	intensity $10
	note __, 16
	octave 6
	note C_, 2
	note D_, 2
	note C_, 2
	note F_, 2
	note C_, 12
	intensity $20
	note C_, 8
	intensity $30
	note C_, 4
	octave 5
	intensity $10
	note A_, 2
	note F_, 1
	intensity $20
	note F_, 1
	intensity $10
	note F_, 2
	note A_, 2
	octave 6
	note F_, 2
	note C_, 2
	octave 5
	note A_, 2
	note F_, 12
	intensity $20
	note F_, 8
	intensity $30
	note F_, 4
	note __, 8
	notetype $3, $10
	note F_, 1
	note B_, 1
	octave 6
	note C_, 1
	note D_, 1
	notetype $c, $10
	note E_, 1
	intensity $30
	note E_, 1
	intensity $10
	note D_, 1
	intensity $30
	note D_, 1
	intensity $10
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	octave 5
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note A_, 1
	intensity $30
	note A_, 1
	intensity $10
	octave 6
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	octave 5
	note E_, 4
	octave 6
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	note C_, 1
	octave 5
	note A#, 1
	note A_, 1
	note A#, 1
	octave 6
	note C_, 2
	note F_, 1
	intensity $30
	note F_, 1
	intensity $10
	note F_, 1
	intensity $30
	note F_, 1
	intensity $10
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	note D_, 2
	notetype $8, $10
	note C_, 1
	note D_, 1
	note C_, 1
	octave 5
	notetype $c, $10
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note A_, 1
	intensity $30
	note A_, 1
	intensity $10
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note A_, 1
	intensity $30
	note A_, 1
	intensity $10
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note F_, 1
	intensity $30
	note F_, 1
	intensity $10
	note G_, 2
	note D#, 2
	notetype $6, $10
	octave 6
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	intensity $20
	note D#, 1
	note F_, 1
	note D#, 1
	note F_, 1
	notetype $c, $10
	note D_, 1
	intensity $30
	note D_, 1
	intensity $10
	octave 5
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note G_, 1
	intensity $30
	note G_, 1
	intensity $10
	octave 6
	note D_, 1
	intensity $30
	note D_, 1
	intensity $10
	note E_, 1
	intensity $30
	note E_, 1
	intensity $10
	note D_, 1
	intensity $30
	note D_, 1
	intensity $10
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	octave 5
	note A#, 1
	intensity $30
	note A#, 1
	intensity $10
	note A_, 1
	intensity $30
	note A_, 1
	intensity $10
	octave 6
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	octave 5
	note E_, 4
	note __, 8
	note A_, 1
	note A#, 1
	note A_, 1
	note A#, 1
	intensity $25
	octave 4
	note D_, 1
	note C_, 1
	octave 3
	note A#, 1
	octave 4
	note D_, 1
	note C_, 6
	intensity $35
	note C_, 2
	intensity $10
	octave 6
	note C_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	intensity $25
	octave 4
	note F_, 1
	note E_, 1
	note C_, 1
	note A_, 1
	note G_, 6
	intensity $35
	note G_, 1
	notetype $3, $10
	octave 5
	note C_, 1
	note G_, 1
	note A_, 1
	note B_, 1
	notetype $c, $10
	octave 6
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	octave 5
	note G_, 1
	intensity $30
	note G_, 1
	intensity $10
	octave 6
	note C_, 1
	intensity $30
	note C_, 1
	intensity $10
	note E_, 1
	intensity $30
	note E_, 1
	intensity $10
	note D_, 1
	intensity $30
	note D_, 1
	intensity $10
	octave 5
	note A_, 1
	intensity $30
	note A_, 1
	intensity $10
	note B_, 1
	intensity $30
	note B_, 1
	intensity $10
	octave 6
	note C_, 2
	notetype $3, $10
	octave 5
	note B_, 4
	intensity $30
	note B_, 9
	octave 6
	intensity $10
	note D_, 1
	note E_, 1
	note F#, 1
	note G_, 8
	note __, 8
	loopchannel 0, Music_SpikyEaredPichuHGSS_Ch3

Music_SpikyEaredPichuHGSS_Ch4:
	togglenoise $3
	notetype $c
Music_SpikyEaredPichuHGSS_Ch4_loop_main:
Music_SpikyEaredPichuHGSS_Ch4_loop_1:
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 7
	notetype $3
	note C_, 1
	note C_, 1
	note C_, 1
	note C_, 1
	notetype $c
	note B_, 6
	note D#, 2
	note C_, 4
	note C_, 4
	loopchannel 2, Music_SpikyEaredPichuHGSS_Ch4_loop_1
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 8
	note G#, 8
	note B_, 2
	note C_, 2
	note B_, 2
	note C_, 2
	note B_, 4
	note D#, 4
	loopchannel 0, Music_SpikyEaredPichuHGSS_Ch4_loop_main
