MACRO base_exception
; mon, actual yield
	dp \1
	dw \2
ENDM

NewBaseExpExceptions:
	base_exception CHANSEY, 395
	base_exception BLISSEY, 608
	dw -1
