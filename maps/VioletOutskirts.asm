VioletOutskirts_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

VioletOutskirts_MapEventHeader:

.Warps: db 0

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 4
	person_event SPRITE_SUICUNE, -2, 16, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_ON_ROUTE_42
	fruittree_event -2, 17, FRUITTREE_ROUTE_42_1, PNK_APRICORN
	fruittree_event -2, 18, FRUITTREE_ROUTE_42_2, GRN_APRICORN
	fruittree_event -2, 19, FRUITTREE_ROUTE_42_3, YLW_APRICORN
