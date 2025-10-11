MACRO parent_node
	_parent_node \1 ; left branch for bit 0
	_parent_node \2 ; right branch for bit 1
ENDM

MACRO _parent_node
	if STRFIND("\1", "$") == 0
		; hex literals indicate parent nodes
		assert ROOT_NODE_ID < \1 && \1 < FIRST_LEAF_NODE_ID, "invalid parent node value \1"
		db \1
	elif STRFIND("\1", "\"") == 0
		; string literals indicate leaf nodes
		DEF x = \1
		if !DEF(___huffman_data_{02X:x})
			fail "invalid leaf node character \1"
		endc
		if DEF(___huffman_leaf_node_{02X:x})
			fail "already mapped leaf node character \1"
		endc
		DEF ___huffman_leaf_node_{02X:x} = 1
		if FIRST_LEAF_NODE_ID <= \1 && \1 < FIRST_SHIFTED_LEAF_NODE_ID
			; these characters directly correspond to the lower set of leaf node IDs
			db \1
		elif FIRST_SHIFTED_LEAF_CHAR_ID <= \1 && \1 <= LAST_SHIFTED_LEAF_CHAR_ID
			; lower characters correspond to the higher set of leaf node IDs
			; (since node IDs below the first leaf node ID must be parent nodes)
			db \1 + FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
		else
			; other characters are unmapped; leaf nodes $fd-$ff are unused
			fail "unmapped leaf node character \1"
		endc
	else
		fail "ambiguous node value \1 (parent = hex, leaf = string)"
	endc
ENDM

TextCompressionHuffmanTree:
	parent_node $01,        $36        ; $00 - root
	parent_node $02,        $22        ; $01 - 0
	parent_node "e",        $03        ; $02 - 00
	parent_node $04,        $1c        ; $03 - 001
	parent_node $05,        "<LINE>"   ; $04 - 0010
	parent_node $06,        "f"        ; $05 - 00100
	parent_node $07,        $08        ; $06 - 001000
	parent_node "H",        "S"        ; $07 - 0010000
	parent_node $09,        $0a        ; $08 - 0010001
	parent_node "D",        "G"        ; $09 - 00100010
	parent_node ":",        $0b        ; $0a - 00100011
	parent_node $0c,        $10        ; $0b - 001000111
	parent_node $0d,        "q"        ; $0c - 0010001110
	parent_node $0e,        "1"        ; $0d - 00100011100
	parent_node "'",        $0f        ; $0e - 001000111000
	parent_node "♪",        "Q"        ; $0f - 0010001110001
	parent_node $11,        "U"        ; $10 - 0010001111
	parent_node $12,        $13        ; $11 - 00100011110
	parent_node "“",        "”"        ; $12 - 001000111100
	parent_node "Z",        $14        ; $13 - 001000111101
	parent_node $15,        $18        ; $14 - 0010001111011
	parent_node $16,        "<RIVAL>"  ; $15 - 00100011110110
	parent_node "№",        $17        ; $16 - 001000111101100
	parent_node "á",        "¡"        ; $17 - 0010001111011001
	parent_node "/",        $19        ; $18 - 00100011110111
	parent_node $1a,        "&"        ; $19 - 001000111101111
	parent_node "<BOLDP>",  $1b        ; $1a - 0010001111011110
	parent_node "<SHARP>",  "í"        ; $1b - 00100011110111101
	parent_node "u",        $1d        ; $1c - 0011
	parent_node $1e,        "<DONE>"   ; $1d - 00111
	parent_node $1f,        $21        ; $1e - 001110
	parent_node "-",        $20        ; $1f - 0011100
	parent_node "L",        "P"        ; $20 - 00111001
	parent_node "<NEXT>",   "'s"       ; $21 - 0011101
	parent_node $23,        " "        ; $22 - 01
	parent_node "a",        $24        ; $23 - 010
	parent_node $25,        $27        ; $24 - 0101
	parent_node $26,        "w"        ; $25 - 01010
	parent_node "v",        ","        ; $26 - 010100
	parent_node $28,        "."        ; $27 - 01011
	parent_node "<CONT>",   $29        ; $28 - 010110
	parent_node "#mon",     $2a        ; $29 - 0101101
	parent_node $2b,        $2e        ; $2a - 01011011
	parent_node $2c,        "'l"       ; $2b - 010110110
	parent_node "<LNBRK>",  $2d        ; $2c - 0101101100
	parent_node "(",        ")"        ; $2d - 01011011001
	parent_node "j",        $2f        ; $2e - 010110111
	parent_node $30,        $32        ; $2f - 0101101111
	parent_node "'d",       $31        ; $30 - 01011011110
	parent_node "<TARGET>", "4"        ; $31 - 010110111101
	parent_node "<USER>",   $33        ; $32 - 01011011111
	parent_node $34,        "5"        ; $33 - 010110111111
	parent_node $35,        "6"        ; $34 - 0101101111110
	parent_node "9",        "<ENEMY>"  ; $35 - 01011011111100
	parent_node $37,        $46        ; $36 - 1
	parent_node $38,        $3b        ; $37 - 10
	parent_node $39,        "t"        ; $38 - 100
	parent_node "l",        $3a        ; $39 - 1000
	parent_node "<PARA>",   "c"        ; $3a - 10001
	parent_node "o",        $3c        ; $3b - 101
	parent_node $3d,        $45        ; $3c - 1011
	parent_node $3e,        "m"        ; $3d - 10110
	parent_node $3f,        "k"        ; $3e - 101100
	parent_node $40,        $42        ; $3f - 1011000
	parent_node "O",        $41        ; $40 - 10110000
	parent_node "'r",       "x"        ; $41 - 101100001
	parent_node "M",        $43        ; $42 - 10110001
	parent_node $44,        "F"        ; $43 - 101100011
	parent_node "#",        "'v"       ; $44 - 1011000110
	parent_node "A",        "g"        ; $45 - 10111
	parent_node $47,        $70        ; $46 - 11
	parent_node $48,        $49        ; $47 - 110
	parent_node "h",        "s"        ; $48 - 1100
	parent_node $4a,        "r"        ; $49 - 1101
	parent_node $4b,        $60        ; $4a - 11010
	parent_node $4c,        $4f        ; $4b - 110100
	parent_node $4d,        "…"        ; $4c - 1101000
	parent_node "'t",       $4e        ; $4d - 11010000
	parent_node "<PROMPT>", "E"        ; $4e - 110100001
	parent_node "?",        $50        ; $4f - 1101001
	parent_node $51,        "C"        ; $50 - 11010011
	parent_node $52,        "R"        ; $51 - 110100110
	parent_node "J",        $53        ; $52 - 1101001100
	parent_node "V",        $54        ; $53 - 11010011001
	parent_node $55,        "3"        ; $54 - 110100110011
	parent_node $56,        $58        ; $55 - 1101001100110
	parent_node $57,        "7"        ; $56 - 11010011001100
	parent_node "×",        "<TRENDY>" ; $57 - 110100110011000
	parent_node $59,        $5f        ; $58 - 11010011001101
	parent_node $5a,        "<PK>"     ; $59 - 110100110011010
	parent_node $5b,        $5c        ; $5a - 1101001100110100
	parent_node "ó",        "¿"        ; $5b - 11010011001101000
	parent_node $5d,        $5e        ; $5c - 11010011001101001
	parent_node "♂",        "♀"        ; $5d - 110100110011010010
	parent_node "É",        "ê"        ; $5e - 110100110011010011
	parent_node "<MN>",     "8"        ; $5f - 110100110011011
	parent_node $61,        "I"        ; $60 - 110101
	parent_node $62,        "T"        ; $61 - 1101010
	parent_node "B",        $63        ; $62 - 11010100
	parent_node "<PLAYER>", $64        ; $63 - 110101001
	parent_node "z",        $65        ; $64 - 1101010011
	parent_node $66,        "0"        ; $65 - 11010100111
	parent_node $67,        "2"        ; $66 - 110101001110
	parent_node "¥",        $68        ; $67 - 1101010011100
	parent_node $69,        $6e        ; $68 - 11010100111001
	parent_node $6a,        "♥"        ; $69 - 110101001110010
	parent_node $6b,        "<ID>"     ; $6a - 1101010011100100
	parent_node $6c,        $6d        ; $6b - 11010100111001000
	parent_node "<PO>",     "<KE>"     ; $6c - 110101001110010000
	parent_node "%",        "+"        ; $6d - 110101001110010001
	parent_node $6f,        "é"        ; $6e - 110101001110011
	parent_node "<LV>",     "X"        ; $6f - 1101010011100110
	parent_node $71,        $74        ; $70 - 111
	parent_node $72,        "i"        ; $71 - 1110
	parent_node $73,        "y"        ; $72 - 11100
	parent_node "!",        "b"        ; $73 - 111000
	parent_node $75,        "n"        ; $74 - 1111
	parent_node "d",        $76        ; $75 - 11110
	parent_node $77,        "p"        ; $76 - 111101
	parent_node $78,        $79        ; $77 - 1111010
	parent_node "@",        "Y"        ; $78 - 11110100
	parent_node "W",        $7a        ; $79 - 11110101
	parent_node "'m",       $7b        ; $7a - 111101011
	parent_node "K",        "N"        ; $7b - 1111010111
	; parent nodes $7c-$7e are unused

for x, 256
	if DEF(___huffman_data_{02X:x}) && !DEF(___huffman_leaf_node_{02X:x})
		fail "unreachable leaf node character {#02X:x}"
	endc
endr

; Huffman tree:
; ( ( ( "e",
;       ( ( ( ( ( "H",
;                 "S"
;               ),
;               ( ( "D",
;                   "G"
;                 ),
;                 ( ":",
;                   ( ( ( ( "'",
;                           ( "♪",
;                             "Q"
;                         ) ),
;                         "1"
;                       ),
;                       "q"
;                     ),
;                     ( ( ( "“",
;                           "”"
;                         ),
;                         ( "Z",
;                           ( ( ( "№",
;                                 ( "á",
;                                   "¡"
;                               ) ),
;                               "<RIVAL>"
;                             ),
;                             ( "/",
;                               ( ( "<BOLDP>",
;                                   ( "<SHARP>",
;                                     "í"
;                                 ) ),
;                                 "&"
;                       ) ) ) ) ),
;                       "U"
;             ) ) ) ) ),
;             "f"
;           ),
;           "<LINE>"
;         ),
;         ( "u",
;           ( ( ( "-",
;                 ( "L",
;                   "P"
;               ) ),
;               ( "<NEXT>",
;                 "'s"
;             ) ),
;             "<DONE>"
;     ) ) ) ),
;     ( ( "a",
;         ( ( ( "v",
;               ","
;             ),
;             "w"
;           ),
;           ( ( "<CONT>",
;               ( "#mon",
;                 ( ( ( "<LNBRK>",
;                       ( "(",
;                         ")"
;                     ) ),
;                     "'l"
;                   ),
;                   ( "j",
;                     ( ( "'d",
;                         ( "<TARGET>",
;                           "4"
;                         )
;                       ),
;                       ( "<USER>",
;                         ( ( ( "9",
;                               "<ENEMY>"
;                             ),
;                             "6"
;                           ),
;                           "5"
;             ) ) ) ) ) ) ),
;             "."
;       ) ) ),
;       " "
;   ) ),
;   ( ( ( ( "l",
;           ( "<PARA>",
;             "c"
;         ) ),
;         "t"
;       ),
;       ( "o",
;         ( ( ( ( ( "O",
;                   ( "'r",
;                     "x"
;                 ) ),
;                 ( "M",
;                   ( ( "#",
;                       "'v"
;                     ),
;                     "F"
;               ) ) ),
;               "k"
;             ),
;             "m"
;           ),
;           ( "A",
;             "g"
;     ) ) ) ),
;     ( ( ( "h",
;           "s"
;         ),
;         ( ( ( ( ( "'t",
;                   ( "<PROMPT>",
;                     "E"
;                 ) ),
;                 "…"
;               ),
;               ( "?",
;                 ( ( ( "J",
;                       ( "V",
;                         ( ( ( ( "×",
;                                 "<TRENDY>"
;                               ),
;                               "7"
;                             ),
;                             ( ( ( ( "ó",
;                                     "¿"
;                                   ),
;                                   ( ( "♂",
;                                       "♀"
;                                     ),
;                                     ( "É",
;                                       "ê"
;                                 ) ) ),
;                                 "<PK>"
;                               ),
;                               ( "<MN>",
;                                 "8"
;                           ) ) ),
;                           "3"
;                     ) ) ),
;                     "R"
;                   ),
;                   "C"
;             ) ) ),
;             ( ( ( "B",
;                   ( "<PLAYER>",
;                     ( "z",
;                       ( ( ( "¥",
;                             ( ( ( ( ( "<PO>",
;                                       "<KE>"
;                                     ),
;                                     ( "%",
;                                       "+"
;                                   ) ),
;                                   "<ID>"
;                                 ),
;                                 "♥"
;                               ),
;                               ( ( "<LV>",
;                                   "X"
;                                 ),
;                                 "é"
;                           ) ) ),
;                           "2"
;                         ),
;                         "0"
;                 ) ) ) ),
;                 "T"
;               ),
;               "I"
;           ) ),
;           "r"
;       ) ),
;       ( ( ( ( "!",
;               "b"
;             ),
;             "y"
;           ),
;           "i"
;         ),
;         ( ( "d",
;             ( ( ( "@",
;                   "Y"
;                 ),
;                 ( "W",
;                   ( "'m",
;                     ( "K",
;                       "N"
;               ) ) ) ),
;               "p"
;           ) ),
;           "n"
; ) ) ) ) )
