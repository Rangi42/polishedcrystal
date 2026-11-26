Drumkits:
	dr Drumkit0
	dr Drumkit1
	dr Drumkit2
	dr Drumkit3
	dr Drumkit4
	dr Drumkit5
	dr Drumkit6

Drumkit0:
	dr Drum00    ; rest
	dr Snare1    ; c
	dr Snare2    ; c#
	dr Snare3    ; d
	dr Snare4    ; d#
	dr Drum05    ; e
	dr Triangle1 ; f
	dr Triangle2 ; f#
	dr HiHat1    ; g
	dr Snare5    ; g#
	dr Snare6    ; a
	dr Snare7    ; a#
	dr HiHat2    ; b
Drumkit1:
	dr Drum00
	dr HiHat1
	dr Snare5
	dr Snare6
	dr Snare7
	dr HiHat2
	dr HiHat3
	dr Snare8
	dr Triangle3
	dr Triangle4
	dr Snare9
	dr Snare10
	dr Snare11
Drumkit2:
	dr Drum00
	dr Snare1
	dr Snare9
	dr Snare10
	dr Snare11
	dr Drum05
	dr Triangle1
	dr Triangle2
	dr HiHat1
	dr Snare5
	dr Snare6
	dr Snare7
	dr HiHat2
Drumkit3:
	dr Drum21
	dr Snare12
	dr Snare13
	dr Snare14
	dr Kick1
	dr Triangle5
	dr Drum20
	dr Drum27
	dr Drum28
	dr Drum29
	dr Drum21
	dr Kick2
	dr Crash2
Drumkit4:
	dr Drum21
	dr Drum20
	dr Snare13
	dr Snare14
	dr Kick1
	dr Drum33
	dr Triangle5
	dr Drum35
	dr Drum31
	dr Drum32
	dr Drum36
	dr Kick2
	dr Crash1
Drumkit5:
	dr Drum00
	dr Snare9
	dr Snare10
	dr Snare11
	dr Drum27
	dr Drum28
	dr Drum29
	dr Drum05
	dr Triangle1
	dr Crash1
	dr Snare14
	dr Snare13
	dr Kick2
Drumkit6:
	dr Drum00
	dr Kick2
	dr Snare9
	dr Snare10
	dr Snare11
	dr Crash2
	dr Crash1
	dr Snare9
	dr Snare9
	dr Snare9
	dr Snare9
	dr Snare9
	dr Snare9

; ReadNoiseSample reads each drum step as three uncompressed bytes.
Drum00:
; unused
	raw_noise_note 32, 1, 1, 0
	sound_ret

Snare1:
	raw_noise_note 32, 12, 1, 51
	sound_ret

Snare2:
	raw_noise_note 32, 11, 1, 51
	sound_ret

Snare3:
	raw_noise_note 32, 10, 1, 51
	sound_ret

Snare4:
	raw_noise_note 32, 8, 1, 51
	sound_ret

Drum05:
	raw_noise_note 39, 8, 4, 55
	raw_noise_note 38, 8, 4, 54
	raw_noise_note 37, 8, 3, 53
	raw_noise_note 36, 8, 3, 52
	raw_noise_note 35, 8, 2, 51
	raw_noise_note 34, 8, 1, 50
	sound_ret

Triangle1:
	raw_noise_note 32, 5, 1, 42
	sound_ret

Triangle2:
	raw_noise_note 33, 4, 1, 43
	raw_noise_note 32, 6, 1, 42
	sound_ret

HiHat1:
	raw_noise_note 32, 8, 1, 16
	sound_ret

Snare5:
	raw_noise_note 32, 8, 2, 35
	sound_ret

Snare6:
	raw_noise_note 32, 8, 2, 37
	sound_ret

Snare7:
	raw_noise_note 32, 8, 2, 38
	sound_ret

HiHat2:
	raw_noise_note 32, 10, 1, 16
	sound_ret

HiHat3:
	raw_noise_note 32, 10, 2, 17
	sound_ret

Snare8:
	raw_noise_note 32, 10, 2, 80
	sound_ret

Triangle3:
	raw_noise_note 32, 10, 1, 24
	raw_noise_note 32, 3, 1, 51
	sound_ret

Triangle4:
	raw_noise_note 34, 9, 1, 40
	raw_noise_note 32, 7, 1, 24
	sound_ret

Snare9:
	raw_noise_note 32, 9, 1, 34
	sound_ret

Snare10:
	raw_noise_note 32, 7, 1, 34
	sound_ret

Snare11:
	raw_noise_note 32, 6, 1, 34
	sound_ret

Drum20:
	raw_noise_note 32, 1, 1, 17
	sound_ret

Drum21:
	sound_ret

Snare12:
	raw_noise_note 32, 9, 1, 51
	sound_ret

Snare13:
	raw_noise_note 32, 5, 1, 50
	sound_ret

Snare14:
	raw_noise_note 32, 8, 1, 49
	sound_ret

Kick1:
	raw_noise_note 32, 8, 8, 107
	raw_noise_note 32, 7, 1, 0
	sound_ret

Triangle5:
	raw_noise_note 48, 9, 1, 24
	sound_ret

Drum27:
	raw_noise_note 39, 9, 2, 16
	sound_ret

Drum28:
	raw_noise_note 51, 9, 1, 0
	raw_noise_note 51, 1, 1, 0
	sound_ret

Drum29:
	raw_noise_note 51, 9, 1, 17
	raw_noise_note 51, 1, 1, 0
	sound_ret

Crash1:
	raw_noise_note 51, 8, 8, 21
	raw_noise_note 32, 6, 5, 18
	sound_ret

Drum31:
	raw_noise_note 51, 5, 1, 33
	raw_noise_note 51, 1, 1, 17
	sound_ret

Drum32:
	raw_noise_note 51, 5, 1, 80
	raw_noise_note 51, 1, 1, 17
	sound_ret

Drum33:
	raw_noise_note 32, 10, 1, 49
	sound_ret

Crash2:
	raw_noise_note 32, 8, 4, 18
	sound_ret

Drum35:
	raw_noise_note 51, 8, 1, 0
	raw_noise_note 51, 1, 1, 0
	sound_ret

Drum36:
	raw_noise_note 51, 8, 1, 33
	raw_noise_note 51, 1, 1, 17
	sound_ret

Kick2:
	raw_noise_note 32, 10, 8, 107
	raw_noise_note 32, 7, 1, 0
	sound_ret
