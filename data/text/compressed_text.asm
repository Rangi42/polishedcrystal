HuffmanPairs:
	MACRO x_pair_rule
		assert \1 == ' ' || (\1 >= 'A' && \1 <= 'Z') || (\1 >= 'a' && \1 <= 'z')
		assert \2 == ' ' || (\2 >= 'A' && \2 <= 'Z') || (\2 >= 'a' && \2 <= 'z')
		db \1, \2
	ENDM
	huffman_pair_rules
	PURGE x_pair_rule

HuffmanContexts:
	MACRO x_pair_contexts
		rept _NARG
			db 2 * (\1) ; byte offset in the pointer table
			shift
		endr
	ENDM
	huffman_pair_contexts
	PURGE x_pair_contexts

HuffmanTrees:
for tree, NUM_HUFFMAN_TREES
	dw HuffmanTree{d:tree}
endr

for tree, NUM_HUFFMAN_TREES
	HuffmanTree{d:tree}:
		DEF _rank = 0
		MACRO x_pair_codes
			DEF _rank += _NARG
			db _NARG
			dr HuffmanSymbols{d:tree} + _rank
		ENDM
		huffman_tree_{d:tree}
		PURGE x_pair_codes

	HuffmanSymbols{d:tree}:
		MACRO x_pair_codes
			if _NARG
				db \#
			endc
		ENDM
		huffman_tree_{d:tree}
		PURGE x_pair_codes
endr
