# Map dialogue compression

Dialogue assembled by `data/maps/scripts.asm` can use a second compressed format.
The existing text macros determine where a stream starts and ends, including an
implicit `@` before an inline text command. Raw segments keep their existing
fallthrough behavior. For a segment that would use `<CTXT>`, the assembler tries
the pair encoder and selects it only if the marker and padded payload together
occupy fewer bytes. Text authors use the usual macros.

## Reading a stream

The marker is `$4c`. Bits follow most significant first. The first context is a
space. Each subsequent context comes from the last **expanded** byte. There are
dedicated contexts for the 32 most frequent previous bytes plus boundary, vowel,
and other fallback contexts. A model stores canonical Huffman codes grouped by
length. Each length has a count and a one-byte displacement to the end of that
group's symbols. The reader can advance one group per bit.

| Token | Meaning |
| --- | --- |
| `$00–$7e` | Index of a two-byte literal pair |
| `$7f–$eb` | The charmap byte itself |
| `$ec–$fb` | Charmap bytes `$4d–$5c`, including n-grams, controls, and terminators |
| `$ff` | Escape followed by an eight-bit token |

Pairs contain only spaces and ASCII letters from the charmap. Each rule expands
to exactly two literal bytes. The assembler works backwards through each segment,
comparing the bit cost of a literal and the remaining suffix with the cost of a
matching pair and its suffix. Both choices use the preceding source byte as
context. This finds a minimum-bit encoding even when pair matches overlap.
Equal bit costs favor the pair.
Printing a pair buffers its second byte for the next character call. The model,
dictionary and token reader share one ROMX section. The fixed-bank refill reads
one source byte on demand and restores the model bank. The reader restores the
source bank before handing a character to the printer. With the checked-in model
the longest direct code is 13 bits and the longest escape including its payload is 18 bits.
That bounds a token at three refills and eight bank switches. Returning a pending
byte needs neither.

## Checking or retraining

Run `make check-map-text` for a host check or `make check-map-text-vibe` to also
execute the Game Boy reader using the Rust core in `../vibeEmu`. Both targets
build a temporary copy with symbols bracketing every eligible segment and check
that the ROM is byte-identical to the normal build. The host checks every source
byte, terminal, padding bit, record end and fallback choice. It also checks the
minimum bit cost using the tables in the linked ROM. The emulator checks
terminated strings, output guards, source-bank restoration and the resume
address. It also prints a record ending at `$7fff` through `FarString` and
compares the tilemap glyphs.

The checked-in model supports edited dialogue through its escape. To retrain it,
run these commands in the project root after a regular build. The corpus contains
RGBDS-expanded bytes and the implicit-terminator flag for each segment. The
trainer refits the context tables to the token choices from the preceding round.
It keeps the round with the smallest combined padded payload and table size,
up to ten rounds.

```sh
rgbasm -E -Q8 -P includes.asm -DPAIR_TEXT_CORPUS -o /tmp/map-text.o data/maps/map_data.asm > /tmp/map-text.corpus
python3 utils/pair_text.py /tmp/map-text.corpus data/text/map_pair_models.inc
make check-map-text-vibe
```

## Measurements

On the default ROM at `fc83c01e94` with RGBDS 1.0.4, the 6,153 eligible segments
occupied 240,545 bytes. The optimized build uses 199,640 bytes across 5,836 pair
streams, 229 legacy streams and 88 raw fragments. Both ROMs are 2 MiB.

| Linked change | Bytes |
| --- | ---: |
| Map dialogue payload saved | 40,905 |
| Pair dictionary | 254 |
| Context lookup and tree directory | 326 |
| Canonical model headers and symbols | 2,698 |
| New reader and integration, net code growth | 149 |
| Six map script branches shortened after compression | 6 saved |
| **Net ROM space recovered** | **37,484** |

The code growth includes the 89-byte banked token reader and the trampoline for
weekday text, whose existing printer and strings moved to ROMX. ROM0 gained ten
free bytes. The decoder uses two additional HRAM bytes and zero additional WRAM
bytes. The default link has 62,077 free bytes, up from 51,404 with the first
pair encoder and 24,593 with the original reader. On the audit revision
`f9a3e47a`, the same change raised free space from 24,311 to 61,795 bytes.
With the first pair tables,
optimal parsing alone saved 4,308 payload bytes. In a timed assembly of
`data/maps/map_data.asm` with those tables, it added about 10 seconds (51 to 61).

In vibeEmu (`b7938e4`), the original reader averaged 730.3 CPU T-cycles on the
404,722 expanded bytes now served by the pair reader. The pair reader averaged
753.6. The maximum on those bytes went from 2,288 to 2,260. The largest increase
for an individual byte at the same position was 1,564 T-cycles. Across all
408,872 compressed bytes, including the legacy fallback, the mean went from
730.8 to 754.2 and the maximum from 2,288 to 2,316. Timings include the call and
return and exclude printer delays. A separate sweep of 86,840 cases covered every
pair context, legal token, direct and escaped encoding, and initial bit alignment
at the end of a ROM bank. Its maximum was also 2,260 T-cycles.

Nine rendering traces covered player and rival names, RAM substitutions, repeated
line and paragraph breaks, consecutive pages, prompts, far text and inline
assembly. Glyphs, tile coordinates, final tilemaps, command order and resume
positions matched the original game. The largest difference in scene duration
was 0.012 frames.

## General Huffman tables

Regenerating the original three context tables from the complete default corpus
(567,883 tokens) saved zero linked bytes. Training them on non-map text saved
836 bytes. Training them on the streams still using legacy compression saved
1,057 bytes. Both targeted models changed which short strings the assembler
stored raw, including Palmer's “Bravo!” battle message.

A vibeEmu test called that message with `text_far` and followed it with
`text_today`. The existing tables printed the weekday and resumed after the
caller’s terminator. Both targeted models returned at the end of `text_far`
and skipped the weekday. The same difference occurred with the enemy-fled
battle message. The build therefore keeps the original three tables.
