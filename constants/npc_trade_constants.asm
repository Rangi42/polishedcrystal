; npctrade struct members (see data/events/npc_trades.asm)
rsreset
DEF NPCTRADE_DIALOG      rb
DEF NPCTRADE_GIVEMON     rw
DEF NPCTRADE_GETMON      rw
DEF NPCTRADE_NICKNAME    rb MON_NAME_LENGTH
DEF NPCTRADE_DVS         rb 3
DEF NPCTRADE_PERSONALITY rb
DEF NPCTRADE_BALL        rb
DEF NPCTRADE_ITEM        rb
DEF NPCTRADE_OT_ID       rw
DEF NPCTRADE_OT_NAME     rb PLAYER_NAME_LENGTH
                         rb_skip
DEF NPCTRADE_STRUCT_LENGTH EQU _RS

; NPCTrades indexes (see data/events/npc_trades.asm)
	const_def
	const NPC_TRADE_MIKE    ; 0
	const NPC_TRADE_KYLE    ; 1
	const NPC_TRADE_TIM     ; 2
	const NPC_TRADE_EMY     ; 3
	const NPC_TRADE_CHRIS   ; 4
	const NPC_TRADE_KIM     ; 5
	const NPC_TRADE_JACQUES ; 6
	const NPC_TRADE_HARI    ; 7
	const NPC_TRADE_JEEVES  ; 8
DEF NUM_NPC_TRADES EQU const_value

; trade gender limits
	const_def
	const TRADE_GENDER_EITHER
	const TRADE_GENDER_MALE
	const TRADE_GENDER_FEMALE

; TradeTexts indexes (see engine/events/npc_trade.asm)

; trade dialogs
	const_def
	const TRADE_DIALOG_INTRO
	const TRADE_DIALOG_CANCEL
	const TRADE_DIALOG_WRONG
	const TRADE_DIALOG_COMPLETE
	const TRADE_DIALOG_AFTER

; trade dialog sets
	const_def
	const TRADE_DIALOGSET_COLLECTOR
	const TRADE_DIALOGSET_HAPPY
	const TRADE_DIALOGSET_NEWBIE
	const TRADE_DIALOGSET_GIRL
