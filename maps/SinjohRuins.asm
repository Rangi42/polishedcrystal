SinjohRuins_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

SinjohRuins_MapEventHeader:

.Warps: db 2
	warp_def 7, 5, 1, MYSTRI_STAGE
	warp_def 21, 13, 1, SINJOH_RUINS_HOUSE

.XYTriggers: db 0

.Signposts: db 1
	signpost 8, 7, SIGNPOST_JUMPTEXT, SinjohRuinsSignpostText

.PersonEvents: db 0

SinjohRuinsSignpostText:
	text "The Sinjoh Ruins"
	done
