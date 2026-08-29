MACRO _huffman_branch_node
	REDEF _branch_code EQUS "{node_prefix_\1_{02X:parent_node_id}}\2"
	if DEF(___huffman_escape_\1_{_branch_code})
		db CONTEXT_ESCAPE_NODE_ID
	elif DEF(___huffman_char_\1_{_branch_code})
			DEF x = CHARVAL(___huffman_char_\1_{_branch_code})
			DEF ___huffman_leaf_node_\1_{02X:x} = 1
			if FIRST_LEAF_NODE_ID <= x && x < FIRST_SHIFTED_LEAF_NODE_ID
				; These characters directly correspond to the lower leaf IDs.
				db x
			elif FIRST_SHIFTED_LEAF_CHAR_ID <= x && x <= LAST_SHIFTED_LEAF_CHAR_ID
				; Lower characters correspond to the higher leaf IDs.
				db x + FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
			else
				fail "invalid contextual Huffman leaf character ${02x:x} for code {_branch_code}"
			endc
	else
		DEF num_parent_nodes_\1 += 1
		DEF node_prefix_\1_{02X:num_parent_nodes_\1} EQUS #_branch_code
		db num_parent_nodes_\1
	endc
ENDM

MACRO huffman_tree
	DEF num_parent_nodes_\1 = ROOT_NODE_ID
	DEF node_prefix_\1_{02X:num_parent_nodes_\1} EQUS ""
\2:
	for parent_node_id, ROOT_NODE_ID, FIRST_LEAF_NODE_ID
		if !DEF(node_prefix_\1_{02X:parent_node_id})
			break
		endc
		_huffman_branch_node \1, 0
		_huffman_branch_node \1, 1
	endr
	assert num_parent_nodes_\1 < FIRST_LEAF_NODE_ID, "too many contextual Huffman parent nodes"

	for x, 256
		if DEF(___huffman_requires_leaf_\1_{02X:x})
			assert DEF(___huffman_leaf_node_\1_{02X:x}), \
				"unreachable contextual Huffman leaf character ${02x:x}"
		endc
	endr
ENDM

huffman_tree b, TextCompressionHuffmanTreeBoundary
huffman_tree v, TextCompressionHuffmanTreeVowel
huffman_tree o, TextCompressionHuffmanTreeOther
