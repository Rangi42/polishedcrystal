SECTION "Sfx_PokeballsPlacedOnTable", ROMX

Sfx_PokeballsPlacedOnTable:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 3, -2
	square_note 4, 15, 2, 512
	pitch_sweep 2, 2
	square_note 8, 14, 2, 512
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_BallWiggle", ROMX

Sfx_BallWiggle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 3, -2
	square_note 4, 15, 2, 1024
	pitch_sweep 2, 2
	square_note 8, 14, 2, 1024
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Potion", ROMX

Sfx_Potion:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 1, 7
	square_note 15, 15, 0, 1264
	square_note 15, 15, 2, 1616
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_FullHeal", ROMX

Sfx_FullHeal:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 1, 4
	square_note 4, 15, 2, 1536
	square_note 4, 15, 2, 1536
	pitch_sweep 1, 7
	square_note 15, 15, 2, 1536
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Menu", ROMX

Sfx_Menu:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 14, 2, 51
	noise_note 8, 14, 1, 34
	endchannel


SECTION "Sfx_ReadText", ROMX

Sfx_ReadText:
Sfx_ReadText2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
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
	duty_cycle 0
	pitch_sweep 1, 4
	square_note 4, 15, 2, 1536
	loopchannel 4, .loop
	square_note 15, 15, 3, 1536
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_GotSafariBalls", ROMX

Sfx_GotSafariBalls:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 1, 5
	square_note 15, 15, 0, 1264
	square_note 15, 15, 2, 1616
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_BootPc", ROMX

Sfx_BootPc:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
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
	duty_cycle 2
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
	duty_cycle 2
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
	duty_cycle 1
	pitch_sweep 1, 7
	square_note 15, 13, 7, 1536
	square_note 15, 11, 7, 1408
	square_note 15, 8, 7, 1280
	square_note 15, 4, 7, 1152
	square_note 15, 1, 7, 1024
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_PushButton", ROMX

Sfx_PushButton:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
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
	duty_cycle 2
	pitch_sweep 2, -4
	square_note 4, 15, 2, 1280
	pitch_sweep 2, 2
	square_note 2, 15, 1, 1280
	pitch_sweep 0, 8
	square_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_WarpTo", ROMX

Sfx_WarpTo:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 1, 7
	square_note 15, 13, 7, 1280
	square_note 15, 11, 7, 1408
	square_note 15, 8, 7, 1536
	square_note 15, 4, 7, 1664
	square_note 15, 1, 7, 1792
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_WarpFrom", ROMX

Sfx_WarpFrom:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 1, 7
	square_note 15, 13, 7, 1792
	square_note 15, 11, 7, 1664
	square_note 15, 8, 7, 1536
	square_note 15, 4, 7, 1408
	square_note 15, 1, 7, 1280
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_ChangeDexMode", ROMX

Sfx_ChangeDexMode:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 1, 6
	square_note 15, 13, 2, 1280
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_JumpOverLedge", ROMX

Sfx_JumpOverLedge:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 9, 5
	square_note 15, 15, 2, 1024
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_GrassRustle", ROMX

Sfx_GrassRustle:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 1, 50
	noise_note 2, 0, 0, 0
	noise_note 2, 15, 1, 34
	noise_note 1, 0, 0, 0
	endchannel


SECTION "Sfx_Fly", ROMX

Sfx_Fly:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 10, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 13, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 8, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 11, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 6, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 9, 1, 18
	noise_note 2, 0, 0, 0
	noise_note 2, 4, 1, 18
	noise_note 2, 0, 0, 0
	endchannel


SECTION "Sfx_Wrong", ROMX

Sfx_Wrong:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 3
	pitch_sweep 5, -2
	square_note 4, 15, 0, 1280
	pitch_sweep 0, 8
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1280
	square_note 1, 0, 0, 0
	endchannel

.Ch6:
	duty_cycle 3
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
	duty_cycle 0
	pitch_sweep 1, 7
	square_note 15, 13, 2, 1792
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Strength", ROMX

Sfx_Strength:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 10, 2, 35
	noise_note 8, 15, 1, 52
	noise_note 15, 0, 0, 0
	noise_note 2, 15, 7, 36
	noise_note 2, 15, 7, 52
	noise_note 4, 15, 7, 68
	noise_note 8, 15, 4, 85
	noise_note 8, 15, 1, 68
	endchannel


SECTION "Sfx_Boat", ROMX

Sfx_Boat:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 15, 15, 0, 1280
	square_note 4, 0, 0, 0
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 0, 1280
	square_note 15, 15, 2, 1280
	endchannel

.Ch6:
	duty_cycle 3
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
	duty_cycle 1
	pitch_sweep 3, -2
	square_note 4, 15, 2, 1280
	pitch_sweep 2, 2
	square_note 4, 14, 2, 1280
	pitch_sweep 3, -2
	square_note 4, 15, 2, 1792
	pitch_sweep 2, 2
	square_note 15, 14, 2, 1792
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_PlacePuzzlePieceDown", ROMX

Sfx_PlacePuzzlePieceDown:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 7, 36
	noise_note 2, 15, 7, 52
	noise_note 4, 15, 7, 68
	noise_note 8, 15, 4, 85
	noise_note 8, 15, 1, 68
	endchannel


SECTION "Sfx_EnterDoor", ROMX

Sfx_EnterDoor:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 9, 15, 1, 68
	noise_note 8, 13, 1, 67
	endchannel


SECTION "Sfx_SwitchPokemon", ROMX

Sfx_SwitchPokemon:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 8, 14, 1, 1856
	endchannel

.Ch6:
	duty_cycle 2
	square_note 2, 0, 8, 0
	square_note 8, 11, 1, 1857
	endchannel


SECTION "Sfx_Tally", ROMX

Sfx_Tally:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 4, 15, 1, 1920
	endchannel

.Ch6:
	duty_cycle 2
	square_note 1, 0, 8, 0
	square_note 4, 10, 1, 1889
	endchannel


SECTION "Sfx_Transaction", ROMX

Sfx_Transaction:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 4, 14, 1, 1792
	square_note 24, 15, 2, 2016
	endchannel

.Ch6:
	duty_cycle 2
	square_note 1, 0, 8, 0
	square_note 4, 9, 1, 1729
	square_note 24, 10, 2, 1953
	endchannel


SECTION "Sfx_Bump", ROMX

Sfx_Bump:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 5, -2
	square_note 15, 15, 1, 768
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_ExitBuilding", ROMX

Sfx_ExitBuilding:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 1, 84
	noise_note 12, 7, 1, 35
	noise_note 2, 11, 1, 84
	noise_note 12, 6, 1, 35
	noise_note 6, 4, 1, 84
	endchannel


SECTION "Sfx_Save", ROMX

Sfx_Save:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 2, 15, 1, 1792
	square_note 1, 14, 1, 1536
	square_note 1, 14, 1, 1664
	square_note 1, 14, 1, 1728
	square_note 2, 14, 1, 1792
	square_note 2, 14, 1, 1984
	square_note 15, 15, 2, 2016
	endchannel

.Ch6:
	duty_cycle 2
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
	note_type 12, 1, 0
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
	duty_cycle 2
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
	duty_cycle 2
	pitch_sweep 2, -7
	square_note 15, 15, 2, 1920
	endchannel

.Ch6:
	duty_cycle 2
	square_note 15, 12, 2, 1922
	endchannel


SECTION "Sfx_BallPoof", ROMX

Sfx_BallPoof:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
	pitch_sweep 1, 6
	square_note 15, 15, 2, 1024
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 15, 10, 2, 34
	endchannel


SECTION "Sfx_Faint", ROMX

Sfx_Faint:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	square_note 15, 13, 1, 512
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 4, 15, 5, 51
	noise_note 8, 15, 4, 34
	noise_note 15, 15, 2, 33
	endchannel


SECTION "Sfx_Run", ROMX

Sfx_Run:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 6, 1, 35
	noise_note 2, 10, 1, 51
	noise_note 2, 12, 1, 51
	noise_note 2, 5, 1, 17
	noise_note 2, 15, 1, 51
	noise_note 2, 4, 1, 17
	noise_note 2, 12, 1, 51
	noise_note 2, 3, 1, 17
	noise_note 2, 8, 1, 51
	noise_note 2, 3, 1, 17
	noise_note 8, 4, 1, 51
	endchannel


SECTION "Sfx_SlotMachineStart", ROMX

Sfx_SlotMachineStart:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	pitch_sweep 4, 4
	square_note 15, 15, 0, 1264
	pitch_sweep 1, 7
	square_note 15, 15, 2, 1616
	pitch_sweep 0, 8
	endchannel

.Ch6:
	duty_cycle 2
	square_note 15, 9, 2, 1536
	square_note 15, 9, 2, 1922
	endchannel


SECTION "Sfx_Call", ROMX

Sfx_Call:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	pitch_sweep 6, 7
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	square_note 4, 15, 7, 1952
	pitch_sweep 0, 8
	square_note 4, 0, 0, 0
	endchannel


SECTION "Sfx_Unknown60", ROMX

Sfx_Unknown60:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 6, 2, 0, 16
	noise_note 6, 2, -7, 64
	noise_note 6, 4, -7, 65
	noise_note 6, 8, -7, 65
	noise_note 6, 12, -7, 66
	noise_note 8, 13, 7, 66
	noise_note 15, 14, 7, 67
	noise_note 15, 15, 2, 67
	endchannel


SECTION "Sfx_Unknown61", ROMX

Sfx_Unknown61:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 13, 1, 65
	endchannel


SECTION "Sfx_SwitchPockets", ROMX

Sfx_SwitchPockets:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 12, 1, 66
	endchannel


SECTION "Sfx_Unknown63", ROMX

Sfx_Unknown63:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 6, -7, 33
	noise_note 2, 10, -7, 49
	noise_note 15, 15, 2, 65
	endchannel


SECTION "Sfx_Burn", ROMX

Sfx_Burn:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 13, 2, 50
	noise_note 15, 15, 2, 67
	endchannel


SECTION "Sfx_TitleScreenEntrance", ROMX

Sfx_TitleScreenEntrance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 7, 0, 34
	noise_note 2, 8, 0, 35
	noise_note 2, 9, 0, 36
	noise_note 2, 10, 0, 37
	noise_note 2, 11, 0, 38
	noise_note 15, 12, 2, 38
	endchannel


SECTION "Sfx_Unknown66", ROMX

Sfx_Unknown66:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	square_note 1, 15, 2, 1696
	square_note 1, 15, 2, 1760
	square_note 8, 15, 1, 1792
	endchannel


SECTION "Sfx_GetCoinFromSlots", ROMX

Sfx_GetCoinFromSlots:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	square_note 2, 15, 1, 1792
	square_note 8, 8, 1, 2016
	endchannel


SECTION "Sfx_PayDay", ROMX

Sfx_PayDay:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 3
	square_note 5, 14, 1, 1792
	square_note 2, 14, 1, 1920
	square_note 15, 15, 1, 1984
	endchannel

.Ch6:
	duty_cycle 2
	square_note 4, 12, 1, 1729
	square_note 2, 12, 1, 1857
	square_note 15, 13, 1, 1921
	endchannel


SECTION "Sfx_Metronome", ROMX

Sfx_Metronome:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 5, -7
	square_note 4, 4, 0, 2016
	square_note 4, 6, 0, 2016
	square_note 4, 8, 0, 2016
	square_note 8, 10, 0, 2016
	square_note 8, 10, 0, 2016
	square_note 8, 8, 0, 2016
	square_note 8, 6, 0, 2016
	square_note 8, 3, 0, 2016
	square_note 15, 1, 2, 2016
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Peck", ROMX

Sfx_Peck:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 10, 1, 18
	endchannel


SECTION "Sfx_Kinesis", ROMX

Sfx_Kinesis:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 10, -7
	square_note 15, 15, 2, 1920
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Lick", ROMX

Sfx_Lick:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 9, 7
	square_note 15, 15, 2, 1280
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Pound", ROMX

Sfx_Pound:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 10, 1, 34
	endchannel


SECTION "Sfx_MovePuzzlePiece", ROMX

Sfx_MovePuzzlePiece:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 8, 15, 1, 84
	endchannel


SECTION "Sfx_CometPunch", ROMX

Sfx_CometPunch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 15, 8, -7, 17
	noise_note 4, 15, -7, 18
	noise_note 10, 15, 1, 85
	endchannel


SECTION "Sfx_MegaPunch", ROMX

Sfx_MegaPunch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 15, 8, -7, 52
	noise_note 8, 15, 2, 53
	noise_note 10, 15, 1, 85
	endchannel


SECTION "Sfx_Scratch", ROMX

Sfx_Scratch:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 15, 9, -7, 35
	noise_note 8, 15, 1, 33
	endchannel


SECTION "Sfx_Vicegrip", ROMX

Sfx_Vicegrip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 14, 1, 75
	noise_note 10, 15, 1, 68
	noise_note 2, 14, 1, 58
	noise_note 6, 15, 1, 52
	endchannel


SECTION "Sfx_RazorWind", ROMX

Sfx_RazorWind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 4, 68
	noise_note 2, 15, 4, 20
	noise_note 15, 15, 1, 50
	endchannel


SECTION "Sfx_Cut", ROMX

Sfx_Cut:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 8, -7, 85
	noise_note 2, 15, 4, 68
	noise_note 8, 15, 4, 34
	noise_note 15, 15, 2, 33
	endchannel


SECTION "Sfx_WingAttack", ROMX

Sfx_WingAttack:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise_note 8, 4, -7, 35
	noise_note 4, 12, 4, 34
	noise_note 6, 15, 2, 35
	loopchannel 4, .branch8
	endchannel


SECTION "Sfx_Whirlwind", ROMX

Sfx_Whirlwind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 8, 4, -7, 51
	noise_note 4, 12, 4, 34
	noise_note 6, 15, 2, 35
	noise_note 15, 15, 2, 34
	endchannel


SECTION "Sfx_Bind", ROMX

Sfx_Bind:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 8, 15, -7, 50
	noise_note 8, 15, 4, 67
	noise_note 8, 15, 2, 84
	noise_note 8, 15, 1, 101
	endchannel


SECTION "Sfx_VineWhip", ROMX

Sfx_VineWhip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 12, 2, 51
	noise_note 2, 15, 2, 33
	noise_note 1, 14, 2, 51
	noise_note 1, 12, 2, 50
	noise_note 1, 9, 2, 18
	noise_note 1, 11, 2, 49
	noise_note 12, 9, 1, 16
	noise_note 8, 15, 2, 65
	endchannel


SECTION "Sfx_DoubleKick", ROMX

Sfx_DoubleKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 9, 4, 35
	noise_note 1, 11, 4, 34
	noise_note 8, 15, 1, 68
	endchannel


SECTION "Sfx_MegaKick", ROMX

Sfx_MegaKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 9, 4, 51
	noise_note 4, 11, 4, 34
	noise_note 4, 15, 1, 68
	noise_note 8, 15, 1, 85
	endchannel


SECTION "Sfx_Headbutt", ROMX

Sfx_Headbutt:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 15, -7, 85
	noise_note 8, 15, 1, 101
	endchannel


SECTION "Sfx_HornAttack", ROMX

Sfx_HornAttack:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 8, 4, 67
	noise_note 2, 12, 4, 34
	noise_note 8, 15, 2, 52
	endchannel


SECTION "Sfx_Tackle", ROMX

Sfx_Tackle:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 15, 1, 52
	noise_note 15, 15, 2, 100
	endchannel


SECTION "Sfx_PoisonSting", ROMX

Sfx_PoisonSting:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 1, 34
	noise_note 15, 15, 2, 18
	endchannel


SECTION "Sfx_Powder", ROMX

Sfx_Powder:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 12, 2, 1
	noise_note 15, 15, 4, 1
	noise_note 15, 15, 2, 1
	endchannel


SECTION "Sfx_DoubleSlap", ROMX

Sfx_DoubleSlap:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 8, 15, 1, 50
	noise_note 8, 15, 1, 51
	endchannel


SECTION "Sfx_Bite", ROMX

Sfx_Bite:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 0
	pitch_sweep 3, -2
	square_note 4, 15, 2, 512
	pitch_sweep 2, 2
	square_note 8, 14, 2, 512
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 0, 13, 1, 66
	noise_note 4, 10, 1, 50
	noise_note 0, 13, 1, 34
	noise_note 6, 10, 1, 50
	endchannel


SECTION "Sfx_JumpKick", ROMX

Sfx_JumpKick:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 3, 9, 2, 49
	noise_note 3, 11, 2, 50
	noise_note 3, 12, 2, 51
	noise_note 8, 15, 1, 84
	endchannel


SECTION "Sfx_Stomp", ROMX

Sfx_Stomp:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 12, 15, 1, 84
	noise_note 8, 15, 1, 100
	endchannel


SECTION "Sfx_TailWhip", ROMX

Sfx_TailWhip:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 1, 51
	noise_note 2, 12, 1, 50
	noise_note 2, 10, 1, 49
	noise_note 15, 8, 2, 50
	noise_note 8, 15, 1, 52
	endchannel


SECTION "Sfx_KarateChop", ROMX

Sfx_KarateChop:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 13, 2, 50
	noise_note 15, 15, 2, 67
	endchannel


SECTION "Sfx_Submission", ROMX

Sfx_Submission:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 15, 2, 67
	noise_note 4, 11, 5, 50
	noise_note 9, 8, 6, 49
	noise_note 7, 6, 4, 0
	noise_note 15, 15, 2, 85
	endchannel


SECTION "Sfx_WaterGun", ROMX

Sfx_WaterGun:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 1
	pitch_sweep 9, 7
	square_note 15, 15, 2, 1792
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 15, 3, -7, 34
	noise_note 15, 15, 2, 33
	endchannel


SECTION "Sfx_SwordsDance", ROMX

Sfx_SwordsDance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 15, 4, -7, 65
	noise_note 8, 8, -7, 65
	noise_note 8, 12, -7, 65
	noise_note 8, 15, 2, 66
	noise_note 15, 15, 2, 65
	endchannel


SECTION "Sfx_Thunder", ROMX

Sfx_Thunder:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 10, 15, -7, 80
	noise_note 15, 15, -7, 81
	noise_note 8, 15, 2, 81
	noise_note 6, 15, -7, 82
	noise_note 6, 15, -7, 83
	noise_note 8, 15, -7, 84
	noise_note 15, 15, 2, 84
	endchannel


SECTION "Sfx_Supersonic", ROMX

Sfx_Supersonic:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
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
	noise_note 3, 9, 7, 18
	noise_note 3, 10, 1, 17
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
	duty_cycle 0
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
	noise_note 1, 13, 1, 73
	noise_note 1, 13, 1, 41
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
	noise_note 10, 15, 3, 53
	noise_note 14, 15, 6, 69
	loopchannel 4, .branch8
	noise_note 12, 15, 4, 188
	noise_note 12, 15, 5, 156
	noise_note 15, 15, 4, 172
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
	noise_note 5, 12, 3, 51
	noise_note 3, 9, 2, 67
	noise_note 10, 11, 5, 51
	noise_note 15, 12, 3, 50
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
	noise_note 3, 6, 2, 34
	noise_note 3, 10, 2, 50
	noise_note 3, 13, 2, 51
	noise_note 3, 9, 2, 35
	noise_note 3, 5, 2, 18
	loopchannel 5, .branch8
	noise_note 8, 8, 1, 18
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
	noise_note 9, 15, 4, 68
	noise_note 9, 15, 2, 67
	noise_note 15, 15, 4, 66
	noise_note 15, 15, 4, 65
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
	noise_note 2, 13, 1, 74
	noise_note 2, 13, 2, 42
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
	duty_cycle 0
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
	noise_note 2, 13, 3, 16
	noise_note 3, 13, 3, 17
	noise_note 2, 13, 2, 16
	noise_note 5, 13, 2, 18
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
	noise_note 4, 15, -7, 67
	noise_note 4, 15, 2, 68
	loopchannel 9, .branch8
	endchannel


SECTION "Sfx_Psychic", ROMX

Sfx_Psychic:
	channel_count 3
	channel 5, .Ch5
	channel 6, .Ch6
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
	pitch_sweep 15, 7
	square_note 8, 12, 4, 1981
	square_note 8, 12, 4, 1982
	square_note 8, 12, 4, 1983
	square_note 8, 12, 4, 1984
	square_note 15, 12, 4, 1985
	square_note 15, 15, 2, 1984
	pitch_sweep 0, 8
	endchannel

.Ch6:
	duty_cycle 2
	square_note 8, 12, 4, 1904
	square_note 8, 12, 4, 1889
	square_note 8, 12, 4, 1890
	square_note 8, 12, 4, 1891
	square_note 15, 12, 4, 1892
	square_note 15, 15, 2, 1892
	endchannel

.Ch8:
	noise_note 15, 3, -7, 20
	noise_note 15, 12, -7, 19
	noise_note 15, 12, -7, 18
	noise_note 15, 12, -7, 17
	noise_note 15, 12, -7, 16
	noise_note 15, 12, 2, 16
	endchannel


SECTION "Sfx_Screech", ROMX

Sfx_Screech:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, -7, 2016
	square_note 15, 15, 2, 2016
	endchannel

.Ch6:
	duty_cycle 3
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
	duty_cycle 2
	pitch_sweep 10, -7
	square_note 8, 15, 1, 1792
	pitch_sweep 0, 8
	endchannel

.Ch6:
	duty_cycle 3
	square_note 8, 15, 1, 1793
	endchannel


SECTION "Sfx_Sharpen", ROMX

Sfx_Sharpen:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 6, 15, 1, 1280
	square_note 6, 15, 1, 1408
	square_note 6, 15, 1, 1536
	square_note 6, 15, 1, 1664
	square_note 8, 15, 1, 1792
	endchannel

.Ch6:
	duty_cycle 3
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
	noise_note 4, 15, -7, 81
	noise_note 8, 15, -7, 84
	noise_note 15, 15, -7, 85
	noise_note 15, 15, 3, 86
	endchannel


SECTION "Sfx_Sing", ROMX

Sfx_Sing:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	togglesfx
	vibrato $a, $24
	duty_cycle 2
	note_type 10, 8, 7
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
	duty_cycle 2
	note_type 11, 6, 7
	octave 5
	note G_, 8
	note_type 10, 6, 7
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
	duty_cycle 0
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
	noise_note 1, 13, 1, 73
	noise_note 1, 13, 1, 41
	loopchannel 26, .branch8
	endchannel


SECTION "Sfx_Shine", ROMX

Sfx_Shine:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 0
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
	noise_note 1, 15, 8, 65
	noise_note 2, 9, -4, 36
	noise_note 0, 0, 0, 0
	noise_note 3, 5, -1, 22
	noise_note 2, 0, 0, 0
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
	duty_cycle 2
	square_note 4, 11, 8, 1915
	square_note 2, 2, 1, 1915
	square_note 16, 0, 0, 0
Sfx_NoSignal_Ch5:
.branch5:
	duty_cycle 2
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
	duty_cycle 2
	pitch_sweep 5, -2
.branch5:
	square_note 2, 15, 1, 768
	loopchannel 48, .branch5
	pitch_sweep 0, 8
	duty_cycle 2
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
	noise_note 96, 0, 0, 0
	noise_note 83, 0, 0, 0
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
	duty_cycle 2
	note_type 8, 11, 1
	octave 3
	note B_, 2
	note B_, 2
	note B_, 2
	volume_envelope 11, 3
	octave 4
	note G#, 12
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 8, 12, 1
	octave 4
	note E_, 2
	note E_, 2
	note E_, 2
	volume_envelope 12, 3
	note B_, 12
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
	octave 4
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	note G#, 1
	note __, 1
	octave 5
	note E_, 5
	volume_envelope 3, 5
	note E_, 3
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 2
	note_type 6, 11, 1
	octave 3
	note B_, 4
	note B_, 2
	note B_, 2
	note B_, 4
	octave 4
	note E_, 4
	volume_envelope 11, 3
	note G#, 16
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 6, 12, 1
	octave 4
	note E_, 4
	note E_, 2
	note E_, 2
	note E_, 4
	note G#, 4
	volume_envelope 12, 3
	note B_, 16
	endchannel

.Ch7:
	togglesfx
	note_type 6, 2, 5
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
	volume_envelope 3, 5
	note E_, 4
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 2
	note_type 12, 8, 8
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
	duty_cycle 2
	note_type 12, 12, 1
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
	note_type 12, 2, 5
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
	note_type 12
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
	duty_cycle 2
	note_type 8, 11, 2
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
	duty_cycle 2
	note_type 8, 12, 3
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
	note_type 8, 2, 5
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
	volume_envelope 3, 5
	note F_, 4
	note __, 14
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 2
	note_type 8, 11, 3
	octave 4
	note C_, 6
	octave 3
	note A_, 6
	note F_, 12
	volume_envelope 11, 1
	octave 4
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note D#, 2
	note G_, 2
	volume_envelope 11, 3
	note F_, 12
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	vibrato $8, $27
	note_type 8, 12, 3
	octave 4
	note A_, 6
	note F_, 6
	note C_, 12
	volume_envelope 12, 1
	note A#, 2
	note A#, 2
	note A#, 2
	note G_, 2
	note G_, 2
	note A#, 2
	volume_envelope 12, 3
	note A_, 12
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	volume_envelope 3, 5
	note A_, 3
	note __, 3
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 2
	note_type 12, 11, 1
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
	volume_envelope 10, 5
	note A#, 16
	endchannel

.Ch6:
	togglesfx
	vibrato $8, $27
	duty_cycle 2
	note_type 12, 12, 1
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
	volume_envelope 11, 5
	octave 5
	note D#, 16
	endchannel

.Ch7:
	togglesfx
	note_type 12, 2, 5
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
	volume_envelope 3, 5
	note D#, 3
	note __, 9
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 3
	note_type 6, 11, 5
	octave 3
	note G#, 4
	note_type 4, 11, 2
	note F_, 2
	note G#, 2
	note A_, 2
	note A#, 2
	note F#, 2
	note A#, 2
	octave 4
	note C_, 4
	note C_, 2
	note_type 4, 11, 6
	note C#, 12
	sfxpriorityoff
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 6, 12, 5
	octave 4
	note C#, 6
	note_type 4, 12, 1
	note C#, 1
	note C#, 1
	note C#, 1
	note_type 4, 12, 2
	note D#, 2
	note C#, 2
	note D#, 2
	note E_, 4
	note E_, 2
	note_type 4, 12, 6
	note F_, 12
	endchannel

.Ch8:
	togglesfx
	note_type 6
	note C_, 1
	octave 5
	note C#, 2
	note __, 2
	note C#, 2
	note __, 2
	note_type 4
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
	duty_cycle 2
	note_type 12, 11, 1
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
	volume_envelope 10, 5
	note F_, 16
	endchannel

.Ch6:
	togglesfx
	vibrato $8, $27
	duty_cycle 2
	note_type 12, 12, 1
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
	volume_envelope 11, 5
	note A_, 16
	endchannel

.Ch7:
	togglesfx
	note_type 12, 2, 5
	octave 4
	note F_, 8
	note C_, 2
	note E_, 2
	note G_, 2
	note A#, 2
	note A_, 4
	volume_envelope 3, 5
	note A_, 3
	note __, 9
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 12
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
	duty_cycle 3
	tone $0001
	note_type 6, 11, 3
	octave 3
	note F_, 4
	note C#, 4
	note F#, 4
	note D#, 4
	note G#, 4
	note F_, 4
	note A#, 4
	note F#, 4
	note_type 4, 11, 3
	note A#, 4
	note B_, 4
	octave 4
	note C_, 4
	note C#, 4
	note D#, 4
	note C_, 4
	note_type 4, 11, 6
	note C#, 12
	sfxpriorityoff
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 6, 12, 4
	octave 4
	note C#, 4
	note_type 4, 12, 4
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
	note_type 4, 12, 6
	note F#, 12
	endchannel

.Ch8:
	togglesfx
	note_type 6
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
	note_type 4
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
	duty_cycle 3
	note_type 12, 10, 2
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
	duty_cycle 3
	note_type 12, 12, 2
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
	note_type 12, 2, 5
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
	note_type 12
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
	duty_cycle 2
	note_type 12, 10, 4
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
	duty_cycle 2
	note_type 12, 11, 4
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
	note_type 12, 2, 5
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
	duty_cycle 2
	note_type 8, 10, 1
	note __, 2
	octave 3
	note C_, 2
	note F_, 2
	note A_, 2
	note F_, 2
	note A#, 2
	octave 4
	note D_, 2
	volume_envelope 10, 2
	note F_, 6
	volume_envelope 10, 1
	duty_cycle 3
	octave 3
	note E_, 2
	note G_, 2
	octave 4
	note C_, 2
	volume_envelope 10, 4
	note F_, 9
	note __, 9
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	duty_cycle 3
	note_type 8, 12, 2
	note __, 2
	octave 4
	note F_, 2
	note __, 2
	note A_, 2
	volume_envelope 12, 1
	note A#, 2
	note A_, 2
	note A#, 2
	volume_envelope 12, 2
	octave 5
	note C_, 6
	volume_envelope 12, 1
	octave 4
	note C_, 2
	note E_, 2
	note G_, 2
	volume_envelope 12, 4
	note A_, 9
	note __, 9
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 8
	note __, 2
	note_type 12
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
	duty_cycle 2
	vibrato $c, $44
	note_type 12, 10, 4
	note __, 8
	octave 2
	note G_, 1
	note __, 2
	note C#, 1
	note E_, 1
	note D#, 1
	note E_, 4
	volume_envelope 10, 1
	note G_, 2
	note F_, 2
	note E_, 2
	note D_, 2
	note G#, 2
	note B_, 2
	volume_envelope 10, 6
	octave 3
	note D_, 10
	note __, 6
	endchannel

.Ch6:
	togglesfx
	duty_cycle 3
	vibrato $c, $44
	note_type 12, 7, 4
	octave 1
	note B_, 1
	octave 2
	note D_, 1
	note F_, 1
	note G#, 1
	volume_envelope 9, 4
	note D_, 1
	note F_, 1
	note G#, 1
	note B_, 1
	volume_envelope 11, 4
	octave 3
	note C#, 1
	note __, 2
	octave 2
	note A#, 1
	octave 3
	note C#, 4
	note __, 2
	volume_envelope 11, 1
	note C#, 2
	note D#, 2
	note E_, 2
	volume_envelope 11, 6
	note F_, 16
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 6, 2, 5
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
	note_type 12, 2, 0
	note B_, 16
	note __, 6
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $3
	note_type 12
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
	duty_cycle 2
	vibrato $c, $34
	note_type 8, 10, 1
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
	volume_envelope 10, 7
	note B_, 12
	note __, 6
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 8, 11, 1
	octave 4
	note G_, 2
	note G_, 2
	note G_, 2
	note A_, 4
	note B_, 2
	volume_envelope 11, 4
	octave 5
	note C_, 12
	volume_envelope 11, 1
	note C_, 2
	note C_, 2
	note C_, 2
	volume_envelope 11, 7
	note D_, 12
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 8
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
	duty_cycle 3
	vibrato $c, $34
	note_type 12, 10, 1
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
	volume_envelope 9, 1
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note A#, 1
	volume_envelope 8, 1
	octave 5
	note D_, 1
	octave 4
	note A#, 1
	note F_, 1
	note D_, 1
	volume_envelope 10, 1
	note C_, 2
	note E_, 2
	note G_, 2
	volume_envelope 10, 7
	note A_, 10
	note __, 6
	endchannel

.Ch6:
	togglesfx
	duty_cycle 3
	vibrato $c, $34
	note_type 12, 12, 1
	octave 3
	note B_, 2
	note G_, 2
	note B_, 2
	volume_envelope 11, 6
	octave 4
	note D_, 12
	volume_envelope 12, 1
	note E_, 2
	note G_, 2
	octave 5
	note C_, 2
	volume_envelope 11, 7
	note D_, 10
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 12, 2, 5
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
	note_type 6
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
	note_type 12
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
	duty_cycle 3
	note_type 6, 10, 4
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
	volume_envelope 7, 1
	octave 3
	note E_, 1
	note F#, 1
	note G#, 1
	note A_, 1
	volume_envelope 9, 1
	note B_, 1
	octave 4
	note C#, 1
	note D_, 1
	note D#, 1
	volume_envelope 10, 4
	note E_, 4
	note __, 12
	endchannel

.Ch6:
	togglesfx
	duty_cycle 3
	note_type 6, 11, 4
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
	note_type 6, 2, 5
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
	note_type 6
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
	duty_cycle 3
	vibrato $8, $24
	note_type 12, 10, 3
	octave 4
	note D_, 1
	note __, 1
	octave 3
	note B_, 1
	octave 4
	note D_, 1
	note G_, 6
	volume_envelope 11, 1
	note E_, 2
	note F#, 2
	note G_, 2
	volume_envelope 10, 5
	note F#, 8
	note __, 6
	endchannel

.Ch6:
	togglesfx
	duty_cycle 3
	vibrato $8, $24
	note_type 12, 11, 3
	octave 4
	note G_, 1
	note __, 1
	note D_, 1
	note G_, 1
	note B_, 6
	volume_envelope 12, 1
	note A_, 2
	note B_, 2
	octave 5
	note C_, 2
	volume_envelope 11, 5
	note D_, 8
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 6, 2, 5
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
	note_type 6
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
	duty_cycle 2
	vibrato $8, $24
	note_type 6, 9, 2
	octave 4
	note F_, 3
	callchannel .branch5
	note A#, 3
	transpose 0, 2
	callchannel .branch5
	transpose 0, 0
	volume_envelope 10, 7
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
	duty_cycle 3
	vibrato $8, $24
	note_type 6, 11, 5
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
	volume_envelope 9, 5
	octave 5
	note C_, 1
	volume_envelope 11, 5
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
	volume_envelope 9, 5
	octave 5
	note D_, 1
	volume_envelope 11, 5
	note D#, 8
	note F_, 16
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 6, 2, 5
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
	note_type 6
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
	duty_cycle 2
	note_type 8, 8, 2
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
	volume_envelope 9, 7
	note G#, 14
	note __, 6
	endchannel

.Ch6:
	togglesfx
	duty_cycle 2
	note_type 8, 11, 3
	note __, 3
	octave 4
	note B_, 1
	octave 5
	note C_, 2
	octave 4
	note G#, 4
	note A#, 2
	volume_envelope 12, 1
	note B_, 4
	note A#, 2
	note G#, 4
	note F_, 2
	note F#, 4
	note F_, 2
	note D#, 4
	volume_envelope 11, 7
	note F_, 14
	note __, 6
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 8
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
	note_type 1, 15, 1
	duty_cycle 0
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
	volume_envelope 12, 1
	octave 5
	note F_, 5
	note A_, 5
	volume_envelope 9, 1
	octave 6
	note C_, 5
	note E_, 5
	volume_envelope 7, 1
	octave 5
	note F#, 5
	note A#, 5
	volume_envelope 5, 1
	octave 6
	note C#, 5
	note E_, 5
	endchannel

.Ch8:
.branch8:
	noise_note 9, 9, -6, 0
	noise_note 9, 11, -6, 17
	loopchannel 6, .branch8
	noise_note 9, 10, 7, 0
	noise_note 16, 7, 5, 17
	endchannel


SECTION "Sfx_Sketch", ROMX

Sfx_Sketch:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 10, 5
.branch5:
	square_note 2, 15, 1, 1760
	square_note 13, 10, -7, 1456
	square_note 4, 0, 0, 0
	square_note 9, 15, 4, 1816
	loopchannel 3, .branch5
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_RainDance", ROMX

Sfx_RainDance:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise_note 11, 7, -5, 80
	noise_note 6, 7, -5, 79
	noise_note 11, 7, -7, 71
	noise_note 15, 6, -6, 34
	loopchannel 3, .branch8
	noise_note 6, 6, -5, 80
	noise_note 5, 5, -5, 79
	noise_note 5, 4, -7, 71
	noise_note 10, 3, 2, 70
	endchannel


SECTION "Sfx_Aeroblast", ROMX

Sfx_Aeroblast:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	sound_duty 2, 0, 3, 3
	pitch_sweep 15, 5
	square_note 28, 15, 8, 1408
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 4, 15, 8, 108
	noise_note 4, 12, 8, 92
	noise_note 4, 7, 8, 91
	noise_note 16, 3, 1, 90
	endchannel


SECTION "Sfx_Spark", ROMX

Sfx_Spark:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise_note 4, 15, 8, 93
	noise_note 4, 13, 8, 111
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_Curse", ROMX

Sfx_Curse:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 3
	square_note 4, 15, 2, 1155
	square_note 4, 15, 2, 1297
	square_note 4, 15, 2, 1417
	square_note 4, 15, 2, 1517
	endchannel

.Ch8:
	noise_note 20, 9, -2, 9
	endchannel


SECTION "Sfx_Rage", ROMX

Sfx_Rage:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 0
	square_note 3, 13, 1, 1968
	square_note 3, 13, 1, 1986
	square_note 24, 13, 2, 2005
	endchannel

.Ch8:
	noise_note 3, 15, 4, 26
	noise_note 3, 15, 4, 25
	noise_note 24, 15, 2, 24
	endchannel


SECTION "Sfx_Thief", ROMX

Sfx_Thief:
	channel_count 1
	channel 8, .Ch8

.Ch8:
.branch8:
	noise_note 0, 0, 0, 0
	noise_note 4, 14, 1, 18
	noise_note 0, 0, 0, 0
	noise_note 2, 11, 1, 34
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_Thief2", ROMX

Sfx_Thief2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	note_type 2, 15, 4
	duty_cycle 0
	octave 4
	note C#, 3
	note A#, 3
	volume_envelope 13, 2
	note C#, 3
	note A#, 3
	volume_envelope 11, 1
	note C_, 3
	note A_, 3
	volume_envelope 8, 1
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
	duty_cycle 0
	square_note 32, 7, -7, 1824
	pitch_sweep 9, 5
	square_note 4, 15, 8, 1568
	square_note 4, 14, 8, 1584
	square_note 4, 13, 8, 1600
	square_note 4, 9, 5, 1568
	square_note 4, 7, 3, 1584
	square_note 4, 5, 1, 1600
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 32, 14, -7, 0
	endchannel


SECTION "Sfx_MindReader", ROMX

Sfx_MindReader:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	togglesfx
	duty_cycle 2
	note_type 2, 15, 1
	octave 5
	note C_, 3
	volume_envelope 4, 1
	note C_, 3
	volume_envelope 15, 1
	note C#, 3
	volume_envelope 4, 1
	note C#, 3
	volume_envelope 15, 1
	note D_, 3
	volume_envelope 4, 1
	note D_, 3
	togglesfx
	endchannel

.Ch8:
	noise_note 17, 10, -7, 25
	noise_note 18, 10, -7, 24
	endchannel


SECTION "Sfx_Nightmare", ROMX

Sfx_Nightmare:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 0
	pitch_sweep 3, 4
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
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Snore", ROMX

Sfx_Snore:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 14, -2, 75
	noise_note 2, 14, -2, 91
	noise_note 2, 0, 0, 0
	noise_note 4, 14, -6, 71
	noise_note 4, 14, -6, 70
	noise_note 4, 14, -6, 69
	endchannel


SECTION "Sfx_SweetKiss", ROMX

Sfx_SweetKiss:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
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
	duty_cycle 0
	pitch_sweep 9, 7
	square_note 2, 15, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 12, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 11, 4, 1906
	square_note 4, 0, 0, 0
	square_note 2, 10, 1, 1906
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_BellyDrum", ROMX

Sfx_BellyDrum:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
	pitch_sweep 10, -4
	square_note 12, 15, 1, 1443
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 12, 11, 1, 108
	endchannel


SECTION "Sfx_Toxic", ROMX

Sfx_Toxic:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 9, 5
	square_note 2, 12, -1, 947
	square_note 5, 15, 8, 1123
	square_note 4, 13, 1, 1347
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_SludgeBomb", ROMX

Sfx_SludgeBomb:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
	pitch_sweep 12, 5
	square_note 3, 15, 8, 1409
	square_note 1, 0, 0, 0
	pitch_sweep 12, -3
	square_note 16, 15, 2, 1489
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 3, 14, 2, 110
	noise_note 1, 0, 0, 0
	noise_note 16, 14, 2, 109
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
	duty_cycle 3
	pitch_sweep 15, -5
	note_type 3, 15, 8
	octave 3
	note F_, 3
	note G#, 3
	note B_, 3
	note E_, 3
	note G_, 3
	note A#, 3
	volume_envelope 11, -7
	note D#, 3
	note F#, 3
	note A_, 3
	volume_envelope 5, -7
	note D_, 3
	volume_envelope 2, -7
	note F_, 3
	note G#, 3
	pitch_sweep 0, 8
	togglesfx
	endchannel


SECTION "Sfx_Outrage", ROMX

Sfx_Outrage:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 11, 14, -2, 108
	noise_note 11, 14, -2, 107
	noise_note 11, 14, -2, 106
	noise_note 11, 14, -2, 105
	noise_note 11, 14, 1, 89
	endchannel


SECTION "Sfx_PerishSong", ROMX

Sfx_PerishSong:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	togglesfx
	duty_cycle 0
	vibrato $12, $53
	note_type 8, 10, -7
	octave 4
	note A_, 9
	note G#, 9
	togglesfx
	endchannel

.Ch6:
	togglesfx
	duty_cycle 0
	vibrato $12, $53
	note_type 8, 10, -7
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
	duty_cycle 2
	pitch_sweep 9, 7
	square_note 4, 15, 8, 1664
	square_note 20, 15, 8, 1664
	square_note 20, 12, 8, 1632
	square_note 20, 10, 8, 1648
	square_note 20, 8, 8, 1664
	square_note 20, 15, 8, 1377
	square_note 20, 12, 8, 1345
	square_note 20, 10, 8, 1313
	square_note 20, 8, 8, 1297
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 4, 12, 8, 68
	noise_note 20, 12, 8, 80
	noise_note 20, 12, 8, 82
	noise_note 20, 12, 8, 84
	noise_note 20, 12, 8, 86
	noise_note 64, 12, 7, 87
	endchannel


SECTION "Sfx_Attract", ROMX

Sfx_Attract:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 0
	pitch_sweep 7, 7
	square_note 4, 10, -1, 1776
	square_note 12, 15, 8, 1824
	pitch_sweep 7, -7
	square_note 8, 15, 1, 1856
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Kinesis2", ROMX

Sfx_Kinesis2:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 0
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
	noise_note 2, 14, 1, 73
	noise_note 0, 0, 0, 0
	loopchannel 8, .branch8
	noise_note 8, 14, 1, 73
	endchannel


SECTION "Sfx_MeanLook", ROMX

Sfx_MeanLook:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	pitch_sweep 7, 7
	duty_cycle 3
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
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_HealBell", ROMX

Sfx_HealBell:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
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
	duty_cycle 0
.branch5:
	pitch_sweep 11, -7
	square_note 8, 15, 1, 1881
	pitch_sweep 5, 7
	square_note 8, 15, 1, 1881
	square_note 16, 0, 0, 0
	loopchannel 2, .branch5
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_ExpBar", ROMX

Sfx_ExpBar:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 13, 7
	square_note 8, 14, 1, 1872
	pitch_sweep 14, 7
	square_note 8, 4, 8, 1760
	square_note 8, 5, 8, 1784
	square_note 8, 6, 8, 1808
	square_note 8, 7, 8, 1832
	square_note 8, 8, 8, 1856
	square_note 8, 9, 8, 1880
	square_note 16, 10, 8, 1904
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_MilkDrink", ROMX

Sfx_MilkDrink:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
.branch5:
	pitch_sweep 10, 4
	square_note 2, 14, -2, 1248
	square_note 13, 15, 7, 656
	pitch_sweep 9, -6
	square_note 4, 12, -1, 1505
	square_note 2, 0, 0, 0
	loopchannel 6, .branch5
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_Present", ROMX

Sfx_Present:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 13, 6
.branch5:
	square_note 2, 15, 1, 1856
	square_note 1, 0, 0, 0
	loopchannel 3, .branch5
	square_note 16, 15, 1, 1920
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_MorningSun", ROMX

Sfx_MorningSun:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 3
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
	duty_cycle 2
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
	duty_cycle 2
	pitch_sweep 12, -6
	square_note 16, 0, 0, 0
.branch5:
	square_note 2, 15, 8, 1908
	square_note 36, 0, 0, 0
	loopchannel 2, .branch5
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 48, 1, -7, 54
	noise_note 48, 7, 6, 54
	endchannel


SECTION "Sfx_BeatUp", ROMX

Sfx_BeatUp:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 2, 14, 8, 105
	noise_note 6, 13, 8, 36
	noise_note 2, 14, 8, 108
	noise_note 4, 12, 8, 70
	noise_note 6, 13, 1, 36
	endchannel


SECTION "Sfx_SweetScent", ROMX

Sfx_SweetScent:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 9, 6
	square_note 6, 15, 8, 1888
	square_note 6, 14, 8, 1824
	pitch_sweep 13, -7
	square_note 22, 15, 1, 1840
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_BatonPass", ROMX

Sfx_BatonPass:
	channel_count 2
	channel 5, .Ch5
	channel 8, .Ch8

.Ch5:
	duty_cycle 2
	pitch_sweep 15, 7
	square_note 32, 15, 2, 1664
	square_note 1, 15, 1, 1888
	square_note 32, 0, 0, 0
	square_note 1, 15, 1, 1888
	square_note 26, 0, 0, 0
	square_note 1, 15, 1, 1888
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 32, 15, 2, 32
	endchannel


SECTION "Sfx_EggCrack", ROMX

Sfx_EggCrack:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	note_type 1, 15, 1
	duty_cycle 0
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
	note_type 1, 12, 1
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
	duty_cycle 1
	note_type 2, 14, 1
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
	volume_envelope 12, 1
	note G#, 2
	note G_, 2
	note F#, 2
	volume_envelope 9, 1
	note F_, 2
	note E_, 2
	note D#, 2
	volume_envelope 6, 1
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
	note_type 2, 15, 1
	duty_cycle 2
	octave 5
	note E_, 1
	note C_, 1
	note __, 1
	note G_, 1
	note D_, 1
	volume_envelope 14, 2
	note B_, 7
	volume_envelope 8, 2
	note B_, 7
	volume_envelope 4, 2
	note B_, 7
	endchannel


SECTION "Sfx_GsIntroCharizardFireball", ROMX

Sfx_GsIntroCharizardFireball:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 8, 12, -7, 77
	noise_note 8, 15, 1, 55
.branch8:
	noise_note 1, 15, 8, 79
	noise_note 0, 12, 8, 38
	noise_note 1, 13, 8, 95
	noise_note 0, 10, 8, 55
	loopchannel 12, .branch8
	noise_note 3, 15, 8, 111
	noise_note 4, 13, 8, 95
	noise_note 12, 13, 8, 92
	noise_note 40, 13, 3, 79
	endchannel


SECTION "Sfx_GsIntroPokemonAppears", ROMX

Sfx_GsIntroPokemonAppears:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 8, 8, 79
	noise_note 2, 8, -7, 2
	noise_note 2, 5, -7, 18
	noise_note 2, 3, -7, 34
	noise_note 0, 15, 8, 39
	noise_note 1, 15, 8, 79
	noise_note 8, 15, 1, 0
	endchannel


SECTION "Sfx_Flash", ROMX

Sfx_Flash:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 14, -7
	square_note 1, 4, 0, 2024
	square_note 1, 6, 0, 2024
	square_note 2, 8, 0, 2024
	square_note 5, 10, 0, 2024
	square_note 6, 10, 0, 2024
	square_note 7, 8, 0, 2024
	square_note 8, 6, 0, 2024
	square_note 9, 3, 0, 2024
	square_note 15, 1, 2, 2024
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_GameFreakLogoGs", ROMX

Sfx_GameFreakLogoGs:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 3
	pitch_sweep 7, -7
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
	pitch_sweep 0, 8
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
	note_type 8, 11, 1
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
	note_type 8, 12, 1
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
	note_type 8, 2, 5
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
	note_type 12
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
	duty_cycle 3
	vibrato $12, $34
	note_type 6, 11, 1
	note __, 8
	octave 3
	note E_, 4
	note E_, 4
	note A_, 4
	octave 4
	note C#, 4
	volume_envelope 10, 4
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
	duty_cycle 2
	vibrato $12, $34
	note_type 6, 12, 1
	octave 4
	note E_, 4
	note F#, 4
	note G_, 4
	note G_, 4
	note G_, 4
	note G_, 4
	volume_envelope 11, 4
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
	note_type 12, 2, 5
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
	note_type 12
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
	duty_cycle 3
	note_type 8, 11, 4
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
	volume_envelope 12, 1
	note F_, 4
	note G_, 4
	note A_, 4
	note_type 12, 10, 8
	note A#, 12
	note __, 4
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	duty_cycle 3
	note_type 8, 12, 4
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
	volume_envelope 13, 1
	octave 4
	note D#, 4
	note D#, 4
	note D#, 4
	note_type 12, 11, 8
	note D_, 12
	note __, 4
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 12, 2, 5
	octave 2
	note A#, 12
	note __, 4
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 8
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
	note_type 12
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
	duty_cycle 3
	note_type 8, 11, 2
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
	note_type 12, 10, 8
	note F#, 12
	note __, 4
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	duty_cycle 3
	note_type 8, 11, 2
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
	note_type 12, 11, 8
	note A_, 12
	note __, 4
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 8
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
	duty_cycle 3
	note_type 8, 10, 5
	octave 3
	note B_, 2
	note G_, 2
	note B_, 2
	octave 4
	note D_, 14
	note __, 2
	duty_cycle 2
	volume_envelope 8, 5
	octave 2
	note F_, 1
	note __, 1
	note F_, 6
	volume_envelope 10, 5
	duty_cycle 3
	octave 3
	note A_, 2
	note G_, 2
	note F_, 10
	note __, 2
	duty_cycle 2
	volume_envelope 8, 5
	octave 2
	note F_, 1
	note __, 1
	note F_, 6
	volume_envelope 10, 5
	duty_cycle 3
	octave 3
	note A#, 12
	volume_envelope 11, 2
	note G_, 4
	note A_, 4
	note A#, 4
	note_type 12, 10, 8
	note A_, 14
	note __, 2
	endchannel

.Ch6:
	togglesfx
	vibrato $12, $34
	duty_cycle 3
	note_type 8, 11, 5
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
	volume_envelope 12, 2
	note G_, 4
	note G_, 4
	note G_, 4
	note_type 12, 11, 8
	note F#, 14
	note __, 2
	endchannel

.Ch7:
	togglesfx
	note_type 8, 2, 5
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
	note_type 12, 2, 5
	note D_, 14
	note __, 2
	endchannel

.Ch8:
	togglesfx
	sfxtogglenoise $4
	note_type 8
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
	noise_note 4, 15, 1, 95
	noise_note 1, 10, 0, 66
	noise_note 16, 15, 1, 83
	endchannel


SECTION "Sfx_Damage", ROMX

Sfx_Damage:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 4, 15, 1, 94
	noise_note 1, 10, 0, 18
	noise_note 4, 15, 0, 50
	noise_note 16, 15, 1, 68
	endchannel


SECTION "Sfx_SuperEffective", ROMX

Sfx_SuperEffective:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 3, 15, 1, 79
	noise_note 1, 12, 8, 34
	noise_note 2, 15, 8, 63
	noise_note 3, 13, 0, 21
	noise_note 32, 15, 2, 53
	endchannel


SECTION "Sfx_BallBounce", ROMX

Sfx_BallBounce:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
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
	duty_cycle 2
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
	pitch_sweep 10, -7
	duty_cycle 1
	square_note 6, 15, 8, 1520
	square_note 2, 15, 1, 1568
	square_note 16, 15, 1, 1616
	pitch_sweep 0, 8
	endchannel

.Ch8:
	noise_note 2, 14, 8, 34
	noise_note 17, 10, -2, 0
.branch8:
	noise_note 4, 13, -1, 16
	noise_note 8, 9, 1, 0
	noise_note 2, 6, 1, 7
	loopchannel 5, .branch8
	noise_note 4, 9, -1, 0
	noise_note 10, 6, 1, 0
	noise_note 6, 5, -1, 0
	noise_note 2, 2, 1, 7
	endchannel


SECTION "Sfx_HitEndOfExpBar", ROMX

Sfx_HitEndOfExpBar:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 1, 14, 1, 1929
	square_note 1, 14, 1, 1954
	square_note 16, 14, 1, 1969
	endchannel

.Ch6:
	duty_cycle 2
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
	duty_cycle 1
	pitch_sweep 10, 7
	square_note 27, 15, 4, 1872
	square_note 27, 13, 4, 1872
	square_note 27, 11, 4, 1872
	square_note 27, 9, 4, 1872
	square_note 27, 7, 4, 1872
	square_note 27, 5, 4, 1872
	square_note 27, 3, 4, 1872
	square_note 27, 1, 4, 1872
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_GetTrademon", ROMX

Sfx_GetTrademon:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	square_note 32, 0, 0, 0
	duty_cycle 2
	pitch_sweep 11, -7
	square_note 27, 1, 4, 1980
	square_note 27, 3, 4, 1980
	square_note 27, 5, 4, 1980
	square_note 27, 7, 4, 1980
	square_note 27, 9, 4, 1980
	square_note 27, 11, 4, 1980
	square_note 27, 13, 4, 1980
	square_note 27, 15, 4, 1980
	pitch_sweep 0, 8
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
	duty_cycle 2
	square_note 4, 5, -7, 1681
	square_note 4, 6, -7, 1684
	square_note 4, 7, 8, 1687
	square_note 4, 7, -7, 1690
	square_note 4, 6, 8, 1710
	square_note 16, 6, -7, 1707
	square_note 104, 6, 5, 1704
	endchannel

.Ch8:
	noise_note 5, 10, -7, 16
	noise_note 4, 9, -7, 32
	noise_note 4, 8, -7, 33
	noise_note 4, 7, -7, 34
	noise_note 4, 8, -7, 33
	noise_note 4, 9, -7, 32
	noise_note 4, 9, -7, 16
	noise_note 104, 10, 3, 0
	endchannel


SECTION "Sfx_2Boops", ROMX

Sfx_2Boops:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
.branch5:
	pitch_sweep 7, -1
	square_note 1, 9, -1, 1379
	square_note 4, 15, 2, 1205
	pitch_sweep 4, 3
	square_note 16, 15, 8, 1485
	loopchannel 2, .branch5
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_TitleScreenIntro", ROMX

Sfx_TitleScreenIntro:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 1, 0, 16
	noise_note 2, 2, 0, 16
	noise_note 2, 3, 0, 32
	noise_note 2, 4, 0, 32
	noise_note 2, 5, 0, 33
	noise_note 2, 6, 0, 34
	noise_note 4, 7, 0, 34
	noise_note 8, 8, 0, 34
	noise_note 15, 9, 4, 34
	endchannel


SECTION "Sfx_StopSlot", ROMX

Sfx_StopSlot:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	square_note 1, 15, 8, 1888
	square_note 4, 8, 2, 1888
	endchannel


SECTION "Sfx_GlassTing", ROMX

Sfx_GlassTing:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	square_note 32, 13, 1, 2012
	endchannel


SECTION "Sfx_GlassTing2", ROMX

Sfx_GlassTing2:
	channel_count 2
	channel 5, .Ch5
	channel 6, .Ch6

.Ch5:
	duty_cycle 2
	square_note 16, 15, 1, 2012
	endchannel

.Ch6:
	duty_cycle 2
	square_note 16, 13, 1, 2013
	endchannel


SECTION "Sfx_IntroUnown1", ROMX

Sfx_IntroUnown1:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	vibrato $1, $a3
	duty_cycle 2
	square_note 8, 3, -1, 1797
	square_note 32, 14, 2, 1797
	endchannel


SECTION "Sfx_IntroUnown2", ROMX

Sfx_IntroUnown2:
	channel_count 1
	channel 6, .Ch6

.Ch6:
	vibrato $1, $73
	duty_cycle 2
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
	duty_cycle 2
	pitch_sweep 1, -6
	square_note 3, 8, 2, 1792
	square_note 1, 3, 1, 1793
	pitch_sweep 1, 6
	square_note 4, 11, 1, 1600
	square_note 16, 3, 1, 1601
	endchannel


SECTION "Sfx_DittoTransform", ROMX

Sfx_DittoTransform:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 2, 6
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
	noise_note 1, 5, 8, 89
	noise_note 2, 9, 1, 35
	endchannel


SECTION "Sfx_IntroPichu", ROMX

Sfx_IntroPichu:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 3
	pitch_sweep 4, -5
	square_note 1, 8, 8, 1904
	square_note 3, 0, 0, 0
	pitch_sweep 1, 7
	square_note 2, 8, 8, 1910
	endchannel


SECTION "Sfx_IntroSuicune2", ROMX

Sfx_IntroSuicune2:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 10, 7, 49
	noise_note 1, 9, 1, 0
	noise_note 1, 9, 2, 33
	noise_note 1, 9, 1, 0
	noise_note 1, 9, 2, 34
	noise_note 1, 8, 2, 17
	noise_note 1, 8, 2, 34
	noise_note 1, 7, 2, 17
	noise_note 1, 7, 2, 18
	noise_note 1, 6, 2, 16
	noise_note 1, 6, 3, 0
	noise_note 1, 5, 3, 16
	noise_note 1, 4, 3, 0
	noise_note 1, 3, 3, 16
	noise_note 1, 2, 3, 0
	noise_note 1, 1, 3, 16
	endchannel


SECTION "Sfx_IntroSuicune3", ROMX

Sfx_IntroSuicune3:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 8, 8, 49
	noise_note 8, 3, -1, 17
	noise_note 4, 10, 4, 16
	noise_note 4, 4, 4, 16
	noise_note 4, 2, 4, 16
	endchannel


SECTION "Sfx_DittoBounce", ROMX

Sfx_DittoBounce:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
	pitch_sweep 2, -4
	square_note 2, 8, 2, 1200
	square_note 0, 3, 1, 1200
	pitch_sweep 3, 4
	square_note 16, 11, 1, 1056
	endchannel


SECTION "Sfx_IntroSuicune4", ROMX

Sfx_IntroSuicune4:
	channel_count 1
	channel 8, .Ch8

.Ch8:
	noise_note 1, 10, 1, 92
	noise_note 0, 0, 0, 0
	noise_note 1, 12, 1, 77
	noise_note 0, 0, 0, 0
	noise_note 4, 11, 2, 49
	noise_note 0, 0, 0, 0
	noise_note 4, 10, 2, 2
	noise_note 0, 0, 0, 0
	noise_note 4, 9, 2, 1
	noise_note 0, 0, 0, 0
	noise_note 32, 7, 2, 0
	endchannel


SECTION "Sfx_GameFreakPresents", ROMX

Sfx_GameFreakPresents:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	duty_cycle 2
	note_type 2, 11, 1
	pitch_sweep 15, -7
	transpose 1, 10
	octave 5
	note C_, 2
	note E_, 2
	note G_, 2
	octave 6
	note C_, 2
	note E_, 2
	note G_, 3
	volume_envelope 8, 1
	note G_, 3
	volume_envelope 5, 1
	note G_, 3
	volume_envelope 3, 1
	note G_, 3
	endchannel


SECTION "Sfx_Tingle", ROMX

Sfx_Tingle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	duty_cycle 1
	transpose 0, 11
	note_type 1, 11, 1
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
	volume_envelope 10, 1
	note G_, 13
	endchannel


SECTION "Sfx_TwoPcBeeps", ROMX

Sfx_TwoPcBeeps:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 2
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
	duty_cycle 2
	note_type 2, 14, 8
	transpose 0, 2
	octave 4
	note C_, 2
	volume_envelope 4, 8
	note C_, 2
	volume_envelope 14, 8
	note G_, 2
	volume_envelope 4, 8
	note G_, 2
	octave 5
	volume_envelope 14, 8
	note E_, 2
	volume_envelope 4, 8
	note E_, 2
	octave 6
	volume_envelope 14, 8
	note C_, 2
	volume_envelope 4, 3
	note C_, 16
	endchannel

.Ch6:
	togglesfx
	note_type 2, 11, 8
	note __, 9
	note __, 16
	endchannel

.Ch7:
	togglesfx
	note_type 2, 11, 8
	note __, 9
	note __, 16
	endchannel


SECTION "Sfx_Twinkle", ROMX

Sfx_Twinkle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	togglesfx
	duty_cycle 0
	transpose 0, 2
	note_type 2, 14, 1
	octave 3
	note G_, 2
	volume_envelope 11, 1
	octave 4
	note D_, 2
	volume_envelope 14, 1
	note B_, 2
	volume_envelope 11, 1
	note G_, 2
	volume_envelope 14, 1
	octave 5
	note D_, 2
	volume_envelope 11, 1
	octave 4
	note B_, 2
	volume_envelope 14, 1
	octave 5
	note G_, 6
	endchannel


SECTION "Sfx_Puddle", ROMX

Sfx_Puddle:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 9, 7
	square_note 15, 9, 8, 1792
	pitch_sweep 0, 8
	endchannel


SECTION "Sfx_AbilitySlideout", ROMX

Sfx_AbilitySlideout:
	channel_count 1
	channel 5, .Ch5

.Ch5:
	duty_cycle 1
	pitch_sweep 9, -7
	square_note 3, 14, 8, 2047
	square_note 23, 14, 8, 2016
	pitch_sweep 0, 8
	endchannel
