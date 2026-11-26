# Text compression

The text macros choose between raw charmap bytes and a Huffman stream marked
with `<CTXT>`. Each compressible segment ends at `@`, `<DONE>`, or `<PROMPT>`.
Before an inline command the macros supply an implicit `@` for the decoder.
Raw text falls through to the command without storing the extra terminator.
The assembler uses the compressed form only when it saves at least one byte,
including the marker and the final padding.

With either encoding, `text_far` resumes at the next command when its callee
finishes. `text_farend` ends the current script after the callee finishes.
A nonblocking preview stops its enclosing callers at a page or scroll break.

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

The escape can represent any valid token, so ordinary text edits use the
checked-in model. To retrain on all text in the default build, run:

```sh
make huffman > /tmp/text.corpus
python3 utils/huffman.py /tmp/text.corpus data/text/huffman_model.inc
```

The corpus records the bytes after charmap expansion, including any implicit
terminator. The trainer selects frequent pairs, then alternates between choosing
tokens for those strings and fitting codes to the resulting counts. It keeps
the model with the smallest combined table and padded payload size. To check
the result, run `utils/check-text.sh`. It compares the linked streams with
the expanded source bytes and checks the encoder's choice for each segment.
