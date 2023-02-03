SECTION "Sfx_PokeballsPlacedOnTable", ROMX

Sfx_PokeballsPlacedOnTable:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $3a
	square_note 4, 15, 2, 512
	soundinput $22
	square_note 8, 14, 2, 512
	soundinput $8
	endchannel


SECTION "Sfx_BallWiggle", ROMX

Sfx_BallWiggle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $3a
	square_note 4, 15, 2, 1024
	soundinput $22
	square_note 8, 14, 2, 1024
	soundinput $8
	endchannel


SECTION "Sfx_Potion", ROMX

Sfx_Potion:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $17
	square_note 15, 15, 0, 1264
	square_note 15, 15, 2, 1616
	soundinput $8
	endchannel


SECTION "Sfx_FullHeal", ROMX

Sfx_FullHeal:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $14
	square_note 4, 15, 2, 1536
	square_note 4, 15, 2, 1536
	soundinput $17
	square_note 15, 15, 2, 1536
	soundinput $8
	endchannel


SECTION "Sfx_Menu", ROMX

Sfx_Menu:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $e2, $33
	noise __,  9, $e1, $22
	endchannel


SECTION "Sfx_ReadText", ROMX

Sfx_ReadText:
Sfx_ReadText2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 0, 9, 1, 1984
	square_note 0, 8, 1, 2000
	square_note 0, 9, 1, 1984
	square_note 12, 10, 1, 2000
	endchannel


SECTION "Sfx_Poison", ROMX

Sfx_Poison:
	channel_count 1
	channel 5, .Ch5

.Ch5:
.loop:
	dutycycle $0
	soundinput $14
	square_note 4, 15, 2, 1536
	loopchannel 4, .loop
	square_note 15, 15, 3, 1536
	soundinput $8
	endchannel


SECTION "Sfx_GotSafariBalls", ROMX

Sfx_GotSafariBalls:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $15
	square_note 15, 15, 0, 1264
	square_note 15, 15, 2, 1616
	soundinput $8
	endchannel


SECTION "Sfx_BootPc", ROMX

Sfx_BootPc:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 15, 15, 2, 1984
	square_note 15, 0, 0, 0
	square_note 3, 10, 1, 1920
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1856
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1920
	square_note 3, 10, 1, 1792
	square_note 3, 10, 1, 1984
	square_note 8, 10, 1, 1792
	endchannel


SECTION "Sfx_ShutDownPc", ROMX

Sfx_ShutDownPc:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 4, 15, 0, 1536
	square_note 4, 15, 0, 1024
	square_note 4, 15, 0, 512
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_ChoosePcOption", ROMX

Sfx_ChoosePcOption:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 6, 15, 0, 1792
	square_note 4, 0, 0, 0
	square_note 6, 15, 0, 1792
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_EscapeRope", ROMX

Sfx_EscapeRope:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	square_note 15, 13, 7, 1536
	square_note 15, 11, 7, 1408
	square_note 15, 8, 7, 1280
	square_note 15, 4, 7, 1152
	square_note 15, 1, 7, 1024
	soundinput $8
	endchannel


SECTION "Sfx_PushButton", ROMX

Sfx_PushButton:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 4, 0, 0, 0
	square_note 2, 15, 1, 1664
	square_note 1, 0, 0, 0
	square_note 4, 15, 1, 1920
	square_note 4, 0, 0, 0
	endchannel


SECTION "Sfx_SecondPartOfItemfinder", ROMX

Sfx_SecondPartOfItemfinder:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $2c
	square_note 4, 15, 2, 1280
	soundinput $22
	square_note 2, 15, 1, 1280
	soundinput $8
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_WarpTo", ROMX

Sfx_WarpTo:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	square_note 15, 13, 7, 1280
	square_note 15, 11, 7, 1408
	square_note 15, 8, 7, 1536
	square_note 15, 4, 7, 1664
	square_note 15, 1, 7, 1792
	soundinput $8
	endchannel


SECTION "Sfx_WarpFrom", ROMX

Sfx_WarpFrom:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	square_note 15, 13, 7, 1792
	square_note 15, 11, 7, 1664
	square_note 15, 8, 7, 1536
	square_note 15, 4, 7, 1408
	square_note 15, 1, 7, 1280
	soundinput $8
	endchannel


SECTION "Sfx_ChangeDexMode", ROMX

Sfx_ChangeDexMode:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $16
	square_note 15, 13, 2, 1280
	soundinput $8
	endchannel


SECTION "Sfx_JumpOverLedge", ROMX

Sfx_JumpOverLedge:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $95
	square_note 15, 15, 2, 1024
	soundinput $8
	endchannel


SECTION "Sfx_GrassRustle", ROMX

Sfx_GrassRustle:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f1, $32
	noise __,  3, $0, $0
	noise __,  3, $f1, $22
	noise __,  2, $0, $0
	endchannel


SECTION "Sfx_Fly", ROMX

Sfx_Fly:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f1, $12
	noise __,  3, $0, $0
	noise __,  3, $a1, $12
	noise __,  3, $0, $0
	noise __,  3, $d1, $12
	noise __,  3, $0, $0
	noise __,  3, $81, $12
	noise __,  3, $0, $0
	noise __,  3, $b1, $12
	noise __,  3, $0, $0
	noise __,  3, $61, $12
	noise __,  3, $0, $0
	noise __,  3, $91, $12
	noise __,  3, $0, $0
	noise __,  3, $41, $12
	noise __,  3, $0, $0
	endchannel


SECTION "Sfx_Wrong", ROMX

Sfx_Wrong:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $3
	soundinput $5a
	square_note 4, 15, 0, 1280
	soundinput $8
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1280
	square_note 1, 0, 0, 0
	endchannel

.Ch6:
	dutycycle $3
	square_note 4, 15, 0, 1025
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1025
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_Squeak", ROMX

Sfx_Squeak:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $17
	square_note 15, 13, 2, 1792
	soundinput $8
	endchannel


SECTION "Sfx_Strength", ROMX

Sfx_Strength:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $a2, $23
	noise __,  9, $f1, $34
	noise __, 16, $0, $0
	noise __,  3, $f7, $24
	noise __,  3, $f7, $34
	noise __,  5, $f7, $44
	noise __,  9, $f4, $55
	noise __,  9, $f1, $44
	endchannel


SECTION "Sfx_Boat", ROMX

Sfx_Boat:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 15, 15, 0, 1280
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 2, 1280
	endchannel

.Ch6:
	dutycycle $3
	square_note 15, 15, 0, 1154
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1154
	square_note 15, 15, 0, 1154
	square_note 15, 15, 0, 1154
	square_note 15, 15, 0, 1154
	square_note 15, 15, 2, 1154
	endchannel


SECTION "Sfx_WallOpen", ROMX

Sfx_WallOpen:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $3a
	square_note 4, 15, 2, 1280
	soundinput $22
	square_note 4, 14, 2, 1280
	soundinput $3a
	square_note 4, 15, 2, 1792
	soundinput $22
	square_note 15, 14, 2, 1792
	soundinput $8
	endchannel


SECTION "Sfx_PlacePuzzlePieceDown", ROMX

Sfx_PlacePuzzlePieceDown:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f7, $24
	noise __,  3, $f7, $34
	noise __,  5, $f7, $44
	noise __,  9, $f4, $55
	noise __,  9, $f1, $44
	endchannel


SECTION "Sfx_EnterDoor", ROMX

Sfx_EnterDoor:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 10, $f1, $44
	noise __,  9, $d1, $43
	endchannel


SECTION "Sfx_SwitchPokemon", ROMX

Sfx_SwitchPokemon:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 8, 14, 1, 1856
	endchannel

.Ch6:
	dutycycle $2
	square_note 2, 0, 8, 0
	square_note 8, 11, 1, 1857
	endchannel


SECTION "Sfx_Tally", ROMX

Sfx_Tally:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 4, 15, 1, 1920
	endchannel

.Ch6:
	dutycycle $2
	square_note 1, 0, 8, 0
	square_note 4, 10, 1, 1889
	endchannel


SECTION "Sfx_Transaction", ROMX

Sfx_Transaction:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 4, 14, 1, 1792
	square_note 24, 15, 2, 2016
	endchannel

.Ch6:
	dutycycle $2
	square_note 1, 0, 8, 0
	square_note 4, 9, 1, 1729
	square_note 24, 10, 2, 1953
	endchannel


SECTION "Sfx_Bump", ROMX

Sfx_Bump:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $5a
	square_note 15, 15, 1, 768
	soundinput $8
	endchannel


SECTION "Sfx_ExitBuilding", ROMX

Sfx_ExitBuilding:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f1, $54
	noise __, 13, $71, $23
	noise __,  3, $b1, $54
	noise __, 13, $61, $23
	noise __,  7, $41, $54
	endchannel


SECTION "Sfx_Save", ROMX

Sfx_Save:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 2, 15, 1, 1792
	square_note 1, 14, 1, 1536
	square_note 1, 14, 1, 1664
	square_note 1, 14, 1, 1728
	square_note 2, 14, 1, 1792
	square_note 2, 14, 1, 1984
	square_note 15, 15, 2, 2016
	endchannel

.Ch6:
	dutycycle $2
	square_note 2, 0, 8, 0
	square_note 2, 10, 1, 1793
	square_note 1, 9, 1, 1537
	square_note 1, 9, 1, 1665
	square_note 1, 9, 1, 1729
	square_note 2, 9, 1, 1793
	square_note 2, 9, 1, 1985
	square_note 15, 13, 2, 2017
	endchannel


SECTION "Sfx_Pokeflute", ROMX

Sfx_Pokeflute:
	channel_count 1
	channel 7, .Ch7

.Ch7:
	tempo 256
	volume 7, 7
	togglesfx
	vibrato $10, $14
	notetype $c, $10
	octave 5
	note E_, 2
	note F_, 2
	note G_, 4
	note A_, 2
	note G_, 2
	octave 6
	note C_, 4
	note C_, 2
	note D_, 2
	note C_, 2
	octave 5
	note G_, 2
	note A_, 2
	note F_, 2
	note G_, 8
	note __, 12
	endchannel


SECTION "Sfx_ElevatorEnd", ROMX

Sfx_ElevatorEnd:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 15, 15, 3, 1840
	square_note 8, 6, 5, 1840
	square_note 15, 15, 4, 1792
	square_note 15, 7, 4, 1792
	square_note 15, 4, 4, 1792
	square_note 15, 2, 4, 1792
	endchannel


SECTION "Sfx_ThrowBall", ROMX

Sfx_ThrowBall:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $2f
	square_note 15, 15, 2, 1920
	endchannel

.Ch6:
	dutycycle $2
	square_note 15, 12, 2, 1922
	endchannel


SECTION "Sfx_BallPoof", ROMX

Sfx_BallPoof:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $16
	square_note 15, 15, 2, 1024
	soundinput $8
	endchannel

.Ch8:
	noise __, 16, $a2, $22
	endchannel


SECTION "Sfx_Faint", ROMX

Sfx_Faint:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	square_note 15, 13, 1, 512
	soundinput $8
	endchannel

.Ch8:
	noise __,  5, $f5, $33
	noise __,  9, $f4, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_Run", ROMX

Sfx_Run:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $61, $23
	noise __,  3, $a1, $33
	noise __,  3, $c1, $33
	noise __,  3, $51, $11
	noise __,  3, $f1, $33
	noise __,  3, $41, $11
	noise __,  3, $c1, $33
	noise __,  3, $31, $11
	noise __,  3, $81, $33
	noise __,  3, $31, $11
	noise __,  9, $41, $33
	endchannel


SECTION "Sfx_SlotMachineStart", ROMX

Sfx_SlotMachineStart:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $44
	square_note 15, 15, 0, 1264
	soundinput $17
	square_note 15, 15, 2, 1616
	soundinput $8
	endchannel

.Ch6:
	dutycycle $2
	square_note 15, 9, 2, 1536
	square_note 15, 9, 2, 1922
	endchannel


SECTION "Sfx_Call", ROMX

Sfx_Call:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	soundinput $67
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	soundinput $8
	square_note 4, 0, 0, 0
	endchannel


SECTION "Sfx_Unknown60", ROMX

Sfx_Unknown60:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  7, $20, $10
	noise __,  7, $2f, $40
	noise __,  7, $4f, $41
	noise __,  7, $8f, $41
	noise __,  7, $cf, $42
	noise __,  9, $d7, $42
	noise __, 16, $e7, $43
	noise __, 16, $f2, $43
	endchannel


SECTION "Sfx_Unknown61", ROMX

Sfx_Unknown61:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $d1, $41
	endchannel


SECTION "Sfx_SwitchPockets", ROMX

Sfx_SwitchPockets:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $c1, $42
	endchannel


SECTION "Sfx_Unknown63", ROMX

Sfx_Unknown63:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $6f, $21
	noise __,  3, $af, $31
	noise __, 16, $f2, $41
	endchannel


SECTION "Sfx_Burn", ROMX

Sfx_Burn:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $d2, $32
	noise __, 16, $f2, $43
	endchannel


SECTION "Sfx_TitleScreenEntrance", ROMX

Sfx_TitleScreenEntrance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $70, $22
	noise __,  3, $80, $23
	noise __,  3, $90, $24
	noise __,  3, $a0, $25
	noise __,  3, $b0, $26
	noise __, 16, $c2, $26
	endchannel


SECTION "Sfx_Unknown66", ROMX

Sfx_Unknown66:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 1, 15, 2, 1696
	square_note 1, 15, 2, 1760
	square_note 8, 15, 1, 1792
	endchannel


SECTION "Sfx_GetCoinFromSlots", ROMX

Sfx_GetCoinFromSlots:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 2, 15, 1, 1792
	square_note 8, 8, 1, 2016
	endchannel


SECTION "Sfx_PayDay", ROMX

Sfx_PayDay:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $3
	square_note 5, 14, 1, 1792
	square_note 2, 14, 1, 1920
	square_note 15, 15, 1, 1984
	endchannel

.Ch6:
	dutycycle $2
	square_note 4, 12, 1, 1729
	square_note 2, 12, 1, 1857
	square_note 15, 13, 1, 1921
	endchannel


SECTION "Sfx_Metronome", ROMX

Sfx_Metronome:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $5f
	square_note 4, 4, 0, 2016
	square_note 4, 6, 0, 2016
	square_note 4, 8, 0, 2016
	square_note 8, 10, 0, 2016
	square_note 8, 10, 0, 2016
	square_note 8, 8, 0, 2016
	square_note 8, 6, 0, 2016
	square_note 8, 3, 0, 2016
	square_note 15, 1, 2, 2016
	soundinput $8
	endchannel


SECTION "Sfx_Peck", ROMX

Sfx_Peck:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $a1, $12
	endchannel


SECTION "Sfx_Kinesis", ROMX

Sfx_Kinesis:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $af
	square_note 15, 15, 2, 1920
	soundinput $8
	endchannel


SECTION "Sfx_Lick", ROMX

Sfx_Lick:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $97
	square_note 15, 15, 2, 1280
	soundinput $8
	endchannel


SECTION "Sfx_Pound", ROMX

Sfx_Pound:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $a1, $22
	endchannel


SECTION "Sfx_MovePuzzlePiece", ROMX

Sfx_MovePuzzlePiece:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  9, $f1, $54
	endchannel


SECTION "Sfx_CometPunch", ROMX

Sfx_CometPunch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 16, $8f, $11
	noise __,  5, $ff, $12
	noise __, 11, $f1, $55
	endchannel


SECTION "Sfx_MegaPunch", ROMX

Sfx_MegaPunch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 16, $8f, $34
	noise __,  9, $f2, $35
	noise __, 11, $f1, $55
	endchannel


SECTION "Sfx_Scratch", ROMX

Sfx_Scratch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 16, $9f, $23
	noise __,  9, $f1, $21
	endchannel


SECTION "Sfx_Vicegrip", ROMX

Sfx_Vicegrip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $e1, $4b
	noise __, 11, $f1, $44
	noise __,  3, $e1, $3a
	noise __,  7, $f1, $34
	endchannel


SECTION "Sfx_RazorWind", ROMX

Sfx_RazorWind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f4, $44
	noise __,  3, $f4, $14
	noise __, 16, $f1, $32
	endchannel


SECTION "Sfx_Cut", ROMX

Sfx_Cut:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $8f, $55
	noise __,  3, $f4, $44
	noise __,  9, $f4, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_WingAttack", ROMX

Sfx_WingAttack:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise __,  9, $4f, $23
	noise __,  5, $c4, $22
	noise __,  7, $f2, $23
	loopchannel 4, .branch8
	endchannel


SECTION "Sfx_Whirlwind", ROMX

Sfx_Whirlwind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  9, $4f, $33
	noise __,  5, $c4, $22
	noise __,  7, $f2, $23
	noise __, 16, $f2, $22
	endchannel


SECTION "Sfx_Bind", ROMX

Sfx_Bind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  9, $ff, $32
	noise __,  9, $f4, $43
	noise __,  9, $f2, $54
	noise __,  9, $f1, $65
	endchannel


SECTION "Sfx_VineWhip", ROMX

Sfx_VineWhip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $c2, $33
	noise __,  3, $f2, $21
	noise __,  2, $e2, $33
	noise __,  2, $c2, $32
	noise __,  2, $92, $12
	noise __,  2, $b2, $31
	noise __, 13, $91, $10
	noise __,  9, $f2, $41
	endchannel


SECTION "Sfx_DoubleKick", ROMX

Sfx_DoubleKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $94, $23
	noise __,  2, $b4, $22
	noise __,  9, $f1, $44
	endchannel


SECTION "Sfx_MegaKick", ROMX

Sfx_MegaKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $94, $33
	noise __,  5, $b4, $22
	noise __,  5, $f1, $44
	noise __,  9, $f1, $55
	endchannel


SECTION "Sfx_Headbutt", ROMX

Sfx_Headbutt:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $ff, $55
	noise __,  9, $f1, $65
	endchannel


SECTION "Sfx_HornAttack", ROMX

Sfx_HornAttack:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $84, $43
	noise __,  3, $c4, $22
	noise __,  9, $f2, $34
	endchannel


SECTION "Sfx_Tackle", ROMX

Sfx_Tackle:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $f1, $34
	noise __, 16, $f2, $64
	endchannel


SECTION "Sfx_PoisonSting", ROMX

Sfx_PoisonSting:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f1, $22
	noise __, 16, $f2, $12
	endchannel


SECTION "Sfx_Powder", ROMX

Sfx_Powder:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $c2, $1
	noise __, 16, $f4, $1
	noise __, 16, $f2, $1
	endchannel


SECTION "Sfx_DoubleSlap", ROMX

Sfx_DoubleSlap:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  9, $f1, $32
	noise __,  9, $f1, $33
	endchannel


SECTION "Sfx_Bite", ROMX

Sfx_Bite:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $0
	soundinput $3a
	square_note 4, 15, 2, 512
	soundinput $22
	square_note 8, 14, 2, 512
	soundinput $8
	endchannel

.Ch8:
	noise __,  1, $d1, $42
	noise __,  5, $a1, $32
	noise __,  1, $d1, $22
	noise __,  7, $a1, $32
	endchannel


SECTION "Sfx_JumpKick", ROMX

Sfx_JumpKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  4, $92, $31
	noise __,  4, $b2, $32
	noise __,  4, $c2, $33
	noise __,  9, $f1, $54
	endchannel


SECTION "Sfx_Stomp", ROMX

Sfx_Stomp:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 13, $f1, $54
	noise __,  9, $f1, $64
	endchannel


SECTION "Sfx_TailWhip", ROMX

Sfx_TailWhip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f1, $33
	noise __,  3, $c1, $32
	noise __,  3, $a1, $31
	noise __, 16, $82, $32
	noise __,  9, $f1, $34
	endchannel


SECTION "Sfx_KarateChop", ROMX

Sfx_KarateChop:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $d2, $32
	noise __, 16, $f2, $43
	endchannel


SECTION "Sfx_Submission", ROMX

Sfx_Submission:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $f2, $43
	noise __,  5, $b5, $32
	noise __, 10, $86, $31
	noise __,  8, $64, $0
	noise __, 16, $f2, $55
	endchannel


SECTION "Sfx_WaterGun", ROMX

Sfx_WaterGun:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $1
	soundinput $97
	square_note 15, 15, 2, 1792
	soundinput $8
	endchannel

.Ch8:
	noise __, 16, $3f, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_SwordsDance", ROMX

Sfx_SwordsDance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 16, $4f, $41
	noise __,  9, $8f, $41
	noise __,  9, $cf, $41
	noise __,  9, $f2, $42
	noise __, 16, $f2, $41
	endchannel


SECTION "Sfx_Thunder", ROMX

Sfx_Thunder:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 11, $ff, $50
	noise __, 16, $ff, $51
	noise __,  9, $f2, $51
	noise __,  7, $ff, $52
	noise __,  7, $ff, $53
	noise __,  9, $ff, $54
	noise __, 16, $f2, $54
	endchannel


SECTION "Sfx_Supersonic", ROMX

Sfx_Supersonic:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	square_note 15, 3, -7, 1984
.branch5:
	square_note 15, 13, -7, 1984
	loopchannel 4, .branch5
	square_note 15, 13, 1, 1984
	endchannel

.Ch6:
	sound_duty 3, 0, 3, 2
	square_note 15, 2, -7, 1992
.branch6:
	square_note 15, 12, -7, 1991
	loopchannel 4, .branch6
	square_note 15, 12, 1, 1992
	endchannel

.Ch8:
.branch8:
	noise __,  4, $97, $12
	noise __,  4, $a1, $11
	loopchannel 10, .branch8
	endchannel


SECTION "Sfx_Leer", ROMX

Sfx_Leer:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	dutycycle $0
	square_note 0, 15, 1, 1984
	square_note 0, 15, 1, 1792
	loopchannel 12, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	square_note 0, 14, 1, 1985
	square_note 0, 14, 1, 1793
	loopchannel 12, .branch6
	endchannel

.Ch8:
.branch8:
	noise __,  2, $d1, $49
	noise __,  2, $d1, $29
	loopchannel 6, .branch8
	endchannel


SECTION "Sfx_Ember", ROMX

Sfx_Ember:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 0, 3
	square_note 11, 15, 3, 288
	square_note 9, 13, 3, 336
	loopchannel 5, .branch5
	square_note 8, 14, 3, 304
	square_note 15, 12, 2, 272
	endchannel

.Ch8:
.branch8:
	noise __, 11, $f3, $35
	noise __, 15, $f6, $45
	loopchannel 4, .branch8
	noise __, 13, $f4, $bc
	noise __, 13, $f5, $9c
	noise __, 16, $f4, $ac
	endchannel


SECTION "Sfx_BubbleBeam", ROMX

Sfx_BubbleBeam:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 3, 0
	square_note 4, 15, 4, 1536
	square_note 3, 12, 4, 1280
	square_note 5, 11, 5, 1536
	square_note 13, 14, 2, 1728
	loopchannel 3, .branch5
	square_note 8, 13, 1, 1536
	endchannel

.Ch6:
.branch6:
	sound_duty 1, 3, 0, 2
	square_note 5, 14, 4, 1504
	square_note 4, 11, 4, 1248
	square_note 6, 10, 5, 1512
	square_note 14, 13, 1, 1696
	loopchannel 3, .branch6
	endchannel

.Ch8:
.branch8:
	noise __,  6, $c3, $33
	noise __,  4, $92, $43
	noise __, 11, $b5, $33
	noise __, 16, $c3, $32
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_HydroPump", ROMX

Sfx_HydroPump:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 2, 0, 1, 3
	square_note 3, 8, 1, 768
	square_note 3, 12, 1, 1024
	square_note 3, 15, 1, 1280
	square_note 3, 11, 1, 1024
	square_note 3, 7, 1, 768
	loopchannel 5, .branch5
	square_note 8, 8, 1, 1024
	endchannel

.Ch8:
.branch8:
	noise __,  4, $62, $22
	noise __,  4, $a2, $32
	noise __,  4, $d2, $33
	noise __,  4, $92, $23
	noise __,  4, $52, $12
	loopchannel 5, .branch8
	noise __,  9, $81, $12
	endchannel


SECTION "Sfx_Surf", ROMX

Sfx_Surf:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 3, 0
	square_note 15, 15, 4, 1280
	square_note 15, 12, 4, 1024
	square_note 15, 14, 2, 1472
	loopchannel 3, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 1, 3, 0, 2
	square_note 7, 14, 4, 1072
	square_note 15, 11, 4, 816
	square_note 15, 10, 2, 1080
	loopchannel 4, .branch6
	endchannel

.Ch8:
.branch8:
	noise __, 10, $f4, $44
	noise __, 10, $f2, $43
	noise __, 16, $f4, $42
	noise __, 16, $f4, $41
	loopchannel 3, .branch8
	endchannel


SECTION "Sfx_Psybeam", ROMX

Sfx_Psybeam:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 0, 2, 2
	square_note 10, 15, 1, 1600
	square_note 10, 15, 3, 1664
	square_note 10, 15, 2, 1568
	loopchannel 4, .branch5
	square_note 10, 15, 1, 1600
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	square_note 10, 15, 3, 1393
	square_note 7, 14, 3, 1329
	square_note 10, 15, 1, 1361
	loopchannel 4, .branch6
	square_note 10, 15, 1, 1393
	endchannel

.Ch8:
.branch8:
	noise __,  3, $d1, $4a
	noise __,  3, $d2, $2a
	loopchannel 21, .branch8
	endchannel


SECTION "Sfx_Charge", ROMX

Sfx_Charge:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	dutycycle $0
	square_note 2, 15, 1, 512
	square_note 3, 15, 1, 1792
	square_note 4, 15, 1, 1280
	square_note 5, 15, 1, 2032
	loopchannel 8, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	square_note 2, 14, 1, 770
	square_note 3, 14, 1, 2034
	square_note 4, 14, 1, 1538
	square_note 5, 14, 1, 1794
	loopchannel 8, .branch6
	endchannel

.Ch8:
.branch8:
	noise __,  3, $d3, $10
	noise __,  4, $d3, $11
	noise __,  3, $d2, $10
	noise __,  6, $d2, $12
	loopchannel 9, .branch8
	endchannel


SECTION "Sfx_Thundershock", ROMX

Sfx_Thundershock:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
.branch5:
	sound_duty 3, 2, 2, 0
	square_note 3, 15, 1, 2032
	square_note 4, 15, 2, 512
	loopchannel 8, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	square_note 4, 14, 2, 514
	square_note 4, 14, 1, 2018
	loopchannel 9, .branch6
	endchannel

.Ch8:
.branch8:
	noise __,  5, $ff, $43
	noise __,  5, $f2, $44
	loopchannel 9, .branch8
	endchannel


SECTION "Sfx_Psychic", ROMX

Sfx_Psychic:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $f7
	square_note 8, 12, 4, 1981
	square_note 8, 12, 4, 1982
	square_note 8, 12, 4, 1983
	square_note 8, 12, 4, 1984
	square_note 15, 12, 4, 1985
	square_note 15, 15, 2, 1984
	soundinput $8
	endchannel

.Ch6:
	dutycycle $2
	square_note 8, 12, 4, 1904
	square_note 8, 12, 4, 1889
	square_note 8, 12, 4, 1890
	square_note 8, 12, 4, 1891
	square_note 15, 12, 4, 1892
	square_note 15, 15, 2, 1892
	endchannel

.Ch8:
	noise __, 16, $3f, $14
	noise __, 16, $cf, $13
	noise __, 16, $cf, $12
	noise __, 16, $cf, $11
	noise __, 16, $cf, $10
	noise __, 16, $c2, $10
	endchannel


SECTION "Sfx_Screech", ROMX

Sfx_Screech:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, 2, 2016
	endchannel

.Ch6:
	dutycycle $3
	square_note 15, 15, -7, 2018
	square_note 15, 15, -7, 2017
	square_note 15, 15, -7, 2018
	square_note 15, 15, -7, 2017
	square_note 15, 15, 2, 2018
	endchannel


SECTION "Sfx_BoneClub", ROMX

Sfx_BoneClub:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $af
	square_note 8, 15, 1, 1792
	soundinput $8
	endchannel

.Ch6:
	dutycycle $3
	square_note 8, 15, 1, 1793
	endchannel


SECTION "Sfx_Sharpen", ROMX

Sfx_Sharpen:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 6, 15, 1, 1280
	square_note 6, 15, 1, 1408
	square_note 6, 15, 1, 1536
	square_note 6, 15, 1, 1664
	square_note 8, 15, 1, 1792
	endchannel

.Ch6:
	dutycycle $3
	square_note 6, 14, 1, 1296
	square_note 6, 14, 1, 1424
	square_note 6, 14, 1, 1552
	square_note 6, 14, 1, 1680
	square_note 8, 14, 1, 1808
	endchannel


SECTION "Sfx_EggBomb", ROMX

Sfx_EggBomb:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	sound_duty 1, 3, 2, 3
	square_note 8, 15, -7, 1016
	square_note 15, 15, -7, 1024
	square_note 15, 15, 3, 1024
	endchannel

.Ch6:
	sound_duty 0, 1, 3, 2
	square_note 8, 14, -7, 960
	square_note 15, 14, -7, 960
	square_note 15, 14, 3, 960
	endchannel

.Ch8:
	noise __,  5, $ff, $51
	noise __,  9, $ff, $54
	noise __, 16, $ff, $55
	noise __, 16, $f3, $56
	endchannel


SECTION "Sfx_Sing", ROMX

Sfx_Sing:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	togglesfx
	vibrato $a, $24
	dutycycle $2
	notetype $a, $87
	octave 5
	note G_, 8
	octave 6
	note F_, 4
	note D#, 4
	octave 5
	note G_, 8
	endchannel

.Ch6:
	togglesfx
	vibrato $a, $23
	dutycycle $2
	notetype $b, $67
	octave 5
	note G_, 8
	notetype $a, $67
	octave 6
	note F_, 4
	note D#, 4
	octave 5
	note G_, 8
	endchannel


SECTION "Sfx_HyperBeam", ROMX

Sfx_HyperBeam:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	dutycycle $0
	square_note 2, 15, 1, 1920
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 1936
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 1952
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 1968
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 1984
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 2000
.branch5:
	square_note 2, 15, 1, 1792
	square_note 2, 15, 1, 2016
	loopchannel 12, .branch5
	square_note 15, 15, 1, 1792
	endchannel

.Ch6:
	sound_duty 3, 0, 3, 2
	square_note 2, 15, 1, 1921
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 1937
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 1953
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 1969
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 1985
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 2001
.branch6:
	square_note 2, 15, 1, 1793
	square_note 2, 15, 1, 2017
	loopchannel 12, .branch6
	square_note 15, 15, 1, 1793
	endchannel

.Ch8:
.branch8:
	noise __,  2, $d1, $49
	noise __,  2, $d1, $29
	loopchannel 26, .branch8
	endchannel


SECTION "Sfx_Shine", ROMX

Sfx_Shine:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	square_note 0, 13, 2, 1792
	square_note 0, 13, 2, 1856
	square_note 0, 13, 2, 1920
	square_note 0, 13, 2, 1984
	square_note 10, 14, 1, 2016
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_Unknown5F", ROMX

Sfx_Unknown5F:
	channel_count 3
	channel 5, Sfx_Unknown5F_Ch5
	channel 6, Sfx_Unknown5F_Ch6
Sfx_Sandstorm:
	channel_count 1
	channel 8, Sfx_Sandstorm_Ch8

Sfx_Unknown5F_Ch5:
.branch5:
	square_note 2, 15, 7, 1537
	square_note 2, 15, 7, 1793
	loopchannel 8, .branch5
	endchannel

Sfx_Unknown5F_Ch6:
	square_note 1, 15, 7, 65535
	square_note 2, 15, 7, 1538
	square_note 2, 15, 7, 1794
	loopchannel 8, Sfx_Unknown5F_Ch5.branch5
	endchannel

Sfx_Sandstorm_Ch8:
.branch8:
	noise __,  2, $f8, $41
	noise __,  3, $9c, $24
	noise __,  1, $0, $0
	noise __,  4, $59, $16
	noise __,  3, $0, $0
	loopchannel 3, .branch8
	endchannel


SECTION "Sfx_HangUp", ROMX

Sfx_HangUp:
	channel_count 1
	channel 5, Sfx_HangUp_Ch5

Sfx_NoSignal:
	channel_count 1
	channel 5, Sfx_NoSignal_Ch5

Sfx_HangUp_Ch5:
	dutycycle $2
	square_note 4, 11, 8, 1915
	square_note 2, 2, 1, 1915
	square_note 16, 0, 0, 0
Sfx_NoSignal_Ch5:
.branch5:
	dutycycle $2
	square_note 20, 14, 8, 1803
	square_note 28, 0, 0, 0
	loopchannel 3, .branch5
	endchannel


SECTION "Sfx_Elevator", ROMX

Sfx_Elevator:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $5a
.branch5:
	square_note 2, 15, 1, 768
	loopchannel 48, .branch5
	soundinput $8
	dutycycle $2
	square_note 15, 15, 3, 1840
	square_note 8, 6, 5, 1840
	square_note 15, 15, 4, 1792
	square_note 15, 7, 4, 1792
	square_note 15, 4, 4, 1792
	square_note 15, 2, 4, 1792
	endchannel

.Ch6:
.Ch7:
	square_note 96, 0, 0, 0
	square_note 83, 0, 0, 0
	endchannel

.Ch8:
	noise F_,  1, $0, $0
	noise E_,  4, $0, $0
	endchannel


SECTION "Sfx_LevelUp", ROMX

Sfx_LevelUp:
Sfx_DexFanfare5079:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	dutycycle $2
	notetype $8, $b1
	octave 3
	note B_, 2
	note B_, 2
	note B_, 2
	intensity $b3
	octave 4
	note G#, 12
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $8, $c1
	octave 4
	note E_, 2
	note E_, 2
	note E_, 2
	intensity $c3
	note B_, 12
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 5
	note E_, 5
	intensity $35
	note E_, 3
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 12
	endchannel


SECTION "Sfx_KeyItem", ROMX

Sfx_KeyItem:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	dutycycle $2
	notetype $6, $b1
	octave 3
	note B_, 4
	note B_, 2
	note B_, 2
	note B_, 4
	octave 4
	note E_, 4
	intensity $b3
	note G#, 16
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $6, $c1
	octave 4
	note E_, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note G#, 4
	intensity $c3
	note B_, 16
	endchannel

.Ch7:
	togglesfx
	notetype $6, $25
	octave 4
	note G#, 2
	note __, 2
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 2
	note __, 2
	note B_, 2
	note __, 2
	octave 5
	note E_, 8
	intensity $35
	note E_, 4
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	endchannel


SECTION "Sfx_DexFanfare2049", ROMX

Sfx_DexFanfare2049:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 104
	volume 7, 7
	dutycycle $2
	notetype $c, $88
	octave 3
	note A_, 4
	note __, 2
	note A_, 1
	note __, 1
	note A#, 4
	note __, 2
	note A#, 1
	note __, 1
	octave 4
	note C_, 2
	note __, 2
	octave 3
	note A#, 2
	note __, 2
	note A_, 2
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $c, $c1
	octave 5
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 4
	note A#, 2
	octave 5
	note C_, 2
	note D_, 2
	note E_, 2
	note F_, 4
	note G_, 4
	note F_, 8
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	octave 4
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note A_, 2
	note __, 2
	note E_, 2
	note __, 2
	note F_, 2
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	note __, 16
	endchannel


SECTION "Sfx_Item", ROMX

Sfx_Item:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 108
	volume 7, 7
	vibrato $8, $27
	dutycycle $2
	notetype $8, $b2
	octave 4
	note C_, 6
	note C_, 2
	note F_, 2
	note C_, 2
	note G_, 4
	note G_, 4
	note G_, 4
	note F_, 12
	note __, 12
	endchannel

.Ch6:
	togglesfx
	vibrato $8, $27
	dutycycle $2
	notetype $8, $c3
	octave 4
	note A_, 6
	note A_, 2
	note A_, 2
	note A_, 2
	note A#, 4
	note A#, 4
	note A#, 4
	note A_, 12
	note __, 12
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 4
	note F_, 4
	note __, 2
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	note D#, 2
	note __, 2
	note D#, 2
	note __, 2
	note E_, 2
	note __, 2
	note F_, 6
	intensity $35
	note F_, 4
	note __, 14
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	note __, 16
	endchannel


SECTION "Sfx_CaughtMon", ROMX

Sfx_CaughtMon:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume 7, 7
	vibrato $8, $27
	dutycycle $2
	notetype $8, $b3
	octave 4
	note C_, 6
	octave 3
	note A_, 6
	note F_, 12
	intensity $b1
	octave 4
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note G_, 2
	intensity $b3
	note F_, 12
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	vibrato $8, $27
	notetype $8, $c3
	octave 4
	note A_, 6
	note F_, 6
	note C_, 12
	intensity $c1
	note A#, 2
	note A#, 2
	note A#, 2
	note G_, 2
	note G_, 2
	note A#, 2
	intensity $c3
	note A_, 12
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note C_, 12
	note C_, 6
	octave 2
	note A_, 2
	octave 3
	note C_, 2
	note F_, 2
	note G_, 6
	note A#, 6
	note A_, 6
	intensity $35
	note A_, 3
	note __, 3
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	note __, 16
	endchannel


SECTION "Sfx_DexFanfare80109", ROMX

Sfx_DexFanfare80109:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume 7, 7
	vibrato $8, $27
	dutycycle $2
	notetype $c, $b1
	octave 4
	note D#, 2
	note D#, 1
	note D#, 1
	octave 3
	note A#, 2
	note A#, 1
	note A#, 1
	octave 4
	note D#, 2
	note D#, 1
	note D#, 1
	note F_, 2
	note F_, 1
	note F_, 1
	intensity $a5
	note A#, 16
	endchannel

.Ch6:
	togglesfx
	vibrato $8, $27
	dutycycle $2
	notetype $c, $c1
	octave 4
	note G_, 2
	note G_, 1
	note G_, 1
	note D#, 2
	note D#, 1
	note D#, 1
	note G#, 2
	note G#, 1
	note G#, 1
	note A#, 2
	note A#, 1
	note A#, 1
	intensity $b5
	octave 5
	note D#, 16
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	octave 4
	note D#, 1
	note __, 1
	octave 3
	note A#, 2
	octave 4
	note D#, 1
	note __, 1
	octave 3
	note A#, 2
	octave 4
	note D#, 1
	note __, 1
	note C_, 2
	note D_, 1
	note __, 1
	octave 3
	note A#, 2
	note D#, 4
	intensity $35
	note D#, 3
	note __, 9
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	note __, 16
	endchannel


SECTION "Sfx_Fanfare2", ROMX

Sfx_Fanfare2:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	togglesfx
	sfxpriorityon
	tempo 256
	volume 7, 7
	tone $0001
	dutycycle $3
	notetype $6, $b5
	octave 3
	note G#, 4
	notetype $4, $b2
	note F_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note F#, 2
	note A#, 2
	octave 4
	note C_, 4
	note C_, 2
	notetype $4, $b6
	note C#, 12
	sfxpriorityoff
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $6, $c5
	octave 4
	note C#, 6
	notetype $4, $c1
	note C#, 1
	note C#, 1
	note C#, 1
	notetype $4, $c2
	note D#, 2
	note C#, 2
	note D#, 2
	note E_, 4
	note E_, 2
	notetype $4, $c6
	note F_, 12
	endchannel

.Ch8:
	togglesfx
	notetype $6
	note C_, 1
	octave 5
	note C#, 2
	note __, 2
	note C#, 2
	note __, 2
	notetype $4
	note C_, 1
	note C#, 2
	note __, 2
	note C#, 2
	note D#, 2
	note __, 2
	note F_, 2
	note G#, 6
	endchannel


SECTION "UnknownSfx", ROMX

UnknownSfx:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume 7, 7
	vibrato $8, $27
	dutycycle $2
	notetype $c, $b1
	octave 4
	note F_, 2
	note F_, 1
	note F_, 1
	note C_, 2
	note C_, 1
	note C_, 1
	note E_, 2
	note G_, 1
	note G_, 1
	note C_, 2
	note E_, 1
	note E_, 1
	intensity $a5
	note F_, 16
	endchannel

.Ch6:
	togglesfx
	vibrato $8, $27
	dutycycle $2
	notetype $c, $c1
	octave 4
	note A_, 2
	note A_, 1
	note A_, 1
	note F_, 2
	note F_, 1
	note F_, 1
	octave 5
	note C_, 2
	note C_, 1
	note C_, 1
	octave 4
	note A#, 2
	note A#, 1
	note A#, 1
	intensity $b5
	note A_, 16
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	octave 4
	note F_, 8
	note C_, 2
	note E_, 2
	note G_, 2
	note A#, 2
	note A_, 4
	intensity $35
	note A_, 3
	note __, 9
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 16
	note __, 16
	endchannel


SECTION "Sfx_Fanfare", ROMX

Sfx_Fanfare:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	togglesfx
	sfxpriorityon
	tempo 256
	volume 7, 7
	dutycycle $3
	tone $0001
	notetype $6, $b3
	octave 3
	note F_, 4
	note C#, 4
	note F#, 4
	note D#, 4
	note G#, 4
	note F_, 4
	note A#, 4
	note F#, 4
	notetype $4, $b3
	note A#, 4
	note B_, 4
	octave 4
	note C_, 4
	note C#, 4
	note D#, 4
	note C_, 4
	notetype $4, $b6
	note C#, 12
	sfxpriorityoff
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $6, $c4
	octave 4
	note C#, 4
	notetype $4, $c4
	note C#, 2
	octave 3
	note A#, 2
	octave 4
	note C#, 2
	note D#, 6
	note D#, 2
	octave 3
	note B_, 2
	octave 4
	note D#, 2
	note F_, 6
	note F_, 2
	note C#, 2
	note F_, 2
	note F#, 6
	note F#, 2
	note D#, 2
	note F#, 2
	note C#, 4
	note D#, 4
	note E_, 4
	note F_, 4
	note F#, 4
	note G#, 4
	notetype $4, $c6
	note F#, 12
	endchannel

.Ch8:
	togglesfx
	notetype $6
	note C_, 1
	octave 4
	note A#, 4
	note __, 4
	note B_, 4
	note __, 4
	octave 5
	note C#, 4
	note __, 4
	note D#, 4
	note __, 4
	notetype $4
	note C_, 1
	note F_, 4
	note D#, 4
	note C#, 4
	note A#, 4
	note G#, 4
	note F_, 4
	note F#, 6
	endchannel


SECTION "Sfx_RegisterPhoneNumber", ROMX

Sfx_RegisterPhoneNumber:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume 7, 7
	dutycycle $3
	notetype $c, $a2
	note __, 2
	octave 3
	note C_, 4
	note G#, 4
	octave 4
	note C_, 2
	octave 3
	note F_, 1
	note G#, 2
	note C_, 1
	note F_, 2
	note A#, 3
	octave 4
	note C#, 3
	note C_, 2
	note __, 8
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	notetype $c, $c2
	note __, 2
	octave 4
	note D#, 2
	note C#, 2
	note C_, 2
	note D#, 2
	note F_, 2
	note __, 1
	note G#, 3
	octave 5
	note C_, 2
	note D#, 3
	octave 4
	note G_, 3
	note G#, 2
	note __, 8
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	note __, 2
	octave 3
	note D#, 7
	note __, 1
	note G#, 2
	note __, 1
	note C_, 2
	note __, 1
	note G#, 2
	note G_, 2
	note __, 1
	note A#, 3
	note G#, 2
	note __, 8
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 2
	note __, 16
	note __, 16
	endchannel


SECTION "Sfx_3RdPlace", ROMX

Sfx_3RdPlace:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	dutycycle $2
	notetype $c, $a4
	octave 4
	note F_, 1
	note A_, 1
	octave 5
	note C_, 1
	note F_, 1
	note __, 1
	note C_, 1
	note D_, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $c, $b4
	octave 4
	note A_, 1
	octave 5
	note C_, 1
	note F_, 1
	note A_, 1
	note __, 1
	note F_, 1
	note G_, 6
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	octave 3
	note A_, 1
	note F_, 1
	note A_, 1
	octave 4
	note C_, 1
	note __, 1
	octave 3
	note A_, 1
	note B_, 6
	endchannel


SECTION "Sfx_GetEggFromDayCareLady", ROMX

Sfx_GetEggFromDayCareLady:
Sfx_GetEggFromDayCareMan:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	vibrato $12, $34
	dutycycle $2
	notetype $8, $a1
	note __, 2
	octave 3
	note C_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	intensity $a2
	note F_, 6
	intensity $a1
	dutycycle $3
	octave 3
	note E_, 2
	note G_, 2
	octave 4
	note C_, 2
	intensity $a4
	note F_, 9
	note __, 9
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	dutycycle $3
	notetype $8, $c2
	note __, 2
	octave 4
	note F_, 2
	note __, 2
	note A_, 2
	intensity $c1
	note A#, 2
	note A_, 2
	note A#, 2
	intensity $c2
	octave 5
	note C_, 6
	intensity $c1
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	intensity $c4
	note A_, 9
	note __, 9
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	note __, 2
	octave 3
	note C_, 6
	octave 2
	note A#, 6
	octave 3
	note C_, 2
	note F_, 2
	note G_, 2
	note A#, 6
	note A_, 9
	note __, 9
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $8
	note __, 2
	notetype $c
	note __, 16
	note __, 12
	endchannel


SECTION "Sfx_MoveDeleted", ROMX

Sfx_MoveDeleted:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 116
	volume 7, 7
	dutycycle $2
	vibrato $c, $44
	notetype $c, $a4
	note __, 8
	octave 2
	note G_, 1
	note __, 2
	note C#, 1
	note E_, 1
	note D#, 1
	note E_, 4
	intensity $a1
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note G#, 2
	note B_, 2
	intensity $a6
	octave 3
	note D_, 10
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	vibrato $c, $44
	notetype $c, $74
	octave 1
	note B_, 1
	octave 2
	note D_, 1
	note F_, 1
	note G#, 1
	intensity $94
	note D_, 1
	note F_, 1
	note G#, 1
	note B_, 1
	intensity $b4
	octave 3
	note C#, 1
	note __, 2
	octave 2
	note A#, 1
	octave 3
	note C#, 4
	note __, 2
	intensity $b1
	note C#, 2
	note D#, 2
	note E_, 2
	intensity $b6
	note F_, 16
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $6, $25
	octave 2
	note G#, 8
	note A_, 8
	note A#, 2
	note __, 4
	note A#, 1
	note __, 1
	note A#, 8
	note __, 4
	octave 3
	note C#, 2
	note __, 2
	note C_, 2
	note __, 2
	octave 2
	note A#, 2
	note __, 2
	notetype $c, $20
	note B_, 16
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $3
	notetype $c
	note F_, 8
	note __, 16
	note __, 16
	note __, 6
	endchannel


SECTION "Sfx_2ndPlace", ROMX

Sfx_2ndPlace:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 116
	volume 7, 7
	dutycycle $2
	vibrato $c, $34
	notetype $8, $a1
	octave 4
	note E_, 2
	note E_, 2
	note E_, 2
	note C_, 2
	octave 3
	note A_, 2
	note F_, 2
	note A_, 2
	octave 4
	note C_, 2
	note F_, 2
	note C_, 2
	octave 3
	note A_, 2
	octave 4
	note F_, 2
	note A_, 2
	note A_, 2
	note A_, 2
	intensity $a7
	note B_, 12
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $8, $b1
	octave 4
	note G_, 2
	note G_, 2
	note G_, 2
	note A_, 4
	note B_, 2
	intensity $b4
	octave 5
	note C_, 12
	intensity $b1
	note C_, 2
	note C_, 2
	note C_, 2
	intensity $b7
	note D_, 12
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note F_, 2
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note F_, 2
	octave 2
	note F_, 2
	note __, 2
	octave 3
	note F_, 2
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 2
	note G_, 12
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $3
	notetype $8
.branch8:
	note C#, 1
	loopchannel 6, .branch8
	note B_, 12
	note B_, 12
	note B_, 12
	note __, 6
	endchannel


SECTION "Sfx_1stPlace", ROMX

Sfx_1stPlace:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume 7, 7
	dutycycle $3
	vibrato $c, $34
	notetype $c, $a1
	octave 5
	note D_, 2
	octave 4
	note B_, 2
	octave 5
	note D_, 2
	note A#, 1
	note F_, 1
	note D_, 1
	note F_, 1
	intensity $91
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note A#, 1
	intensity $81
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	intensity $a1
	note C_, 2
	note E_, 2
	note G_, 2
	intensity $a7
	note A_, 10
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	vibrato $c, $34
	notetype $c, $c1
	octave 3
	note B_, 2
	note G_, 2
	note B_, 2
	intensity $b6
	octave 4
	note D_, 12
	intensity $c1
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	intensity $b7
	note D_, 10
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	octave 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 6
	note F_, 6
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	note D_, 10
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $6
	note D_, 4
	note D_, 4
	note D_, 4
	note B_, 12
	note B_, 10
	note C#, 1
	note C#, 1
	note D_, 4
	note D_, 4
	note D_, 4
	notetype $c
	note B_, 10
	note __, 6
	endchannel


SECTION "Sfx_ChooseACard", ROMX

Sfx_ChooseACard:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 152
	volume 7, 7
	dutycycle $3
	notetype $6, $a4
	octave 3
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 4
	note C#, 4
	octave 3
	note F_, 1
	note __, 1
	note F_, 1
	note __, 1
	octave 4
	note D_, 4
	octave 3
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	octave 4
	note E_, 4
	intensity $71
	octave 3
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	intensity $91
	note B_, 1
	octave 4
	note C#, 1
	note D_, 1
	note D#, 1
	intensity $a4
	note E_, 4
	note __, 12
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	notetype $6, $b4
	octave 3
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note E_, 4
	octave 3
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note F_, 4
	octave 3
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	octave 4
	note G_, 4
	note G#, 8
	note A_, 4
	note __, 12
	endchannel

.Ch7:
	togglesfx
	notetype $6, $25
	octave 3
	note C#, 1
	note __, 1
	note C#, 1
	note __, 1
	octave 2
	note A_, 4
	octave 3
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 2
	note A_, 4
	octave 3
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 2
	note A_, 4
	octave 3
	note E_, 2
	octave 2
	note G#, 2
	note B_, 2
	note G#, 2
	note A_, 4
	note __, 12
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $6
	note D_, 2
	note C#, 2
	note B_, 4
	note D_, 2
	note C#, 2
	note B_, 4
	note D_, 2
	note C#, 2
	note D_, 1
	note C#, 1
	note D_, 1
	note C#, 1
	note D_, 2
	note C#, 2
	note C#, 2
	note D_, 2
	note B_, 16
	endchannel


SECTION "Sfx_GetTm", ROMX

Sfx_GetTm:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 144
	volume 7, 7
	dutycycle $3
	vibrato $8, $24
	notetype $c, $a3
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note G_, 6
	intensity $b1
	note E_, 2
	note F#, 2
	note G_, 2
	intensity $a5
	note F#, 8
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	vibrato $8, $24
	notetype $c, $b3
	octave 4
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note B_, 6
	intensity $c1
	note A_, 2
	note B_, 2
	octave 5
	note C_, 2
	intensity $b5
	note D_, 8
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $6, $25
	octave 2
	note B_, 2
	note __, 2
	note G_, 2
	note B_, 2
	octave 3
	note D_, 4
	octave 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 4
	octave 3
	note C_, 2
	note __, 2
	octave 2
	note B_, 2
	note __, 2
	octave 3
	note C_, 4
	octave 2
	note A_, 16
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $6
	note D_, 4
	note C#, 2
	note D_, 2
	note B_, 8
	note D_, 4
	note C#, 4
	note D_, 4
	note C#, 1
	note C#, 1
	note D_, 2
	note B_, 16
	note __, 6
	endchannel


SECTION "Sfx_GetBadge", ROMX

Sfx_GetBadge:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	dutycycle $2
	vibrato $8, $24
	notetype $6, $92
	octave 4
	note F_, 3
	callchannel .branch5
	note A#, 3
	pitchoffset 0, D_
	callchannel .branch5
	pitchoffset 0, C_
	intensity $a7
	note A_, 16
	note __, 6
	endchannel

.branch5:
	note __, 5
	octave 3
	note F_, 2
	note G#, 2
	octave 4
	note C#, 2
	note F_, 2
	note C#, 2
	octave 3
	note F_, 2
	note G#, 2
	octave 4
	note C#, 2
	octave 3
	note F_, 2
	note G#, 2
	octave 4
	note C#, 2
	note F_, 2
	endchannel

.Ch6:
	togglesfx
	dutycycle $3
	vibrato $8, $24
	notetype $6, $b5
	octave 5
	note C#, 3
	note __, 3
	octave 4
	note G#, 1
	note __, 1
	note G#, 8
	octave 3
	note C#, 2
	note __, 2
	octave 2
	note G#, 2
	note __, 1
	intensity $95
	octave 5
	note C_, 1
	intensity $b5
	note C#, 2
	note __, 2
	note D_, 2
	note __, 2
	note D#, 3
	note __, 3
	octave 4
	note A#, 1
	note __, 1
	note A#, 8
	octave 3
	note D#, 2
	note __, 2
	octave 2
	note A#, 2
	note __, 1
	intensity $95
	octave 5
	note D_, 1
	intensity $b5
	note D#, 8
	note F_, 16
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $6, $25
	octave 2
	note G#, 3
	note __, 3
	octave 3
	note C#, 1
	note __, 1
	note C#, 8
	note G#, 2
	note __, 2
	note F_, 2
	note __, 2
	note C#, 2
	note C_, 2
	octave 2
	note A#, 2
	note G#, 2
	note G_, 3
	note __, 3
	octave 3
	note D#, 1
	note __, 1
	note D#, 8
	note A#, 2
	note __, 2
	note G_, 2
	note __, 2
	note G_, 2
	note F_, 2
	note G_, 2
	note D#, 2
	note F_, 16
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $6
.branch8:
	note B_, 12
	note D_, 1
	note D_, 1
	note D_, 2
	note D_, 4
	note D_, 4
	note D_, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	loopchannel 2, .branch8
	note B_, 16
	note __, 6
	endchannel


SECTION "Sfx_QuitSlots", ROMX

Sfx_QuitSlots:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 144
	volume 7, 7
	dutycycle $2
	notetype $8, $82
	octave 3
	note G#, 2
	note __, 4
	note C#, 2
	note F_, 2
	note G#, 2
	note F_, 2
	note G#, 2
	octave 4
	note D_, 2
	note F_, 2
	note D_, 2
	octave 3
	note B_, 2
	note A#, 2
	note F#, 2
	note A#, 2
	note G#, 2
	note F#, 2
	intensity $97
	note G#, 14
	note __, 6
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	notetype $8, $b3
	note __, 3
	octave 4
	note B_, 1
	octave 5
	note C_, 2
	octave 4
	note G#, 4
	note A#, 2
	intensity $c1
	note B_, 4
	note A#, 2
	note G#, 4
	note F_, 2
	note F#, 4
	note F_, 2
	note D#, 4
	intensity $b7
	note F_, 14
	note __, 6
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note C#, 2
	note __, 2
	note F_, 2
	note D#, 2
	note C#, 2
	note G#, 2
	note D_, 2
	note __, 2
	note D_, 2
	octave 2
	note G#, 2
	note B_, 2
	octave 3
	note D_, 2
	note D#, 2
	note __, 2
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	note __, 2
	note C#, 14
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $3
	notetype $8
	note D#, 6
	note D_, 4
	note D#, 2
	note D#, 4
	note D#, 2
	note D_, 4
	note D#, 2
	note D_, 4
	note D#, 2
	note D_, 4
	note B_, 14
	note __, 6
	endchannel


SECTION "Sfx_Protect", ROMX

Sfx_Protect:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	togglesfx
	notetype $1, $f1
	dutycycle $0
.branch5:
	octave 5
	note F_, 5
	note A_, 5
	octave 6
	note C_, 5
	note E_, 5
	octave 5
	note F#, 5
	note A#, 5
	octave 6
	note C#, 5
	note E_, 5
	loopchannel 3, .branch5
	intensity $c1
	octave 5
	note F_, 5
	note A_, 5
	intensity $91
	octave 6
	note C_, 5
	note E_, 5
	intensity $71
	octave 5
	note F#, 5
	note A#, 5
	intensity $51
	octave 6
	note C#, 5
	note E_, 5
	endchannel

.Ch8:
.branch8:
	noise __, 10, $9e, $0
	noise __, 10, $be, $11
	loopchannel 6, .branch8
	noise __, 10, $a7, $0
	noise C_,  1, $75, $11
	endchannel


SECTION "Sfx_Sketch", ROMX

Sfx_Sketch:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $a5
.branch5:
	square_note 2, 15, 1, 1760
	square_note 13, 10, -7, 1456
	square_note 4, 0, 0, 0
	square_note 9, 15, 4, 1816
	loopchannel 3, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_RainDance", ROMX

Sfx_RainDance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise __, 12, $7d, $50
	noise __,  7, $7d, $4f
	noise __, 12, $7f, $47
	noise __, 16, $6e, $22
	loopchannel 3, .branch8
	noise __,  7, $6d, $50
	noise __,  6, $5d, $4f
	noise __,  6, $4f, $47
	noise __, 11, $32, $46
	endchannel


SECTION "Sfx_Aeroblast", ROMX

Sfx_Aeroblast:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	sound_duty 2, 0, 3, 3
	soundinput $f5
	square_note 28, 15, 8, 1408
	soundinput $8
	endchannel

.Ch8:
	noise __,  5, $f8, $6c
	noise __,  5, $c8, $5c
	noise __,  5, $78, $5b
	noise C_,  1, $31, $5a
	endchannel


SECTION "Sfx_Spark", ROMX

Sfx_Spark:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise __,  5, $f8, $5d
	noise __,  5, $d8, $6f
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_Curse", ROMX

Sfx_Curse:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $3
	square_note 4, 15, 2, 1155
	square_note 4, 15, 2, 1297
	square_note 4, 15, 2, 1417
	square_note 4, 15, 2, 1517
	endchannel

.Ch8:
	noise C_,  5, $9a, $9
	endchannel


SECTION "Sfx_Rage", ROMX

Sfx_Rage:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $0
	square_note 3, 13, 1, 1968
	square_note 3, 13, 1, 1986
	square_note 24, 13, 2, 2005
	endchannel

.Ch8:
	noise __,  4, $f4, $1a
	noise __,  4, $f4, $19
	noise C_,  9, $f2, $18
	endchannel


SECTION "Sfx_Thief", ROMX

Sfx_Thief:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise __,  1, $0, $0
	noise __,  5, $e1, $12
	noise __,  1, $0, $0
	noise __,  3, $b1, $22
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_Thief2", ROMX

Sfx_Thief2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	notetype $2, $f4
	dutycycle $0
	octave 4
	note C#, 3
	note A#, 3
	intensity $d2
	note C#, 3
	note A#, 3
	intensity $b1
	note C_, 3
	note A_, 3
	intensity $81
	note C_, 3
	note A_, 3
	togglesfx
	endchannel


SECTION "Sfx_SpiderWeb", ROMX

Sfx_SpiderWeb:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $0
	square_note 32, 7, -7, 1824
	soundinput $95
	square_note 4, 15, 8, 1568
	square_note 4, 14, 8, 1584
	square_note 4, 13, 8, 1600
	square_note 4, 9, 5, 1568
	square_note 4, 7, 3, 1584
	square_note 4, 5, 1, 1600
	soundinput $8
	endchannel

.Ch8:
	noise C#,  1, $ef, $0
	endchannel


SECTION "Sfx_MindReader", ROMX

Sfx_MindReader:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	togglesfx
	dutycycle $2
	notetype $2, $f1
	octave 5
	note C_, 3
	intensity $41
	note C_, 3
	intensity $f1
	note C#, 3
	intensity $41
	note C#, 3
	intensity $f1
	note D_, 3
	intensity $41
	note D_, 3
	togglesfx
	endchannel

.Ch8:
	noise C_,  2, $af, $19
	noise C_,  3, $af, $18
	endchannel


SECTION "Sfx_Nightmare", ROMX

Sfx_Nightmare:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $34
.branch5:
	square_note 3, 11, -2, 1585
	square_note 2, 0, 0, 0
	square_note 3, 15, 8, 1569
	square_note 2, 0, 0, 0
	square_note 3, 15, 8, 1553
	square_note 2, 0, 0, 0
	square_note 3, 14, 8, 1537
	square_note 2, 0, 0, 0
	square_note 3, 14, 8, 1521
	square_note 2, 0, 0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_Snore", ROMX

Sfx_Snore:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $ea, $4b
	noise __,  3, $ea, $5b
	noise __,  3, $0, $0
	noise __,  5, $ee, $47
	noise __,  5, $ee, $46
	noise __,  5, $ee, $45
	endchannel


SECTION "Sfx_SweetKiss", ROMX

Sfx_SweetKiss:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	square_note 2, 12, 1, 1992
	square_note 2, 13, 1, 2010
	loopchannel 2, .branch5
	square_note 26, 15, 1, 2018
	endchannel


SECTION "Sfx_SweetKiss2", ROMX

Sfx_SweetKiss2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $97
	square_note 2, 15, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 12, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 11, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 10, 1, 1906
	soundinput $8
	endchannel


SECTION "Sfx_BellyDrum", ROMX

Sfx_BellyDrum:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $ac
	square_note 12, 15, 1, 1443
	soundinput $8
	endchannel

.Ch8:
	noise __, 13, $b1, $6c
	endchannel


SECTION "Sfx_Toxic", ROMX

Sfx_Toxic:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $95
	square_note 2, 12, -1, 947
	square_note 5, 15, 8, 1123
	square_note 4, 13, 1, 1347
	soundinput $8
	endchannel


SECTION "Sfx_SludgeBomb", ROMX

Sfx_SludgeBomb:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $c5
	square_note 3, 15, 8, 1409
	square_note 1, 0, 0, 0
	soundinput $cb
	square_note 16, 15, 2, 1489
	soundinput $8
	endchannel

.Ch8:
	noise __,  4, $e2, $6e
	noise __,  2, $0, $0
	noise C_,  1, $e2, $6d
	endchannel


SECTION "Sfx_Foresight", ROMX

Sfx_Foresight:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	square_note 3, 15, 4, 1973
	square_note 3, 15, 5, 1992
	square_note 8, 15, 4, 2010
	square_note 2, 0, 0, 0
	square_note 8, 12, 1, 2010
	square_note 2, 0, 0, 0
	square_note 8, 9, 1, 2010
	endchannel


SECTION "Sfx_Spite", ROMX

Sfx_Spite:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	vibrato $0, $12
	dutycycle $3
	soundinput $fd
	notetype $3, $f8
	octave 3
	note F_, 3
	note G#, 3
	note B_, 3
	note E_, 3
	note G_, 3
	note A#, 3
	intensity $bf
	note D#, 3
	note F#, 3
	note A_, 3
	intensity $5f
	note D_, 3
	intensity $2f
	note F_, 3
	note G#, 3
	soundinput $8
	togglesfx
	endchannel


SECTION "Sfx_Outrage", ROMX

Sfx_Outrage:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __, 12, $ea, $6c
	noise __, 12, $ea, $6b
	noise __, 12, $ea, $6a
	noise __, 12, $ea, $69
	noise __, 12, $e1, $59
	endchannel


SECTION "Sfx_PerishSong", ROMX

Sfx_PerishSong:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	togglesfx
	dutycycle $0
	vibrato $12, $53
	notetype $8, $af
	octave 4
	note A_, 9
	note G#, 9
	togglesfx
	endchannel

.Ch6:
	togglesfx
	dutycycle $0
	vibrato $12, $53
	notetype $8, $af
	octave 4
	note C_, 9
	octave 3
	note B_, 9
	togglesfx
	endchannel


SECTION "Sfx_GigaDrain", ROMX

Sfx_GigaDrain:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $97
	square_note 4, 15, 8, 1664
	square_note 20, 15, 8, 1664
	square_note 20, 12, 8, 1632
	square_note 20, 10, 8, 1648
	square_note 20, 8, 8, 1664
	square_note 20, 15, 8, 1377
	square_note 20, 12, 8, 1345
	square_note 20, 10, 8, 1313
	square_note 20, 8, 8, 1297
	soundinput $8
	endchannel

.Ch8:
	noise __,  5, $c8, $44
	noise C_,  5, $c8, $50
	noise C_,  5, $c8, $52
	noise C_,  5, $c8, $54
	noise C_,  5, $c8, $56
	noise D#,  1, $c7, $57
	endchannel


SECTION "Sfx_Attract", ROMX

Sfx_Attract:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $77
	square_note 4, 10, -1, 1776
	square_note 12, 15, 8, 1824
	soundinput $7f
	square_note 8, 15, 1, 1856
	soundinput $8
	endchannel


SECTION "Sfx_Kinesis2", ROMX

Sfx_Kinesis2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
	square_note 2, 15, 3, 1942
	square_note 2, 2, 3, 1942
	square_note 20, 15, 1, 1988
	endchannel


SECTION "Sfx_ZapCannon", ROMX

Sfx_ZapCannon:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise __,  3, $e1, $49
	noise __,  1, $0, $0
	loopchannel 8, .branch8
	noise __,  9, $e1, $49
	endchannel


SECTION "Sfx_MeanLook", ROMX

Sfx_MeanLook:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	soundinput $77
	dutycycle $3
	square_note 2, 15, 8, 1824
.branch5:
	square_note 1, 8, 8, 1632
	square_note 2, 15, 8, 1936
	loopchannel 5, .branch5
	square_note 12, 15, 8, 1792
	square_note 12, 12, 8, 1824
	square_note 12, 10, 8, 1792
	square_note 12, 7, 8, 1824
	square_note 12, 4, 8, 1792
	square_note 12, 2, 8, 1824
	soundinput $8
	endchannel


SECTION "Sfx_HealBell", ROMX

Sfx_HealBell:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	square_note 1, 15, 1, 2010
	square_note 1, 13, 1, 2009
	square_note 1, 15, 1, 2010
	square_note 8, 13, 1, 2011
	endchannel


SECTION "Sfx_Return", ROMX

Sfx_Return:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $0
.branch5:
	soundinput $bf
	square_note 8, 15, 1, 1881
	soundinput $57
	square_note 8, 15, 1, 1881
	square_note 16, 0, 0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_ExpBar", ROMX

Sfx_ExpBar:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $d7
	square_note 8, 14, 1, 1872
	soundinput $e7
	square_note 8, 4, 8, 1760
	square_note 8, 5, 8, 1784
	square_note 8, 6, 8, 1808
	square_note 8, 7, 8, 1832
	square_note 8, 8, 8, 1856
	square_note 8, 9, 8, 1880
	square_note 16, 10, 8, 1904
	soundinput $8
	endchannel


SECTION "Sfx_MilkDrink", ROMX

Sfx_MilkDrink:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	soundinput $a4
	square_note 2, 14, -2, 1248
	square_note 13, 15, 7, 656
	soundinput $9e
	square_note 4, 12, -1, 1505
	square_note 2, 0, 0, 0
	loopchannel 6, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_Present", ROMX

Sfx_Present:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $d6
.branch5:
	square_note 2, 15, 1, 1856
	square_note 1, 0, 0, 0
	loopchannel 3, .branch5
	square_note 16, 15, 1, 1920
	soundinput $8
	endchannel


SECTION "Sfx_MorningSun", ROMX

Sfx_MorningSun:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $3
.branch5:
	square_note 2, 15, 1, 2020
	square_note 2, 15, 1, 2016
	square_note 5, 15, 2, 2023
	loopchannel 3, .branch5
	square_note 1, 0, 0, 0
	square_note 8, 12, 2, 2023
	square_note 1, 0, 0, 0
	square_note 8, 8, 2, 2023
	endchannel


SECTION "Sfx_Moonlight", ROMX

Sfx_Moonlight:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	square_note 1, 15, 8, 2000
	square_note 4, 15, 1, 2016
	loopchannel 2, .branch5
	square_note 16, 15, 1, 2016
	square_note 16, 13, 1, 2016
	square_note 16, 8, 1, 2016
	endchannel


SECTION "Sfx_Encore", ROMX

Sfx_Encore:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $ce
	square_note 16, 0, 0, 0
.branch5:
	square_note 2, 15, 8, 1908
	square_note 36, 0, 0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel

.Ch8:
	noise D_,  1, $1f, $36
	noise D_,  1, $76, $36
	endchannel


SECTION "Sfx_BeatUp", ROMX

Sfx_BeatUp:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  3, $e8, $69
	noise __,  7, $d8, $24
	noise __,  3, $e8, $6c
	noise __,  5, $c8, $46
	noise __,  7, $d1, $24
	endchannel


SECTION "Sfx_SweetScent", ROMX

Sfx_SweetScent:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $96
	square_note 6, 15, 8, 1888
	square_note 6, 14, 8, 1824
	soundinput $df
	square_note 22, 15, 1, 1840
	soundinput $8
	endchannel


SECTION "Sfx_BatonPass", ROMX

Sfx_BatonPass:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $f7
	square_note 32, 15, 2, 1664
	square_note 1, 15, 1, 1888
	square_note 32, 0, 0, 0
	square_note 1, 15, 1, 1888
	square_note 26, 0, 0, 0
	square_note 1, 15, 1, 1888
	soundinput $8
	endchannel

.Ch8:
	noise C#,  1, $f2, $20
	endchannel


SECTION "Sfx_EggCrack", ROMX

Sfx_EggCrack:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	notetype $1, $f1
	dutycycle $0
	octave 4
	note D#, 1
	note C_, 1
	note __, 1
	note F#, 1
	endchannel


SECTION "Sfx_Evolved", ROMX

Sfx_Evolved:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	notetype $1, $c1
	octave 4
	note C_, 2
	note E_, 2
	note C_, 2
	note E_, 3
	note G_, 3
	note B_, 3
	octave 5
	note E_, 2
	note C_, 2
	note E_, 2
	note G_, 3
	note B_, 3
	octave 7
	note C_, 16
	endchannel


SECTION "Sfx_MasterBall", ROMX

Sfx_MasterBall:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	dutycycle $1
	notetype $2, $e1
	octave 6
	note B_, 2
	octave 7
	note D_, 2
	octave 6
	note B_, 2
	note G_, 2
	note B_, 2
	note A#, 2
	note A_, 2
	note A#, 2
	note A_, 2
	intensity $c1
	note G#, 2
	note G_, 2
	note F#, 2
	intensity $91
	note F_, 2
	note E_, 2
	note D#, 2
	intensity $61
	note D_, 2
	note C#, 2
	note C_, 2
	endchannel


SECTION "Sfx_EggHatch", ROMX

Sfx_EggHatch:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	notetype $2, $f1
	dutycycle $2
	octave 5
	note E_, 1
	note C_, 1
	note __, 1
	note G_, 1
	note D_, 1
	intensity $e2
	note B_, 7
	intensity $82
	note B_, 7
	intensity $42
	note B_, 7
	endchannel


SECTION "Sfx_GsIntroCharizardFireball", ROMX

Sfx_GsIntroCharizardFireball:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  9, $cf, $4d
	noise __,  9, $f1, $37
.branch8:
	noise __,  2, $f8, $4f
	noise __,  1, $c8, $26
	noise __,  2, $d8, $5f
	noise __,  1, $a8, $37
	loopchannel 12, .branch8
	noise __,  4, $f8, $6f
	noise __,  5, $d8, $5f
	noise __, 13, $d8, $5c
	noise C#,  9, $d3, $4f
	endchannel


SECTION "Sfx_GsIntroPokemonAppears", ROMX

Sfx_GsIntroPokemonAppears:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $88, $4f
	noise __,  3, $8f, $2
	noise __,  3, $5f, $12
	noise __,  3, $3f, $22
	noise __,  1, $f8, $27
	noise __,  2, $f8, $4f
	noise __,  9, $f1, $0
	endchannel


SECTION "Sfx_Flash", ROMX

Sfx_Flash:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $ef
	square_note 1, 4, 0, 2024
	square_note 1, 6, 0, 2024
	square_note 2, 8, 0, 2024
	square_note 5, 10, 0, 2024
	square_note 6, 10, 0, 2024
	square_note 7, 8, 0, 2024
	square_note 8, 6, 0, 2024
	square_note 9, 3, 0, 2024
	square_note 15, 1, 2, 2024
	soundinput $8
	endchannel


SECTION "Sfx_GameFreakLogoGs", ROMX

Sfx_GameFreakLogoGs:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $3
	soundinput $7f
	square_note 4, 5, 5, 2018
	square_note 5, 7, 5, 2018
	square_note 6, 9, 4, 2018
	square_note 7, 11, 4, 2018
	square_note 8, 11, 3, 2018
	square_note 9, 9, 3, 2018
	square_note 10, 7, 2, 2018
	square_note 10, 5, 3, 2018
	square_note 10, 3, 4, 2018
	square_note 10, 1, 5, 2018
	soundinput $8
	endchannel


SECTION "Sfx_DexFanfareLessThan20", ROMX

Sfx_DexFanfareLessThan20:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume 7, 7
	notetype $8, $b1
	octave 3
	note A_, 4
	note F#, 2
	note A_, 4
	note F#, 2
	note C#, 6
	note G_, 6
	note F#, 6
	note E_, 2
	note E_, 2
	note E_, 2
	note D_, 6
	endchannel

.Ch6:
	togglesfx
	notetype $8, $c1
	octave 3
	note B_, 4
	note A_, 2
	note B_, 4
	note A_, 2
	note D#, 6
	note A#, 6
	note A_, 6
	note A_, 2
	note A_, 2
	note G_, 2
	note F#, 6
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 4
	note D_, 6
	octave 3
	note A_, 2
	note __, 2
	note A_, 2
	note A#, 4
	note G_, 2
	octave 4
	note D#, 6
	note D_, 2
	note __, 4
	octave 3
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note G_, 1
	note __, 1
	note A_, 2
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C#, 6
	note __, 16
	note __, 12
	endchannel


SECTION "Sfx_DexFanfare140169", ROMX

Sfx_DexFanfare140169:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume 7, 7
	dutycycle $3
	vibrato $12, $34
	notetype $6, $b1
	note __, 8
	octave 3
	note E_, 4
	note E_, 4
	note A_, 4
	octave 4
	note C#, 4
	intensity $a4
	note D_, 4
	note C_, 4
	octave 3
	note A_, 2
	note G_, 2
	note F#, 4
	note G_, 16
	octave 2
	note B_, 8
	note __, 8
	endchannel

.Ch6:
	togglesfx
	dutycycle $2
	vibrato $12, $34
	notetype $6, $c1
	octave 4
	note E_, 4
	note F#, 4
	note G_, 4
	note G_, 4
	note G_, 4
	note G_, 4
	intensity $b4
	note F#, 4
	note G_, 4
	note A_, 4
	octave 5
	note C_, 4
	octave 4
	note B_, 16
	note G_, 8
	note __, 8
	endchannel

.Ch7:
	togglesfx
	notetype $c, $25
	note __, 4
	octave 2
	note A_, 1
	octave 3
	note C#, 1
	note E_, 1
	note A_, 3
	note C#, 1
	note __, 1
	note D_, 1
	note F#, 1
	note A_, 1
	octave 4
	note D_, 3
	octave 2
	note A_, 1
	note __, 1
	note G_, 1
	note B_, 1
	octave 3
	note D_, 1
	note G_, 3
	octave 2
	note B_, 1
	note __, 1
	note G_, 4
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $c
	note C_, 4
.branch8:
	note D_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	loopchannel 3, .branch8
	note D_, 8
	endchannel


SECTION "Sfx_DexFanfare170199", ROMX

Sfx_DexFanfare170199:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume 7, 7
	vibrato $12, $34
	dutycycle $3
	notetype $8, $b4
	octave 3
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 6
	note __, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	intensity $c1
	note F_, 4
	note G_, 4
	note A_, 4
	notetype $c, $a8
	note A#, 12
	note __, 4
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	dutycycle $3
	notetype $8, $c4
	octave 3
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 6
	note __, 2
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	intensity $d1
	octave 4
	note D#, 4
	note D#, 4
	note D#, 4
	notetype $c, $b8
	note D_, 12
	note __, 4
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note D#, 6
	note __, 2
	note D#, 1
	note __, 1
	note D#, 1
	note __, 1
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	note C_, 2
	note __, 2
	notetype $c, $25
	octave 2
	note A#, 12
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $8
	note D_, 2
	note D_, 2
	note D_, 4
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 4
	note D_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	notetype $c
	note B_, 16
	endchannel

	db $fd


SECTION "Sfx_DexFanfare200229", ROMX

Sfx_DexFanfare200229:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume 7, 7
	vibrato $12, $34
	dutycycle $3
	notetype $8, $b2
	octave 3
	note C_, 2
	note E_, 2
	note G_, 2
	octave 4
	note C_, 4
	octave 3
	note B_, 4
	note A_, 4
	note A#, 4
	octave 4
	note D#, 4
	note G_, 4
	notetype $c, $a8
	note F#, 12
	note __, 4
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	dutycycle $3
	notetype $8, $b2
	octave 3
	note E_, 2
	note G_, 2
	octave 4
	note C_, 2
	note E_, 4
	note D_, 4
	note C_, 4
	note D#, 4
	note G_, 4
	note A#, 4
	notetype $c, $b8
	note A_, 12
	note __, 4
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 1
	note __, 1
	note C_, 2
	note E_, 2
	note G_, 2
	octave 4
	note C_, 2
	octave 3
	note C_, 4
	note D#, 2
	note G_, 2
	note A#, 2
	octave 4
	note D#, 2
	octave 3
	note D#, 4
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 2
	note A_, 2
	octave 3
	note D_, 1
	note __, 1
	note D_, 1
	note __, 1
	octave 2
	note A_, 2
	octave 3
	note D_, 6
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $8
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note D_, 4
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note D_, 4
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 2
	note B_, 12
	endchannel


SECTION "Sfx_DexFanfare230Plus", ROMX

Sfx_DexFanfare230Plus:
	channel_count 4
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7
	channel 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume 7, 7
	vibrato $12, $34
	dutycycle $3
	notetype $8, $a5
	octave 3
	note B_, 2
	note G_, 2
	note B_, 2
	octave 4
	note D_, 14
	note __, 2
	dutycycle $2
	intensity $85
	octave 2
	note F_, 1
	note __, 1
	note F_, 6
	intensity $a5
	dutycycle $3
	octave 3
	note A_, 2
	note G_, 2
	note F_, 10
	note __, 2
	dutycycle $2
	intensity $85
	octave 2
	note F_, 1
	note __, 1
	note F_, 6
	intensity $a5
	dutycycle $3
	octave 3
	note A#, 12
	intensity $b2
	note G_, 4
	note A_, 4
	note A#, 4
	notetype $c, $a8
	note A_, 14
	note __, 2
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	dutycycle $3
	notetype $8, $b5
	octave 4
	note G_, 2
	note D_, 2
	note G_, 2
	note F_, 14
	note __, 4
	note F_, 2
	note E_, 2
	note D_, 2
	note C_, 2
	octave 3
	note B_, 2
	note A_, 10
	note __, 4
	note A_, 2
	octave 4
	note C_, 2
	note D_, 2
	note D#, 12
	intensity $c2
	note G_, 4
	note G_, 4
	note G_, 4
	notetype $c, $b8
	note F#, 14
	note __, 2
	endchannel

.Ch7:
	togglesfx
	notetype $8, $25
	octave 3
	note G_, 6
	note A#, 4
	note F_, 2
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 1
	note __, 1
	note A#, 2
	note __, 2
	note D_, 1
	note __, 1
	note D_, 6
	note A_, 4
	note F_, 2
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 1
	note __, 1
	note A_, 2
	note __, 2
	note C_, 1
	note __, 1
	note C_, 6
	note G_, 4
	note D#, 2
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note G_, 1
	note __, 1
	note A#, 4
	note G_, 4
	note D#, 4
	notetype $c, $25
	note D_, 14
	note __, 2
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	notetype $8
	note D_, 2
	note D_, 2
	note D_, 2
.branch8_1:
	note D_, 6
	note D_, 2
	note D_, 2
	note D_, 2
	note D_, 6
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note C#, 1
	loopchannel 2, .branch8_1
	note D_, 6
	note D_, 2
	note D_, 2
	note C#, 1
	note C#, 1
	note D_, 4
	note D_, 4
	note D_, 4
.branch8_2:
	note C#, 1
	loopchannel 18, .branch8_2
	note D_, 6
	endchannel


SECTION "Sfx_NotVeryEffective", ROMX

Sfx_NotVeryEffective:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $f1, $5f
	noise __,  2, $a0, $42
	noise C_,  1, $f1, $53
	endchannel


SECTION "Sfx_Damage", ROMX

Sfx_Damage:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  5, $f1, $5e
	noise __,  2, $a0, $12
	noise __,  5, $f0, $32
	noise C_,  1, $f1, $44
	endchannel


SECTION "Sfx_SuperEffective", ROMX

Sfx_SuperEffective:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  4, $f1, $4f
	noise __,  2, $c8, $22
	noise __,  3, $f8, $3f
	noise __,  4, $d0, $15
	noise C#,  1, $f2, $35
	endchannel


SECTION "Sfx_BallBounce", ROMX

Sfx_BallBounce:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 8, 14, 1, 1856
	square_note 23, 0, 0, 0
	square_note 8, 11, 1, 1856
	square_note 23, 0, 0, 0
	square_note 8, 8, 1, 1856
	square_note 23, 0, 0, 0
	square_note 8, 5, 1, 1856
	square_note 23, 0, 0, 0
	endchannel

.Ch6:
	dutycycle $2
	square_note 2, 0, 8, 0
	square_note 8, 11, 1, 1857
	square_note 23, 0, 0, 0
	square_note 8, 8, 1, 1857
	square_note 23, 0, 0, 0
	square_note 8, 5, 1, 1857
	square_note 23, 0, 0, 0
	square_note 8, 2, 1, 1857
	square_note 23, 0, 0, 0
	endchannel


SECTION "Sfx_SweetScent2", ROMX

Sfx_SweetScent2:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	soundinput $af
	dutycycle $1
	square_note 6, 15, 8, 1520
	square_note 2, 15, 1, 1568
	square_note 16, 15, 1, 1616
	soundinput $8
	endchannel

.Ch8:
	noise __,  3, $e8, $22
	noise C_,  2, $aa, $0
.branch8:
	noise __,  5, $d9, $10
	noise __,  9, $91, $0
	noise __,  3, $61, $7
	loopchannel 5, .branch8
	noise __,  5, $99, $0
	noise __, 11, $61, $0
	noise __,  7, $59, $0
	noise __,  3, $21, $7
	endchannel


SECTION "Sfx_HitEndOfExpBar", ROMX

Sfx_HitEndOfExpBar:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 1, 14, 1, 1929
	square_note 1, 14, 1, 1954
	square_note 16, 14, 1, 1969
	endchannel

.Ch6:
	dutycycle $2
	square_note 1, 14, 1, 1954
	square_note 1, 14, 1, 1969
	square_note 16, 14, 1, 1988
	endchannel


SECTION "Sfx_GiveTrademon", ROMX

Sfx_GiveTrademon:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	square_note 32, 0, 0, 0
	dutycycle $1
	soundinput $a7
	square_note 27, 15, 4, 1872
	square_note 27, 13, 4, 1872
	square_note 27, 11, 4, 1872
	square_note 27, 9, 4, 1872
	square_note 27, 7, 4, 1872
	square_note 27, 5, 4, 1872
	square_note 27, 3, 4, 1872
	square_note 27, 1, 4, 1872
	soundinput $8
	endchannel


SECTION "Sfx_GetTrademon", ROMX

Sfx_GetTrademon:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	square_note 32, 0, 0, 0
	dutycycle $2
	soundinput $bf
	square_note 27, 1, 4, 1980
	square_note 27, 3, 4, 1980
	square_note 27, 5, 4, 1980
	square_note 27, 7, 4, 1980
	square_note 27, 9, 4, 1980
	square_note 27, 11, 4, 1980
	square_note 27, 13, 4, 1980
	square_note 27, 15, 4, 1980
	soundinput $8
	endchannel


SECTION "Sfx_TrainArrived", ROMX

Sfx_TrainArrived:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch6:
	tone $0008
	square_note 8, 0, 0, 0
.Ch5:
	dutycycle $2
	square_note 4, 5, -7, 1681
	square_note 4, 6, -7, 1684
	square_note 4, 7, 8, 1687
	square_note 4, 7, -7, 1690
	square_note 4, 6, 8, 1710
	square_note 16, 6, -7, 1707
	square_note 104, 6, 5, 1704
	endchannel

.Ch8:
	noise __,  6, $af, $10
	noise __,  5, $9f, $20
	noise __,  5, $8f, $21
	noise __,  5, $7f, $22
	noise __,  5, $8f, $21
	noise __,  5, $9f, $20
	noise __,  5, $9f, $10
	noise F_,  9, $a3, $0
	endchannel


SECTION "Sfx_2Boops", ROMX

Sfx_2Boops:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	soundinput $79
	square_note 1, 9, -1, 1379
	square_note 4, 15, 2, 1205
	soundinput $43
	square_note 16, 15, 8, 1485
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_TitleScreenIntro", ROMX

Sfx_TitleScreenIntro:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $10, $10
	noise __,  3, $20, $10
	noise __,  3, $30, $20
	noise __,  3, $40, $20
	noise __,  3, $50, $21
	noise __,  3, $60, $22
	noise __,  5, $70, $22
	noise __,  9, $80, $22
	noise __, 16, $94, $22
	endchannel


SECTION "Sfx_StopSlot", ROMX

Sfx_StopSlot:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 1, 15, 8, 1888
	square_note 4, 8, 2, 1888
	endchannel


SECTION "Sfx_GlassTing", ROMX

Sfx_GlassTing:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 32, 13, 1, 2012
	endchannel


SECTION "Sfx_GlassTing2", ROMX

Sfx_GlassTing2:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	dutycycle $2
	square_note 16, 15, 1, 2012
	endchannel

.Ch6:
	dutycycle $2
	square_note 16, 13, 1, 2013
	endchannel


SECTION "Sfx_IntroUnown1", ROMX

Sfx_IntroUnown1:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	vibrato $1, $a3
	dutycycle $2
	square_note 8, 3, -1, 1797
	square_note 32, 14, 2, 1797
	endchannel


SECTION "Sfx_IntroUnown2", ROMX

Sfx_IntroUnown2:
	channel_count 1
	channel 6, .Ch6

.Ch6:
	vibrato $1, $73
	dutycycle $2
	square_note 8, 3, -1, 1880
	square_note 32, 14, 2, 1880
	endchannel


SECTION "Sfx_IntroUnown3", ROMX

Sfx_IntroUnown3:
	channel_count 1
	channel 7, .Ch7

.Ch7:
	vibrato $1, $53
	square_note 3, 3, 2, 1986
	square_note 3, 2, 2, 1986
	square_note 3, 1, 2, 1986
	square_note 16, 1, 2, 1986
	square_note 6, 2, 2, 1986
	square_note 6, 3, 2, 1986
	endchannel


SECTION "Sfx_DittoPopUp", ROMX

Sfx_DittoPopUp:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $1e
	square_note 3, 8, 2, 1792
	square_note 1, 3, 1, 1793
	soundinput $16
	square_note 4, 11, 1, 1600
	square_note 16, 3, 1, 1601
	endchannel


SECTION "Sfx_DittoTransform", ROMX

Sfx_DittoTransform:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $26
	square_note 20, 3, -3, 1088
	square_note 4, 9, 7, 1216
	square_note 4, 6, 7, 1217
	square_note 4, 4, 2, 1218
	endchannel


SECTION "Sfx_IntroSuicune1", ROMX

Sfx_IntroSuicune1:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $58, $59
	noise __,  3, $91, $23
	endchannel


SECTION "Sfx_IntroPichu", ROMX

Sfx_IntroPichu:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $3
	soundinput $4d
	square_note 1, 8, 8, 1904
	square_note 3, 0, 0, 0
	soundinput $17
	square_note 2, 8, 8, 1910
	endchannel


SECTION "Sfx_IntroSuicune2", ROMX

Sfx_IntroSuicune2:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $a7, $31
	noise __,  2, $91, $0
	noise __,  2, $92, $21
	noise __,  2, $91, $0
	noise __,  2, $92, $22
	noise __,  2, $82, $11
	noise __,  2, $82, $22
	noise __,  2, $72, $11
	noise __,  2, $72, $12
	noise __,  2, $62, $10
	noise __,  2, $63, $0
	noise __,  2, $53, $10
	noise __,  2, $43, $0
	noise __,  2, $33, $10
	noise __,  2, $23, $0
	noise __,  2, $13, $10
	endchannel


SECTION "Sfx_IntroSuicune3", ROMX

Sfx_IntroSuicune3:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $88, $31
	noise __,  9, $39, $11
	noise __,  5, $a4, $10
	noise __,  5, $44, $10
	noise __,  5, $24, $10
	endchannel


SECTION "Sfx_DittoBounce", ROMX

Sfx_DittoBounce:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $2c
	square_note 2, 8, 2, 1200
	square_note 0, 3, 1, 1200
	soundinput $34
	square_note 16, 11, 1, 1056
	endchannel


SECTION "Sfx_IntroSuicune4", ROMX

Sfx_IntroSuicune4:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise __,  2, $a1, $5c
	noise __,  1, $0, $0
	noise __,  2, $c1, $4d
	noise __,  1, $0, $0
	noise __,  5, $b2, $31
	noise __,  1, $0, $0
	noise __,  5, $a2, $2
	noise __,  1, $0, $0
	noise __,  5, $92, $1
	noise __,  1, $0, $0
	noise C#,  1, $72, $0
	endchannel


SECTION "Sfx_GameFreakPresents", ROMX

Sfx_GameFreakPresents:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	dutycycle $2
	notetype $2, $b1
	soundinput $ff
	pitchoffset 1, A#
	octave 5
	note C_, 2
	note E_, 2
	note G_, 2
	octave 6
	note C_, 2
	note E_, 2
	note G_, 3
	intensity $81
	note G_, 3
	intensity $51
	note G_, 3
	intensity $31
	note G_, 3
	endchannel


SECTION "Sfx_Tingle", ROMX

Sfx_Tingle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	dutycycle $1
	pitchoffset 0, B_
	notetype $1, $b1
.branch5:
	octave 5
	note C_, 3
	octave 6
	note G_, 2
	octave 5
	note C_, 3
	note __, 2
	loopchannel 2, .branch5
	note C_, 2
	intensity $a1
	note G_, 13
	endchannel


SECTION "Sfx_TwoPcBeeps", ROMX

Sfx_TwoPcBeeps:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $2
	square_note 2, 14, 8, 1986
	square_note 2, 2, 8, 1986
	square_note 2, 14, 8, 1986
	square_note 2, 2, 8, 1986
	endchannel


SECTION "Sfx_4NoteDitty", ROMX

Sfx_4NoteDitty:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 7, .Ch7

.Ch5:
	togglesfx
	dutycycle $2
	notetype $2, $e8
	pitchoffset 0, D_
	octave 4
	note C_, 2
	intensity $48
	note C_, 2
	intensity $e8
	note G_, 2
	intensity $48
	note G_, 2
	octave 5
	intensity $e8
	note E_, 2
	intensity $48
	note E_, 2
	octave 6
	intensity $e8
	note C_, 2
	intensity $43
	note C_, 16
	endchannel

.Ch6:
	togglesfx
	notetype $2, $b8
	note __, 9
	note __, 16
	endchannel

.Ch7:
	togglesfx
	notetype $2, $b8
	note __, 9
	note __, 16
	endchannel


SECTION "Sfx_Twinkle", ROMX

Sfx_Twinkle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	dutycycle $0
	pitchoffset 0, D_
	notetype $2, $e1
	octave 3
	note G_, 2
	intensity $b1
	octave 4
	note D_, 2
	intensity $e1
	note B_, 2
	intensity $b1
	note G_, 2
	intensity $e1
	octave 5
	note D_, 2
	intensity $b1
	octave 4
	note B_, 2
	intensity $e1
	octave 5
	note G_, 6
	endchannel


SECTION "Sfx_Puddle", ROMX

Sfx_Puddle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $97
	square_note 15, 9, 8, 1792
	soundinput $8
	endchannel


SECTION "Sfx_AbilitySlideout", ROMX

Sfx_AbilitySlideout:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $9f
	square_note 3, 14, 8, 2047
	square_note 23, 14, 8, 2016
	soundinput $8
	endchannel
