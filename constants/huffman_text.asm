MACRO huffmap
	DEF x = CHARVAL(\2)
	DEF ___huffman_data_\1_{02X:x} EQU %\3
	DEF ___huffman_length_\1_{02X:x} EQU STRLEN("\3")
	DEF ___huffman_char_\1_\3 EQUS "\2"
	DEF ___huffman_requires_leaf_\1_{02X:x} = 1
ENDM

MACRO huffesc
	DEF x = CHARVAL(\2)
	DEF ___huffman_data_\1_{02X:x} EQU %\3
	DEF ___huffman_length_\1_{02X:x} EQU STRLEN("\3")
ENDM

MACRO huffleaf
	DEF ___huffman_escape_\1_\2 = 1
ENDM

; Contextual Huffman text compression
; (see constants/huffman_text.inc, data/text/compressed_text.asm, and home/text.asm)
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
DEF CONTEXT_ESCAPE_NODE_ID     EQU $fc
assert LAST_SHIFTED_LEAF_NODE_ID <= LAST_LEAF_NODE_ID
assert FIRST_SHIFTED_LEAF_CHAR_ID < LAST_SHIFTED_LEAF_CHAR_ID && LAST_SHIFTED_LEAF_CHAR_ID < FIRST_LEAF_NODE_ID

INCLUDE "constants/huffman_text.inc"
