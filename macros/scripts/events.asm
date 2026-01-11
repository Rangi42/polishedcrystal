; RunScriptCommand.Jumptable indexes (see engine/overworld/scripting.asm)
	const_def

	const scall_command
MACRO scall
	db scall_command
	dw \1 ; pointer
ENDM

	const farscall_command
MACRO farscall
	db farscall_command
	dba \1
ENDM

	const memcall_command
MACRO memcall
	db memcall_command
	dw \1 ; pointer
ENDM

	const sjump_command
MACRO sjump
	db sjump_command
	dw \1 ; pointer
	assert warn, \1 - @ > 255 || \1 - @ < 0, "sjump can be sjumpfwd"
ENDM

	const farsjump_command
MACRO farsjump
	db farsjump_command
	dba \1
ENDM

	const memjump_command
MACRO memjump
	db memjump_command
	dw \1 ; pointer
ENDM

	const ifequal_command
MACRO ifequal
	db ifequal_command
	db \1 ; byte
	dw \2 ; pointer
	assert warn, \2 - @ > 255 || \2 - @ < 0, "ifequal can be ifequalfwd"
ENDM

	const ifnotequal_command
MACRO ifnotequal
	db ifnotequal_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const iffalse_command
MACRO iffalse
	db iffalse_command
	dw \1 ; pointer
	assert warn, \1 - @ > 255 || \1 - @ < 0, "iffalse can be iffalsefwd"
ENDM

	const iftrue_command
MACRO iftrue
	db iftrue_command
	dw \1 ; pointer
	assert warn, \1 - @ > 255 || \1 - @ < 0, "iftrue can be iftruefwd"
ENDM

	const ifgreater_command
MACRO ifgreater
	db ifgreater_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const ifless_command
MACRO ifless
	db ifless_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const jumpstd_command
MACRO jumpstd
	db jumpstd_command
	db \1 ; predefined_script
ENDM

	const callstd_command
MACRO callstd
	db callstd_command
	db \1 ; predefined_script
ENDM

	const callasm_command
MACRO callasm
	db callasm_command
	dba \1
ENDM

	const special_command
MACRO special
	db special_command
	db (\1Special - SpecialsPointers) / 3
ENDM

	const memcallasm_command
MACRO memcallasm
	db memcallasm_command
	dw \1 ; asm
ENDM

	const checkmapscene_command
MACRO checkmapscene
	db checkmapscene_command
	map_id \1 ; map
ENDM

	const setmapscene_command
MACRO setmapscene
	db setmapscene_command
	map_id \1 ; map
	db \2 ; trigger_id
ENDM

	const checkscene_command
MACRO checkscene
	db checkscene_command
ENDM

	const setscene_command
MACRO setscene
	db setscene_command
	db \1 ; trigger_id
ENDM

	const setval_command
MACRO setval
	db setval_command
	db \1 ; value
ENDM

	const setval16_command
MACRO setval16
	db setval16_command
	dw \1 ; value
ENDM

MACRO setmonval ; pseudo-command for loading mons into hScriptVar
	db setval16_command
	dp \1 ; mon value
ENDM

	const addval_command
MACRO addval
	db addval_command
	db \1 ; value
ENDM

	const random_command
MACRO random
	db random_command
	db \1 ; input
ENDM

	const random16_command
MACRO random16
	db random16_command
	dw \1 ; input
ENDM

	const readmem_command
MACRO readmem
	db readmem_command
	dw \1 ; address
ENDM

	const readmem16_command
MACRO readmem16
	db readmem16_command
	if _NARG == 2
		dw \1, \2
	else
		dw \1, \1+1
	endc
ENDM

	const writemem_command
MACRO writemem
	db writemem_command
	dw \1 ; address
ENDM

	const loadmem_command
MACRO loadmem
	db loadmem_command
	dw \1 ; address
	db \2 ; value
ENDM

	const readvar_command
MACRO readvar
	db readvar_command
	db \1 ; variable_id
ENDM

	const writevar_command
MACRO writevar
	db writevar_command
	db \1 ; variable_id
ENDM

	const loadvar_command
MACRO loadvar
	db loadvar_command
	db \1 ; variable_id
	db \2 ; value
ENDM

	const giveitem_command
MACRO giveitem
	db giveitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const takeitem_command
MACRO takeitem
	db takeitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const checkitem_command
MACRO checkitem
	db checkitem_command
	db \1 ; item
ENDM

	const givemoney_command
MACRO givemoney
	db givemoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const takemoney_command
MACRO takemoney
	db takemoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const checkmoney_command
MACRO checkmoney
	db checkmoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const givecoins_command
MACRO givecoins
	db givecoins_command
	dw \1 ; coins
ENDM

	const takecoins_command
MACRO takecoins
	db takecoins_command
	dw \1 ; coins
ENDM

	const checkcoins_command
MACRO checkcoins
	db checkcoins_command
	dw \1 ; coins
ENDM

	const addcellnum_command
MACRO addcellnum
	db addcellnum_command
	db \1 ; person
ENDM

	const delcellnum_command
MACRO delcellnum
	db delcellnum_command
	db \1 ; person
ENDM

	const checkcellnum_command
MACRO checkcellnum
	db checkcellnum_command
	db \1 ; person
ENDM

	const checktime_command
MACRO checktime
	db checktime_command
	db \1 ; time
ENDM

	const checkpoke_command
MACRO checkpoke
	db checkpoke_command
	dp \1 ; pkmn
ENDM

	const givepoke_command
MACRO givepoke
	db givepoke_command
	if _NARG >= 3
		dp \1, \2 ; pokemon
		db \3 ; level
	else
		dp \1, PLAIN_FORM
		db \2 ; level
	endc
	if _NARG >= 4
		db \4 ; item
	else
		db NO_ITEM
	endc
	if _NARG >= 5
		db \5 ; ball
	else
		db POKE_BALL
	endc
	if _NARG >= 6
		db \6 ; special move
	else
		db NO_MOVE
	endc
	if _NARG >= 7
		db TRUE ; trainer
		dw \7 ; nickname_pointer
		dw \8 ; ot_name_pointer
		bigdw \9 ; ot_id
	else
		db FALSE ; no trainer
	endc
ENDM

	const giveegg_command
MACRO giveegg
	db giveegg_command
	if _NARG >= 2
		dp \1, \2 | IS_EGG_MASK
	else
		dp \1, PLAIN_FORM | IS_EGG_MASK
	endc
ENDM

	const givepokemail_command
MACRO givepokemail
	db givepokemail_command
	dw \1 ; pointer
ENDM

	const checkpokemail_command
MACRO checkpokemail
	db checkpokemail_command
	dw \1 ; pointer
ENDM

	const checkevent_command
MACRO checkevent
	db checkevent_command
	dw \1 ; event_flag
ENDM

	const clearevent_command
MACRO clearevent
	db clearevent_command
	dw \1 ; event_flag
ENDM

	const setevent_command
MACRO setevent
	db setevent_command
	dw \1 ; event_flag
ENDM

	const checkflag_command
MACRO checkflag
	db checkflag_command
	dw \1 ; engine_flag
ENDM

	const clearflag_command
MACRO clearflag
	db clearflag_command
	dw \1 ; engine_flag
ENDM

	const setflag_command
MACRO setflag
	db setflag_command
	dw \1 ; engine_flag
ENDM

	const wildon_command
MACRO wildon
	db wildon_command
ENDM

	const wildoff_command
MACRO wildoff
	db wildoff_command
ENDM

	const warpmod_command
MACRO warpmod
	db warpmod_command
	db \1 ; warp_id
	map_id \2 ; map
ENDM

	const blackoutmod_command
MACRO blackoutmod
	db blackoutmod_command
	map_id \1 ; map
ENDM

	const warp_command
MACRO warp
	db warp_command
	map_id \1 ; map
	db \2 ; x
	db \3 ; y
ENDM

	const getmoney_command
MACRO getmoney
	db getmoney_command
	db \1 ; account
	db \2 ; memory
ENDM

	const getcoins_command
MACRO getcoins
	db getcoins_command
	db \1 ; memory
ENDM

	const getnum_command
MACRO getnum
	db getnum_command
	db \1 ; memory
ENDM

	const getmonname_command
MACRO getmonname
	db getmonname_command
	dp \1 ; pokemon
	db \2 ; memory
ENDM

	const getitemname_command
MACRO getitemname
	db getitemname_command
	db \1 ; item
	db \2 ; memory
ENDM

	const getcurlandmarkname_command
MACRO getcurlandmarkname
	db getcurlandmarkname_command
	db \1 ; memory
ENDM

	const gettrainername_command
MACRO gettrainername
	db gettrainername_command
	db \1 ; trainer_id
	db \2 ; trainer_group
	db \3 ; memory
ENDM

	const getstring_command
MACRO getstring
	db getstring_command
	dw \1 ; text_pointer
	db \2 ; memory
ENDM

	const itemnotify_command
MACRO itemnotify
	db itemnotify_command
ENDM

	const pocketisfull_command
MACRO pocketisfull
	db pocketisfull_command
ENDM

	const opentext_command
MACRO opentext
	db opentext_command
ENDM

	const reanchormap_command
MACRO reanchormap
	db reanchormap_command
ENDM

	const closetext_command
MACRO closetext
	db closetext_command
ENDM

	const farwritetext_command
MACRO farwritetext
	db farwritetext_command
	dba \1
ENDM

	const writetext_command
MACRO writetext
	db writetext_command
	dw \1 ; text_pointer
ENDM

	const repeattext_command
MACRO repeattext
	db repeattext_command
ENDM

	const yesorno_command
MACRO yesorno
	db yesorno_command
ENDM

	const loadmenu_command
MACRO loadmenu
	db loadmenu_command
	dw \1 ; data
ENDM

	const closewindow_command
MACRO closewindow
	db closewindow_command
ENDM

	const jumptextfaceplayer_command
MACRO jumptextfaceplayer
	db jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const farjumptext_command
MACRO farjumptext
	db farjumptext_command
	dba \1
ENDM

	const jumptext_command
MACRO jumptext
	db jumptext_command
	dw \1 ; text_pointer
ENDM

	const waitbutton_command
MACRO waitbutton
	db waitbutton_command
ENDM

	const promptbutton_command
MACRO promptbutton
	db promptbutton_command
ENDM

	const pokepic_command
MACRO pokepic
	db pokepic_command
	if \1 == 0
		db \1 ; party mon
	elif _NARG == 2
		dp \1, \2 ; form
	else
		dp \1, PLAIN_FORM
	endc
ENDM

	const closepokepic_command
MACRO closepokepic
	db closepokepic_command
ENDM

	const _2dmenu_command
MACRO _2dmenu
	db _2dmenu_command
ENDM

	const verticalmenu_command
MACRO verticalmenu
	db verticalmenu_command
ENDM

	const randomwildmon_command
MACRO randomwildmon
	db randomwildmon_command
ENDM

	const loadtemptrainer_command
MACRO loadtemptrainer
	db loadtemptrainer_command
ENDM

	const loadwildmon_command
MACRO loadwildmon
	db loadwildmon_command
	if _NARG == 3
		dp \1, \2 ; pokemon
		db \3 ; level
	else
		dp \1, PLAIN_FORM
		db \2 ; level
	endc
ENDM

	const loadtrainer_command
MACRO loadtrainer
	db loadtrainer_command
	db \1 ; trainer_group
	db \2 ; trainer_id
ENDM

	const startbattle_command
MACRO startbattle
	db startbattle_command
ENDM

	const reloadmapafterbattle_command
MACRO reloadmapafterbattle
	db reloadmapafterbattle_command
ENDM

	const catchtutorial_command
MACRO catchtutorial
	db catchtutorial_command
	db \1 ; byte
ENDM

	const trainertext_command
MACRO trainertext
	db trainertext_command
	db \1 ; which_text
ENDM

	const trainerflagaction_command
MACRO trainerflagaction
	db trainerflagaction_command
	db \1 ; action
ENDM

	const winlosstext_command
MACRO winlosstext
	db winlosstext_command
	dw \1 ; win_text_pointer
	dw \2 ; loss_text_pointer
ENDM

	const scripttalkafter_command
MACRO scripttalkafter
	db scripttalkafter_command
ENDM

	const endifjustbattled_command
MACRO endifjustbattled
	db endifjustbattled_command
ENDM

	const checkjustbattled_command
MACRO checkjustbattled
	db checkjustbattled_command
ENDM

	const setlasttalked_command
MACRO setlasttalked
	db setlasttalked_command
	db \1 ; person
ENDM

	const applymovement_command
MACRO applymovement
	db applymovement_command
	db \1 ; person
	dw \2 ; data
ENDM

	const applymovementlasttalked_command
MACRO applymovementlasttalked
	db applymovementlasttalked_command
	dw \1 ; data
ENDM

	const faceplayer_command
MACRO faceplayer
	db faceplayer_command
ENDM

	const faceobject_command
MACRO faceobject
	db faceobject_command
	db \1 ; person1
	db \2 ; person2
ENDM

	const variablesprite_command
MACRO variablesprite
	db variablesprite_command
	db \1 - SPRITE_VARS ; byte
	db \2 ; sprite
ENDM

	const disappear_command
MACRO disappear
	db disappear_command
	db \1 ; person
ENDM

	const appear_command
MACRO appear
	db appear_command
	db \1 ; person
ENDM

	const follow_command
MACRO follow
	db follow_command
	db \1 ; person2
	db \2 ; person1
ENDM

	const stopfollow_command
MACRO stopfollow
	db stopfollow_command
ENDM

	const moveobject_command
MACRO moveobject
	db moveobject_command
	db \1 ; person
	db \2 ; x
	db \3 ; y
ENDM

	const writeobjectxy_command
MACRO writeobjectxy
	db writeobjectxy_command
	db \1 ; person
ENDM

	const loademote_command
MACRO loademote
	db loademote_command
	db \1 ; bubble
ENDM

	const showemote_command
MACRO showemote
	db showemote_command
	db \1 ; bubble
	db \2 ; person
	db \3 ; time
ENDM

	const turnobject_command
MACRO turnobject
	db turnobject_command
	db \1 ; person
	db \2 ; facing
ENDM

	const follownotexact_command
MACRO follownotexact
	db follownotexact_command
	db \1 ; person2
	db \2 ; person1
ENDM

	const earthquake_command
MACRO earthquake
	db earthquake_command
	db \1 ; param
ENDM

	const changemapblocks_command
MACRO changemapblocks
	db changemapblocks_command
	dba \1 ; map_data
ENDM

	const changeblock_command
MACRO changeblock
	db changeblock_command
	db \1 ; x
	db \2 ; y
	db \3 ; block
ENDM

	const reloadmap_command
MACRO reloadmap
	db reloadmap_command
ENDM

	const refreshmap_command
MACRO refreshmap
	db refreshmap_command
ENDM

	const usestonetable_command
MACRO usestonetable
	db usestonetable_command
	dw \1 ; stonetable_pointer
ENDM

	const playmusic_command
MACRO playmusic
	db playmusic_command
	db \1 ; music_id
ENDM

	const encountermusic_command
MACRO encountermusic
	db encountermusic_command
ENDM

	const musicfadeout_command
MACRO musicfadeout
	db musicfadeout_command
	db \1 ; music
	db \2 ; fadetime
ENDM

	const playmapmusic_command
MACRO playmapmusic
	db playmapmusic_command
ENDM

	const dontrestartmapmusic_command
MACRO dontrestartmapmusic
	db dontrestartmapmusic_command
ENDM

	const cry_command
MACRO cry
	db cry_command
	if \1 == 0
		db \1 ; party mon
	elif _NARG == 2
		dp \1, \2 ; form
	else
		dp \1, PLAIN_FORM
	endc
ENDM

	const playsound_command
MACRO playsound
	db playsound_command
	db \1 ; sound_id
ENDM

	const waitsfx_command
MACRO waitsfx
	db waitsfx_command
ENDM

	const warpsound_command
MACRO warpsound
	db warpsound_command
ENDM

	const specialsound_command
MACRO specialsound
	db specialsound_command
ENDM

	const autoinput_command
MACRO autoinput
	db autoinput_command
	db \1 ; data_pointer
ENDM

	const newloadmap_command
MACRO newloadmap
	db newloadmap_command
	db \1 ; which_method
ENDM

	const pause_command
MACRO pause
	db pause_command
	db \1 ; length
ENDM

	const deactivatefacing_command
MACRO deactivatefacing
	db deactivatefacing_command
	db \1 ; time
ENDM

	const sdefer_command
MACRO sdefer
	db sdefer_command
	dw \1 ; pointer
ENDM

	const warpcheck_command
MACRO warpcheck
	db warpcheck_command
ENDM

	const stopandsjump_command
MACRO stopandsjump
	db stopandsjump_command
	dw \1 ; pointer
ENDM

	const endcallback_command
MACRO endcallback
	db endcallback_command
ENDM

	const end_command
MACRO end
	db end_command
ENDM

	const reloadend_command
MACRO reloadend
	db reloadend_command
	db \1 ; which_method
ENDM

	const endall_command
MACRO endall
	db endall_command
ENDM

	const pokemart_command
MACRO pokemart
	db pokemart_command
	db \1 ; dialog_id
	db \2 ; mart_id
ENDM

	const elevator_command
MACRO elevator
	db elevator_command
	dw \1 ; floor_list_pointer
ENDM

	const trade_command
MACRO trade
	db trade_command
	db \1 ; trade_id
ENDM

	const askforphonenumber_command
MACRO askforphonenumber
	db askforphonenumber_command
	db \1 ; number
ENDM

	const hangup_command
MACRO hangup
	db hangup_command
ENDM

	const describedecoration_command
MACRO describedecoration
	db describedecoration_command
	db \1 ; byte
ENDM

	const fruittree_command
MACRO fruittree
	db fruittree_command
	db \1 ; tree_id
	db \2 ; fruit_id
ENDM

	const specialphonecall_command
MACRO specialphonecall
	db specialphonecall_command
	db \1 ; call_id
ENDM

	const checkphonecall_command
MACRO checkphonecall
	db checkphonecall_command
ENDM

	const verbosegiveitem_command
MACRO verbosegiveitem
	db verbosegiveitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const verbosegiveitemvar_command
MACRO verbosegiveitemvar
	db verbosegiveitemvar_command
	db \1 ; item
	db \2 ; var
ENDM

	const swarm_command
MACRO swarm
	db swarm_command
	db \1 ; flag
	map_id \2 ; map
ENDM

	const halloffame_command
MACRO halloffame
	db halloffame_command
ENDM

	const credits_command
MACRO credits
	db credits_command
ENDM

	const warpfacing_command
MACRO warpfacing
	db warpfacing_command
	db \1 ; facing
	map_id \2 ; map
	db \3 ; x
	db \4 ; y
ENDM

	const battletowertext_command
MACRO battletowertext
	db battletowertext_command
	db \1 ; memory
ENDM

	const getlandmarkname_command
MACRO getlandmarkname
	db getlandmarkname_command
	db \1 ; id
	db \2 ; memory
ENDM

	const gettrainerclassname_command
MACRO gettrainerclassname
	db gettrainerclassname_command
	db \1 ; id
	db \2 ; memory
ENDM

	const wait_command
MACRO wait
	db wait_command
	db \1 ; duration
ENDM

	const checksave_command
MACRO checksave
	db checksave_command
ENDM

	const trainerpic_command
MACRO trainerpic
	db trainerpic_command
	db \1 ; trainer
ENDM

	const givetmhm_command
MACRO givetmhm
	db givetmhm_command
	db \1 ; tmhm
ENDM

	const checktmhm_command
MACRO checktmhm
	db checktmhm_command
	db \1 ; tmhm
ENDM

	const verbosegivetmhm_command
MACRO verbosegivetmhm
	db verbosegivetmhm_command
	db \1 ; tmhm
ENDM

	const tmhmnotify_command
MACRO tmhmnotify
	db tmhmnotify_command
ENDM

	const gettmhmname_command
MACRO gettmhmname
	db gettmhmname_command
	db \1 ; tmhm
	db \2 ; memory
ENDM

	const checkdarkness_command
MACRO checkdarkness
	db checkdarkness_command
ENDM

	const checkunits_command
MACRO checkunits
	db checkunits_command
ENDM

	const unowntypeface_command
MACRO unowntypeface
	db unowntypeface_command
ENDM

	const restoretypeface_command
MACRO restoretypeface
	db restoretypeface_command
ENDM

	const jumpstashedtext_command
MACRO jumpstashedtext
	db jumpstashedtext_command
ENDM

	const jumpopenedtext_command
MACRO jumpopenedtext
	db jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumptext_command
MACRO iftrue_jumptext
	db iftrue_jumptext_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumptext_command
MACRO iffalse_jumptext
	db iffalse_jumptext_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumptextfaceplayer_command
MACRO iftrue_jumptextfaceplayer
	db iftrue_jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumptextfaceplayer_command
MACRO iffalse_jumptextfaceplayer
	db iffalse_jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumpopenedtext_command
MACRO iftrue_jumpopenedtext
	db iftrue_jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumpopenedtext_command
MACRO iffalse_jumpopenedtext
	db iffalse_jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const writethistext_command
MACRO writethistext
	db writethistext_command
ENDM

	const jumpthistext_command
MACRO jumpthistext
	db jumpthistext_command
ENDM

	const jumpthistextfaceplayer_command
MACRO jumpthistextfaceplayer
	db jumpthistextfaceplayer_command
ENDM

	const jumpthisopenedtext_command
MACRO jumpthisopenedtext
	db jumpthisopenedtext_command
ENDM

	const showtext_command
MACRO showtext
	db showtext_command
	dw \1 ; text_pointer
ENDM

	const showtextfaceplayer_command
MACRO showtextfaceplayer
	db showtextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const applyonemovement_command
MACRO applyonemovement
	db applyonemovement_command
	db \1 ; person
	db movement_\2 ; movement data
	db movement_step_end
ENDM

	const showcrytext_command
MACRO showcrytext
	db showcrytext_command
	dw \1 ; text_pointer
	dp \2 ; cry_id
ENDM

	const endtext_command
MACRO endtext
	db endtext_command
ENDM

	const waitendtext_command
MACRO waitendtext
	db waitendtext_command
ENDM

	const iftrue_endtext_command
MACRO iftrue_endtext
	db iftrue_endtext_command
ENDM

	const iffalse_endtext_command
MACRO iffalse_endtext
	db iffalse_endtext_command
ENDM

	const loadgrottomon_command
MACRO loadgrottomon
	db loadgrottomon_command
ENDM

	const giveapricorn_command
MACRO giveapricorn
	db giveapricorn_command
	db \1 ; apricorn
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const paintingpic_command
MACRO paintingpic
	db paintingpic_command
	db \1 ; painting
ENDM

	const checkegg_command
MACRO checkegg
	db checkegg_command
ENDM

MACRO callthisasm
	callasm .thisasm\@
	end
.thisasm\@
ENDM

	const givekeyitem_command
MACRO givekeyitem
	db givekeyitem_command
	db \1 ; key item
ENDM

	const checkkeyitem_command
MACRO checkkeyitem
	db checkkeyitem_command
	db \1 ; key item
ENDM

	const takekeyitem_command
MACRO takekeyitem
	db takekeyitem_command
	db \1 ; key item
ENDM

	const verbosegivekeyitem_command
MACRO verbosegivekeyitem
	db verbosegivekeyitem_command
	db \1 ; key item
ENDM

	const keyitemnotify_command
MACRO keyitemnotify
	db keyitemnotify_command
ENDM

	const givebp_command
MACRO givebp
	db givebp_command
	dw \1 ; bp
ENDM

	const takebp_command
MACRO takebp
	db takebp_command
	dw \1 ; bp
ENDM

	const checkbp_command
MACRO checkbp
	db checkbp_command
	dw \1 ; bp
ENDM

	const sjumpfwd_command
MACRO sjumpfwd
	assert \1 > @, "sjumpfwd cannot jump backward"
	db sjumpfwd_command
	dr \1 - 1 ; distance
ENDM

	const ifequalfwd_command
MACRO ifequalfwd
	assert \2 > @, "ifequalfwd cannot jump backward"
	db ifequalfwd_command
	db \1 ; byte
	dr \2 - 1 ; distance
ENDM

	const iffalsefwd_command
MACRO iffalsefwd
	assert \1 > @, "iffalsefwd cannot jump backward"
	db iffalsefwd_command
	dr \1 - 1 ; distance
ENDM

	const iftruefwd_command
MACRO iftruefwd
	assert \1 > @, "iftruefwd cannot jump backward"
	db iftruefwd_command
	dr \1 - 1 ; distance
ENDM

	const scalltable_command
MACRO scalltable
	db scalltable_command
	dw \1 ; pointer table
ENDM

	const setmapobjectmovedata_command
MACRO setmapobjectmovedata
	db setmapobjectmovedata_command
	db \1 ; person
	db \2 ; SpriteMovementData index
ENDM

	const setmapobjectpal_command
MACRO setmapobjectpal
	db setmapobjectpal_command
	db \1 ; person
	db \2 ; palette
ENDM

	const givespecialitem_command
MACRO givespecialitem
	db givespecialitem_command
	db \1 ; key item
ENDM

	const givebadge_command
MACRO givebadge
	db givebadge_command
	dn \2, \1 ; region, badge
ENDM

	const setquantity_command
MACRO setquantity
	db setquantity_command
ENDM

	const pluralize_command
MACRO pluralize
	db pluralize_command
	dw \1 ; pointer
ENDM

	const loadtrainerwithpal_command
MACRO loadtrainerwithpal
	db loadtrainerwithpal_command
	db \1 ; trainer_group
	db \2 ; trainer_id
	db \3 ; palette
ENDM

DEF NUM_EVENT_COMMANDS EQU const_value
