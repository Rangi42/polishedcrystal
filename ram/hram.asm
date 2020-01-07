HRAM_START         EQU $ff80
hPushOAM           EQU $ff80 ; 10 bytes

hROMBankBackup     EQU $ff8a
hBuffer            EQU $ff8b
hLYOverrideStackCopyAmount EQU $ff8c

hRTCDayHi          EQU $ff8d
hRTCDayLo          EQU $ff8e
hRTCHours          EQU $ff8f
hRTCMinutes        EQU $ff90
hRTCSeconds        EQU $ff91

hHours             EQU $ff94
hMinutes           EQU $ff96
hSeconds           EQU $ff98

hVBlankCounter     EQU $ff9b

hROMBank           EQU $ff9d
hVBlank            EQU $ff9e
hMapEntryMethod    EQU $ff9f
hMenuReturn        EQU $ffa0

hJoypadReleased    EQU $ffa2
hJoypadPressed     EQU $ffa3
hJoypadDown        EQU $ffa4
hJoypadSum         EQU $ffa5
hJoyReleased       EQU $ffa6
hJoyPressed        EQU $ffa7
hJoyDown           EQU $ffa8
hJoyLast           EQU $ffa9
hInMenu            EQU $ffaa

hGraphicStartTile        EQU $ffad
hMoveMon                 EQU $ffae
hMapObjectIndexBuffer    EQU $ffaf
hObjectStructIndexBuffer EQU $ffb0

hConnectionStripLength EQU $ffaf
hConnectedMapWidth EQU $ffb0

hMapBorderBlock     EQU $ffad
hMapWidthPlus6      EQU $ffae

hPredefTemp        EQU $ffb1

; can only use the bytes reserved for hPredefTemp in contained functions, unless you know what you're doing

hLZAddress         EQU $ffb1

; Arithmetic addresses aren't seperate, to simplify
; chain usage. The exact format is (all big endian):
;  hDividend   hProduct
;  hDividend+1 hProduct+1 hQuotient   hMultiplicand
;  hDividend+2 hProduct+2 hQuotient+1 hMultiplicand+1
;  hDividend+3 hProduct+3 hQuotient+2 hMultiplicand+2
;  hDivisor hMultiplier hRemainder
hDividend          EQU $ffb3 ; length in b register, before 'call Divide' (max 4 bytes)
hDivisor           EQU $ffb7 ; 1 byte long
hQuotient          EQU $ffb4 ; result (3 bytes long)
hRemainder         EQU $ffb7

hMultiplicand      EQU $ffb4 ; 3 bytes long
hMultiplier        EQU $ffb7 ; 1 byte long
hProduct           EQU $ffb3 ; result (4 bytes long)
hPrintNum          EQU $ffb3 ; used by PrintNum (4 bytes)

hMathBuffer        EQU $ffb8

hTilesetPalettesHigh   EQU $ffb3

hMetatileCountWidth    EQU $ffb3
hMetatileCountHeight   EQU $ffb4


hUsedSpriteIndex   EQU $ffbd
hUsedSpriteTile    EQU $ffbe

hCurSpriteXCoord   EQU $ffbd
hCurSpriteYCoord   EQU $ffbe

hCurSpriteXPixel   EQU $ffbf
hCurSpriteYPixel   EQU $ffc0
hCurSpriteTile     EQU $ffc1
hCurSpriteOAMFlags EQU $ffc2

hMoneyTemp         EQU $ffc3

hLCDCPointer       EQU $ffc6
hLYOverrideStart   EQU $ffc7
hLYOverrideEnd     EQU $ffc8

hSerialReceivedNewData     EQU $ffca
hSerialConnectionStatus    EQU $ffcb
hSerialIgnoringInitialData EQU $ffcc
hSerialSend                EQU $ffcd
hSerialReceive             EQU $ffce

hSCX               EQU $ffcf
hSCY               EQU $ffd0
hWX                EQU $ffd1
hWY                EQU $ffd2
hTilesPerCycle     EQU $ffd3
; 0 - no update
; 1 - VBGMap0 tiles
; 2 - VBGMap0 attributes
; 3 - VBGMap0 tiles
; 4 - VBGMap0 attributes
hBGMapMode         EQU $ffd4
; 0 - top third
; 1 - middle third
; 2 - bottom third
hBGMapHalf         EQU $ffd5
hBGMapAddress      EQU $ffd6

hOAMUpdate         EQU $ffd8
hSPBuffer          EQU $ffd9

hBGMapUpdate       EQU $ffdb
hBGMapTileCount    EQU $ffdc

hMapAnims          EQU $ffde
hTileAnimFrame     EQU $ffdf

hLastTalked        EQU $ffe0

hRandom            EQU $ffe1
hRandomAdd         EQU $ffe1
hRandomSub         EQU $ffe2
hSecondsBackup     EQU $ffe3
hBattleTurn        EQU $ffe4 ; Which trainers turn is it? 0: Player, 1: Opponent Trainer

hCGBPalUpdate      EQU $ffe5
hCGB               EQU $ffe6

hDMATransfer       EQU $ffe8

hFarCallSavedA     EQU $ffe9

hDelayFrameLY      EQU $ffea

hClockResetTrigger EQU $ffeb

hMPState           EQU $ffed
hMPBuffer          EQU $ffee

hRequested2bpp         EQU $fff1
hRequested1bpp         EQU $fff2
hRequestedVTileDest    EQU $fff3
hRequestedVTileSource  EQU $fff5

hTmpd              EQU $fff7
hTmpe              EQU $fff8

hFastMusicUpdate   EQU $fff9

hRequestOpaque1bpp EQU $fffb

hTilesetGFXBank EQU $fffc

HRAM_END EQU $ffff
