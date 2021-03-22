ItemPocketNames:
	table_width 2, ItemPocketNames
	dw .Item
	dw .Medicine
	dw .Ball
	dw .TM ; impossible
	dw .Berry
	dw .Key ; impossible
	assert_table_length NUM_POCKETS

.Item:
	db "Item Pocket@"
.Medicine:
	db "Med.Pocket@"
.Ball:
	db "Ball Pocket@"
.TM:
	db "TM Pocket@"
.Berry:
	db "Berry Pocket@"
.Key:
	db "Key Pocket@"
