unown_set: MACRO
rept _NARG
	db UNOWN_\1_FORM
	shift
endr
	db -1
ENDM

UnlockedUnownLetterSets:
	dw .Set1
	dw .Set2
	dw .Set3
	dw .Set4
.End

.Set1:
	unown_set A, B, C, D, E, F, G, H, I, J
.Set2:
	unown_set K, L, M, N, O, P, Q
.Set3:
	unown_set R, S, T, U, V, W
.Set4:
	unown_set X, Y, Z, EXCLAMATION, QUESTION
