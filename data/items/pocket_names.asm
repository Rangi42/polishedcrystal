ItemPocketNames:
	dw .Item
	dw .Medicine
	dw .Ball
	dw .TM ; impossible
	dw .Berry
	dw .Key

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
