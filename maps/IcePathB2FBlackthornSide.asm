IcePathB2FBlackthornSide_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  3, 15, ICE_PATH_B1F, 8
	warp_event  3,  3, ICE_PATH_B3F, 2

	def_coord_events

	def_bg_events
	bg_event  2, 10, BGEVENT_ITEM + ICE_HEAL, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL

	def_object_events
	itemball_event  8, 16, NUGGET, 1, EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_NUGGET
