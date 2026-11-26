# Map dialog compression

Map scripts use the usual text macros. For each segment, the assembler first
compares raw text with the singular Huffman encoding (`<CTXT>`), which codes
one character at a time. If that saves a byte, it also tries the map pair encoding
(`<MAP_PAIR_TEXT_MARKER>`). The pair encoding must beat the singular encoding
after counting the marker and rounding the payload up to whole bytes. Ties keep
the first choice. Outside map scripts, the assembler chooses between raw text
and the singular encoding.

A segment ends at `@`, `<DONE>`, or `<PROMPT>`. Before an inline text command,
the macros supply an implicit `@` for the compressed reader. A raw segment
falls through to that command without storing the extra terminator.

The raw/compressed choice also affects callers. When a compressed segment
ends in `<DONE>` or `<PROMPT>`, the decoder sets `hStopPrintingString`. A
nested `text_far` can then stop the caller's text command loop. Switching
between singular and pair codes preserves this behavior because both use the
same terminator handling.

## How the pair format works

Each Huffman tree assigns codes to both individual characters and common pairs
such as `'e', ' '`. The preceding **expanded character** selects the tree for
the next token. The initial character is a space. The most frequent preceding
characters have their own trees. Other characters share trees for boundaries
(spaces and line controls), vowels, and everything else.

The encoder works backwards through the segment. At each position it compares
the cost of one literal plus the best encoding of the remaining text with the
cost of a matching pair plus the best encoding starting two bytes ahead. Either
choice leaves the same context at the next shared position. This lets the
encoder find the minimum bit count even where pairs overlap. Equal costs favor
the pair.

After the marker, the reader consumes bits most significant first. Each tree
groups its canonical Huffman codes by length. The count for each length tells
the reader how many codes to skip before trying one more bit. Once it has a
match, a displacement points to the end of that length's symbol group.

| Token | Meaning |
| --- | --- |
| `$00–$7e` | Index into the dictionary of two-character pairs |
| `$7f–$eb` | Literal charmap byte |
| `$ec–$fb` | Shifted charmap byte in `$4d–$5c`, including n-grams, controls and terminators |
| `$ff` | Escape followed by an eight-bit token |

A pair contains only letters and spaces. The reader returns the first character
and saves the second for the next call. A pending character needs no input bits
or dictionary lookup. The dictionary, context lookup, trees and token reader
share a ROM bank. The fixed-bank refill routine fetches one source byte when
needed, so a stream can end at the last byte of its bank. The decoder restores
the source bank before returning a character to the printer.

## Updating the model

The escape can represent any valid token, so editing map text does not require
regenerating the tables. To retrain after a change to the corpus, run these
commands from the project root after a default build:

```sh
rgbasm -E -Q8 -P includes.asm -DPAIR_TEXT_CORPUS -o /tmp/map-text.o data/maps/map_data.asm > /tmp/map-text.corpus
python3 utils/pair_text.py /tmp/map-text.corpus data/text/map_pair_models.inc
```

The corpus records the bytes after charmap expansion, including any implicit
terminator. The trainer selects frequent pairs, then alternates between choosing
tokens for those strings and fitting codes to the resulting counts. It keeps
the model with the smallest combined table and padded payload size. To check
the result, run `utils/check-map-text.sh`. It compares the linked streams with
the expanded source bytes and checks the encoder's choice for each segment.
