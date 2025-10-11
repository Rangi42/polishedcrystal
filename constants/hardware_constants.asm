INCLUDE "constants/hardware.inc"

; Carts that do not support RTC may write to this byte in SRAM.
; Corrupting the last byte is harmless; the first byte ($A000) is not.
redef rRTCREG equ $BFFF

if DEF(ANALOGUE_POCKET)

; LCDC is relocated and its bits are reversed

redef rLCDC equ $FF4E

redef B_LCDC_ENABLE   equ 0
redef B_LCDC_WIN_MAP  equ 1
redef B_LCDC_WINDOW   equ 2
redef B_LCDC_BLOCKS   equ 3
redef B_LCDC_BG_MAP   equ 4
redef B_LCDC_OBJ_SIZE equ 5
redef B_LCDC_OBJS     equ 6
redef B_LCDC_BG       equ 7
redef B_LCDC_PRIO     equ 7
    redef LCDC_ENABLE   equ 1 << B_LCDC_ENABLE
        redef LCDC_OFF equ 0 << B_LCDC_ENABLE
        redef LCDC_ON  equ 1 << B_LCDC_ENABLE
    redef LCDC_WIN_MAP  equ 1 << B_LCDC_WIN_MAP
        redef LCDC_WIN_9800 equ 0 << B_LCDC_WIN_MAP
        redef LCDC_WIN_9C00 equ 1 << B_LCDC_WIN_MAP
    redef LCDC_WINDOW   equ 1 << B_LCDC_WINDOW
        redef LCDC_WIN_OFF equ 0 << B_LCDC_WINDOW
        redef LCDC_WIN_ON  equ 1 << B_LCDC_WINDOW
    redef LCDC_BLOCKS   equ 1 << B_LCDC_BLOCKS
        redef LCDC_BLOCK21 equ 0 << B_LCDC_BLOCKS
        redef LCDC_BLOCK01 equ 1 << B_LCDC_BLOCKS
    redef LCDC_BG_MAP   equ 1 << B_LCDC_BG_MAP
        redef LCDC_BG_9800 equ 0 << B_LCDC_BG_MAP
        redef LCDC_BG_9C00 equ 1 << B_LCDC_BG_MAP
    redef LCDC_OBJ_SIZE equ 1 << B_LCDC_OBJ_SIZE
        redef LCDC_OBJ_8  equ 0 << B_LCDC_OBJ_SIZE
        redef LCDC_OBJ_16 equ 1 << B_LCDC_OBJ_SIZE
    redef LCDC_OBJS     equ 1 << B_LCDC_OBJS
        redef LCDC_OBJ_OFF equ 0 << B_LCDC_OBJS
        redef LCDC_OBJ_ON  equ 1 << B_LCDC_OBJS
    redef LCDC_BG       equ 1 << B_LCDC_BG
        redef LCDC_BG_OFF equ 0 << B_LCDC_BG
        redef LCDC_BG_ON  equ 1 << B_LCDC_BG
    redef LCDC_PRIO     equ 1 << B_LCDC_PRIO
        redef LCDC_PRIO_OFF equ 0 << B_LCDC_PRIO
        redef LCDC_PRIO_ON  equ 1 << B_LCDC_PRIO

; The bits of STAT are reversed

redef B_STAT_LYC    equ 1
redef B_STAT_MODE_2 equ 2
redef B_STAT_MODE_1 equ 3
redef B_STAT_MODE_0 equ 4
redef B_STAT_LYCF   equ 5
redef B_STAT_BUSY   equ 6
    redef STAT_LYC    equ 1 << B_STAT_LYC
    redef STAT_MODE_2 equ 1 << B_STAT_MODE_2
    redef STAT_MODE_1 equ 1 << B_STAT_MODE_1
    redef STAT_MODE_0 equ 1 << B_STAT_MODE_0
    redef STAT_LYCF   equ 1 << B_STAT_LYCF
    redef STAT_BUSY   equ 1 << B_STAT_BUSY

redef STAT_MODE equ %11_000000
    redef STAT_HBLANK equ %00_000000
    redef STAT_VBLANK equ %10_000000
    redef STAT_OAM    equ %01_000000
    redef STAT_LCD    equ %11_000000

endc
