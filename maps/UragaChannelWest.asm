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
	warp_def $9, $14, 1, URAGA_CHANNEL_EAST

.XYTriggers:
	db 0

.Signposts:
	db 1
	signpost 11, 31, SIGNPOST_READ, ScaryCaveEastSign

.PersonEvents:
	db 0
