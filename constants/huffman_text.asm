; Pair indices occupy the token IDs below the space character. Literals from
; the low end of the charmap are shifted above the directly encodable range.
DEF HUFFMAN_FIRST_SHIFTED_CHAR EQU NGRAMS_START ; $4d
DEF HUFFMAN_LAST_SHIFTED_CHAR  EQU '<CTXT>' - 1 ; $5c

DEF HUFFMAN_FIRST_SHIFTED_TOKEN EQU '…' + 1                                          ; $ec
DEF HUFFMAN_TOKEN_SHIFT EQU HUFFMAN_FIRST_SHIFTED_TOKEN - HUFFMAN_FIRST_SHIFTED_CHAR ; $9f
DEF HUFFMAN_LAST_SHIFTED_TOKEN  EQU HUFFMAN_LAST_SHIFTED_CHAR + HUFFMAN_TOKEN_SHIFT  ; $fb

DEF HUFFMAN_ESCAPE EQU $ff
assert HUFFMAN_LAST_SHIFTED_TOKEN < HUFFMAN_ESCAPE
