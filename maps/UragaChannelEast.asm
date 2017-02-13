const_value set 2

UragaChannelEast_MapScriptHeader:
.MapTriggers:
	db 0

.MapCallbacks:
	db 0

UragaChannelSign:
	jumptext UragaChannelSignText

ScaryCaveEastSign:
	jumptext ScaryCaveEastSignText

UragaChannelSignText:
	text "Uraga Channel"
	done

ScaryCaveEastSignText:
	text "There's graffiti"
	line "on this sign…"

	para "“This cave is"
	line "scary!”"
	done

UragaChannelEast_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 1
	warp_def $b, $4, 1, URAGA_CHANNEL_WEST

.XYTriggers:
	db 0

.Signposts:
	db 2
	signpost 5, 23, SIGNPOST_READ, UragaChannelSign
	signpost 13, 3, SIGNPOST_READ, ScaryCaveEastSign

.PersonEvents:
	db 0
