SECTION "Sfx_PokeballsPlacedOnTable", ROMX

Sfx_PokeballsPlacedOnTable:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $3a
	sound __,  5, $f2, $0200
	soundinput $22
	sound __,  9, $e2, $0200
	soundinput $8
	endchannel


SECTION "Sfx_BallWiggle", ROMX

Sfx_BallWiggle:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $3a
	sound __,  5, $f2, $0400
	soundinput $22
	sound __,  9, $e2, $0400
	soundinput $8
	endchannel


SECTION "Sfx_Potion", ROMX

Sfx_Potion:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $17
	sound __, 16, $f0, $04f0
	sound __, 16, $f2, $0650
	soundinput $8
	endchannel


SECTION "Sfx_FullHeal", ROMX

Sfx_FullHeal:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $14
	sound __,  5, $f2, $0600
	sound __,  5, $f2, $0600
	soundinput $17
	sound __, 16, $f2, $0600
	soundinput $8
	endchannel


SECTION "Sfx_Menu", ROMX

Sfx_Menu:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  2, $e2, $33
	noise __,  9, $e1, $22
	endchannel


SECTION "Sfx_ReadText", ROMX

Sfx_ReadText:
Sfx_ReadText2:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  1, $91, $07c0
	sound __,  1, $81, $07d0
	sound __,  1, $91, $07c0
	sound __, 13, $a1, $07d0
	endchannel


SECTION "Sfx_Poison", ROMX

Sfx_Poison:
	musicheader 1, 5, .Ch5

.Ch5:
.loop:
	dutycycle $0
	soundinput $14
	sound __,  5, $f2, $0600
	loopchannel 4, .loop
	sound __, 16, $f3, $0600
	soundinput $8
	endchannel


SECTION "Sfx_GotSafariBalls", ROMX

Sfx_GotSafariBalls:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $15
	sound __, 16, $f0, $04f0
	sound __, 16, $f2, $0650
	soundinput $8
	endchannel


SECTION "Sfx_BootPc", ROMX

Sfx_BootPc:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __, 16, $f2, $07c0
	sound __, 16, $0, 0
	sound __,  4, $a1, $0780
	sound __,  4, $a1, $0700
	sound __,  4, $a1, $0740
	sound __,  4, $a1, $0700
	sound __,  4, $a1, $0780
	sound __,  4, $a1, $0700
	sound __,  4, $a1, $07c0
	sound __,  9, $a1, $0700
	endchannel


SECTION "Sfx_ShutDownPc", ROMX

Sfx_ShutDownPc:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  5, $f0, $0600
	sound __,  5, $f0, $0400
	sound __,  5, $f0, $0200
	sound __,  2, $0, 0
	endchannel


SECTION "Sfx_ChoosePcOption", ROMX

Sfx_ChoosePcOption:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  7, $f0, $0700
	sound __,  5, $0, 0
	sound __,  7, $f0, $0700
	sound __,  2, $0, 0
	endchannel


SECTION "Sfx_EscapeRope", ROMX

Sfx_EscapeRope:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	sound __, 16, $d7, $0600
	sound __, 16, $b7, $0580
	sound __, 16, $87, $0500
	sound __, 16, $47, $0480
	sound __, 16, $17, $0400
	soundinput $8
	endchannel


SECTION "Sfx_PushButton", ROMX

Sfx_PushButton:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  5, $0, 0
	sound __,  3, $f1, $0680
	sound __,  2, $0, 0
	sound __,  5, $f1, $0780
	sound __,  5, $0, 0
	endchannel


SECTION "Sfx_SecondPartOfItemfinder", ROMX

Sfx_SecondPartOfItemfinder:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $2c
	sound __,  5, $f2, $0500
	soundinput $22
	sound __,  3, $f1, $0500
	soundinput $8
	sound __,  2, $0, 0
	endchannel


SECTION "Sfx_WarpTo", ROMX

Sfx_WarpTo:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	sound __, 16, $d7, $0500
	sound __, 16, $b7, $0580
	sound __, 16, $87, $0600
	sound __, 16, $47, $0680
	sound __, 16, $17, $0700
	soundinput $8
	endchannel


SECTION "Sfx_WarpFrom", ROMX

Sfx_WarpFrom:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $17
	sound __, 16, $d7, $0700
	sound __, 16, $b7, $0680
	sound __, 16, $87, $0600
	sound __, 16, $47, $0580
	sound __, 16, $17, $0500
	soundinput $8
	endchannel


SECTION "Sfx_ChangeDexMode", ROMX

Sfx_ChangeDexMode:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $16
	sound __, 16, $d2, $0500
	soundinput $8
	endchannel


SECTION "Sfx_JumpOverLedge", ROMX

Sfx_JumpOverLedge:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $95
	sound __, 16, $f2, $0400
	soundinput $8
	endchannel


SECTION "Sfx_GrassRustle", ROMX

Sfx_GrassRustle:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f1, $32
	noise __,  3, $0, $0
	noise __,  3, $f1, $22
	noise __,  2, $0, $0
	endchannel


SECTION "Sfx_Fly", ROMX

Sfx_Fly:
	musicheader 1, 8, .Ch8

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
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $3
	soundinput $5a
	sound __,  5, $f0, $0500
	soundinput $8
	sound __,  5, $0, 0
	sound __, 16, $f0, $0500
	sound __,  2, $0, 0
	endchannel

.Ch6:
	dutycycle $3
	sound __,  5, $f0, $0401
	sound __,  5, $0, 0
	sound __, 16, $f0, $0401
	sound __,  2, $0, 0
	endchannel


SECTION "Sfx_Squeak", ROMX

Sfx_Squeak:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $17
	sound __, 16, $d2, $0700
	soundinput $8
	endchannel


SECTION "Sfx_Strength", ROMX

Sfx_Strength:
	musicheader 1, 8, .Ch8

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
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __, 16, $f0, $0500
	sound __,  5, $0, 0
	sound __, 16, $f0, $0500
	sound __, 16, $f0, $0500
	sound __, 16, $f0, $0500
	sound __, 16, $f0, $0500
	sound __, 16, $f2, $0500
	endchannel

.Ch6:
	dutycycle $3
	sound __, 16, $f0, $0482
	sound __,  5, $0, 0
	sound __, 16, $f0, $0482
	sound __, 16, $f0, $0482
	sound __, 16, $f0, $0482
	sound __, 16, $f0, $0482
	sound __, 16, $f2, $0482
	endchannel


SECTION "Sfx_WallOpen", ROMX

Sfx_WallOpen:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $3a
	sound __,  5, $f2, $0500
	soundinput $22
	sound __,  5, $e2, $0500
	soundinput $3a
	sound __,  5, $f2, $0700
	soundinput $22
	sound __, 16, $e2, $0700
	soundinput $8
	endchannel


SECTION "Sfx_PlacePuzzlePieceDown", ROMX

Sfx_PlacePuzzlePieceDown:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f7, $24
	noise __,  3, $f7, $34
	noise __,  5, $f7, $44
	noise __,  9, $f4, $55
	noise __,  9, $f1, $44
	endchannel


SECTION "Sfx_EnterDoor", ROMX

Sfx_EnterDoor:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 10, $f1, $44
	noise __,  9, $d1, $43
	endchannel


SECTION "Sfx_SwitchPokemon", ROMX

Sfx_SwitchPokemon:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  9, $e1, $0740
	endchannel

.Ch6:
	dutycycle $2
	sound __,  3, $8, 0
	sound __,  9, $b1, $0741
	endchannel


SECTION "Sfx_Tally", ROMX

Sfx_Tally:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  5, $f1, $0780
	endchannel

.Ch6:
	dutycycle $2
	sound __,  2, $8, 0
	sound __,  5, $a1, $0761
	endchannel


SECTION "Sfx_Transaction", ROMX

Sfx_Transaction:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  5, $e1, $0700
	sound C_,  9, $f2, $07e0
	endchannel

.Ch6:
	dutycycle $2
	sound __,  2, $8, 0
	sound __,  5, $91, $06c1
	sound C_,  9, $a2, $07a1
	endchannel


SECTION "Sfx_Bump", ROMX

Sfx_Bump:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $5a
	sound __, 16, $f1, $0300
	soundinput $8
	endchannel


SECTION "Sfx_ExitBuilding", ROMX

Sfx_ExitBuilding:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f1, $54
	noise __, 13, $71, $23
	noise __,  3, $b1, $54
	noise __, 13, $61, $23
	noise __,  7, $41, $54
	endchannel


SECTION "Sfx_Save", ROMX

Sfx_Save:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  3, $f1, $0700
	sound __,  2, $e1, $0600
	sound __,  2, $e1, $0680
	sound __,  2, $e1, $06c0
	sound __,  3, $e1, $0700
	sound __,  3, $e1, $07c0
	sound __, 16, $f2, $07e0
	endchannel

.Ch6:
	dutycycle $2
	sound __,  3, $8, 0
	sound __,  3, $a1, $0701
	sound __,  2, $91, $0601
	sound __,  2, $91, $0681
	sound __,  2, $91, $06c1
	sound __,  3, $91, $0701
	sound __,  3, $91, $07c1
	sound __, 16, $d2, $07e1
	endchannel


SECTION "Sfx_Pokeflute", ROMX

Sfx_Pokeflute:
	musicheader 1, 7, .Ch7

.Ch7:
	tempo 256
	volume $77
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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __, 16, $f3, $0730
	sound __,  9, $65, $0730
	sound __, 16, $f4, $0700
	sound __, 16, $74, $0700
	sound __, 16, $44, $0700
	sound __, 16, $24, $0700
	endchannel


SECTION "Sfx_ThrowBall", ROMX

Sfx_ThrowBall:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $2f
	sound __, 16, $f2, $0780
	endchannel

.Ch6:
	dutycycle $2
	sound __, 16, $c2, $0782
	endchannel


SECTION "Sfx_BallPoof", ROMX

Sfx_BallPoof:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $16
	sound __, 16, $f2, $0400
	soundinput $8
	endchannel

.Ch8:
	noise __, 16, $a2, $22
	endchannel


SECTION "Sfx_Faint", ROMX

Sfx_Faint:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	sound __, 16, $d1, $0200
	soundinput $8
	endchannel

.Ch8:
	noise __,  5, $f5, $33
	noise __,  9, $f4, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_Run", ROMX

Sfx_Run:
	musicheader 1, 8, .Ch8

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
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $44
	sound __, 16, $f0, $04f0
	soundinput $17
	sound __, 16, $f2, $0650
	soundinput $8
	endchannel

.Ch6:
	dutycycle $2
	sound __, 16, $92, $0600
	sound __, 16, $92, $0782
	endchannel


SECTION "Sfx_Call", ROMX

Sfx_Call:
	musicheader 1, 5, .Ch5

.Ch5:
	soundinput $67
	sound __,  5, $f7, $07a0
	sound __,  5, $f7, $07a0
	sound __,  5, $f7, $07a0
	sound __,  5, $f7, $07a0
	sound __,  5, $f7, $07a0
	soundinput $8
	sound __,  5, $0, 0
	endchannel


SECTION "Sfx_Unknown60", ROMX

Sfx_Unknown60:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $d1, $41
	endchannel


SECTION "Sfx_SwitchPockets", ROMX

Sfx_SwitchPockets:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $c1, $42
	endchannel


SECTION "Sfx_Unknown63", ROMX

Sfx_Unknown63:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $6f, $21
	noise __,  3, $af, $31
	noise __, 16, $f2, $41
	endchannel


SECTION "Sfx_Burn", ROMX

Sfx_Burn:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $d2, $32
	noise __, 16, $f2, $43
	endchannel


SECTION "Sfx_TitleScreenEntrance", ROMX

Sfx_TitleScreenEntrance:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  2, $f2, $06a0
	sound __,  2, $f2, $06e0
	sound __,  9, $f1, $0700
	endchannel


SECTION "Sfx_GetCoinFromSlots", ROMX

Sfx_GetCoinFromSlots:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  3, $f1, $0700
	sound __,  9, $81, $07e0
	endchannel


SECTION "Sfx_PayDay", ROMX

Sfx_PayDay:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $3
	sound __,  6, $e1, $0700
	sound __,  3, $e1, $0780
	sound __, 16, $f1, $07c0
	endchannel

.Ch6:
	dutycycle $2
	sound __,  5, $c1, $06c1
	sound __,  3, $c1, $0741
	sound __, 16, $d1, $0781
	endchannel


SECTION "Sfx_Metronome", ROMX

Sfx_Metronome:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $5f
	sound __,  5, $40, $07e0
	sound __,  5, $60, $07e0
	sound __,  5, $80, $07e0
	sound __,  9, $a0, $07e0
	sound __,  9, $a0, $07e0
	sound __,  9, $80, $07e0
	sound __,  9, $60, $07e0
	sound __,  9, $30, $07e0
	sound __, 16, $12, $07e0
	soundinput $8
	endchannel


SECTION "Sfx_Peck", ROMX

Sfx_Peck:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $a1, $12
	endchannel


SECTION "Sfx_Kinesis", ROMX

Sfx_Kinesis:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $af
	sound __, 16, $f2, $0780
	soundinput $8
	endchannel


SECTION "Sfx_Lick", ROMX

Sfx_Lick:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $97
	sound __, 16, $f2, $0500
	soundinput $8
	endchannel


SECTION "Sfx_Pound", ROMX

Sfx_Pound:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $a1, $22
	endchannel


SECTION "Sfx_MovePuzzlePiece", ROMX

Sfx_MovePuzzlePiece:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  9, $f1, $54
	endchannel


SECTION "Sfx_CometPunch", ROMX

Sfx_CometPunch:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 16, $8f, $11
	noise __,  5, $ff, $12
	noise __, 11, $f1, $55
	endchannel


SECTION "Sfx_MegaPunch", ROMX

Sfx_MegaPunch:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 16, $8f, $34
	noise __,  9, $f2, $35
	noise __, 11, $f1, $55
	endchannel


SECTION "Sfx_Scratch", ROMX

Sfx_Scratch:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 16, $9f, $23
	noise __,  9, $f1, $21
	endchannel


SECTION "Sfx_Vicegrip", ROMX

Sfx_Vicegrip:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $e1, $4b
	noise __, 11, $f1, $44
	noise __,  3, $e1, $3a
	noise __,  7, $f1, $34
	endchannel


SECTION "Sfx_RazorWind", ROMX

Sfx_RazorWind:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f4, $44
	noise __,  3, $f4, $14
	noise __, 16, $f1, $32
	endchannel


SECTION "Sfx_Cut", ROMX

Sfx_Cut:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $8f, $55
	noise __,  3, $f4, $44
	noise __,  9, $f4, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_WingAttack", ROMX

Sfx_WingAttack:
	musicheader 1, 8, .Ch8

.Ch8:
.branch8:
	noise __,  9, $4f, $23
	noise __,  5, $c4, $22
	noise __,  7, $f2, $23
	loopchannel 4, .branch8
	endchannel


SECTION "Sfx_Whirlwind", ROMX

Sfx_Whirlwind:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  9, $4f, $33
	noise __,  5, $c4, $22
	noise __,  7, $f2, $23
	noise __, 16, $f2, $22
	endchannel


SECTION "Sfx_Bind", ROMX

Sfx_Bind:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  9, $ff, $32
	noise __,  9, $f4, $43
	noise __,  9, $f2, $54
	noise __,  9, $f1, $65
	endchannel


SECTION "Sfx_VineWhip", ROMX

Sfx_VineWhip:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  2, $94, $23
	noise __,  2, $b4, $22
	noise __,  9, $f1, $44
	endchannel


SECTION "Sfx_MegaKick", ROMX

Sfx_MegaKick:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $94, $33
	noise __,  5, $b4, $22
	noise __,  5, $f1, $44
	noise __,  9, $f1, $55
	endchannel


SECTION "Sfx_Headbutt", ROMX

Sfx_Headbutt:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $ff, $55
	noise __,  9, $f1, $65
	endchannel


SECTION "Sfx_HornAttack", ROMX

Sfx_HornAttack:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $84, $43
	noise __,  3, $c4, $22
	noise __,  9, $f2, $34
	endchannel


SECTION "Sfx_Tackle", ROMX

Sfx_Tackle:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $f1, $34
	noise __, 16, $f2, $64
	endchannel


SECTION "Sfx_PoisonSting", ROMX

Sfx_PoisonSting:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f1, $22
	noise __, 16, $f2, $12
	endchannel


SECTION "Sfx_Powder", ROMX

Sfx_Powder:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $c2, $1
	noise __, 16, $f4, $1
	noise __, 16, $f2, $1
	endchannel


SECTION "Sfx_DoubleSlap", ROMX

Sfx_DoubleSlap:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  9, $f1, $32
	noise __,  9, $f1, $33
	endchannel


SECTION "Sfx_Bite", ROMX

Sfx_Bite:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $0
	soundinput $3a
	sound __,  5, $f2, $0200
	soundinput $22
	sound __,  9, $e2, $0200
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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  4, $92, $31
	noise __,  4, $b2, $32
	noise __,  4, $c2, $33
	noise __,  9, $f1, $54
	endchannel


SECTION "Sfx_Stomp", ROMX

Sfx_Stomp:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 13, $f1, $54
	noise __,  9, $f1, $64
	endchannel


SECTION "Sfx_TailWhip", ROMX

Sfx_TailWhip:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f1, $33
	noise __,  3, $c1, $32
	noise __,  3, $a1, $31
	noise __, 16, $82, $32
	noise __,  9, $f1, $34
	endchannel


SECTION "Sfx_KarateChop", ROMX

Sfx_KarateChop:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $d2, $32
	noise __, 16, $f2, $43
	endchannel


SECTION "Sfx_Submission", ROMX

Sfx_Submission:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $f2, $43
	noise __,  5, $b5, $32
	noise __, 10, $86, $31
	noise __,  8, $64, $0
	noise __, 16, $f2, $55
	endchannel


SECTION "Sfx_WaterGun", ROMX

Sfx_WaterGun:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $1
	soundinput $97
	sound __, 16, $f2, $0700
	soundinput $8
	endchannel

.Ch8:
	noise __, 16, $3f, $22
	noise __, 16, $f2, $21
	endchannel


SECTION "Sfx_SwordsDance", ROMX

Sfx_SwordsDance:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 16, $4f, $41
	noise __,  9, $8f, $41
	noise __,  9, $cf, $41
	noise __,  9, $f2, $42
	noise __, 16, $f2, $41
	endchannel


SECTION "Sfx_Thunder", ROMX

Sfx_Thunder:
	musicheader 1, 8, .Ch8

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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	sound __, 16, $3f, $07c0
.branch5:
	sound __, 16, $df, $07c0
	loopchannel 4, .branch5
	sound __, 16, $d1, $07c0
	endchannel

.Ch6:
	sound_duty 3, 0, 3, 2
	sound __, 16, $2f, $07c8
.branch6:
	sound __, 16, $cf, $07c7
	loopchannel 4, .branch6
	sound __, 16, $c1, $07c8
	endchannel

.Ch8:
.branch8:
	noise __,  4, $97, $12
	noise __,  4, $a1, $11
	loopchannel 10, .branch8
	endchannel


SECTION "Sfx_Leer", ROMX

Sfx_Leer:
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	dutycycle $0
	sound __,  1, $f1, $07c0
	sound __,  1, $f1, $0700
	loopchannel 12, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	sound __,  1, $e1, $07c1
	sound __,  1, $e1, $0701
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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 0, 3
	sound __, 12, $f3, $0120
	sound __, 10, $d3, $0150
	loopchannel 5, .branch5
	sound __,  9, $e3, $0130
	sound __, 16, $c2, $0110
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 3, 0
	sound __,  5, $f4, $0600
	sound __,  4, $c4, $0500
	sound __,  6, $b5, $0600
	sound __, 14, $e2, $06c0
	loopchannel 3, .branch5
	sound __,  9, $d1, $0600
	endchannel

.Ch6:
.branch6:
	sound_duty 1, 3, 0, 2
	sound __,  6, $e4, $05e0
	sound __,  5, $b4, $04e0
	sound __,  7, $a5, $05e8
	sound __, 15, $d1, $06a0
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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 2, 0, 1, 3
	sound __,  4, $81, $0300
	sound __,  4, $c1, $0400
	sound __,  4, $f1, $0500
	sound __,  4, $b1, $0400
	sound __,  4, $71, $0300
	loopchannel 5, .branch5
	sound __,  9, $81, $0400
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 2, 3, 0
	sound __, 16, $f4, $0500
	sound __, 16, $c4, $0400
	sound __, 16, $e2, $05c0
	loopchannel 3, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 1, 3, 0, 2
	sound __,  8, $e4, $0430
	sound __, 16, $b4, $0330
	sound __, 16, $a2, $0438
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 1, 0, 2, 2
	sound __, 11, $f1, $0640
	sound __, 11, $f3, $0680
	sound __, 11, $f2, $0620
	loopchannel 4, .branch5
	sound __, 11, $f1, $0640
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	sound __, 11, $f3, $0571
	sound __,  8, $e3, $0531
	sound __, 11, $f1, $0551
	loopchannel 4, .branch6
	sound __, 11, $f1, $0571
	endchannel

.Ch8:
.branch8:
	noise __,  3, $d1, $4a
	noise __,  3, $d2, $2a
	loopchannel 21, .branch8
	endchannel


SECTION "Sfx_Charge", ROMX

Sfx_Charge:
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	dutycycle $0
	sound __,  3, $f1, $0200
	sound __,  4, $f1, $0700
	sound __,  5, $f1, $0500
	sound __,  6, $f1, $07f0
	loopchannel 8, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	sound __,  3, $e1, $0302
	sound __,  4, $e1, $07f2
	sound __,  5, $e1, $0602
	sound __,  6, $e1, $0702
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
.branch5:
	sound_duty 3, 2, 2, 0
	sound __,  4, $f1, $07f0
	sound __,  5, $f2, $0200
	loopchannel 8, .branch5
	endchannel

.Ch6:
.branch6:
	sound_duty 3, 0, 3, 2
	sound __,  5, $e2, $0202
	sound __,  5, $e1, $07e2
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $f7
	sound __,  9, $c4, $07bd
	sound __,  9, $c4, $07be
	sound __,  9, $c4, $07bf
	sound __,  9, $c4, $07c0
	sound __, 16, $c4, $07c1
	sound __, 16, $f2, $07c0
	soundinput $8
	endchannel

.Ch6:
	dutycycle $2
	sound __,  9, $c4, $0770
	sound __,  9, $c4, $0761
	sound __,  9, $c4, $0762
	sound __,  9, $c4, $0763
	sound __, 16, $c4, $0764
	sound __, 16, $f2, $0764
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
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __, 16, $ff, $07e0
	sound __, 16, $ff, $07e0
	sound __, 16, $ff, $07e0
	sound __, 16, $ff, $07e0
	sound __, 16, $f2, $07e0
	endchannel

.Ch6:
	dutycycle $3
	sound __, 16, $ff, $07e2
	sound __, 16, $ff, $07e1
	sound __, 16, $ff, $07e2
	sound __, 16, $ff, $07e1
	sound __, 16, $f2, $07e2
	endchannel


SECTION "Sfx_BoneClub", ROMX

Sfx_BoneClub:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	soundinput $af
	sound __,  9, $f1, $0700
	soundinput $8
	endchannel

.Ch6:
	dutycycle $3
	sound __,  9, $f1, $0701
	endchannel


SECTION "Sfx_Sharpen", ROMX

Sfx_Sharpen:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  7, $f1, $0500
	sound __,  7, $f1, $0580
	sound __,  7, $f1, $0600
	sound __,  7, $f1, $0680
	sound __,  9, $f1, $0700
	endchannel

.Ch6:
	dutycycle $3
	sound __,  7, $e1, $0510
	sound __,  7, $e1, $0590
	sound __,  7, $e1, $0610
	sound __,  7, $e1, $0690
	sound __,  9, $e1, $0710
	endchannel


SECTION "Sfx_EggBomb", ROMX

Sfx_EggBomb:
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	sound_duty 1, 3, 2, 3
	sound __,  9, $ff, $03f8
	sound __, 16, $ff, $0400
	sound __, 16, $f3, $0400
	endchannel

.Ch6:
	sound_duty 0, 1, 3, 2
	sound __,  9, $ef, $03c0
	sound __, 16, $ef, $03c0
	sound __, 16, $e3, $03c0
	endchannel

.Ch8:
	noise __,  5, $ff, $51
	noise __,  9, $ff, $54
	noise __, 16, $ff, $55
	noise __, 16, $f3, $56
	endchannel


SECTION "Sfx_Sing", ROMX

Sfx_Sing:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $0
	sound __,  3, $f1, $0780
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $0790
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $07a0
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $07b0
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $07c0
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $07d0
.branch5:
	sound __,  3, $f1, $0700
	sound __,  3, $f1, $07e0
	loopchannel 12, .branch5
	sound __, 16, $f1, $0700
	endchannel

.Ch6:
	sound_duty 3, 0, 3, 2
	sound __,  3, $f1, $0781
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $0791
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $07a1
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $07b1
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $07c1
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $07d1
.branch6:
	sound __,  3, $f1, $0701
	sound __,  3, $f1, $07e1
	loopchannel 12, .branch6
	sound __, 16, $f1, $0701
	endchannel

.Ch8:
.branch8:
	noise __,  2, $d1, $49
	noise __,  2, $d1, $29
	loopchannel 26, .branch8
	endchannel


SECTION "Sfx_Shine", ROMX

Sfx_Shine:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	sound __,  1, $d2, $0700
	sound __,  1, $d2, $0740
	sound __,  1, $d2, $0780
	sound __,  1, $d2, $07c0
	sound __, 11, $e1, $07e0
	sound __,  2, $0, 0
	endchannel


SECTION "Sfx_Unknown5F", ROMX

Sfx_Unknown5F:
	musicheader 3, 5, Sfx_Unknown5F_Ch5
	musicheader 1, 6, Sfx_Unknown5F_Ch6
Sfx_Sandstorm:
	musicheader 1, 8, Sfx_Sandstorm_Ch8

Sfx_Unknown5F_Ch5:
.branch5:
	sound __,  3, $f7, $0601
	sound __,  3, $f7, $0701
	loopchannel 8, .branch5
	endchannel

Sfx_Unknown5F_Ch6:
	sound __,  2, $f7, $ffff
	sound __,  3, $f7, $0602
	sound __,  3, $f7, $0702
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
	musicheader 1, 5, Sfx_HangUp_Ch5

Sfx_NoSignal:
	musicheader 1, 5, Sfx_NoSignal_Ch5

Sfx_HangUp_Ch5:
	dutycycle $2
	sound __,  5, $b8, $077b
	sound __,  3, $21, $077b
	sound C_,  1, $0, 0
Sfx_NoSignal_Ch5:
.branch5:
	dutycycle $2
	sound C_,  5, $e8, $070b
	sound C_, 13, $0, 0
	loopchannel 3, .branch5
	endchannel


SECTION "Sfx_Elevator", ROMX

Sfx_Elevator:
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $5a
.branch5:
	sound __,  3, $f1, $0300
	loopchannel 48, .branch5
	soundinput $8
	dutycycle $2
	sound __, 16, $f3, $0730
	sound __,  9, $65, $0730
	sound __, 16, $f4, $0700
	sound __, 16, $74, $0700
	sound __, 16, $44, $0700
	sound __, 16, $24, $0700
	endchannel

.Ch6:
.Ch7:
	sound F_,  1, $0, 0
	sound E_,  4, $0, 0
	endchannel

.Ch8:
	noise F_,  1, $0, $0
	noise E_,  4, $0, $0
	endchannel


SECTION "Sfx_LevelUp", ROMX

Sfx_LevelUp:
Sfx_DexFanfare5079:
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 104
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 108
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume $77
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	sfxpriorityon
	tempo 256
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume $77
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	sfxpriorityon
	tempo 256
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume $77
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
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 116
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 116
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 152
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 144
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 144
	volume $77
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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $a5
.branch5:
	sound __,  3, $f1, $06e0
	sound __, 14, $af, $05b0
	sound __,  5, $0, 0
	sound __, 10, $f4, $0718
	loopchannel 3, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_RainDance", ROMX

Sfx_RainDance:
	musicheader 1, 8, .Ch8

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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	sound_duty 2, 0, 3, 3
	soundinput $f5
	sound C_, 13, $f8, $0580
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
	musicheader 1, 8, .Ch8

.Ch8:
.branch8:
	noise __,  5, $f8, $5d
	noise __,  5, $d8, $6f
	loopchannel 2, .branch8
	endchannel


SECTION "Sfx_Curse", ROMX

Sfx_Curse:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $3
	sound __,  5, $f2, $0483
	sound __,  5, $f2, $0511
	sound __,  5, $f2, $0589
	sound __,  5, $f2, $05ed
	endchannel

.Ch8:
	noise C_,  5, $9a, $9
	endchannel


SECTION "Sfx_Rage", ROMX

Sfx_Rage:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $0
	sound __,  4, $d1, $07b0
	sound __,  4, $d1, $07c2
	sound C_,  9, $d2, $07d5
	endchannel

.Ch8:
	noise __,  4, $f4, $1a
	noise __,  4, $f4, $19
	noise C_,  9, $f2, $18
	endchannel


SECTION "Sfx_Thief", ROMX

Sfx_Thief:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $0
	sound C#,  1, $7f, $0720
	soundinput $95
	sound __,  5, $f8, $0620
	sound __,  5, $e8, $0630
	sound __,  5, $d8, $0640
	sound __,  5, $95, $0620
	sound __,  5, $73, $0630
	sound __,  5, $51, $0640
	soundinput $8
	endchannel

.Ch8:
	noise C#,  1, $ef, $0
	endchannel


SECTION "Sfx_MindReader", ROMX

Sfx_MindReader:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $34
.branch5:
	sound __,  4, $ba, $0631
	sound __,  3, $0, 0
	sound __,  4, $f8, $0621
	sound __,  3, $0, 0
	sound __,  4, $f8, $0611
	sound __,  3, $0, 0
	sound __,  4, $e8, $0601
	sound __,  3, $0, 0
	sound __,  4, $e8, $05f1
	sound __,  3, $0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_Snore", ROMX

Sfx_Snore:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	sound __,  3, $c1, $07c8
	sound __,  3, $d1, $07da
	loopchannel 2, .branch5
	sound C_, 11, $f1, $07e2
	endchannel


SECTION "Sfx_SweetKiss2", ROMX

Sfx_SweetKiss2:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $97
	sound __,  3, $f4, $0772
	sound __,  5, $0, 0
	sound __,  3, $c4, $0772
	sound __,  5, $0, 0
	sound __,  3, $b4, $0772
	sound __,  5, $0, 0
	sound __,  3, $a1, $0772
	soundinput $8
	endchannel


SECTION "Sfx_BellyDrum", ROMX

Sfx_BellyDrum:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $ac
	sound __, 13, $f1, $05a3
	soundinput $8
	endchannel

.Ch8:
	noise __, 13, $b1, $6c
	endchannel


SECTION "Sfx_Toxic", ROMX

Sfx_Toxic:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $95
	sound __,  3, $c9, $03b3
	sound __,  6, $f8, $0463
	sound __,  5, $d1, $0543
	soundinput $8
	endchannel


SECTION "Sfx_SludgeBomb", ROMX

Sfx_SludgeBomb:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $c5
	sound __,  4, $f8, $0581
	sound __,  2, $0, 0
	soundinput $cb
	sound C_,  1, $f2, $05d1
	soundinput $8
	endchannel

.Ch8:
	noise __,  4, $e2, $6e
	noise __,  2, $0, $0
	noise C_,  1, $e2, $6d
	endchannel


SECTION "Sfx_Foresight", ROMX

Sfx_Foresight:
	musicheader 1, 5, .Ch5

.Ch5:
	sound __,  4, $f4, $07b5
	sound __,  4, $f5, $07c8
	sound __,  9, $f4, $07da
	sound __,  3, $0, 0
	sound __,  9, $c1, $07da
	sound __,  3, $0, 0
	sound __,  9, $91, $07da
	endchannel


SECTION "Sfx_Spite", ROMX

Sfx_Spite:
	musicheader 1, 5, .Ch5

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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __, 12, $ea, $6c
	noise __, 12, $ea, $6b
	noise __, 12, $ea, $6a
	noise __, 12, $ea, $69
	noise __, 12, $e1, $59
	endchannel


SECTION "Sfx_PerishSong", ROMX

Sfx_PerishSong:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

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
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $97
	sound __,  5, $f8, $0680
	sound C_,  5, $f8, $0680
	sound C_,  5, $c8, $0660
	sound C_,  5, $a8, $0670
	sound C_,  5, $88, $0680
	sound C_,  5, $f8, $0561
	sound C_,  5, $c8, $0541
	sound C_,  5, $a8, $0521
	sound C_,  5, $88, $0511
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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	soundinput $77
	sound __,  5, $a9, $06f0
	sound __, 13, $f8, $0720
	soundinput $7f
	sound __,  9, $f1, $0740
	soundinput $8
	endchannel


SECTION "Sfx_Kinesis2", ROMX

Sfx_Kinesis2:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
	sound __,  3, $f3, $0796
	sound __,  3, $23, $0796
	sound C_,  5, $f1, $07c4
	endchannel


SECTION "Sfx_ZapCannon", ROMX

Sfx_ZapCannon:
	musicheader 1, 8, .Ch8

.Ch8:
.branch8:
	noise __,  3, $e1, $49
	noise __,  1, $0, $0
	loopchannel 8, .branch8
	noise __,  9, $e1, $49
	endchannel


SECTION "Sfx_MeanLook", ROMX

Sfx_MeanLook:
	musicheader 1, 5, .Ch5

.Ch5:
	soundinput $77
	dutycycle $3
	sound __,  3, $f8, $0720
.branch5:
	sound __,  2, $88, $0660
	sound __,  3, $f8, $0790
	loopchannel 5, .branch5
	sound __, 13, $f8, $0700
	sound __, 13, $c8, $0720
	sound __, 13, $a8, $0700
	sound __, 13, $78, $0720
	sound __, 13, $48, $0700
	sound __, 13, $28, $0720
	soundinput $8
	endchannel


SECTION "Sfx_HealBell", ROMX

Sfx_HealBell:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	sound __,  2, $f1, $07da
	sound __,  2, $d1, $07d9
	sound __,  2, $f1, $07da
	sound __,  9, $d1, $07db
	endchannel


SECTION "Sfx_Return", ROMX

Sfx_Return:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $0
.branch5:
	soundinput $bf
	sound __,  9, $f1, $0759
	soundinput $57
	sound __,  9, $f1, $0759
	sound C_,  1, $0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_ExpBar", ROMX

Sfx_ExpBar:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $d7
	sound __,  9, $e1, $0750
	soundinput $e7
	sound __,  9, $48, $06e0
	sound __,  9, $58, $06f8
	sound __,  9, $68, $0710
	sound __,  9, $78, $0728
	sound __,  9, $88, $0740
	sound __,  9, $98, $0758
	sound C_,  1, $a8, $0770
	soundinput $8
	endchannel


SECTION "Sfx_MilkDrink", ROMX

Sfx_MilkDrink:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	soundinput $a4
	sound __,  3, $ea, $04e0
	sound __, 14, $f7, $0290
	soundinput $9e
	sound __,  5, $c9, $05e1
	sound __,  3, $0, 0
	loopchannel 6, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_Present", ROMX

Sfx_Present:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $d6
.branch5:
	sound __,  3, $f1, $0740
	sound __,  2, $0, 0
	loopchannel 3, .branch5
	sound C_,  1, $f1, $0780
	soundinput $8
	endchannel


SECTION "Sfx_MorningSun", ROMX

Sfx_MorningSun:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $3
.branch5:
	sound __,  3, $f1, $07e4
	sound __,  3, $f1, $07e0
	sound __,  6, $f2, $07e7
	loopchannel 3, .branch5
	sound __,  2, $0, 0
	sound __,  9, $c2, $07e7
	sound __,  2, $0, 0
	sound __,  9, $82, $07e7
	endchannel


SECTION "Sfx_Moonlight", ROMX

Sfx_Moonlight:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	sound __,  2, $f8, $07d0
	sound __,  5, $f1, $07e0
	loopchannel 2, .branch5
	sound C_,  1, $f1, $07e0
	sound C_,  1, $d1, $07e0
	sound C_,  1, $81, $07e0
	endchannel


SECTION "Sfx_Encore", ROMX

Sfx_Encore:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $ce
	sound C_,  1, $0, 0
.branch5:
	sound __,  3, $f8, $0774
	sound C#,  5, $0, 0
	loopchannel 2, .branch5
	soundinput $8
	endchannel

.Ch8:
	noise D_,  1, $1f, $36
	noise D_,  1, $76, $36
	endchannel


SECTION "Sfx_BeatUp", ROMX

Sfx_BeatUp:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  3, $e8, $69
	noise __,  7, $d8, $24
	noise __,  3, $e8, $6c
	noise __,  5, $c8, $46
	noise __,  7, $d1, $24
	endchannel


SECTION "Sfx_SweetScent", ROMX

Sfx_SweetScent:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $96
	sound __,  7, $f8, $0760
	sound __,  7, $e8, $0720
	soundinput $df
	sound C_,  7, $f1, $0730
	soundinput $8
	endchannel


SECTION "Sfx_BatonPass", ROMX

Sfx_BatonPass:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	dutycycle $2
	soundinput $f7
	sound C#,  1, $f2, $0680
	sound __,  2, $f1, $0760
	sound C#,  1, $0, 0
	sound __,  2, $f1, $0760
	sound C_, 11, $0, 0
	sound __,  2, $f1, $0760
	soundinput $8
	endchannel

.Ch8:
	noise C#,  1, $f2, $20
	endchannel


SECTION "Sfx_EggCrack", ROMX

Sfx_EggCrack:
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 8, .Ch8

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
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $ef
	sound __,  2, $40, $07e8
	sound __,  2, $60, $07e8
	sound __,  3, $80, $07e8
	sound __,  6, $a0, $07e8
	sound __,  7, $a0, $07e8
	sound __,  8, $80, $07e8
	sound __,  9, $60, $07e8
	sound __, 10, $30, $07e8
	sound __, 16, $12, $07e8
	soundinput $8
	endchannel


SECTION "Sfx_GameFreakLogoGs", ROMX

Sfx_GameFreakLogoGs:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $3
	soundinput $7f
	sound __,  5, $55, $07e2
	sound __,  6, $75, $07e2
	sound __,  7, $94, $07e2
	sound __,  8, $b4, $07e2
	sound __,  9, $b3, $07e2
	sound __, 10, $93, $07e2
	sound __, 11, $72, $07e2
	sound __, 11, $53, $07e2
	sound __, 11, $34, $07e2
	sound __, 11, $15, $07e2
	soundinput $8
	endchannel


SECTION "Sfx_DexFanfareLessThan20", ROMX

Sfx_DexFanfareLessThan20:
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 120
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 124
	volume $77
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
	musicheader 4, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7
	musicheader 1, 8, .Ch8

.Ch5:
	togglesfx
	tempo 112
	volume $77
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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $f1, $5f
	noise __,  2, $a0, $42
	noise C_,  1, $f1, $53
	endchannel


SECTION "Sfx_Damage", ROMX

Sfx_Damage:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  5, $f1, $5e
	noise __,  2, $a0, $12
	noise __,  5, $f0, $32
	noise C_,  1, $f1, $44
	endchannel


SECTION "Sfx_SuperEffective", ROMX

Sfx_SuperEffective:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  4, $f1, $4f
	noise __,  2, $c8, $22
	noise __,  3, $f8, $3f
	noise __,  4, $d0, $15
	noise C#,  1, $f2, $35
	endchannel


SECTION "Sfx_BallBounce", ROMX

Sfx_BallBounce:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  9, $e1, $0740
	sound C_,  8, $0, 0
	sound __,  9, $b1, $0740
	sound C_,  8, $0, 0
	sound __,  9, $81, $0740
	sound C_,  8, $0, 0
	sound __,  9, $51, $0740
	sound C_,  8, $0, 0
	endchannel

.Ch6:
	dutycycle $2
	sound __,  3, $8, 0
	sound __,  9, $b1, $0741
	sound C_,  8, $0, 0
	sound __,  9, $81, $0741
	sound C_,  8, $0, 0
	sound __,  9, $51, $0741
	sound C_,  8, $0, 0
	sound __,  9, $21, $0741
	sound C_,  8, $0, 0
	endchannel


SECTION "Sfx_SweetScent2", ROMX

Sfx_SweetScent2:
	musicheader 2, 5, .Ch5
	musicheader 1, 8, .Ch8

.Ch5:
	soundinput $af
	dutycycle $1
	sound __,  7, $f8, $05f0
	sound __,  3, $f1, $0620
	sound C_,  1, $f1, $0650
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
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound __,  2, $e1, $0789
	sound __,  2, $e1, $07a2
	sound C_,  1, $e1, $07b1
	endchannel

.Ch6:
	dutycycle $2
	sound __,  2, $e1, $07a2
	sound __,  2, $e1, $07b1
	sound C_,  1, $e1, $07c4
	endchannel


SECTION "Sfx_GiveTrademon", ROMX

Sfx_GiveTrademon:
	musicheader 1, 5, .Ch5

.Ch5:
	sound C#,  1, $0, 0
	dutycycle $1
	soundinput $a7
	sound C_, 12, $f4, $0750
	sound C_, 12, $d4, $0750
	sound C_, 12, $b4, $0750
	sound C_, 12, $94, $0750
	sound C_, 12, $74, $0750
	sound C_, 12, $54, $0750
	sound C_, 12, $34, $0750
	sound C_, 12, $14, $0750
	soundinput $8
	endchannel


SECTION "Sfx_GetTrademon", ROMX

Sfx_GetTrademon:
	musicheader 1, 5, .Ch5

.Ch5:
	sound C#,  1, $0, 0
	dutycycle $2
	soundinput $bf
	sound C_, 12, $14, $07bc
	sound C_, 12, $34, $07bc
	sound C_, 12, $54, $07bc
	sound C_, 12, $74, $07bc
	sound C_, 12, $94, $07bc
	sound C_, 12, $b4, $07bc
	sound C_, 12, $d4, $07bc
	sound C_, 12, $f4, $07bc
	soundinput $8
	endchannel


SECTION "Sfx_TrainArrived", ROMX

Sfx_TrainArrived:
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 8, .Ch8

.Ch6:
	tone $0008
	sound __,  9, $0, 0
.Ch5:
	dutycycle $2
	sound __,  5, $5f, $0691
	sound __,  5, $6f, $0694
	sound __,  5, $78, $0697
	sound __,  5, $7f, $069a
	sound __,  5, $68, $06ae
	sound C_,  1, $6f, $06ab
	sound F_,  9, $65, $06a8
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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
.branch5:
	soundinput $79
	sound __,  2, $99, $0563
	sound __,  5, $f2, $04b5
	soundinput $43
	sound C_,  1, $f8, $05cd
	loopchannel 2, .branch5
	soundinput $8
	endchannel


SECTION "Sfx_TitleScreenIntro", ROMX

Sfx_TitleScreenIntro:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  2, $f8, $0760
	sound __,  5, $82, $0760
	endchannel


SECTION "Sfx_GlassTing", ROMX

Sfx_GlassTing:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound C#,  1, $d1, $07dc
	endchannel


SECTION "Sfx_GlassTing2", ROMX

Sfx_GlassTing2:
	musicheader 2, 5, .Ch5
	musicheader 1, 6, .Ch6

.Ch5:
	dutycycle $2
	sound C_,  1, $f1, $07dc
	endchannel

.Ch6:
	dutycycle $2
	sound C_,  1, $d1, $07dd
	endchannel


SECTION "Sfx_IntroUnown1", ROMX

Sfx_IntroUnown1:
	musicheader 1, 5, .Ch5

.Ch5:
	vibrato $1, $a3
	dutycycle $2
	sound __,  9, $39, $0705
	sound C#,  1, $e2, $0705
	endchannel


SECTION "Sfx_IntroUnown2", ROMX

Sfx_IntroUnown2:
	musicheader 1, 6, .Ch6

.Ch6:
	vibrato $1, $73
	dutycycle $2
	sound __,  9, $39, $0758
	sound C#,  1, $e2, $0758
	endchannel


SECTION "Sfx_IntroUnown3", ROMX

Sfx_IntroUnown3:
	musicheader 1, 7, .Ch7

.Ch7:
	vibrato $1, $53
	sound __,  4, $32, $07c2
	sound __,  4, $22, $07c2
	sound __,  4, $12, $07c2
	sound C_,  1, $12, $07c2
	sound __,  7, $22, $07c2
	sound __,  7, $32, $07c2
	endchannel


SECTION "Sfx_DittoPopUp", ROMX

Sfx_DittoPopUp:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $1e
	sound __,  4, $82, $0700
	sound __,  2, $31, $0701
	soundinput $16
	sound __,  5, $b1, $0640
	sound C_,  1, $31, $0641
	endchannel


SECTION "Sfx_DittoTransform", ROMX

Sfx_DittoTransform:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $26
	sound C_,  5, $3b, $0440
	sound __,  5, $97, $04c0
	sound __,  5, $67, $04c1
	sound __,  5, $42, $04c2
	endchannel


SECTION "Sfx_IntroSuicune1", ROMX

Sfx_IntroSuicune1:
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  2, $58, $59
	noise __,  3, $91, $23
	endchannel


SECTION "Sfx_IntroPichu", ROMX

Sfx_IntroPichu:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $3
	soundinput $4d
	sound __,  2, $88, $0770
	sound __,  4, $0, 0
	soundinput $17
	sound __,  3, $88, $0776
	endchannel


SECTION "Sfx_IntroSuicune2", ROMX

Sfx_IntroSuicune2:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 8, .Ch8

.Ch8:
	noise __,  2, $88, $31
	noise __,  9, $39, $11
	noise __,  5, $a4, $10
	noise __,  5, $44, $10
	noise __,  5, $24, $10
	endchannel


SECTION "Sfx_DittoBounce", ROMX

Sfx_DittoBounce:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	soundinput $2c
	sound __,  3, $82, $04b0
	sound __,  1, $31, $04b0
	soundinput $34
	sound C_,  1, $b1, $0420
	endchannel


SECTION "Sfx_IntroSuicune4", ROMX

Sfx_IntroSuicune4:
	musicheader 1, 8, .Ch8

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $2
	sound __,  3, $e8, $07c2
	sound __,  3, $28, $07c2
	sound __,  3, $e8, $07c2
	sound __,  3, $28, $07c2
	endchannel


SECTION "Sfx_4NoteDitty", ROMX

Sfx_4NoteDitty:
	musicheader 3, 5, .Ch5
	musicheader 1, 6, .Ch6
	musicheader 1, 7, .Ch7

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
	musicheader 1, 5, .Ch5

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
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $97
	sound __, 16, $98, $0700
	soundinput $8
	endchannel


SECTION "Sfx_AbilitySlideout", ROMX

Sfx_AbilitySlideout:
	musicheader 1, 5, .Ch5

.Ch5:
	dutycycle $1
	soundinput $9f
	sound __, 4, $e8, $07ff
	sound __, 24, $e8, $07e0
	soundinput $8
	endchannel
