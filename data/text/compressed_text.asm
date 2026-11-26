MACRO x_pair_rule
	assert \1 == ' ' || (\1 >= 'A' && \1 <= 'Z') || (\1 >= 'a' && \1 <= 'z')
	assert \2 == ' ' || (\2 >= 'A' && \2 <= 'Z') || (\2 >= 'a' && \2 <= 'z')
	db \1, \2
ENDM

MACRO x_pair_contexts
	rept _NARG
		db 2 * (\1) ; byte offset in the pointer table
		shift
	endr
ENDM

MACRO x_pair_codes
	if _emit_symbols
		if _NARG
			db \#
		endc
	else
		DEF _rank += _NARG
		db _NARG
		dr .Symbols{d:tree} + _rank
	endc
ENDM

HuffmanPairs:
	huffman_pairs

HuffmanContexts:
	huffman_contexts

HuffmanTrees:
	for tree, NUM_HUFFMAN_TREES
		dw .Tree{d:tree}
	endr
	for tree, NUM_HUFFMAN_TREES
	.Tree{d:tree}:
		DEF _rank = 0
		DEF _emit_symbols = 0
		huffman_tree_{d:tree}
	.Symbols{d:tree}:
		DEF _emit_symbols = 1
		huffman_tree_{d:tree}
	endr
