ViridianGym_MapScriptHeader:

.MapTriggers: db 0

.MapCallbacks: db 0

ViridianGym_MapEventHeader:

.Warps: db 2
	warp_def 45, 6, 1, VIRIDIAN_CITY
	warp_def 45, 7, 1, VIRIDIAN_CITY

.XYTriggers: db 0

.Signposts: db 2
	signpost 43, 4, SIGNPOST_READ, ViridianGymStatue
	signpost 43, 9, SIGNPOST_READ, ViridianGymStatue

.PersonEvents: db 8
	person_event SPRITE_BLUE, 2, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, PERSONTYPE_SCRIPT, 0, BlueScript_0x9aa26, EVENT_VIRIDIAN_GYM_BLUE
	person_event SPRITE_GYM_GUY, 43, 8, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ViridianGymGuyScript, EVENT_VIRIDIAN_GYM_BLUE
	person_event SPRITE_COOLTRAINER_M, 35, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoAraandbela1, -1
	person_event SPRITE_COOLTRAINER_F, 35, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoAraandbela2, -1
	person_event SPRITE_COOLTRAINER_F, 34, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfSalma, -1
	person_event SPRITE_COOLTRAINER_F, 20, 3, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerCooltrainerfBonita, -1
	person_event SPRITE_COOLTRAINER_M, 8, 6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoElanandida1, -1
	person_event SPRITE_COOLTRAINER_F, 8, 7, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_TRAINER, 1, TrainerAceDuoElanandida2, -1

BlueScript_0x9aa26:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, 1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLUE
	setevent EVENT_BEAT_ACE_DUO_ARA_AND_BELA
	setevent EVENT_BEAT_COOLTRAINERF_SALMA
	setevent EVENT_BEAT_COOLTRAINERF_BONITA
	setevent EVENT_BEAT_ACE_DUO_ELAN_AND_IDA
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
	setevent EVENT_FINAL_BATTLE_WITH_LYRA
.FightDone:
	checkevent EVENT_GOT_TM71_STONE_EDGE
	iftrue_jumpopenedtext LeaderBlueEpilogueText
	writetext LeaderBlueAfterText
	buttonsound
	verbosegivetmhm TM_STONE_EDGE
	setevent EVENT_GOT_TM71_STONE_EDGE
	jumpopenedtext BlueOutroText

ViridianGymGuyScript:
	checkevent EVENT_BEAT_BLUE
	iftrue_jumptextfaceplayer ViridianGymGuyWinText
	jumptextfaceplayer ViridianGymGuyText

TrainerAceDuoAraandbela1:
	trainer EVENT_BEAT_ACE_DUO_ARA_AND_BELA, ACE_DUO, ARAANDBELA1, AceDuoAraandbela1SeenText, AceDuoAraandbela1BeatenText, 0, AceDuoAraandbela1Script

AceDuoAraandbela1Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoAraandbela1AfterText

TrainerAceDuoAraandbela2:
	trainer EVENT_BEAT_ACE_DUO_ARA_AND_BELA, ACE_DUO, ARAANDBELA2, AceDuoAraandbela2SeenText, AceDuoAraandbela2BeatenText, 0, AceDuoAraandbela2Script

AceDuoAraandbela2Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoAraandbela2AfterText

TrainerCooltrainerfSalma:
	trainer EVENT_BEAT_COOLTRAINERF_SALMA, COOLTRAINERF, SALMA, CooltrainerfSalmaSeenText, CooltrainerfSalmaBeatenText, 0, CooltrainerfSalmaScript

CooltrainerfSalmaScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainerfSalmaAfterText

TrainerCooltrainerfBonita:
	trainer EVENT_BEAT_COOLTRAINERF_BONITA, COOLTRAINERF, BONITA, CooltrainerfBonitaSeenText, CooltrainerfBonitaBeatenText, 0, CooltrainerfBonitaScript

CooltrainerfBonitaScript:
	end_if_just_battled
	jumptextfaceplayer CooltrainerfBonitaAfterText

TrainerAceDuoElanandida1:
	trainer EVENT_BEAT_ACE_DUO_ELAN_AND_IDA, ACE_DUO, ELANANDIDA1, AceDuoElanandida1SeenText, AceDuoElanandida1BeatenText, 0, AceDuoElanandida1Script

AceDuoElanandida1Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoElanandida1AfterText

TrainerAceDuoElanandida2:
	trainer EVENT_BEAT_ACE_DUO_ELAN_AND_IDA, ACE_DUO, ELANANDIDA2, AceDuoElanandida2SeenText, AceDuoElanandida2BeatenText, 0, AceDuoElanandida2Script

AceDuoElanandida2Script:
	end_if_just_battled
	jumptextfaceplayer AceDuoElanandida2AfterText

ViridianGymStatue:
	trainertotext BLUE, 1, $1
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd gymstatue1
.Beaten:
	jumpstd gymstatue2

LeaderBlueBeforeText:
	text "Blue: Yo! Finally"
	line "got here, huh?"

	para "I wasn't in the"
	line "mood at Cinnabar,"

	para "but now I'm ready"
	line "to battle you."

	para "…"

	para "You're telling me"
	line "you conquered all"
	cont "the Gyms in Johto?"

	para "Heh! Johto's Gyms"
	line "must be pretty"
	cont "pathetic then."

	para "Hey, don't worry"
	line "about it."

	para "I'll know if you"
	line "are good or not by"

	para "battling you right"
	line "now."

	para "Ready, Johto"
	line "Champ?"
	done

LeaderBlueWinText:
	text "Blue: What?"

	para "How the heck did I"
	line "lose to you?"

	para "…"

	para "Tch, all right…"
	line "Here, take this--"

	para "it's the Earth"
	line "Badge."
	done

Text_ReceivedEarthBadge:
	text "<PLAYER> received"
	line "the Earth Badge."
	done

LeaderBlueAfterText:
	text "Blue: Here! Take"
	line "this as well!"
	done

BlueOutroText:
	text "It contains Stone"
	line "Edge. It's not only"

	para "for Rock-type"
	line "#mon, got it?"

	para "…"

	para "All right, I was"
	line "wrong. You're the"

	para "real deal. You are"
	line "a good trainer."

	para "With eight badges"
	line "from Kanto, you"

	para "can challenge the"
	line "Elite Four again."

	para "They won't go easy"
	line "on a trainer who"
	cont "beat two regions."

	para "You can practice"
	line "with me at the"

	para "Fighting Dojo in"
	line "Saffron City on"
	cont "Mondays."

	para "All of the Gym"
	line "Leaders show up"
	cont "there to train."

	para "I'm going to beat"
	line "you someday."

	para "Don't you forget"
	line "it!"
	done

LeaderBlueEpilogueText:
	text "Blue: Listen, you."

	para "You'd better not"
	line "lose until I beat"
	cont "you. Got it?"
	done

ViridianGymGuyText:
	text "Yo, Champ in"
	line "making!"

	para "How's it going?"
	line "Looks like you're"
	cont "on a roll."

	para "The Gym Leader is"
	line "a guy who battled"

	para "the Champion three"
	line "years ago."

	para "He's no pushover."

	para "Give it everything"
	line "you've got!"
	done

ViridianGymGuyWinText:
	text "Man, you are truly"
	line "tough…"

	para "That was a heck of"
	line "an inspirational"

	para "battle. It brought"
	line "tears to my eyes."
	done

AceDuoAraandbela1SeenText:
	text "Ara: Come on,"
	line "fight us and see"
	cont "how good we are!"
	done

AceDuoAraandbela1BeatenText:
	text "Ara: We were"
	line "deceived!"
	done

AceDuoAraandbela1AfterText:
	text "Ara: Me, I should"
	line "be a pretty good"
	cont "practice partner…"
	done

AceDuoAraandbela2SeenText:
	text "Bela: Come on,"
	line "fight us and see"
	cont "how good we are!"
	done

AceDuoAraandbela2BeatenText:
	text "Bela: We were"
	line "deceived!"
	done

AceDuoAraandbela2AfterText:
	text "Bela: Our practice"
	line "battles didn't pre-"
	cont "pare us for this."
	done

CooltrainerfSalmaSeenText:
	text "What do you think?"

	para "You've never seen"
	line "such a wonderful"
	cont "Gym, have you?"
	done

CooltrainerfSalmaBeatenText:
	text "Whatever!"
	done

CooltrainerfSalmaAfterText:
	text "There are many"
	line "Gyms in the world,"

	para "but I really like"
	line "this one!"
	done

CooltrainerfBonitaSeenText:
	text "Looking around the"
	line "room, doesn't it"
	cont "make you dizzy?"
	done

CooltrainerfBonitaBeatenText:
	text "All of my #mon…"

	para "All dizzy and"
	line "fainting…"
	done

CooltrainerfBonitaAfterText:
	text "Looks like you've"
	line "still got some"
	cont "energy left."
	done

AceDuoElanandida1SeenText:
	text "Elan: All right,"
	line "let's get this"
	cont "fight started!"
	done

AceDuoElanandida1BeatenText:
	text "Elan: Well, this"
	line "is surprising."
	done

AceDuoElanandida1AfterText:
	text "Elan: You're"
	line "stronger than we"
	cont "anticipated!"
	done

AceDuoElanandida2SeenText:
	text "Ida: I'm Ida! Next"
	line "to me is Elan!"

	para "Together, we're an"
	line "Ace Duo!"
	done

AceDuoElanandida2BeatenText:
	text "Ida: Wow. You're"
	line "really something."
	done

AceDuoElanandida2AfterText:
	text "Ida: If all you"
	line "have is strength,"
	cont "you won't do well."

	para "Strategy is also"
	line "important!"
	done
