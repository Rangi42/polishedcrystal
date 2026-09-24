; Each ROM bank self-reports its own bank ID at a fixed address.
; This avoids the need to keep separately track of which ROM bank is being switched to;
; additionally, it avoids the (admittedly small) race condition where the shadow is written to,
; an int handler fires and restores the wrong bank, causing some emulators to raise a false-positive warning.

FOR bank_id, 1, 128
	SECTION "ROM bank {d:bank_id}'s ID", ROMX[CurROMBank],BANK[bank_id]
		db bank_id
ENDR