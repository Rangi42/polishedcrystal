command: MACRO
	enum \1_command
\1 equs "db \1_command"
	dw BattleCommand_\1
ENDM

commandx: MACRO
	enum \1_command
\1_macro: MACRO
	db \1
	db \2
ENDM
\1 equs "\1_macro \1_command,"
	dw BattleCommand_\1
ENDM

commandonly: MACRO
	enum \1_command
\1 equs "db \1_command"
ENDM

	enum_start 1

BattleCommandPointers:
	command checkturn
	command checkobedience
	command usedmovetext
	command doturn
	command critical
	command damagestats
	command stab
	command damagevariation
	command checkhit
	command lowersub
	command moveanimnosub
	command raisesub
	command failuretext
	command applydamage
	command criticaltext
	command supereffectivetext
	command postfainteffects
	command posthiteffects
	command poisontarget
	command sleeptarget
	command draintarget
	command eatdream
	command burntarget
	command freezetarget
	command paralyzetarget
	command selfdestruct
	command payday
	command conversion
	command resetstats
	command forceswitch
	command endloop
	command flinchtarget
	command recoil
	command focusenergy
	command confuse
	command confusetarget
	command heal
	command transform
	command screen
	command poison
	command paralyze
	command substitute
	command rechargenextturn
	command metronome
	command leechseed
	command splash
	command disable
	command cleartext
	command charge
	command traptarget
	command growth
	command rampage
	command constantdamage
	command counter
	command encore
	command painsplit
	command sketch
	command sleeptalk
	command destinybond
	command falseswipe
	command healbell
	command hastarget
	command triplekick
	command kickcounter
	command thief
	command arenatrap
	command defrost
	command curse
	command protect
	command spikes
	command foresight
	command perishsong
	command startsandstorm
	command starthail
	command endure
	command rolloutpower
	command conditionalboost
	command attract
	command happinesspower
	command damagecalc
	command safeguard
	command checksafeguard
	command getmagnitude
	command batonpass
	command pursuit
	command clearhazards
	command healweather
	command hiddenpower
	command startrain
	command startsun
	command effectchance
	command switchturn
	command bellydrum
	command rage
	command doubleflyingdamage
	command doubleundergrounddamage
	command checkfuturesight
	command futuresight
	command doubleminimizedamage
	command thunderaccuracy
	command teleport
	command switchout
	command resettypematchup
	command raisesubnoanim
	command lowersubnoanim
	command clearmissdamage
	command movedelay
	command moveanim
	command tristatuschance
	command startloop
	command curl
	command minimize
	command burn
	command bounceback
	command suckerpunch
	command toxicspikes
	command roost
	command skillswap
	command trick
	command knockoff
	command bugbite
	command toxic
	command gyroball
	command checkpowder
	command lowkick
	command brickbreak
	command trickroom

	; The following commands have an argument: stat to raise/lower.
	; (raise|lower)stat: can miss, silent
	; force(raise|lower)stat: (always)
	; (raise|lower)stathit: can miss, respects secondary, silent
	; (raise|lower)oppstat: can miss, respects sub+mist+clear body
	; force(raise|lower)oppstat: respects sub+mist+clear body
	; (raise|lower)oppstathit: can miss, respects secondary+sub+mist+clear body, silent

	commandx raisestat
	commandx lowerstat
	commandx forceraisestat
	commandx forcelowerstat
	commandx raisestathit
	commandx lowerstathit
	commandx raiseoppstat
	commandx loweroppstat
	commandx forceraiseoppstat
	commandx forceloweroppstat
	commandx raiseoppstathit
	commandx loweroppstathit

FIRST_MOVEARG_COMMAND EQU raisestat_command
LAST_MOVEARG_COMMAND EQU loweroppstathit_command

	enum_start -1, -1
	commandonly endmove
	commandonly endturn
