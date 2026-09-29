; I have put a boatload of comments in this file so that its logic and rationale can be followed by
; others; I am not expecting all of them to stay within the final.
;
; (I am also not expecting all of my style to make it either.
;  I just hope that it can show a different way of doing things,
;  because I promise that I am not needlessly making things complicated.
;  Though part of that is that I'd rather have my assumptions checked at build time,
;  rather than needing to do very thorough play-testing and being paranoid
;  about whether I've missed some fringe edge case...)
;
; Still, enjoy the read! ^w^ ~ISSOtm


; FIXME: feels like those should be defined and used more globally... `map_object_constants.asm`?
;        They still make some magic numbers below disappear, so I've kept them.
def TILES_PER_CEL equ 4
def CELS_PER_OBJECT equ 3 ; Down, Up, Left/Right (shared, mirrored).


SECTION "Cable car asset blob", ROMX

CableCarAssets:
INCBIN "gfx/overworld/cable_car.bin.lzp"
; Some of `cable_car.2bpp.lzp`'s dependency `.2bpp` files get `READFILE()`'d below,
; as part of length checks; they are ordered after this to be robust to dependency ordering / scanning.


def BLANKED_PLAYER_ROWS equ 4


SECTION "Cable Car", ROMX

Special_CableCar::
	; At this point, music is faded out and the screen is faded.
	ld e, MUSIC_MAGNET_TRAIN
	call PlayMusic
	; Disable map anim processing, to save on a lot of VBlank time.
	; This command is always followed by some `warp*` script command,
	; which sets up a new map, and *that* runs `ActivateMapAnims`.
	xor a
	ldh [hMapAnims], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, 7
	ldh [hWX], a
	ld a, 12 * 8
	ldh [hWY], a
	ld a, LCDC_ON | LCDC_WIN_9800 | LCDC_WIN_ON | LCDC_BG_9C00 | LCDC_OBJ_16 | LCDC_OBJ_ON | LCDC_PRIO_ON
	ldh [rLCDC], a

; Set up OAM.
	; For now, only set up the tile and attributes; all positions will be written later.
	ld hl, wShadowOAM
	; TODO
	ld a, 1
	ldh [hOAMUpdate], a

; Write the maps for the window.
	ld hl, wTilemap
	; First row...
	ld c, SCREEN_WIDTH / 2
	ld a, TILE_BG_MED_TO_CLOSE + 1
.writeMedToClose
	dec a
	ld [hli], a
	inc a
	ld [hli], a
	dec c
	jr nz, .writeMedToClose
	; Then the whole trees.
	ld b, 3 ; Do so thrice.
	inc a ; (equiv. to `ld a, CLOSE_TREES`)
.writeTreeBodies
	ld c, SCREEN_WIDTH / 2
.writeTreeRow
	ld [hli], a
	xor 1 ; Toggle between left and right half.
	ld [hli], a
	xor 1
	dec c
	jr nz, .writeTreeRow
	xor TILE_BG_CLOSE_TREES_MID ^ TILE_BG_CLOSE_TREES_BOTTOM ; This should be 2 or 6.
	; Loop if we aren't about to write a "middle" row.
	bit 1, a ; Probe a bit we just toggled...
	assert TILE_BG_CLOSE_TREES_BOTTOM & (1 << 1) == 0, "Invert this condition and next line's `jr`."
	jr z, .writeTreeBodies
	; Otherwise, write a new pair if more trees are expected.
	xor 1 ; ...but flip the two halves!
	dec b
	jr nz, .writeTreeBodies
; The attrmap now...
	ld hl, wAttrmap
	ld a, BGPAL_TREES
	ld bc, SCREEN_WIDTH * 6
	rst ByteFill
; Commit both.
	call ApplyAttrAndTilemapInVBlank

; Load the player's palette.
	ld a, BANK(wPlayerGender)
	ldh [rWBK], a
	ld a, [wPlayerGender]
	assert PLAYER_MALE + 1 == PAL_NPC_RED
	assert PLAYER_FEMALE + 1 == PAL_NPC_BLUE
	assert PLAYER_ENBY + 1 == PAL_NPC_GREEN
	assert PLAYER_BETA + 1 == PAL_NPC_PURPLE
	inc a
	farcall LookupOBPalette
	ld de, wOBPals1 palette OBPAL_PLAYER
	ld bc, 1 palettes
	rst FarCall
	dwb FarCopyColorWRAM, BANK(LookupOBPalette) ; Copy from that function's bank, since that's where the palettes are.

; Load the player sprites.
	farcall GetPlayerIcon ; This reads `wPlayerGender`, and expects its bank to be loaded.
	; Shuffle each cel from row-first to column-first, for 8x16 OAM friendliness. (Grr.)
	; This "only" requires swapping tiles 1 and 2 of each cel, though!
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld hl, wDecompressScratch tile 1
	ld c, PLAYER_NB_TILES / TILES_PER_CEL ; How many cels to process?
.shufflePlayerCel
	ld hl, 1 tiles
	add hl, de
.swapByte
	ld b, [hl] ; Read from tile 2...
	ld a, [de] ; Read from tile 1...
	ld [hli], a ; ...overwrite tile 2.
	ld a, b
	ld [de], a ; ...overwrite tile 1.
	inc e ; This won't overflow, since `wDecompressScratch` is ALIGN[8].
	bit 5, e ; Check if `de` is now pointing into tile 2. (Again, alignment.)
	jr z, .swapByte
	; Advance to next cel, tile 1.
	ld de, 2 tiles
	add hl, de
	ld e, l
	ld d, h
	dec c
	jr nz, .shufflePlayerCel
	; Done! Just need to commit this to VRAM :)
	ld de, wDecompressScratch
	ld hl, vTiles0 tile PLAYER_BASE_TILE
	ld c, PLAYER_NB_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.

; Load the cutscene's own assets.
	ld b, BANK(CableCarAssets)
	ld hl, CableCarAssets
	ld de, vTiles0 tile BASE_TILE
	ld c, NB_TILES
	assert NB_TILES + 2 * SCREEN_HEIGHT * 2 <= 256, "Too much stuff for the decompression buffer!"
	call DecompressRequest2bpp

; Load the cutscene's palettes.
	ld hl, .palettes ; TODO: load a time-of-day palette...
	ld de, wBGPals1 palette PAL_BASE_IDX
	ld bc, NB_PALETTES palettes
	call FarCopyColorWRAM

; Write the main maps.
	; Since they are wider than the WRAM tilemaps, VRAM must be accessed directly;
	; there is enough room in the decompression buffer to hold them, too!
def MAP_SIZE_IN_TILES equ SCREEN_HEIGHT * TILEMAP_WIDTH / TILE_SIZE
	ld de, wDecompressScratch tile NB_TILES ; The tilemap and attrmap are right after the tile data.
	ld hl, vBGMap1
	ld c, MAP_SIZE_IN_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.
	ld a, 1
	ldh [rVBK], a
	ld de, wDecompressScratch tile (NB_TILES + MAP_SIZE_IN_TILES)
	ld hl, vBGMap3
	ld c, MAP_SIZE_IN_TILES
	call Request2bpp.Function ; Screen is on and the right banks are loaded: take a shortcut.
	xor a
	ldh [rVBK], a

; Fade in.
	ld c, 10 ; (frames)
	call FadePalettes

; Perform direction-dependent setup.
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

	; TODO: add random chance for Pokémon to fly in the sky?

	; The rest of the engine relies on global state.
	ld a, BANK(wScriptFlags)
	ldh [rWBK], a
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	xor a
	ldh [hOAMUpdate], a
	ret


.FillRowWithNextA:
	ld bc, SCREEN_WIDTH
.FillWithNextA:
	inc a
	rst ByteFill
	ret


def PAL_BASE_IDX equ 5
.palettes: const_def PAL_BASE_IDX

const BGPAL_TREELINE
	RGB  9, 23, 29 ; Sky. Must be first for priority effects.
	RGB 12, 25,  1
	RGB  5, 14,  0
	RGB  7,  7,  7

const BGPAL_TREES
	RGB 22, 31, 10
	RGB 12, 25,  1
	RGB  5, 14,  0
	RGB  7,  7,  7

const BGPAL_ROCK
	RGB 27, 31, 27
	RGB 24, 18,  7
	RGB 20, 15,  3
	RGB  7,  7,  7

assert const_value == 8, "Not at OBJ pal boundary! (pal #{d:const_value})"
const_def 0

const OBPAL_ROCK
	RGB 27, 31, 27 ; Ignored.
	RGB 24, 18,  7
	RGB 20, 15,  3
	RGB  7,  7,  7

const OBPAL_HANDLE ; Also used for the cable.
	RGB 27, 31, 27 ; Ignored.
	RGB 21, 21, 21
	RGB 13, 13, 13
	RGB  0,  0,  0

const OBPAL_CAR
	RGB 27, 31, 27 ; Ignored.
	RGB 29, 26, 10
	RGB 17, 15, 10
	RGB  7,  7,  7

const OBPAL_WHITE
	RGB 27, 31, 27 ; Ignored.
	RGB 31, 31, 31 ; Backdrop for the car. (TODO: consider some darker, desaturated colour?)
	RGB  4,2,0 ; Unused.
	RGB  0,6,9 ; :)

def NB_PALETTES equ const_value + (8 - PAL_BASE_IDX)

const OBPAL_PLAYER
	; Filled in dynamically depending on selected gender.
	; (Thus, must be last.)


; We now define constants for tile indices.
; Some `assert`s act as sanity checks that the tile layout *should* be what we expect;
; this has already caught a mistake in the `.2bpp` file during development
; (one tile was unique and it shouldn't have been), so this seems worth the trouble.
; (And, even after I'm done, keep in mind that other people may want to tweak all this later!)
rsset $00
def PLAYER_BASE_TILE rb TILES_PER_CEL * CELS_PER_OBJECT * 2 ; One set for standing, another for walkies!
def PLAYER_NB_TILES  equ _RS - PLAYER_BASE_TILE

def BASE_TILE        equ $80 ; For `DecompressRequest2bpp`.
static_assert _RS <= BASE_TILE, "Player tiles overflowing into cable car area! ({_RS})"
rsset BASE_TILE

; Tiles from `cable_car/car.2bpp`:
def CAR_BASE_TILE          rb 3 * 4 ; Each column is 4 tiles, and the rightmost 2 columns are mirrors of the left.
def CAR_TILE_DATA equs READFILE("gfx/overworld/cable_car/car.2bpp")
assert BYTELEN(#CAR_TILE_DATA) / TILE_SIZE == _RS - CAR_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CAR_TILE_DATA) / TILE_SIZE, _RS - CAR_BASE_TILE)

; Tiles from `cable_car/handle_side.2bpp`:
def HANDLE_SIDE_BASE_TILE  rb 2
def HANDLE_SIDE_TILE_DATA equs READFILE("gfx/overworld/cable_car/handle_side.2bpp")
assert BYTELEN(#HANDLE_SIDE_TILE_DATA) / TILE_SIZE == _RS - HANDLE_SIDE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#HANDLE_SIDE_TILE_DATA) / TILE_SIZE, _RS - HANDLE_SIDE_BASE_TILE)

; Tiles from `cable_car/handle.2bpp`:
def HANDLE_BASE_TILE       rb 2
def HANDLE_TILE_DATA equs READFILE("gfx/overworld/cable_car/handle.2bpp")
assert BYTELEN(#HANDLE_TILE_DATA) / TILE_SIZE == _RS - HANDLE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#HANDLE_TILE_DATA) / TILE_SIZE, _RS - HANDLE_BASE_TILE)

; Tiles from `cable_car/cable.2bpp`:
def CABLE_BASE_TILE        equ _RS
	def TILE_BG_CABLE              rb 2 * 2
	def TILE_BG_WHITE_OBJ          rb 2
def CABLE_TILE_DATA equs READFILE("gfx/overworld/cable_car/cable.2bpp")
assert BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE == _RS - CABLE_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#CABLE_TILE_DATA) / TILE_SIZE, _RS - CABLE_BASE_TILE)

; Tiles from `cable_car/rocks.png`:
def ROCKS_BASE_TILE        equ _RS
	def TILE_BG_ROCK_SLOPE_FULL    rb 1
	def TILE_BG_ROCK               rb 1
	def TILE_BG_ROCK_SLOPE_PARTIAL rb 1
	def TILE_BG_ROCK_DUPLICATE     rb 1 ; Needed so that these tiles are 8x16-compatible.
def ROCKS_TILE_DATA equs READFILE("gfx/overworld/cable_car/rocks.2bpp")
assert BYTELEN(#ROCKS_TILE_DATA) / TILE_SIZE == _RS - ROCKS_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#ROCKS_TILE_DATA) / TILE_SIZE, _RS - ROCKS_BASE_TILE)

; Tiles from `cable_car/trees.png`:
def TREES_BASE_TILE        equ _RS
	def TILE_BG_SKY                rb 1
	def TILE_BG_TREELINE           rb 1 ; Has a bit of the sky peeking through.
	def TILE_BG_FAR_TREES          rb 1 ; Mostly the same.
	def TILE_BG_FAR_TO_MED         rb 1 ; Transition. 🏳️‍⚧️
	def TILE_BG_MED_TREES          rb 2 ; Each tile is offset horizontally by 4 pixels.
	def TILE_BG_MED_TO_CLOSE       rb 2 ; Transition. 🏳️‍⚧️ Did you know that there are two ways to make people laugh? The first is running gags, and the second is running gags.
	def TILE_BG_CLOSE_TREES_MID    rb 2
	def TILE_BG_CLOSE_TREES_BOTTOM rb 2 ; Doubles as the top of the next row of trees.
def TREES_TILE_DATA equs READFILE("gfx/overworld/cable_car/trees.2bpp")
assert BYTELEN(#TREES_TILE_DATA) / TILE_SIZE == _RS - TREES_BASE_TILE, \
	STRFMT("%u != %u", BYTELEN(#TREES_TILE_DATA) / TILE_SIZE, _RS - TREES_BASE_TILE)

def NB_TILES         equ _RS - BASE_TILE
