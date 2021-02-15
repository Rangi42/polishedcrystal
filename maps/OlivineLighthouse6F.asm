OlivineLighthouse6F_MapScriptHeader:
	def_scene_scripts

	def_callbacks

	def_warp_events
	warp_event  9, 15, OLIVINE_LIGHTHOUSE_5F, 1
	warp_event 16,  5, OLIVINE_LIGHTHOUSE_5F, 6
	warp_event 17,  5, OLIVINE_LIGHTHOUSE_5F, 7
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_ROOF, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  8, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseJasmine, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	object_event  9,  8, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, AMPHAROS, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseAmphy, -1
	itemball_event  3,  4, SUPER_POTION, 1, EVENT_OLIVINE_LIGHTHOUSE_6F_SUPER_POTION

	object_const_def
	const OLIVINELIGHTHOUSE6F_JASMINE
	const OLIVINELIGHTHOUSE6F_AMPHAROS

OlivineLighthouseJasmine:
	faceplayer
	opentext
	checkkeyitem SECRETPOTION
	iftrue UnknownScript_0x60bab
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue UnknownScript_0x60ba5
	writetext JasmineCianwoodPharmacyText
	buttonsound
	setevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
UnknownScript_0x60ba5:
	jumpopenedtext JasmineGetSomeMedicineText

UnknownScript_0x60bab:
	writetext JasmineCureAmphyText
	yesorno
	iffalse UnknownScript_0x60c25
	writetext PlayerHandedSecretpotionText
	buttonsound
	takekeyitem SECRETPOTION
	writetext JasmineDontBeOffendedText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	opentext
	playmusic MUSIC_HEAL
	writetext JasmineAmphyHowAreYouFeelingText
	pause 60
	buttonsound
	closetext
	special RestartMapMusic
	cry AMPHAROS
	special FadeOutPalettes
	special LoadMapPalettes
	pause 10
	special FadeInPalettes
	showtext AmphyPaluPaluluText
	showemote EMOTE_BOLT, OLIVINELIGHTHOUSE6F_AMPHAROS, 15
	showtextfaceplayer JasmineThankYouText
	setevent EVENT_JASMINE_RETURNED_TO_GYM
	clearevent EVENT_OLIVINE_GYM_JASMINE
	checkcode VAR_FACING
	ifequal DOWN, UnknownScript_0x60c17
	ifequal RIGHT, UnknownScript_0x60c1e
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesUpMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c17:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesDownMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c1e:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesRightMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c25:
	writetext JasmineISeeText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	jumptext JasmineAmphyHangOnText

OlivineLighthouseAmphy:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue UnknownScript_0x60c51
	faceplayer
	opentext
	writetext AmphyPalPalooText
	writebyte AMPHAROS
	special PlaySlowCry
	buttonsound
	jumpopenedtext AmphyBreathingLaboredText

UnknownScript_0x60c51:
	showcrytext AmphyPaluPaluluText, AMPHAROS
	special FadeOutPalettes
	special LoadMapPalettes
	special FadeInPalettes
	special FadeOutPalettes
	special LoadMapPalettes
	special FadeInPalettes
	end

OlivineLighthouseJasmineLeavesUpMovement:
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	step_sleep_8
	step_sleep_8
	step_end

OlivineLighthouseJasmineLeavesDownMovement:
	slow_step_down
	slow_step_right
	slow_step_right
	slow_step_right
	slow_step_up
	slow_step_right
	slow_step_right
	slow_step_right
	step_end

OlivineLighthouseJasmineLeavesRightMovement:
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	slow_step_up
	step_sleep_8
	step_end

JasmineCianwoodPharmacyText:
	text "Jasmine: …This"
	line "#mon always"

	para "kept the sea lit"
	line "at night."

	para "…But it suddenly"
	line "got sick… It's"
	cont "gasping for air…"

	para "…I understand"
	line "that there is a"

	para "wonderful Pharmacy"
	line "in Cianwood…"

	para "But that's across"
	line "the sea…"

	para "And I can't leave"
	line "Amphy unattended…"
	done

JasmineGetSomeMedicineText:
	text "…May I ask you to"
	line "get some medicine"
	cont "for me? Please?"
	done

JasmineCureAmphyText:
	text "Jasmine: …Will"
	line "that medicine cure"
	cont "Amphy?"
	done

PlayerHandedSecretpotionText:
	text "<PLAYER> handed the"
	line "SecretPotion to"
	cont "Jasmine."
	done

JasmineDontBeOffendedText:
	text "Jasmine: …Um,"
	line "please don't be"
	cont "offended…"

	para "…Amphy will not"
	line "take anything from"
	cont "anyone but me…"
	done

JasmineAmphyHowAreYouFeelingText:
	text "Jasmine: …"

	para "Amphy, how are you"
	line "feeling?"
	done

JasmineThankYouText:
	text "Jasmine: …Oh, I'm"
	line "so relieved…"

	para "This is just so"
	line "wonderful…"

	para "Thank you so very,"
	line "very much."

	para "…I will return to"
	line "the Gym…"
	done

JasmineISeeText:
	text "Jasmine: …I see…"
	done

JasmineAmphyHangOnText:
	text "…Amphy, hang on!"
	done

AmphyPalPalooText:
	text "Amphy: …"
	line "…Pa… paloo…"
	done

AmphyBreathingLaboredText:
	text "Its breathing is"
	line "terribly labored…"
	done

AmphyPaluPaluluText:
	text "Amphy: Palu!"
	line "Palulu!"
	done
