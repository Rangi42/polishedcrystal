; ScriptCommandTable indexes (see engine/overworld/scripting.asm)
	const_def

	const scall_command
scall: MACRO
	db scall_command
	dw \1 ; pointer
ENDM

	const farscall_command
farscall: MACRO
	db farscall_command
	dba \1
ENDM

	const memcall_command
memcall: MACRO
	db memcall_command
	dw \1 ; pointer
ENDM

	const sjump_command
sjump: MACRO
	db sjump_command
	dw \1 ; pointer
ENDM

	const farsjump_command
farsjump: MACRO
	db farsjump_command
	dba \1
ENDM

	const memjump_command
memjump: MACRO
	db memjump_command
	dw \1 ; pointer
ENDM

	const ifequal_command
ifequal: MACRO
	db ifequal_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const ifnotequal_command
ifnotequal: MACRO
	db ifnotequal_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const iffalse_command
iffalse: MACRO
	db iffalse_command
	dw \1 ; pointer
ENDM

	const iftrue_command
iftrue: MACRO
	db iftrue_command
	dw \1 ; pointer
ENDM

	const ifgreater_command
ifgreater: MACRO
	db ifgreater_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const ifless_command
ifless: MACRO
	db ifless_command
	db \1 ; byte
	dw \2 ; pointer
ENDM

	const jumpstd_command
jumpstd: MACRO
	db jumpstd_command
	db \1 ; predefined_script
ENDM

	const callstd_command
callstd: MACRO
	db callstd_command
	db \1 ; predefined_script
ENDM

	const callasm_command
callasm: MACRO
	db callasm_command
	dba \1
ENDM

	const special_command
special: MACRO
	db special_command
	db (\1Special - SpecialsPointers) / 3
ENDM

	const memcallasm_command
memcallasm: MACRO
	db memcallasm_command
	dw \1 ; asm
ENDM

	const checkmapscene_command
checkmapscene: MACRO
	db checkmapscene_command
	map_id \1 ; map
ENDM

	const setmapscene_command
setmapscene: MACRO
	db setmapscene_command
	map_id \1 ; map
	db \2 ; trigger_id
ENDM

	const checkscene_command
checkscene: MACRO
	db checkscene_command
ENDM

	const setscene_command
setscene: MACRO
	db setscene_command
	db \1 ; trigger_id
ENDM

	const setval_command
setval: MACRO
	db setval_command
	db \1 ; value
ENDM

	const addval_command
addval: MACRO
	db addval_command
	db \1 ; value
ENDM

	const random_command
random: MACRO
	db random_command
	db \1 ; input
ENDM

	const readmem_command
readmem: MACRO
	db readmem_command
	dw \1 ; address
ENDM

	const writemem_command
writemem: MACRO
	db writemem_command
	dw \1 ; address
ENDM

	const loadmem_command
loadmem: MACRO
	db loadmem_command
	dw \1 ; address
	db \2 ; value
ENDM

	const readvar_command
readvar: MACRO
	db readvar_command
	db \1 ; variable_id
ENDM

	const writevar_command
writevar: MACRO
	db writevar_command
	db \1 ; variable_id
ENDM

	const loadvar_command
loadvar: MACRO
	db loadvar_command
	db \1 ; variable_id
	db \2 ; value
ENDM

	const giveitem_command
giveitem: MACRO
	db giveitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const takeitem_command
takeitem: MACRO
	db takeitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const checkitem_command
checkitem: MACRO
	db checkitem_command
	db \1 ; item
ENDM

	const givemoney_command
givemoney: MACRO
	db givemoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const takemoney_command
takemoney: MACRO
	db takemoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const checkmoney_command
checkmoney: MACRO
	db checkmoney_command
	db \1 ; account
	dt \2 ; money
ENDM

	const givecoins_command
givecoins: MACRO
	db givecoins_command
	dw \1 ; coins
ENDM

	const takecoins_command
takecoins: MACRO
	db takecoins_command
	dw \1 ; coins
ENDM

	const checkcoins_command
checkcoins: MACRO
	db checkcoins_command
	dw \1 ; coins
ENDM

	const addcellnum_command
addcellnum: MACRO
	db addcellnum_command
	db \1 ; person
ENDM

	const delcellnum_command
delcellnum: MACRO
	db delcellnum_command
	db \1 ; person
ENDM

	const checkcellnum_command
checkcellnum: MACRO
	db checkcellnum_command
	db \1 ; person
ENDM

	const checktime_command
checktime: MACRO
	db checktime_command
	db \1 ; time
ENDM

	const checkpoke_command
checkpoke: MACRO
	db checkpoke_command
	db \1 ; pkmn
ENDM

	const givepoke_command
givepoke: MACRO
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
		db \7 ; trainer
		if \7
			dw \8 ; trainer_name_pointer
			dw \9 ; pkmn_nickname
			dw \<10> ; trainer_ot_pointer
		endc
	else
		db FALSE ; no trainer
	endc
ENDM

	const giveegg_command
giveegg: MACRO
	db giveegg_command
	if _NARG >= 2
		dp \1, \2 | IS_EGG_MASK
	else
		dp \1, PLAIN_FORM | IS_EGG_MASK
	endc
ENDM

	const givepokemail_command
givepokemail: MACRO
	db givepokemail_command
	dw \1 ; pointer
ENDM

	const checkpokemail_command
checkpokemail: MACRO
	db checkpokemail_command
	dw \1 ; pointer
ENDM

	const checkevent_command
checkevent: MACRO
	db checkevent_command
	dw \1 ; event_flag
ENDM

	const clearevent_command
clearevent: MACRO
	db clearevent_command
	dw \1 ; event_flag
ENDM

	const setevent_command
setevent: MACRO
	db setevent_command
	dw \1 ; event_flag
ENDM

	const checkflag_command
checkflag: MACRO
	db checkflag_command
	dw \1 ; engine_flag
ENDM

	const clearflag_command
clearflag: MACRO
	db clearflag_command
	dw \1 ; engine_flag
ENDM

	const setflag_command
setflag: MACRO
	db setflag_command
	dw \1 ; engine_flag
ENDM

	const wildon_command
wildon: MACRO
	db wildon_command
ENDM

	const wildoff_command
wildoff: MACRO
	db wildoff_command
ENDM

	const warpmod_command
warpmod: MACRO
	db warpmod_command
	db \1 ; warp_id
	map_id \2 ; map
ENDM

	const blackoutmod_command
blackoutmod: MACRO
	db blackoutmod_command
	map_id \1 ; map
ENDM

	const warp_command
warp: MACRO
	db warp_command
	map_id \1 ; map
	db \2 ; x
	db \3 ; y
ENDM

	const getmoney_command
getmoney: MACRO
	db getmoney_command
	db \1 ; account
	db \2 ; memory
ENDM

	const getcoins_command
getcoins: MACRO
	db getcoins_command
	db \1 ; memory
ENDM

	const getnum_command
getnum: MACRO
	db getnum_command
	db \1 ; memory
ENDM

	const getmonname_command
getmonname: MACRO
	db getmonname_command
	db \1 ; pokemon
	db \2 ; memory
ENDM

	const getitemname_command
getitemname: MACRO
	db getitemname_command
	db \1 ; item
	db \2 ; memory
ENDM

	const getcurlandmarkname_command
getcurlandmarkname: MACRO
	db getcurlandmarkname_command
	db \1 ; memory
ENDM

	const gettrainername_command
gettrainername: MACRO
	db gettrainername_command
	db \1 ; trainer_id
	db \2 ; trainer_group
	db \3 ; memory
ENDM

	const getstring_command
getstring: MACRO
	db getstring_command
	dw \1 ; text_pointer
	db \2 ; memory
ENDM

	const itemnotify_command
itemnotify: MACRO
	db itemnotify_command
ENDM

	const pocketisfull_command
pocketisfull: MACRO
	db pocketisfull_command
ENDM

	const opentext_command
opentext: MACRO
	db opentext_command
ENDM

	const refreshscreen_command
refreshscreen: MACRO
	db refreshscreen_command
ENDM

	const closetext_command
closetext: MACRO
	db closetext_command
ENDM

	const farwritetext_command
farwritetext: MACRO
	db farwritetext_command
	dba \1
ENDM

	const writetext_command
writetext: MACRO
	db writetext_command
	dw \1 ; text_pointer
ENDM

	const repeattext_command
repeattext: MACRO
	db repeattext_command
	db \1 ; byte
	db \2 ; byte
ENDM

	const yesorno_command
yesorno: MACRO
	db yesorno_command
ENDM

	const loadmenu_command
loadmenu: MACRO
	db loadmenu_command
	dw \1 ; data
ENDM

	const closewindow_command
closewindow: MACRO
	db closewindow_command
ENDM

	const jumptextfaceplayer_command
jumptextfaceplayer: MACRO
	db jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const farjumptext_command
farjumptext: MACRO
	db farjumptext_command
	dba \1
ENDM

	const jumptext_command
jumptext: MACRO
	db jumptext_command
	dw \1 ; text_pointer
ENDM

	const waitbutton_command
waitbutton: MACRO
	db waitbutton_command
ENDM

	const promptbutton_command
promptbutton: MACRO
	db promptbutton_command
ENDM

	const pokepic_command
pokepic: MACRO
	db pokepic_command
	db \1 ; pokemon
	if \1 == 0
		db -1 ; party mon
	elif _NARG == 2
		db \2 ; form
	else
		db 0
	endc
ENDM

	const closepokepic_command
closepokepic: MACRO
	db closepokepic_command
ENDM

	const _2dmenu_command
_2dmenu: MACRO
	db _2dmenu_command
ENDM

	const verticalmenu_command
verticalmenu: MACRO
	db verticalmenu_command
ENDM

	const randomwildmon_command
randomwildmon: MACRO
	db randomwildmon_command
ENDM

	const loadtemptrainer_command
loadtemptrainer: MACRO
	db loadtemptrainer_command
ENDM

	const loadwildmon_command
loadwildmon: MACRO
	db loadwildmon_command
	db \1 ; pokemon
	if _NARG == 3
		db \2 ; form
		db \3 ; level
	else
		db 0  ; form
		db \2 ; level
	endc
ENDM

	const loadtrainer_command
loadtrainer: MACRO
	db loadtrainer_command
	db \1 ; trainer_group
	db \2 ; trainer_id
ENDM

	const startbattle_command
startbattle: MACRO
	db startbattle_command
ENDM

	const reloadmapafterbattle_command
reloadmapafterbattle: MACRO
	db reloadmapafterbattle_command
ENDM

	const catchtutorial_command
catchtutorial: MACRO
	db catchtutorial_command
	db \1 ; byte
ENDM

	const trainertext_command
trainertext: MACRO
	db trainertext_command
	db \1 ; which_text
ENDM

	const trainerflagaction_command
trainerflagaction: MACRO
	db trainerflagaction_command
	db \1 ; action
ENDM

	const winlosstext_command
winlosstext: MACRO
	db winlosstext_command
	dw \1 ; win_text_pointer
	dw \2 ; loss_text_pointer
ENDM

	const scripttalkafter_command
scripttalkafter: MACRO
	db scripttalkafter_command
ENDM

	const endifjustbattled_command
endifjustbattled: MACRO
	db endifjustbattled_command
ENDM

	const checkjustbattled_command
checkjustbattled: MACRO
	db checkjustbattled_command
ENDM

	const setlasttalked_command
setlasttalked: MACRO
	db setlasttalked_command
	db \1 ; person
ENDM

	const applymovement_command
applymovement: MACRO
	db applymovement_command
	db \1 ; person
	dw \2 ; data
ENDM

	const applymovementlasttalked_command
applymovementlasttalked: MACRO
	db applymovementlasttalked_command
	dw \1 ; data
ENDM

	const faceplayer_command
faceplayer: MACRO
	db faceplayer_command
ENDM

	const faceobject_command
faceobject: MACRO
	db faceobject_command
	db \1 ; person1
	db \2 ; person2
ENDM

	const variablesprite_command
variablesprite: MACRO
	db variablesprite_command
	db \1 - SPRITE_VARS ; byte
	db \2 ; sprite
ENDM

	const disappear_command
disappear: MACRO
	db disappear_command
	db \1 ; person
ENDM

	const appear_command
appear: MACRO
	db appear_command
	db \1 ; person
ENDM

	const follow_command
follow: MACRO
	db follow_command
	db \1 ; person2
	db \2 ; person1
ENDM

	const stopfollow_command
stopfollow: MACRO
	db stopfollow_command
ENDM

	const moveobject_command
moveobject: MACRO
	db moveobject_command
	db \1 ; person
	db \2 ; x
	db \3 ; y
ENDM

	const writeobjectxy_command
writeobjectxy: MACRO
	db writeobjectxy_command
	db \1 ; person
ENDM

	const loademote_command
loademote: MACRO
	db loademote_command
	db \1 ; bubble
ENDM

	const showemote_command
showemote: MACRO
	db showemote_command
	db \1 ; bubble
	db \2 ; person
	db \3 ; time
ENDM

	const turnobject_command
turnobject: MACRO
	db turnobject_command
	db \1 ; person
	db \2 ; facing
ENDM

	const follownotexact_command
follownotexact: MACRO
	db follownotexact_command
	db \1 ; person2
	db \2 ; person1
ENDM

	const earthquake_command
earthquake: MACRO
	db earthquake_command
	db \1 ; param
ENDM

	const changemapblocks_command
changemapblocks: MACRO
	db changemapblocks_command
	dba \1 ; map_data
ENDM

	const changeblock_command
changeblock: MACRO
	db changeblock_command
	db \1 ; x
	db \2 ; y
	db \3 ; block
ENDM

	const reloadmap_command
reloadmap: MACRO
	db reloadmap_command
ENDM

	const reloadmappart_command
reloadmappart: MACRO
	db reloadmappart_command
ENDM

	const usestonetable_command
usestonetable: MACRO
	db usestonetable_command
	dw \1 ; stonetable_pointer
ENDM

	const playmusic_command
playmusic: MACRO
	db playmusic_command
	db \1 ; music_id
ENDM

	const encountermusic_command
encountermusic: MACRO
	db encountermusic_command
ENDM

	const musicfadeout_command
musicfadeout: MACRO
	db musicfadeout_command
	db \1 ; music
	db \2 ; fadetime
ENDM

	const playmapmusic_command
playmapmusic: MACRO
	db playmapmusic_command
ENDM

	const dontrestartmapmusic_command
dontrestartmapmusic: MACRO
	db dontrestartmapmusic_command
ENDM

	const cry_command
cry: MACRO
	db cry_command
	db \1 ; cry_id
ENDM

	const playsound_command
playsound: MACRO
	db playsound_command
	db \1 ; sound_id
ENDM

	const waitsfx_command
waitsfx: MACRO
	db waitsfx_command
ENDM

	const warpsound_command
warpsound: MACRO
	db warpsound_command
ENDM

	const specialsound_command
specialsound: MACRO
	db specialsound_command
ENDM

	const autoinput_command
autoinput: MACRO
	db autoinput_command
	db \1 ; data_pointer
ENDM

	const newloadmap_command
newloadmap: MACRO
	db newloadmap_command
	db \1 ; which_method
ENDM

	const pause_command
pause: MACRO
	db pause_command
	db \1 ; length
ENDM

	const deactivatefacing_command
deactivatefacing: MACRO
	db deactivatefacing_command
	db \1 ; time
ENDM

	const sdefer_command
sdefer: MACRO
	db sdefer_command
	dw \1 ; pointer
ENDM

	const warpcheck_command
warpcheck: MACRO
	db warpcheck_command
ENDM

	const stopandsjump_command
stopandsjump: MACRO
	db stopandsjump_command
	dw \1 ; pointer
ENDM

	const endcallback_command
endcallback: MACRO
	db endcallback_command
ENDM

	const end_command
end: MACRO
	db end_command
ENDM

	const reloadend_command
reloadend: MACRO
	db reloadend_command
	db \1 ; which_method
ENDM

	const endall_command
endall: MACRO
	db endall_command
ENDM

	const pokemart_command
pokemart: MACRO
	db pokemart_command
	db \1 ; dialog_id
	db \2 ; mart_id
ENDM

	const elevator_command
elevator: MACRO
	db elevator_command
	dw \1 ; floor_list_pointer
ENDM

	const trade_command
trade: MACRO
	db trade_command
	db \1 ; trade_id
ENDM

	const askforphonenumber_command
askforphonenumber: MACRO
	db askforphonenumber_command
	db \1 ; number
ENDM

	const hangup_command
hangup: MACRO
	db hangup_command
ENDM

	const describedecoration_command
describedecoration: MACRO
	db describedecoration_command
	db \1 ; byte
ENDM

	const fruittree_command
fruittree: MACRO
	db fruittree_command
	db \1 ; tree_id
	db \2 ; fruit_id
ENDM

	const specialphonecall_command
specialphonecall: MACRO
	db specialphonecall_command
	db \1 ; call_id
ENDM

	const checkphonecall_command
checkphonecall: MACRO
	db checkphonecall_command
ENDM

	const verbosegiveitem_command
verbosegiveitem: MACRO
	db verbosegiveitem_command
	db \1 ; item
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const verbosegiveitemvar_command
verbosegiveitemvar: MACRO
	db verbosegiveitemvar_command
	db \1 ; item
	db \2 ; var
ENDM

	const swarm_command
swarm: MACRO
	db swarm_command
	db \1 ; flag
	map_id \2 ; map
ENDM

	const halloffame_command
halloffame: MACRO
	db halloffame_command
ENDM

	const credits_command
credits: MACRO
	db credits_command
ENDM

	const warpfacing_command
warpfacing: MACRO
	db warpfacing_command
	db \1 ; facing
	map_id \2 ; map
	db \3 ; x
	db \4 ; y
ENDM

	const battletowertext_command
battletowertext: MACRO
	db battletowertext_command
	db \1 ; memory
ENDM

	const getlandmarkname_command
getlandmarkname: MACRO
	db getlandmarkname_command
	db \1 ; id
	db \2 ; memory
ENDM

	const gettrainerclassname_command
gettrainerclassname: MACRO
	db gettrainerclassname_command
	db \1 ; id
	db \2 ; memory
ENDM

	const getname_command
getname: MACRO
	db getname_command
	db \1 ; type
	db \2 ; id
	db \3 ; memory
ENDM

	const wait_command
wait: MACRO
	db wait_command
	db \1 ; duration
ENDM

	const checksave_command
checksave: MACRO
	db checksave_command
ENDM

	const countseencaught_command
countseencaught: MACRO
	db countseencaught_command
ENDM

	const trainerpic_command
trainerpic: MACRO
	db trainerpic_command
	db \1 ; trainer
ENDM

	const givetmhm_command
givetmhm: MACRO
	db givetmhm_command
	db \1 ; tmhm
ENDM

	const checktmhm_command
checktmhm: MACRO
	db checktmhm_command
	db \1 ; tmhm
ENDM

	const verbosegivetmhm_command
verbosegivetmhm: MACRO
	db verbosegivetmhm_command
	db \1 ; tmhm
ENDM

	const tmhmnotify_command
tmhmnotify: MACRO
	db tmhmnotify_command
ENDM

	const gettmhmname_command
gettmhmname: MACRO
	db gettmhmname_command
	db \1 ; tmhm
	db \2 ; memory
ENDM

	const checkdarkness_command
checkdarkness: MACRO
	db checkdarkness_command
ENDM

	const checkunits_command
checkunits: MACRO
	db checkunits_command
ENDM

	const unowntypeface_command
unowntypeface: MACRO
	db unowntypeface_command
ENDM

	const restoretypeface_command
restoretypeface: MACRO
	db restoretypeface_command
ENDM

	const jumpstashedtext_command
jumpstashedtext: MACRO
	db jumpstashedtext_command
ENDM

	const jumpopenedtext_command
jumpopenedtext: MACRO
	db jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumptext_command
iftrue_jumptext: MACRO
	db iftrue_jumptext_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumptext_command
iffalse_jumptext: MACRO
	db iffalse_jumptext_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumptextfaceplayer_command
iftrue_jumptextfaceplayer: MACRO
	db iftrue_jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumptextfaceplayer_command
iffalse_jumptextfaceplayer: MACRO
	db iffalse_jumptextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const iftrue_jumpopenedtext_command
iftrue_jumpopenedtext: MACRO
	db iftrue_jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const iffalse_jumpopenedtext_command
iffalse_jumpopenedtext: MACRO
	db iffalse_jumpopenedtext_command
	dw \1 ; text_pointer
ENDM

	const writethistext_command
writethistext: MACRO
	db writethistext_command
ENDM

	const jumpthistext_command
jumpthistext: MACRO
	db jumpthistext_command
ENDM

	const jumpthistextfaceplayer_command
jumpthistextfaceplayer: MACRO
	db jumpthistextfaceplayer_command
ENDM

	const jumpthisopenedtext_command
jumpthisopenedtext: MACRO
	db jumpthisopenedtext_command
ENDM

	const showtext_command
showtext: MACRO
	db showtext_command
	dw \1 ; text_pointer
ENDM

	const showtextfaceplayer_command
showtextfaceplayer: MACRO
	db showtextfaceplayer_command
	dw \1 ; text_pointer
ENDM

	const applyonemovement_command
applyonemovement: MACRO
	db applyonemovement_command
	db \1 ; person
	db movement_\2 ; movement data
	db movement_step_end
ENDM

	const showcrytext_command
showcrytext: MACRO
	db showcrytext_command
	dw \1 ; text_pointer
	db \2 ; cry_id
ENDM

	const endtext_command
endtext: MACRO
	db endtext_command
ENDM

	const waitendtext_command
waitendtext: MACRO
	db waitendtext_command
ENDM

	const iftrue_endtext_command
iftrue_endtext: MACRO
	db iftrue_endtext_command
ENDM

	const iffalse_endtext_command
iffalse_endtext: MACRO
	db iffalse_endtext_command
ENDM

	const loadgrottomon_command
loadgrottomon: MACRO
	db loadgrottomon_command
ENDM

	const giveapricorn_command
giveapricorn: MACRO
	db giveapricorn_command
	db \1 ; apricorn
	if _NARG == 2
		db \2 ; quantity
	else
		db 1
	endc
ENDM

	const paintingpic_command
paintingpic: MACRO
	db paintingpic_command
	db \1 ; painting
ENDM

	const checkegg_command
checkegg: MACRO
	db checkegg_command
ENDM

callthisasm: MACRO
	; "callasm .asm\@" causes a "File stack dump too long, got truncated"
	; error due to the long filename:linenumber trace of nested macros.
	db callasm_command
	dba .asm\@
	end
.asm\@
ENDM

	const givekeyitem_command
givekeyitem: MACRO
	db givekeyitem_command
	db \1 ; key item
ENDM

	const checkkeyitem_command
checkkeyitem: MACRO
	db checkkeyitem_command
	db \1 ; key item
ENDM

	const takekeyitem_command
takekeyitem: MACRO
	db takekeyitem_command
	db \1 ; key item
ENDM

	const verbosegivekeyitem_command
verbosegivekeyitem: MACRO
	db verbosegivekeyitem_command
	db \1 ; key item
ENDM

	const keyitemnotify_command
keyitemnotify: MACRO
	db keyitemnotify_command
ENDM

	const givebp_command
givebp: MACRO
	db givebp_command
	dw \1 ; bp
ENDM

	const takebp_command
takebp: MACRO
	db takebp_command
	dw \1 ; bp
ENDM

	const checkbp_command
checkbp: MACRO
	db checkbp_command
	dw \1 ; bp
ENDM

NUM_EVENT_COMMANDS EQU const_value
