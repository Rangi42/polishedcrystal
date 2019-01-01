UnlockedUnownLetterSets:
	dw .Set1
	dw .Set2
	dw .Set3
	dw .Set4
.End

.Set1:
	;  A   B   C   D   E   F   G   H   I   J
	db 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, -1
.Set2:
	;  K   L   M   N   O   P   Q
	db 11, 12, 13, 14, 15, 16, 17, -1
.Set3:
	;  R   S   T   U   V   W
	db 18, 19, 20, 21, 22, 23, -1
.Set4:
	;  X   Y   Z   !   ?
	db 24, 25, 26, 27, 28, -1
