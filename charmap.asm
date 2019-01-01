; Control characters

	charmap "<START>",  $00
	charmap "<RAM>",    $01
	charmap "<BCD>",    $02
	charmap "<MOVE>",   $03
	charmap "<BOX>",    $04
	charmap "<LOW>",    $05
	charmap "<WAIT>",   $06
	charmap "<SCROLL>", $07
	charmap "<ASM>",    $08
	charmap "<NUM>",    $09
	charmap "<EXIT>",   $0a
	charmap "<DEX2>",   $0b
	charmap "<DOTS>",   $0c
	charmap "<LINK>",   $0d
	charmap "<DEX1>",   $0e
	charmap "<ITEM>",   $0f
	charmap "<CAUGHT>", $10
	charmap "<DEX3>",   $11
	charmap "<BEEP>",   $12
	charmap "<SLOTS>",  $13
	charmap "<BUFFER>", $14
	charmap "<DAY>",    $15
	charmap "<FAR>",    $16

	charmap "¯",        $1f
	charmap "<LNBRK>",  $22
	charmap "<NEXT>",   $25

	charmap "have",     $38
	charmap "that",     $39
	charmap "for",      $3a
	charmap "with",     $3b
	charmap "and",      $3c
	charmap "this",     $3d

	charmap "<_CONT>",  $4b
	charmap "<SCRL2>",  $4c
	charmap "<NL>",     $4e
	charmap "<LINE>",   $4f

	charmap "@",        $50
	charmap "<PARA>",   $51
	charmap "<PLAYER>", $52
	charmap "<RIVAL>",  $53
	charmap "#",        $54
	charmap "<CONT>",   $55
	charmap "<TRENDY>", $56
	charmap "<DONE>",   $57
	charmap "<PROMPT>", $58
	charmap "<TARGET>", $59
	charmap "<USER>",   $5a
	charmap "<ENEMY>",  $5b

	charmap "the",      $5c
	charmap "you",      $5d
	charmap "#mon",     $5e
	charmap "to",       $5f

; Actual characters

; map tiles:

	charmap "<BLACK>",  $f2 ; aka "<PHONE>"; black edges are sufficient
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

	charmap "★",        $f1
	charmap "<PHONE>",  $f2
	charmap "′",        $f3
	charmap "″",        $f4
	charmap "<—>",      $f5
	charmap "<_>",      $f6
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

; battle extra:
BATTLEEXTRA_GFX_START EQU $5f

	charmap "<BALL>",   $5f
	charmap "<MALE>",   $60
	charmap "<FEMALE>", $61
	charmap "<STAR>",   $62

	charmap "<HP1>",    $63
	charmap "<HP2>",    $64
	charmap "<NOHP>",   $65
	charmap "<FULLHP>", $6d
	charmap "<HPEND>",  $6e

	charmap "_",        $6f
	charmap "◢",        $70
	charmap "—",        $71
	charmap "◣",        $72

	charmap "<XP1>",    $73
	charmap "<XP2>",    $74
	charmap "<NOXP>",   $75
	charmap "<FULLXP>", $7d
	charmap "<XPEND>",  $7e

	charmap "<NONO>",   $f2 ; overwrites <PHONE> in battle
