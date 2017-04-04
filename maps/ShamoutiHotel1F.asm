const_value set 0

ShamoutiHotel1F_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

;No matter where
;you go, <TRENDY> is
;the coolest thing
;around!
;Isn't that so?
;
;You know it! I
;just can't get
;enough of <TRENDY>!
;
;What?! <TRENDY>
;isn't the coolest
;thing around?
;Well, what is the
;coolest thing
;these days?
;
;Oh, yeah! I've got
;it now!
;<TRENDY> is totally
;the best thing
;ever!

ShamoutiHotel1F_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 4
	warp_def $7, $8, 2, SHAMOUTI_ISLAND
	warp_def $7, $9, 2, SHAMOUTI_ISLAND
	warp_def $0, $2, 1, SHAMOUTI_HOTEL_2F
	warp_def $0, $e, 1, SHAMOUTI_HOTEL_RESTAURANT

.XYTriggers:
	db 0

.Signposts:
	db 0

.PersonEvents:
	db 0
