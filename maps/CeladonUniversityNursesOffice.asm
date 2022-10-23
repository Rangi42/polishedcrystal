CeladonUniversityNursesOffice_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  5, CELADON_UNIVERSITY_2F, 7
	warp_event  3,  5, CELADON_UNIVERSITY_2F, 7

	def_coord_events

	def_bg_events
	bg_event  2,  0, BGEVENT_JUMPTEXT, CeladonUniversityNursesOfficeSignText

	def_object_events
	object_event  4,  2, SPRITE_BOWING_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonUniversityNursesOfficeNurseScript, -1

CeladonUniversityNursesOfficeNurseScript:
	showtextfaceplayer CeladonUniversityNursesOfficeNurseText
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special Special_FadeInQuickly
	special RestartMapMusic
	jumpthistext

	text "Stay safe, dear!"
	done

CeladonUniversityNursesOfficeNurseText:
	text "Come in, dear."
	line "Are you feeling"
	cont "well?"

	para "Or are your #-"
	line "mon tuckered out?"

	para "Please rest here"
	line "for a while!"
	done

CeladonUniversityNursesOfficeSignText:
	text "A healthy #mon"
	line "is a happy #-"
	cont "mon!"

	para "Don't let your"
	line "friends faint"
	cont "during battle!"
	done
