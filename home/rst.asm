; rst vectors

SECTION "rst00 EntryPoint", ROM0
	di
	jp Start

DisappearUser::
	farjp _DisappearUser

SECTION "rst08 FarCall", ROM0
	jp RstFarCall

IsAPokemon::
; For functions using EGG as sentinel, use "and a" instead (EGG is $ff)
; Returns carry if species a is not a Pokemon (including $ff)
	inc a
	cp $2 ; sets carry for $0 (inc'ed to $1) and $ff (inc'ed to $0)
	dec a
	ret

SECTION "rst10 Bankswitch", ROM0
	ld [hROMBank], a
	ld [MBC3RomBank], a
	ret

	ds 2 ; free space

SECTION "rst18 AddNTimes", ROM0
	jp _AddNTimes

_de_::
	push de
DoNothing::
	ret

FarCopyWRAM::
	call StackCallInWRAMBankA

SECTION "rst20 CopyBytes", ROM0
	jp _CopyBytes

BattleRandom::
; Handles all RNG calls in the battle engine, allowing
; link battles to remain in sync using a shared PRNG.
	farjp _BattleRandom

_hl_::
	jp hl

SECTION "rst28 JumpTable", ROM0
	jp _Jumptable

DoItemEffect::
	farjp _DoItemEffect

	ds 1 ; free space

SECTION "rst30 Predef", ROM0
	jp _Predef

PushWindow::
	farjp _PushWindow

	ds 1 ; free space

SECTION "rst38 InfiniteLoop", ROM0
	rst InfiniteLoop

ExitMenu::
	push af
	farcall _ExitMenu
	pop af
	ret
