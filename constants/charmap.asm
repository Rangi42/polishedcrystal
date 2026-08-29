	newcharmap no_ngrams

; Control characters

	charmap "<START>",  $00
	charmap "<RAM>",    $01
	charmap "<WAIT>",   $02
	charmap "<ASM>",    $03
	charmap "<NUM>",    $04
	charmap "<PAUSE>",  $05
	charmap "<SOUND>",  $06
	charmap "<DAY>",    $07
	charmap "<FAR>",    $08
	charmap "<PLURAL>", $09
DEF NUM_TEXT_COMMANDS EQU $0a

	; unused: $0a - $4c
	; (Low values can be used for additional text commands; high values can be
	; used for additional n-grams; or existing n-grams can be shifted down to
	; make room for additional special characters.)

	; n-grams: $4d - $51 (defined below)

DEF SPECIALS_START EQU $52

	charmap "<DONE>",   $52
	charmap "@",        $53
	charmap "<PROMPT>", $54
	charmap "<LNBRK>",  $55
	charmap "<NEXT>",   $56
	charmap "<LINE>",   $57
	charmap "<CONT>",   $58
	charmap "<PARA>",   $59

	charmap "<TARGET>", $5a
	charmap "<USER>",   $5b
	charmap "<ENEMY>",  $5c

	charmap "<CTXT>",   $5d

	charmap "¯",        $5e

; Battle characters

DEF BATTLEEXTRA_GFX_START EQU $5f

	charmap "<MALE>",   $5f
	charmap "<FEMALE>", $60
	charmap "<SHINY>",  $61
	charmap "<BALL>",   $62

	charmap "<HP1>",    $63
	charmap "<HP2>",    $64
	charmap "<NOHP>",   $65
	; HP: $66 - $6c
	charmap "<FULLHP>", $6d
	charmap "<HPEND>",  $6e

	charmap "◢",        $6f
	charmap "—",        $70
	charmap "◣",        $71
	charmap "<NONO>",   $72

	charmap "<XP1>",    $73
	charmap "<XP2>",    $74
	charmap "<NOXP>",   $75
	; EXP: $76 - $7c
	charmap "<FULLXP>", $7d
	charmap "<XPEND>",  $7e

; Actual characters

DEF FIRST_REGULAR_TEXT_CHAR EQU $7f

; map tiles:

	charmap " ",        $7f

; typeface font:

	charmap "A",        $80
	charmap "B",        $81
	charmap "C",        $82
	charmap "D",        $83
	charmap "E",        $84
	charmap "F",        $85
	charmap "G",        $86
	charmap "H",        $87
	charmap "I",        $88
	charmap "J",        $89
	charmap "K",        $8a
	charmap "L",        $8b
	charmap "M",        $8c
	charmap "N",        $8d
	charmap "O",        $8e
	charmap "P",        $8f
	charmap "Q",        $90
	charmap "R",        $91
	charmap "S",        $92
	charmap "T",        $93
	charmap "U",        $94
	charmap "V",        $95
	charmap "W",        $96
	charmap "X",        $97
	charmap "Y",        $98
	charmap "Z",        $99

	charmap "(",        $9a
	charmap ")",        $9b
	charmap ".",        $9c
	charmap ",",        $9d
	charmap "?",        $9e
	charmap "!",        $9f

	charmap "a",        $a0
	charmap "b",        $a1
	charmap "c",        $a2
	charmap "d",        $a3
	charmap "e",        $a4
	charmap "f",        $a5
	charmap "g",        $a6
	charmap "h",        $a7
	charmap "i",        $a8
	charmap "j",        $a9
	charmap "k",        $aa
	charmap "l",        $ab
	charmap "m",        $ac
	charmap "n",        $ad
	charmap "o",        $ae
	charmap "p",        $af
	charmap "q",        $b0
	charmap "r",        $b1
	charmap "s",        $b2
	charmap "t",        $b3
	charmap "u",        $b4
	charmap "v",        $b5
	charmap "w",        $b6
	charmap "x",        $b7
	charmap "y",        $b8
	charmap "z",        $b9

	charmap "“",        $ba
	charmap "”",        $bb
	charmap "-",        $bc
	charmap ":",        $bd
	charmap "♂",        $be
	charmap "♀",        $bf

	charmap "'",        $c0
	charmap "'d",       $c1
	charmap "'l",       $c2
	charmap "'m",       $c3
	charmap "'r",       $c4
	charmap "'s",       $c5
	charmap "'t",       $c6
	charmap "'v",       $c7

	charmap "é",        $c8
	charmap "É",        $c9
	charmap "á",        $ca
	charmap "<BOLDH>",  $cb
	charmap "í",        $cc
	charmap "ó",        $cd

	charmap "¿",        $ce
	charmap "¡",        $cf

	charmap "<PO>",     $d0
	charmap "<KE>",     $d1
	charmap "<PK>",     $d2
	charmap "<MN>",     $d3

	charmap "<ID>",     $d4
	charmap "№",        $d5
	charmap "<LV>",     $d6
	charmap "<BOLDP>",  $d7

	charmap "&",        $d8

	charmap "♪",        $d9
	charmap "♥",        $da

	charmap "×",        $db
	charmap "/",        $dc
	charmap "%",        $dd

	charmap "+",        $de
	charmap "<SHARP>",  $df

	charmap "0",        $e0
	charmap "1",        $e1
	charmap "2",        $e2
	charmap "3",        $e3
	charmap "4",        $e4
	charmap "5",        $e5
	charmap "6",        $e6
	charmap "7",        $e7
	charmap "8",        $e8
	charmap "9",        $e9

	charmap "¥",        $ea

	charmap "…",        $eb

	charmap "★",        $ec

	charmap "▼",        $ed
	charmap "▲",        $ee
	charmap "◀",        $ef
	charmap "▶",        $f0
	charmap "▷",        $f1

; common font:
	charmap "↑",        $f2
	charmap "↓",        $f3
	charmap "′",        $f4
	charmap "″",        $f5
	charmap "<PHONE>",  $f6
	charmap "<BLACK>",  $f7

; frame:
	charmap "┌",        $f8
	charmap "─",        $f9
	charmap "┐",        $fa
	charmap "│",        $fb
	charmap "┃",        $fc
	charmap "└",        $fd
	charmap "━",        $fe
	charmap "┘",        $ff


	newcharmap compressing, no_ngrams

DEF NGRAMS_START EQU $4d
	charmap "#",        $4d
	charmap "#mon",     $4e
DEF NGRAMS_VAR_START EQU $4f
	; these below are implemented as n-grams whose string is stored in WRAM
	charmap "<PLAYER>", $4f
	charmap "<RIVAL>",  $50
	charmap "<TRENDY>", $51
DEF NGRAMS_END EQU $51


	newcharmap default, compressing

	setcharmap default


MACRO rawchar
	setcharmap no_ngrams
	db \#
	setcharmap default
ENDM


INCLUDE "constants/huffman_text.asm"
