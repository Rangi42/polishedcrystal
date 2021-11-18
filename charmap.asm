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

	; n-grams: $09 - $52 (defined below)

	charmap "@",        $53
	charmap "¯",        $54
	charmap "<LNBRK>",  $55
	charmap "<NEXT>",   $56
	charmap "<LINE>",   $57
	charmap "<CONT>",   $58
	charmap "<PARA>",   $59
	charmap "<DONE>",   $5a
	charmap "<PROMPT>", $5b

	charmap "<TARGET>", $5c
	charmap "<USER>",   $5d
	charmap "<ENEMY>",  $5e

; Battle characters

BATTLEEXTRA_GFX_START EQU $5f

	charmap "<BALL>",   $5f
	charmap "<MALE>",   $60
	charmap "<FEMALE>", $61
	charmap "<STAR>",   $62

	charmap "<HP1>",    $63
	charmap "<HP2>",    $64
	charmap "<NOHP>",   $65
	; HP: $66 - $6c
	charmap "<FULLHP>", $6d
	charmap "<HPEND>",  $6e

	charmap "_",        $6f
	charmap "◢",        $70
	charmap "—",        $71
	charmap "◣",        $72

	charmap "<XP1>",    $73
	charmap "<XP2>",    $74
	charmap "<NOXP>",   $75
	; EXP: $76 - $7c
	charmap "<FULLXP>", $7d
	charmap "<XPEND>",  $7e

; Actual characters

FIRST_REGULAR_TEXT_CHAR EQU $7f

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
	charmap "ê",        $cb
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

	charmap "▲",        $eb
	charmap "▼",        $ec
	charmap "◀",        $ed
	charmap "▶",        $ee

; common font:
	charmap "▷",        $ef
	charmap "…",        $f0
	charmap "<PHONE>",  $f1
	charmap "<BLACK>",  $f2
	charmap "<NONO>",   $f3
	charmap "′",        $f4
	charmap "″",        $f5
	charmap "★",        $f6
	charmap "↑",        $f7
	charmap "↓",        $f8
	charmap "<UPDN>",   $f9

; frame:
	charmap "┌",        $fa
	charmap "─",        $fb
	charmap "┐",        $fc
	charmap "│",        $fd
	charmap "└",        $fe
	charmap "┘",        $ff


	newcharmap default, no_ngrams

NGRAMS_START EQU $09

	charmap "e ",       $09
	charmap " t",       $0a
	charmap "ou",       $0b
	charmap "in",       $0c
	charmap "th",       $0d
	charmap "he",       $0e
	charmap "t ",       $0f
	charmap "er",       $10
	charmap "on",       $11
	charmap "re",       $12
	charmap "s ",       $13
	charmap "at",       $14
	charmap "an",       $15
	charmap "to",       $16
	charmap "ha",       $17
	charmap "ng",       $18
	charmap "it",       $19
	charmap "is",       $1a
	charmap "ea",       $1b
	charmap "ve",       $1c
	charmap "ar",       $1d
	charmap "st",       $1e
	charmap "le",       $1f
	charmap "or",       $20
	charmap "te",       $21
	charmap "as",       $22
	charmap "yo",       $23
	charmap "y ",       $24
	charmap "r ",       $25
	charmap " b",       $26
	charmap "en",       $27
	charmap "me",       $28
	charmap "e t",      $29
	charmap ", ",       $2a
	charmap "es",       $2b
	charmap "e you",    $2c
	charmap "se",       $2d
	charmap "ne",       $2e
	charmap " h",       $2f
	charmap "I ",       $30
	charmap "our",      $31
	charmap "You",      $32
	charmap "nd",       $33
	charmap "ow",       $34
	charmap " c",       $35
	charmap " wa",      $36
	charmap "ome",      $37
	charmap "are",      $38
	charmap "The",      $39
	charmap "t's",      $3a
	charmap "ut",       $3b
	charmap "nt",       $3c
	charmap "the",      $3d
	charmap "you",      $3e
	charmap "ing",      $3f
	charmap "hat",      $40
	charmap "and",      $41
	charmap "for",      $42
	charmap "all",      $43
	charmap "here",     $44
	charmap "that",     $45
	charmap "have",     $46
	charmap "rain",     $47
	charmap "this",     $48
	charmap "ight",     $49
	charmap "with",     $4a
	charmap "ould",     $4b
	charmap "thing",    $4c
	charmap "attle",    $4d
	charmap "#",        $4e
	charmap "#mon",     $4f
	; these below are implemented as n-grams whose string is stored in WRAM
	charmap "<PLAYER>", $50
	charmap "<RIVAL>",  $51
	charmap "<TRENDY>", $52

NGRAMS_END EQU $52

	setcharmap default


rawchar: MACRO
	setcharmap no_ngrams
	db \#
	setcharmap default
ENDM
