MACRO unown_set
	for i, 1, _NARG + 1
		db UNOWN_\<i>_FORM
	endr
	db -1
ENDM

UnlockedUnownLetterSets:
; entries correspond to UNLOCKED_UNOWNS_* constants
	table_width 2
	dw .Set_A_J
	dw .Set_K_Q
	dw .Set_R_W
	dw .Set_X_Question
	assert_table_length NUM_UNLOCKED_UNOWN_SETS

.Set_A_J:
	unown_set A, B, C, D, E, F, G, H, I, J
.Set_K_Q:
	unown_set K, L, M, N, O, P, Q
.Set_R_W:
	unown_set R, S, T, U, V, W
.Set_X_Question:
	unown_set X, Y, Z, EXCLAMATION, QUESTION
