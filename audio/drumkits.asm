Drumkits:
	dw Drumkit0
	dw Drumkit1
	dw Drumkit2
	dw Drumkit3
	dw Drumkit4
	dw Drumkit5

Drumkit0:
	dw Drum00    ; rest
	dw Snare1    ; c
	dw Snare2    ; c#
	dw Snare3    ; d
	dw Snare4    ; d#
	dw Drum05    ; e
	dw Triangle1 ; f
	dw Triangle2 ; f#
	dw HiHat1    ; g
	dw Snare5    ; g#
	dw Snare6    ; a
	dw Snare7    ; a#
	dw HiHat2    ; b
Drumkit1:
	dw Drum00
	dw HiHat1
	dw Snare5
	dw Snare6
	dw Snare7
	dw HiHat2
	dw HiHat3
	dw Snare8
	dw Triangle3
	dw Triangle4
	dw Snare9
	dw Snare10
	dw Snare11
Drumkit2:
	dw Drum00
	dw Snare1
	dw Snare9
	dw Snare10
	dw Snare11
	dw Drum05
	dw Triangle1
	dw Triangle2
	dw HiHat1
	dw Snare5
	dw Snare6
	dw Snare7
	dw HiHat2
Drumkit3:
	dw Drum21
	dw Snare12
	dw Snare13
	dw Snare14
	dw Kick1
	dw Triangle5
	dw Drum20
	dw Drum27
	dw Drum28
	dw Drum29
	dw Drum21
	dw Kick2
	dw Crash2
Drumkit4:
	dw Drum21
	dw Drum20
	dw Snare13
	dw Snare14
	dw Kick1
	dw Drum33
	dw Triangle5
	dw Drum35
	dw Drum31
	dw Drum32
	dw Drum36
	dw Kick2
	dw Crash1
Drumkit5:
	dw Drum00
	dw Snare9
	dw Snare10
	dw Snare11
	dw Drum27
	dw Drum28
	dw Drum29
	dw Drum05
	dw Triangle1
	dw Crash1
	dw Snare14
	dw Snare13
	dw Kick2

Drum00:
; unused
	noise_note 32, 1, 1, 0
	endchannel

Snare1:
	noise_note 32, 12, 1, 51
	endchannel

Snare2:
	noise_note 32, 11, 1, 51
	endchannel

Snare3:
	noise_note 32, 10, 1, 51
	endchannel

Snare4:
	noise_note 32, 8, 1, 51
	endchannel

Drum05:
	noise_note 39, 8, 4, 55
	noise_note 38, 8, 4, 54
	noise_note 37, 8, 3, 53
	noise_note 36, 8, 3, 52
	noise_note 35, 8, 2, 51
	noise_note 34, 8, 1, 50
	endchannel

Triangle1:
	noise_note 32, 5, 1, 42
	endchannel

Triangle2:
	noise_note 33, 4, 1, 43
	noise_note 32, 6, 1, 42
	endchannel

HiHat1:
	noise_note 32, 8, 1, 16
	endchannel

Snare5:
	noise_note 32, 8, 2, 35
	endchannel

Snare6:
	noise_note 32, 8, 2, 37
	endchannel

Snare7:
	noise_note 32, 8, 2, 38
	endchannel

HiHat2:
	noise_note 32, 10, 1, 16
	endchannel

HiHat3:
	noise_note 32, 10, 2, 17
	endchannel

Snare8:
	noise_note 32, 10, 2, 80
	endchannel

Triangle3:
	noise_note 32, 10, 1, 24
	noise_note 32, 3, 1, 51
	endchannel

Triangle4:
	noise_note 34, 9, 1, 40
	noise_note 32, 7, 1, 24
	endchannel

Snare9:
	noise_note 32, 9, 1, 34
	endchannel

Snare10:
	noise_note 32, 7, 1, 34
	endchannel

Snare11:
	noise_note 32, 6, 1, 34
	endchannel

Drum20:
	noise_note 32, 1, 1, 17
	endchannel

Drum21:
	endchannel

Snare12:
	noise_note 32, 9, 1, 51
	endchannel

Snare13:
	noise_note 32, 5, 1, 50
	endchannel

Snare14:
	noise_note 32, 8, 1, 49
	endchannel

Kick1:
	noise_note 32, 8, 8, 107
	noise_note 32, 7, 1, 0
	endchannel

Triangle5:
	noise_note 48, 9, 1, 24
	endchannel

Drum27:
	noise_note 39, 9, 2, 16
	endchannel

Drum28:
	noise_note 51, 9, 1, 0
	noise_note 51, 1, 1, 0
	endchannel

Drum29:
	noise_note 51, 9, 1, 17
	noise_note 51, 1, 1, 0
	endchannel

Crash1:
	noise_note 51, 8, 8, 21
	noise_note 32, 6, 5, 18
	endchannel

Drum31:
	noise_note 51, 5, 1, 33
	noise_note 51, 1, 1, 17
	endchannel

Drum32:
	noise_note 51, 5, 1, 80
	noise_note 51, 1, 1, 17
	endchannel

Drum33:
	noise_note 32, 10, 1, 49
	endchannel

Crash2:
	noise_note 32, 8, 4, 18
	endchannel

Drum35:
	noise_note 51, 8, 1, 0
	noise_note 51, 1, 1, 0
	endchannel

Drum36:
	noise_note 51, 8, 1, 33
	noise_note 51, 1, 1, 17
	endchannel

Kick2:
	noise_note 32, 10, 8, 107
	noise_note 32, 7, 1, 0
	endchannel
