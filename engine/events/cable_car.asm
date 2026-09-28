Special_CableCar:
	ldh a, [hScriptVar]
	and a
	jr nz, .UpLeftToMountMoonSquare

; DownRightToRoute4
	; TODO

.UpLeftToMountMoonSquare:
	; TODO

.continue
	; TODO (see engine/events/magnet_train.asm or
	; https://github.com/Rangi42/polishedcrystal/pull/1628/files for basis)
	ret
