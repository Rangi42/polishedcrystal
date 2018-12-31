OlivineLighthouse6F_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

OlivineLighthouse6F_MapEventHeader:

.Warps: db 4
	warp_def 15, 9, 1, OLIVINE_LIGHTHOUSE_5F
	warp_def 5, 16, 6, OLIVINE_LIGHTHOUSE_5F
	warp_def 5, 17, 7, OLIVINE_LIGHTHOUSE_5F
	warp_def 3, 9, 1, OLIVINE_LIGHTHOUSE_ROOF

.XYTriggers: db 0

.Signposts: db 0

.PersonEvents: db 3
	person_event SPRITE_JASMINE, 8, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, JasmineScript_0x60b91, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	person_event SPRITE_AMPHAROS, 8, 9, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, MonsterScript_0x60c3a, -1
	itemball_event 4, 3, SUPER_POTION, 1, EVENT_OLIVINE_LIGHTHOUSE_6F_SUPER_POTION

const_value set 1
	const OLIVINELIGHTHOUSE6F_JASMINE
	const OLIVINELIGHTHOUSE6F_AMPHAROS

JasmineScript_0x60b91:
	faceplayer
	opentext
	checkitem SECRETPOTION
	iftrue UnknownScript_0x60bab
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue UnknownScript_0x60ba5
	writetext UnknownText_0x60c81
	buttonsound
	setevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
UnknownScript_0x60ba5:
	jumpopenedtext UnknownText_0x60d64

UnknownScript_0x60bab:
	writetext UnknownText_0x60d99
	yesorno
	iffalse UnknownScript_0x60c25
	writetext UnknownText_0x60dc3
	buttonsound
	takeitem SECRETPOTION
	writetext UnknownText_0x60dea
	waitbutton
	closetext
	spriteface OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	opentext
	playmusic MUSIC_HEAL
	writetext UnknownText_0x60e44
	pause 60
	buttonsound
	closetext
	special RestartMapMusic
	cry AMPHAROS
	special FadeOutPalettes
	pause 10
	special FadeInPalettes
	showtext UnknownText_0x60f3d
	showemote EMOTE_BOLT, OLIVINELIGHTHOUSE6F_AMPHAROS, 15
	showtextfaceplayer UnknownText_0x60e6c
	setevent EVENT_JASMINE_RETURNED_TO_GYM
	clearevent EVENT_OLIVINE_GYM_JASMINE
	checkcode VAR_FACING
	if_equal DOWN, UnknownScript_0x60c17
	if_equal RIGHT, UnknownScript_0x60c1e
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, MovementData_0x60c68
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c17:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, MovementData_0x60c70
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c1e:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, MovementData_0x60c79
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

UnknownScript_0x60c25:
	writetext UnknownText_0x60edf
	waitbutton
	closetext
	spriteface OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	jumptext UnknownText_0x60ef1

MonsterScript_0x60c3a:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue UnknownScript_0x60c51
	faceplayer
	opentext
	writetext UnknownText_0x60f03
	writebyte AMPHAROS
	special PlaySlowCry
	buttonsound
	jumpopenedtext UnknownText_0x60f19

UnknownScript_0x60c51:
	showcrytext UnknownText_0x60f3d, AMPHAROS
	special FadeOutPalettes
	special FadeInPalettes
	special FadeOutPalettes
	special FadeInPalettes
	end

MovementData_0x60c68:
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	step_sleep_8
	step_sleep_8
	step_end

MovementData_0x60c70:
	slow_step_down
	slow_step_right
	slow_step_right
	slow_step_right
	slow_step_up
	slow_step_right
	slow_step_right
	slow_step_right
	step_end

MovementData_0x60c79:
	slow_step_up
	slow_step_up
	slow_step_right
	slow_step_up
	slow_step_up
	slow_step_up
	step_sleep_8
	step_end

UnknownText_0x60c81:
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

UnknownText_0x60d64:
	text "…May I ask you to"
	line "get some medicine"
	cont "for me? Please?"
	done

UnknownText_0x60d99:
	text "Jasmine: …Will"
	line "that medicine cure"
	cont "Amphy?"
	done

UnknownText_0x60dc3:
	text "<PLAYER> handed the"
	line "SecretPotion to"
	cont "Jasmine."
	done

UnknownText_0x60dea:
	text "Jasmine: …Um,"
	line "please don't be"
	cont "offended…"

	para "…Amphy will not"
	line "take anything from"
	cont "anyone but me…"
	done

UnknownText_0x60e44:
	text "Jasmine: …"

	para "Amphy, how are you"
	line "feeling?"
	done

UnknownText_0x60e6c:
	text "Jasmine: …Oh, I'm"
	line "so relieved…"

	para "This is just so"
	line "wonderful…"

	para "Thank you so very,"
	line "very much."

	para "…I will return to"
	line "the Gym…"
	done

UnknownText_0x60edf:
	text "Jasmine: …I see…"
	done

UnknownText_0x60ef1:
	text "…Amphy, hang on!"
	done

UnknownText_0x60f03:
	text "Amphy: …"
	line "…Pa… paloo…"
	done

UnknownText_0x60f19:
	text "Its breathing is"
	line "terribly labored…"
	done

UnknownText_0x60f3d:
	text "Amphy: Palu!"
	line "Palulu!"
	done
