SinjohRuins_MapScriptHeader:
	db 0 ; map triggers

	db 0 ; map callbacks

	db 2 ; warps
	warp_def 7, 5, 1, MYSTRI_STAGE
	warp_def 21, 13, 1, SINJOH_RUINS_HOUSE

	db 0 ; xy triggers

	db 1 ; signposts
	signpost 8, 7, SIGNPOST_JUMPTEXT, SinjohRuinsSignpostText

	db 0 ; person events

SinjohRuinsSignpostText:
	text "The Sinjoh Ruins"
	done
