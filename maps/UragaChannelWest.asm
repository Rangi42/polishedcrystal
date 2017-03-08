const_value set 2

UragaChannelWest_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

ScaryCaveWestSign:
	jumptext ScaryCaveWestSignText

ScaryCaveWestSignText:
	text "Careful! This cave"
	line "is haunted!"
	done

UragaChannelWest_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $9, $8, 2, SCARY_CAVE_1F

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 9, SIGNPOST_READ, ScaryCaveWestSign

.PersonEvents:
	db 0
