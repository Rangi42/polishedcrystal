MACRO ctxtmap
	DEF x = \2
	DEF ___huffman_data_{02X:x} EQU %\3
	DEF ___huffman_length_{02X:x} EQU STRLEN("\3")
	charmap \1, \2
ENDM

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

	; n-grams: $09 - $51 (defined below)

DEF SPECIALS_START EQU $52

	ctxtmap "<DONE>",   $52, 001111
	ctxtmap "@",        $53, 111101000
	ctxtmap "<PROMPT>", $54, 1101000010
	ctxtmap "<LNBRK>",  $55, 01011011000
	ctxtmap "<NEXT>",   $56, 00111010
	ctxtmap "<LINE>",   $57, 00101
	ctxtmap "<CONT>",   $58, 0101100
	ctxtmap "<PARA>",   $59, 100010

	ctxtmap "<TARGET>", $5a, 0101101111010
	ctxtmap "<USER>",   $5b, 010110111110
	ctxtmap "<ENEMY>",  $5c, 010110111111001

	charmap "<CTXT>",   $5d

	charmap "¯",        $5e

; Battle characters

DEF BATTLEEXTRA_GFX_START EQU $5f

	charmap "<MALE>",   $5f
	charmap "<FEMALE>", $60
	charmap "<STAR>",   $61
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

	ctxtmap " ",        $7f, 011

; typeface font:

	ctxtmap "A",        $80, 101110
	ctxtmap "B",        $81, 110101000
	ctxtmap "C",        $82, 110100111
	ctxtmap "D",        $83, 001000100
	ctxtmap "E",        $84, 1101000011
	ctxtmap "F",        $85, 1011000111
	ctxtmap "G",        $86, 001000101
	ctxtmap "H",        $87, 00100000
	ctxtmap "I",        $88, 1101011
	ctxtmap "J",        $89, 11010011000
	ctxtmap "K",        $8a, 11110101110
	ctxtmap "L",        $8b, 001110010
	ctxtmap "M",        $8c, 101100010
	ctxtmap "N",        $8d, 11110101111
	ctxtmap "O",        $8e, 101100000
	ctxtmap "P",        $8f, 001110011
	ctxtmap "Q",        $90, 00100011100011
	ctxtmap "R",        $91, 1101001101
	ctxtmap "S",        $92, 00100001
	ctxtmap "T",        $93, 11010101
	ctxtmap "U",        $94, 00100011111
	ctxtmap "V",        $95, 110100110010
	ctxtmap "W",        $96, 111101010
	ctxtmap "X",        $97, 11010100111001101
	ctxtmap "Y",        $98, 111101001
	ctxtmap "Z",        $99, 0010001111010

	ctxtmap "(",        $9a, 010110110010
	ctxtmap ")",        $9b, 010110110011
	ctxtmap ".",        $9c, 010111
	ctxtmap ",",        $9d, 0101001
	ctxtmap "?",        $9e, 11010010
	ctxtmap "!",        $9f, 1110000

	ctxtmap "a",        $a0, 0100
	ctxtmap "b",        $a1, 1110001
	ctxtmap "c",        $a2, 100011
	ctxtmap "d",        $a3, 111100
	ctxtmap "e",        $a4, 000
	ctxtmap "f",        $a5, 001001
	ctxtmap "g",        $a6, 101111
	ctxtmap "h",        $a7, 11000
	ctxtmap "i",        $a8, 11101
	ctxtmap "j",        $a9, 0101101110
	ctxtmap "k",        $aa, 1011001
	ctxtmap "l",        $ab, 10000
	ctxtmap "m",        $ac, 101101
	ctxtmap "n",        $ad, 11111
	ctxtmap "o",        $ae, 1010
	ctxtmap "p",        $af, 1111011
	ctxtmap "q",        $b0, 00100011101
	ctxtmap "r",        $b1, 11011
	ctxtmap "s",        $b2, 11001
	ctxtmap "t",        $b3, 1001
	ctxtmap "u",        $b4, 00110
	ctxtmap "v",        $b5, 0101000
	ctxtmap "w",        $b6, 010101
	ctxtmap "x",        $b7, 1011000011
	ctxtmap "y",        $b8, 111001
	ctxtmap "z",        $b9, 11010100110

	ctxtmap "“",        $ba, 0010001111000
	ctxtmap "”",        $bb, 0010001111001
	ctxtmap "-",        $bc, 00111000
	ctxtmap ":",        $bd, 001000110
	ctxtmap "♂",        $be, 1101001100110100100
	ctxtmap "♀",        $bf, 1101001100110100101

	ctxtmap "'",        $c0, 0010001110000
	ctxtmap "'d",       $c1, 010110111100
	ctxtmap "'l",       $c2, 0101101101
	ctxtmap "'m",       $c3, 1111010110
	ctxtmap "'r",       $c4, 1011000010
	ctxtmap "'s",       $c5, 00111011
	ctxtmap "'t",       $c6, 110100000
	ctxtmap "'v",       $c7, 10110001101

	ctxtmap "é",        $c8, 1101010011100111
	ctxtmap "É",        $c9, 1101001100110100110
	ctxtmap "á",        $ca, 00100011110110010
	ctxtmap "ê",        $cb, 1101001100110100111
	ctxtmap "í",        $cc, 001000111101111011
	ctxtmap "ó",        $cd, 110100110011010000

	ctxtmap "¿",        $ce, 110100110011010001
	ctxtmap "¡",        $cf, 00100011110110011

	ctxtmap "<PO>",     $d0, 1101010011100100000
	ctxtmap "<KE>",     $d1, 1101010011100100001
	ctxtmap "<PK>",     $d2, 1101001100110101
	ctxtmap "<MN>",     $d3, 1101001100110110

	ctxtmap "<ID>",     $d4, 11010100111001001
	ctxtmap "№",        $d5, 0010001111011000
	ctxtmap "<LV>",     $d6, 11010100111001100
	ctxtmap "<BOLDP>",  $d7, 00100011110111100

	ctxtmap "&",        $d8, 0010001111011111

	ctxtmap "♪",        $d9, 00100011100010
	ctxtmap "♥",        $da, 1101010011100101

	ctxtmap "×",        $db, 1101001100110000
	ctxtmap "/",        $dc, 001000111101110
	ctxtmap "%",        $dd, 1101010011100100010

	ctxtmap "+",        $de, 1101010011100100011
	ctxtmap "<SHARP>",  $df, 001000111101111010

	ctxtmap "0",        $e0, 110101001111
	ctxtmap "1",        $e1, 001000111001
	ctxtmap "2",        $e2, 1101010011101
	ctxtmap "3",        $e3, 1101001100111
	ctxtmap "4",        $e4, 0101101111011
	ctxtmap "5",        $e5, 0101101111111
	ctxtmap "6",        $e6, 01011011111101
	ctxtmap "7",        $e7, 110100110011001
	ctxtmap "8",        $e8, 1101001100110111
	ctxtmap "9",        $e9, 010110111111000

	ctxtmap "¥",        $ea, 11010100111000

	ctxtmap "…",        $eb, 11010001

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


DEF NGRAMS_START EQU $09

	newcharmap compressing, no_ngrams

	ctxtmap "#",        $4d, 10110001100
	ctxtmap "#mon",     $4e, 01011010
DEF NGRAMS_VAR_START EQU $4f
	; these below are implemented as n-grams whose string is stored in WRAM
	ctxtmap "<PLAYER>", $4f, 1101010010
	ctxtmap "<RIVAL>",  $50, 001000111101101
	ctxtmap "<TRENDY>", $51, 1101001100110001

	newcharmap default, compressing

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
	charmap "attle",    $4c

DEF NGRAMS_END EQU $51

	setcharmap default


MACRO rawchar
	setcharmap no_ngrams
	db \#
	setcharmap default
ENDM
