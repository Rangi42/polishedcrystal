NationalForest1_MapScriptHeader:
    def_scene_scripts

    def_callbacks

    def_warp_events
	warp_event 21,  3, OLSTEETON_FOREST_GATE, 5

    def_coord_events

    def_bg_events
	bg_event 25, 5, BGEVENT_JUMPTEXT, NationalForest1EntranceSignText

    def_object_events

    object_const_def

NationalForest1NationalForest1EntranceSignText:
    text "Jolly Sods"
    line "Regional Park"
    done