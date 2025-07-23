DEF num_parent_nodes = ROOT_NODE_ID
DEF node_prefix_{02X:num_parent_nodes} EQUS ""

MACRO _branch_node
	REDEF _branch_code EQUS "{node_prefix_{02X:parent_node_id}}\1"
	if DEF(___huffman_char_{_branch_code})
		DEF x = ___huffman_char_{_branch_code}
		DEF ___huffman_leaf_node_{02X:x} = 1
		if FIRST_LEAF_NODE_ID <= x && x < FIRST_SHIFTED_LEAF_NODE_ID
			; these characters directly correspond to the lower set of leaf node IDs
			db x
		elif FIRST_SHIFTED_LEAF_CHAR_ID <= x && x <= LAST_SHIFTED_LEAF_CHAR_ID
			; lower characters correspond to the higher set of leaf node IDs
			; (since node IDs below the first leaf node ID must be parent nodes)
			db x + FIRST_SHIFTED_LEAF_NODE_ID - FIRST_SHIFTED_LEAF_CHAR_ID
		else
			; other characters are not mappable with leaf nodes
			fail "invalid leaf node character {___huffman_char_{_branch_code}} (${02x:x}) for code {_branch_code}"
		endc
	else
		DEF num_parent_nodes += 1
		DEF node_prefix_{02X:num_parent_nodes} EQUS #_branch_code
		db num_parent_nodes
	endc
ENDM

TextCompressionHuffmanTree:
	for parent_node_id, ROOT_NODE_ID, FIRST_LEAF_NODE_ID
		if !DEF(node_prefix_{02X:parent_node_id})
			break ; all leaf nodes have been reached
		endc
		_branch_node 0 ; left branch
		_branch_node 1 ; right branch
	endr
	assert num_parent_nodes <= FIRST_LEAF_NODE_ID, "too many parent nodes"

for x, 256
	if DEF(___huffman_data_{02X:x})
		assert DEF(___huffman_leaf_node_{02X:x}), \
			"unreachable leaf node character {___huffman_char_{0{u:___huffman_length_{02X:x}}b:___huffman_data_{02X:x}}} ({#02x:x})"
	endc
endr
