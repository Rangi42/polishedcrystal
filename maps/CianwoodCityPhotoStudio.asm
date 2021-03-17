CianwoodCityPhotoStudio_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 5
	warp_event  3,  7, CIANWOOD_CITY, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodPhotoStudioFishingGuruScript, -1

CianwoodPhotoStudioFishingGuruScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_PHOTOGRAPH
	iftrue_jumpopenedtext PhotoStudioAlreadyDoneText
	writetext PhotoStudioGreetingText
	yesorno
	iffalse_jumpopenedtext PhotoStudioRefusedText
	writetext PhotoStudioWhichMonText
	promptbutton
	special Special_CianwoodPhotograph
	ifequal $0, .NoPicture
	ifequal $1, .EggPicture
	setflag ENGINE_DAILY_PHOTOGRAPH
	writetext PhotoStudioHoldStillText
	waitbutton
	closetext
	special FadeOutPalettes
	special LoadMapPalettes
	pause 10
	playsound SFX_DOUBLE_SLAP
	waitsfx
	pause 10
	special FadeInPalettes
	readmem wCurPartySpecies
	pokepic 0
	cry 0
	waitsfx
	closepokepic
	opentext
	writetext PhotoStudioPrestoText
	special PlayCurMonCry
	waitbutton
	jumpthisopenedtext

	text "Come again, OK?"
	done

.NoPicture:
	jumpopenedtext PhotoStudioNoPictureText

.EggPicture:
	jumpopenedtext PhotoStudioEggPictureText

PhotoStudioGreetingText:
	text "I am Cameron"
	line "the Photographer."

	para "You have magnifi-"
	line "cent #mon with"
	cont "you."

	para "How about a photo"
	line "for a souvenir?"
	done

PhotoStudioWhichMonText:
	text "OK! Big smile now!"

	para "Which #mon"
	line "should I photo-"
	cont "graph?"
	done

PhotoStudioHoldStillText:
	text "All righty. Hold"
	line "still for a bit."
	done

PhotoStudioPrestoText:
	text "Presto! All done."

	para "Your "
	text_ram wStringBuffer3
	line "looks happier!"
	done

PhotoStudioAlreadyDoneText:
	text "I've already taken"
	line "a photo for you"
	cont "today."

	para "Come back again"
	line "tomorrow."
	done

PhotoStudioRefusedText:
	text "Oh, that's too"
	line "bad. I thought it"

	para "would be a great"
	line "memento…"
	done

PhotoStudioNoPictureText:
	text "Oh, no picture?"
	line "Come again, OK?"
	done

PhotoStudioEggPictureText:
	text "An Egg? My talent"
	line "is worth more…"
	done
