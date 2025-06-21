MACRO ctxtmap
	DEF x = \2
	DEF ___huffman_data_{02X:x} EQU %\3
	DEF ___huffman_length_{02X:x} EQU STRLEN("\3")
	DEF ___huffman_char_\3 EQUS "\1"
	charmap \1, x
ENDM

; Huffman text compression (see data/text/compressed_text.asm and home/text.asm)
; tree starts at parent node $00
DEF ROOT_NODE_ID               EQU $00
; characters $7f-$eb correspond to leaf nodes $7f-$eb
DEF FIRST_LEAF_NODE_ID         EQU $7f
DEF LAST_LEAF_NODE_ID          EQU $ff
; characters $4d-$5c correspond to leaf nodes $ec-$fb
DEF FIRST_SHIFTED_LEAF_CHAR_ID EQU $4d
DEF LAST_SHIFTED_LEAF_CHAR_ID  EQU $5c
DEF FIRST_SHIFTED_LEAF_NODE_ID EQU $ec
DEF LAST_SHIFTED_LEAF_NODE_ID  EQU FIRST_SHIFTED_LEAF_NODE_ID + LAST_SHIFTED_LEAF_CHAR_ID - FIRST_SHIFTED_LEAF_CHAR_ID ; $fb
assert LAST_SHIFTED_LEAF_NODE_ID <= LAST_LEAF_NODE_ID
assert FIRST_SHIFTED_LEAF_CHAR_ID < LAST_SHIFTED_LEAF_CHAR_ID && LAST_SHIFTED_LEAF_CHAR_ID < FIRST_LEAF_NODE_ID

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

	; n-grams: $0a - $51 (defined below)

DEF SPECIALS_START EQU $52

	ctxtmap "<DONE>",   $52, 101100
	ctxtmap "@",        $53, 001011010
	ctxtmap "<PROMPT>", $54, 1101011001
	ctxtmap "<LNBRK>",  $55, 100001100111
	ctxtmap "<NEXT>",   $56, 1101011100
	ctxtmap "<LINE>",   $57, 01011
	ctxtmap "<CONT>",   $58, 1011100
	ctxtmap "<PARA>",   $59, 101111

	ctxtmap "<TARGET>", $5a, 001101000110100
	ctxtmap "<USER>",   $5b, 001101000011001
	ctxtmap "<ENEMY>",  $5c, 0011010001101011

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

	ctxtmap "A",        $80, 00101100
	ctxtmap "B",        $81, 101110111
	ctxtmap "C",        $82, 100001111
	ctxtmap "D",        $83, 1011101100
	ctxtmap "E",        $84, 0101000111
	ctxtmap "F",        $85, 1000011000
	ctxtmap "G",        $86, 1101011110
	ctxtmap "H",        $87, 010100010
	ctxtmap "I",        $88, 1100100
	ctxtmap "J",        $89, 10000110010
	ctxtmap "K",        $8a, 10111011011
	ctxtmap "L",        $8b, 1101011101
	ctxtmap "M",        $8c, 001011011
	ctxtmap "N",        $8d, 11010100100
	ctxtmap "O",        $8e, 1101010011
	ctxtmap "P",        $8f, 001011100
	ctxtmap "Q",        $90, 110101111100110
	ctxtmap "R",        $91, 1000011011
	ctxtmap "S",        $92, 110101101
	ctxtmap "T",        $93, 00110110
	ctxtmap "U",        $94, 100001110111
	ctxtmap "V",        $95, 001101000111
	ctxtmap "W",        $96, 001101110
	ctxtmap "X",        $97, 0011010000110111
	ctxtmap "Y",        $98, 001101001
	ctxtmap "Z",        $99, 11010111110111

	ctxtmap "(",        $9a, 001101000000
	ctxtmap ")",        $9b, 001101000010
	ctxtmap ".",        $9c, 100000
	ctxtmap ",",        $9d, 0101001
	ctxtmap "?",        $9e, 11010101
	ctxtmap "!",        $9f, 1111011

	ctxtmap "a",        $a0, 0100
	ctxtmap "b",        $a1, 1111010
	ctxtmap "c",        $a2, 101101
	ctxtmap "d",        $a3, 00100
	ctxtmap "e",        $a4, 000
	ctxtmap "f",        $a5, 001100
	ctxtmap "g",        $a6, 110100
	ctxtmap "h",        $a7, 11000
	ctxtmap "i",        $a8, 11101
	ctxtmap "j",        $a9, 0101000110
	ctxtmap "k",        $aa, 1100101
	ctxtmap "l",        $ab, 10001
	ctxtmap "m",        $ac, 110011
	ctxtmap "n",        $ad, 11111
	ctxtmap "o",        $ae, 1001
	ctxtmap "p",        $af, 001010
	ctxtmap "q",        $b0, 00110100010
	ctxtmap "r",        $b1, 11100
	ctxtmap "s",        $b2, 11011
	ctxtmap "t",        $b3, 1010
	ctxtmap "u",        $b4, 00111
	ctxtmap "v",        $b5, 1000010
	ctxtmap "w",        $b6, 010101
	ctxtmap "x",        $b7, 1101011000
	ctxtmap "y",        $b8, 111100
	ctxtmap "z",        $b9, 11010100101

	ctxtmap "“",        $ba, 11010111110101
	ctxtmap "”",        $bb, 0011010001100
	ctxtmap "-",        $bc, 00110101
	ctxtmap ":",        $bd, 001011101
	ctxtmap "♂",        $be, 001101000011011000
	ctxtmap "♀",        $bf, 1000011101101000001

	ctxtmap "'",        $c0, 0011010000111
	ctxtmap "'d",       $c1, 100001100110
	ctxtmap "'l",       $c2, 1000011010
	ctxtmap "'m",       $c3, 1000011100
	ctxtmap "'r",       $c4, 0011011111
	ctxtmap "'s",       $c5, 00101111
	ctxtmap "'t",       $c6, 110101000
	ctxtmap "'v",       $c7, 10111011010

	ctxtmap "é",        $c8, 001101000110110
	ctxtmap "É",        $c9, 1000011101101000000
	ctxtmap "á",        $ca, 00110100001101101
	ctxtmap "ê",        $cb, 0011010001101010111
	ctxtmap "í",        $cc, 100001110110100010
	ctxtmap "ó",        $cd, 110101111100111000

	ctxtmap "¿",        $ce, 100001110110100011
	ctxtmap "¡",        $cf, 0011010001101010110

	ctxtmap "<PO>",     $d0, 0011010001101010101
	ctxtmap "<KE>",     $d1, 0011010001101010100
	ctxtmap "<PK>",     $d2, 1000011101101111
	ctxtmap "<MN>",     $d3, 1000011101101110

	ctxtmap "<ID>",     $d4, 0011010000110110011
	ctxtmap "№",        $d5, 100001110110100001
	ctxtmap "<LV>",     $d6, 11010111110011101
	ctxtmap "<BOLDP>",  $d7, 00110100011010100

	ctxtmap "&",        $d8, 1000011101101010

	ctxtmap "♪",        $d9, 100001110110110
	ctxtmap "♥",        $da, 1101011111001111

	ctxtmap "×",        $db, 1000011101101011
	ctxtmap "/",        $dc, 001101000110111
	ctxtmap "%",        $dd, 110101111100111001

	ctxtmap "+",        $de, 0011010000110100
	ctxtmap "<SHARP>",  $df, 0011010000110110010

	ctxtmap "0",        $e0, 110101111110
	ctxtmap "1",        $e1, 001101000001
	ctxtmap "2",        $e2, 1101011111111
	ctxtmap "3",        $e3, 1101011111110
	ctxtmap "4",        $e4, 1000011101100
	ctxtmap "5",        $e5, 1101011111000
	ctxtmap "6",        $e6, 11010111110010
	ctxtmap "7",        $e7, 110101111101000
	ctxtmap "8",        $e8, 001101000011000
	ctxtmap "9",        $e9, 110101111101001

	ctxtmap "¥",        $ea, 11010111110110

	ctxtmap "…",        $eb, 10111010

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


DEF NGRAMS_START EQU $0a

	newcharmap compressing, no_ngrams

	ctxtmap "#",        $4d, 10000111010
	ctxtmap "#mon",     $4e, 01010000
DEF NGRAMS_VAR_START EQU $4f
	; these below are implemented as n-grams whose string is stored in WRAM
	ctxtmap "<PLAYER>", $4f, 0011011110
	ctxtmap "<RIVAL>",  $50, 1000011101101001
	ctxtmap "<TRENDY>", $51, 0011010000110101

	newcharmap default, compressing

	charmap "ou",       $0a
	charmap "th",       $0b
	charmap "in",       $0c
	charmap "t ",       $0d
	charmap "er",       $0e
	charmap "s ",       $0f
	charmap "an",       $10
	charmap "on",       $11
	charmap "to ",      $12
	charmap "d ",       $13
	charmap "ea",       $14
	charmap "y ",       $15
	charmap "en",       $16
	charmap "or",       $17
	charmap "at",       $18
	charmap ", ",       $19
	charmap "ll",       $1a
	charmap "I ",       $1b
	charmap "ar",       $1c
	charmap "it",       $1d
	charmap "st",       $1e
	charmap "ow",       $1f
	charmap "ha",       $20
	charmap "a ",       $21
	charmap "om",       $22
	charmap "le",       $23
	charmap "of ",      $24
	charmap "se",       $25
	charmap "re",       $26
	charmap "to",       $27
	charmap "'s ",      $28
	charmap "Th",       $29
	charmap "is",       $2a
	charmap "ra",       $2b
	charmap "ch",       $2c
	charmap "I'm ",     $2d
	charmap "o ",       $2e
	charmap "gh",       $2f
	charmap "es",       $30
	charmap "wa",       $31
	charmap "e.",       $32
	charmap "oo",       $33
	charmap "ck",       $34
	charmap "r ",       $35
	charmap "l ",       $36
	charmap "be",       $37
	charmap "li",       $38
	charmap "ed",       $39
	charmap "us",       $3a
	charmap "ti",       $3b
	charmap " you",     $3c
	charmap "ing ",     $3d
	charmap "the ",     $3e
	charmap "you",      $3f
	charmap "ing",      $40
	charmap "is ",      $41
	charmap "the",      $42
	charmap "You ",     $43
	charmap "er ",      $44
	charmap "with",     $45
	charmap "batt",     $46
	charmap "for",      $47
	charmap "ve ",      $48
	charmap "ed ",      $49
	charmap "It's ",    $4a
	charmap "that ",    $4b
	charmap "e ",       $4c

DEF NGRAMS_END EQU $51

	setcharmap default


MACRO rawchar
	setcharmap no_ngrams
	db \#
	setcharmap default
ENDM
