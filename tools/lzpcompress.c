#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define MAX_FILE_SIZE            32768
#define SHORT_COMMAND_COUNT         32
#define MAX_COMMAND_COUNT          512
#define MAX_EXT_COUNT              256 /* max output count for an extended opcode (8-bit len-1) */
#define LOOKBACK_LIMIT             128 /* highest negative valid count for a copy command */

#define LZ_END                  0xff

// Extended opcode bytes ($fc-$fe)
#define LZ_EXT_MASK             0xfc
#define LZ_EXT_BASE             0xfc
// $fc is reserved for an extended opcode; this project uses it for packhi0.
#define LZ_EXT_PACKHI0          0xfc
// $fd is reserved for an extended opcode; this project uses it for pack16.
#define LZ_EXT_PACK16_SHORT     0xfd
// $fe is reserved for an extended opcode; this project uses it for packlo0.
#define LZ_EXT_PACKLO0          0xfe
#define LZ_EXT_SUBTYPE_MASK     0x03
#define LZ_PACK16_NIBBLE_MASK   0x0f
#define PACK16_TABLE_SIZE         16

#define LZ_DATA          0 /* Read literal data for n bytes.   */
#define LZ_REPEAT        1 /* Write the same byte for n bytes. */
#define LZ_ALTERNATE     2 /* Alternate two bytes for n bytes. */
#define LZ_ZERO          3 /* Write 0 for n bytes.             */
#define LZ_COPY_NORMAL   4 /* Repeat n bytes from the offset.  */
#define LZ_COPY_FLIPPED  5 /* Repeat n bitflipped bytes.       */
#define LZ_COPY_REVERSED 6 /* Repeat n bytes in reverse.       */
#define LZ_LONG          7 /* Expand n to 9 bits (wire format) */

// Internal pseudo-command for extended opcodes ($fc-$fe).
// Uses the same numeric value as LZ_LONG since it falls in that byte range,
// but represents a distinct concept in the tools' internal representation.
#define LZ_EXT           7

#if __STDC_VERSION__ >= 201112L
	// <noreturn.h> forces "noreturn void", which is silly and redundant; this is simpler
	#define noreturn _Noreturn void
#else
	#define noreturn void /* fallback */
#endif

struct command {
  // commands 0-6 are as per the base compression spec.
  // LZ_EXT (7) is used internally as a pseudo-command for extended opcodes ($fc-$fe).
  unsigned command: 3;
  unsigned count:  12; // always equals the uncompressed data length
  signed value:    17; // offset for commands 0 (into source) and 4-6 (into decompressed output); repeated bytes for commands 1-2
};

struct options {
  const char * input;
  const char * output;
  unsigned char mode; // 0: compress, 1: compress to text, 2: uncompress, 3: dump commands as text
  unsigned char alignment; // 1 << value
};

extern const unsigned char bit_flipping_table[];
extern char option_name_buffer[];

extern const unsigned char pack16_table[PACK16_TABLE_SIZE];
signed char pack16_index_of(unsigned char value);

noreturn error_exit(int, const char *, ...);
unsigned char * read_file_into_buffer(const char *, unsigned short *);
unsigned minimum_count(unsigned command);
short command_size(struct command);
unsigned short compressed_length(const struct command *, unsigned short);

// main.c
int main(int, char **);
struct command * compress(const unsigned char *, unsigned short *);

struct options get_options(int, char **);
unsigned parse_numeric_option_argument(char ***, unsigned);
const char * get_argument_for_option(char ***, const char **);
noreturn usage(const char *);

void write_commands_to_textfile(const char *, const struct command *, unsigned, const unsigned char *, unsigned char);
void write_commands_and_padding_to_textfile(const char *, const struct command *, unsigned, const unsigned char *, unsigned, unsigned);
void write_command_to_textfile(FILE *, struct command, const unsigned char *);
void write_commands_to_file(const char *, const struct command *, unsigned, const unsigned char *, unsigned char);
void write_command_to_file(FILE *, struct command, const unsigned char *);
void write_raw_data_to_file(const char *, const void *, unsigned);

struct command * get_commands_from_file(const unsigned char *, unsigned short * restrict, unsigned short * restrict);
unsigned char * get_uncompressed_data(const struct command *, const unsigned char *, unsigned short *);

struct command * compress_dp(const unsigned char * data, const unsigned char *, unsigned short *);

const unsigned char bit_flipping_table[] = {
  // For each byte, the table contains that same byte with its bits flipped around (for instance,
  // 0x58 (01011000 binary) becomes 0x1a (00011010 binary)). This is faster than flipping bits
  // manually at runtime.
  0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0, 0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
  0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8, 0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
  0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4, 0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
  0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec, 0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
  0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2, 0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
  0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea, 0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
  0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6, 0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
  0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee, 0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
  0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1, 0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
  0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9, 0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
  0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5, 0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
  0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed, 0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
  0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3, 0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
  0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb, 0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
  0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7, 0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
  0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef, 0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff
};

char option_name_buffer[] = "-?"; // used to extract the name of a short option (separated from its argument)

noreturn error_exit (int error_code, const char * error, ...) {
  va_list ap;
  va_start(ap, error);
  fputs("error: ", stderr);
  vfprintf(stderr, error, ap);
  va_end(ap);
  fputc('\n', stderr);
  exit(error_code);
}

unsigned char * read_file_into_buffer (const char * file, unsigned short * size) {
  FILE * fp = file ? fopen(file, "rb") : stdin;
  if (!fp) error_exit(1, "could not open file %s for reading", file);
  unsigned char * buf = malloc(MAX_FILE_SIZE + 1);
  int rv = fread(buf, 1, MAX_FILE_SIZE + 1, fp);
  if (file) fclose(fp);
  if (rv < 0) error_exit(1, "could not read from file %s", file);
  if (rv > MAX_FILE_SIZE) error_exit(1, "file %s is too big", file ? file : "<standard input>");
  *size = rv;
  return buf;
}

// 16-entry fixed dictionary used by the "lzpack16" opcode.
// This is intentionally biased toward very common tile/bitmask bytes.
const unsigned char pack16_table[PACK16_TABLE_SIZE] = {
  0x00, 0xff, 0x01, 0x02, 0x03, 0xfe, 0x80, 0x07,
  0xc0, 0x7f, 0x04, 0x0f, 0x1f, 0x3f, 0x08, 0xfc,
};

signed char pack16_index_of(unsigned char value) {
  for (signed char i = 0; i < PACK16_TABLE_SIZE; i++) {
    if (pack16_table[(unsigned char)i] == value) return i;
  }
  return -1;
}

unsigned minimum_count (unsigned command) {
  switch (command) {
    case LZ_ALTERNATE:
        return 3;
    case LZ_REPEAT:
        return 2;
    // LZ_EXT is used internally by tools as a pseudo-command for
    // extended opcodes ($fc-$fe). It always represents an opcode whose count
    // is explicitly stored, so its minimum is 1.
    case LZ_EXT:
        return 1;
    default:
        return 1;
  }
}

short command_size (struct command command) {
  if (command.command == LZ_EXT) {
    // Extended commands encoded using $fc-$fe headers.
    // - value in [-MAX_FILE_SIZE..-1]: lzpackhi0 (2-byte header + ceil(count/2) payload)
    // - value < -MAX_FILE_SIZE: lzpacklo0 (2-byte header + ceil(count/2) payload)
    // - value >= 0: lzpack16 (2-byte header + ceil(count/2) payload)
    return 2 + (command.count + 1) / 2;
  }

  short header_size = 1 + (command.count - minimum_count(command.command) > SHORT_COMMAND_COUNT - 1);
  if (command.command >= LZ_COPY_NORMAL && command.command <= LZ_COPY_REVERSED)
    return header_size + 1 + (command.value >= 0);
  // Payload sizes for non-copy base commands:
  //   LZ_DATA (0): count literal bytes
  //   LZ_REPEAT (1): 1 byte (repeated value)
  //   LZ_ALTERNATE (2): 2 bytes (alternating pair)
  //   LZ_ZERO (3): 0 bytes (no payload)
  return header_size + ((short[]){command.count, 1, 2, 0})[command.command];
}

unsigned short compressed_length (const struct command * commands, unsigned short count) {
  unsigned short current, total = 0;
  for (current = 0; current < count; current ++) total += command_size(commands[current]);
  return total;
}

struct options get_options (int argc, char ** argv) {
  struct options result = {.input = NULL, .output = NULL, .alignment = 0};
  const char * program_name = *argv;
  if (argc == 1) usage(program_name);
  for (argv ++; *argv; argv ++) {
    if (**argv != '-') break;
    if (!1[*argv]) break;
    if (!strcmp(*argv, "--")) {
      argv ++;
      break;
    } else if (!(strcmp(*argv, "--text") && strcmp(*argv, "-t")))
      result.mode = 1;
    else if (!(strcmp(*argv, "--binary") && strcmp(*argv, "-b")))
      result.mode = 0;
    else if (!(strcmp(*argv, "--uncompress") && strcmp(*argv, "-u")))
      result.mode = 2;
    else if (!(strcmp(*argv, "--dump") && strcmp(*argv, "-d")))
      result.mode = 3;
    else if (!(strcmp(*argv, "--align") && strncmp(*argv, "-a", 2)))
      result.alignment = parse_numeric_option_argument(&argv, 12);
    else if (!(strcmp(*argv, "--help") && strcmp(*argv, "-?")))
      usage(program_name);
    else
      error_exit(3, "unknown option: %s", *argv);
  }
  if (*argv) {
    if (strcmp(*argv, "-")) result.input = *argv;
    if (*(++ argv)) {
      if (argv[1]) error_exit(3, "too many command-line arguments");
      if (strcmp(*argv, "-")) result.output = *argv;
    }
  }
  return result;
}

unsigned parse_numeric_option_argument (char *** alp, unsigned limit) {
  const char * option;
  const char * value = get_argument_for_option(alp, &option);
  char * error;
  unsigned long result = strtoul(value, &error, 10);
  if (*error) error_exit(3, "invalid argument to option %s", option);
  if (result > limit) error_exit(3, "argument to option %s must be between 0 and %u", option, limit);
  return result;
}

const char * get_argument_for_option (char *** alp, const char ** option_name) {
  // alp: argument list pointer (i.e., address of the current value of argv after indexing)
  // will point at the last consumed argument on exit (since the caller will probably increment it once more)
  const char * option;
  const char * result;
  if (1[**alp] == '-') {
    option = *((*alp) ++);
    result = **alp;
  } else {
    option_name_buffer[1] = 1[**alp];
    option = option_name_buffer;
    result = **alp + 2;
  }
  if (!(result && *result)) error_exit(3, "option %s requires an argument", option);
  if (option_name) *option_name = option;
  return result;
}

noreturn usage (const char * program_name) {
  fprintf(stderr, "Usage: %s [<options>] [<source file> [<output>]]\n\n", program_name);
  fputs("Execution mode:\n", stderr);
  fputs("    -b, --binary      Output the command stream as binary data (default).\n", stderr);
  fputs("    -t, --text        Output the command stream as text.\n", stderr);
  fputs("    -u, --uncompress  Process a compressed file and output the original data.\n", stderr);
  fputs("    -d, --dump        Process a compressed file and dump the command stream as\n", stderr);
  fputs("                      text (as if compressed with the --text option).\n", stderr);
  fputs("    -?, --help        Print this help text and exit.\n", stderr);
  fputs("Compression options:\n", stderr);
  fputs("    -a<number>, --align <number>   Pad the compressed output with zeros until\n", stderr);
  fputs("                                   the size has the specified number of low bits\n", stderr);
  fputs("                                   cleared (default: 0).\n", stderr);
  fputs("The source and output filenames can be given as - (or omitted) to use standard\n", stderr);
  fputs("input and output. Use -- to indicate that subsequent arguments are file names.\n", stderr);
  exit(3);
}

unsigned min(unsigned a, unsigned b) {
    return a < b ? a : b;
}

// best_size[i] = the best compressed length for the first i bytes of input
// Note that this is nondecreasing, since truncating even in
// the middle of a command won't enlarge it.
static unsigned * best_size;
// best_command[i] = the last command of the command stream that yields best_size[i]
static struct command * best_command;

static const unsigned char *data, *bitflipped;
static unsigned size;

static signed char pack_index[256];
static int pack_index_init;

static void init_pack_index(void) {
    if (pack_index_init) return;
    for (unsigned i = 0; i < 256; i++) pack_index[i] = -1;
    for (unsigned i = 0; i < PACK16_TABLE_SIZE; i++) pack_index[pack16_table[i]] = (signed char)i;
    pack_index_init = 1;
}

void consider(unsigned pos, struct command cmd) {
    unsigned new_size = best_size[pos - cmd.count] + command_size(cmd);
    if (new_size < best_size[pos]) {
        best_size[pos] = new_size;
        best_command[pos] = cmd;
    }
}

unsigned match_right(unsigned pos, unsigned at) {
    // Allow overlap (LZ77-style): the decompressor reads from the output buffer,
    // so copy sources can legitimately run into the region being written.
    // This enables better compression for periodic patterns (period > 2) that
    // aren't handled by LZ_REPEAT/LZ_ALTERNATE.
    unsigned n = 0;
    unsigned distance = pos - at;
    while (pos + n < size) {
        unsigned ref = (n < distance) ? (at + n) : (pos + n - distance);
        if (data[pos + n] != data[ref]) break;
        n++;
    }
    return n;
}

unsigned match_flipped(unsigned pos, unsigned at) {
    unsigned n = 0;
    while (pos+n < size && bitflipped[pos+n] == data[at+n]) n++;
    return n;
}

unsigned match_left(unsigned pos, unsigned at) {
    unsigned n = 0;
    while (pos+n < size && n <= at && data[pos+n] == data[at-n]) n++;
    return n;
}

int encode_delta(int pos, int at) {
    if (at - pos >= -LOOKBACK_LIMIT) {
        return at - pos;
    } else {
        return at;
    }
}

void process_input(void) {
    init_pack_index();
    best_size = malloc(sizeof(unsigned) * (size + 1));
    best_command = malloc(sizeof(struct command) * (size + 1));
    best_size[0] = 0;
    for (unsigned short i = 1; i <= size; i++) best_size[i] = -1u;

    for (unsigned plen = 1; plen <= size; plen++) {
        unsigned char current_byte = data[plen - 1];
        for (unsigned prev = plen > MAX_COMMAND_COUNT ? plen - MAX_COMMAND_COUNT : 0; prev < plen; prev++) {
            consider(plen, (struct command) {
                .command = LZ_DATA,
                .count = plen - prev,
                .value = prev,
            });
        }

        unsigned count = 0;
        do {
            count++;
            if (!current_byte || count >= 2)
                consider(plen, (struct command) {
                .command = current_byte ? LZ_REPEAT : LZ_ZERO,
                .count = count,
                .value = current_byte,
            });
        } while (count < MAX_COMMAND_COUNT && count < plen && data[plen - (count + 1)] == current_byte);

        // lzpackhi0: packed literals where every byte has low nibble 0.
        // Consider runs ending at (plen - 1) where (byte & 0x0f) == 0.
        // Minimum length 4: extended opcode (2-byte header + 2 payload) = 4 bytes,
        // vs LZ_DATA (1-byte header + 4 literal) = 5 bytes. Saves 1 byte.
        unsigned packhi0 = 0;
        while (packhi0 < MAX_EXT_COUNT && packhi0 < plen && (data[plen - (packhi0 + 1)] & 0x0f) == 0) packhi0++;
        if (packhi0 >= 4) {
            unsigned start = plen - packhi0;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1,
                });
            }
        }

        // lzpacklo0: packed literals where every byte has high nibble 0.
        // Consider runs ending at (plen - 1) where (byte & 0xf0) == 0.
        // Minimum length 4: extended opcode (2-byte header + 2 payload) = 4 bytes,
        // vs LZ_DATA (1-byte header + 4 literal) = 5 bytes. Saves 1 byte.
        unsigned packlo0 = 0;
        while (packlo0 < MAX_EXT_COUNT && packlo0 < plen && (data[plen - (packlo0 + 1)] & 0xf0) == 0) packlo0++;
        if (packlo0 >= 4) {
            unsigned start = plen - packlo0;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1 - MAX_FILE_SIZE,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = -(int)prev - 1 - MAX_FILE_SIZE,
                });
            }
        }

        // lzpack16: packed literals using 4-bit indices into pack16_table.
        // Consider runs ending at (plen - 1) where every byte is in the table.
        unsigned pack = 0;
        while (pack < MAX_EXT_COUNT && pack < plen && pack_index[data[plen - (pack + 1)]] >= 0) pack++;
        if (pack >= 4) {
            unsigned start = plen - pack;
            // Consider all lengths >= 4. We do two parity passes so we still step by 2.
            for (unsigned prev = start; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = prev,
                });
            }
            for (unsigned prev = start + 1; prev + 4 <= plen; prev += 2) {
                consider(plen, (struct command) {
                    .command = LZ_EXT,
                    .count = plen - prev,
                    .value = prev,
                });
            }
        }

        if (plen > 1) {
            count = 1;
            do {
                count++;
                if (count >= 3)
                    consider(plen, (struct command) {
                    .command = LZ_ALTERNATE,
                    .count = count,
                    .value = (data[plen - count + 1] << 8) | (data[plen - count]),
                });
            } while (count < MAX_COMMAND_COUNT && count < plen && data[plen - (count + 1)] == data[plen - (count - 1)]);
        }

        for (unsigned at = 0; at < plen - 1; at++) {
            unsigned k = min(MAX_COMMAND_COUNT, match_right(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_NORMAL,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }

            k = min(MAX_COMMAND_COUNT, match_left(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_REVERSED,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }

            k = min(MAX_COMMAND_COUNT, match_flipped(plen - 1, at));
            for (unsigned i = 2; i <= k; i++) {
                consider(plen + i - 1, (struct command) {
                    .command = LZ_COPY_FLIPPED,
                    .count = i,
                    .value = encode_delta(plen - 1, at),
                });
            }
        }
    }
}

struct command * compress_dp(const unsigned char * _data, const unsigned char * _bitflipped, unsigned short * psize) {
    data = _data;
    bitflipped = _bitflipped;
    size = *psize;
    process_input();
    unsigned command_count = 0;
    unsigned pos = size;
    while (pos > 0) {
        pos -= best_command[pos].count;
        command_count++;
    }
    *psize = command_count;

    struct command * buf = malloc(sizeof(struct command) * command_count);
    pos = size;
    while (pos > 0) {
        buf[--command_count] = best_command[pos];
        pos -= best_command[pos].count;
    }

    return buf;
}

struct command * get_commands_from_file (const unsigned char * file_buffer, unsigned short * restrict file_size, unsigned short * restrict slack) {
  struct command * result = malloc(*file_size * sizeof(struct command));
  unsigned short remaining = *file_size;
  struct command * current = result;
  const unsigned char * rp = file_buffer;
  while (1) {
    if (!(remaining --)) goto error;
    unsigned char b0 = *(rp ++);
    if (b0 == LZ_END) break;

    // Extended opcode bytes: $fc-$fe
    if ((b0 & LZ_EXT_MASK) == LZ_EXT_BASE) {
      if (!(remaining --)) goto error;
      unsigned char len_lo = *(rp ++);
      unsigned out_count = (unsigned)len_lo + 1;

      current -> command = LZ_EXT;
      current -> count = out_count;

      unsigned payload = (out_count + 1) / 2;
      if (remaining < payload) goto error;

      if (b0 == LZ_EXT_PACKHI0) {
        // lzpackhi0
        current -> value = -(int)(rp - file_buffer) - 1;
      } else if (b0 == LZ_EXT_PACK16_SHORT) {
        // lzpack16
        current -> value = rp - file_buffer;
      } else if (b0 == LZ_EXT_PACKLO0) {
        // lzpacklo0
        current -> value = -(int)(rp - file_buffer) - 1 - MAX_FILE_SIZE;
      } else {
        goto error;
      }

      rp += payload;
      remaining -= payload;
      current ++;
      continue;
    }

    current -> command = b0 >> 5;
    current -> count = b0 & (SHORT_COMMAND_COUNT - 1);
    if (current -> command == LZ_LONG) {
      current -> command = current -> count >> 2;
      current -> count = (current -> count & 3) << 8;
      if (current -> command == LZ_LONG) {
        // If the count is 0x300 here, the original byte was 0xff (terminator).
        if (current -> count == 0x300) break;
      }
      if (!(remaining --)) goto error;
      current -> count |= *(rp ++);
    }
    current -> count += minimum_count(current -> command);
    switch (current -> command) {
      case LZ_DATA:
        if (remaining <= current -> count) goto error;
        current -> value = rp - file_buffer;
        rp += current -> count;
        remaining -= current -> count;
      case LZ_ZERO:
        break;
      case LZ_REPEAT:
      case LZ_ALTERNATE: {
        unsigned char p;
        if (remaining <= current -> command) goto error;
        current -> value = 0;
        for (p = 0; p < current -> command; p ++) current -> value |= *(rp ++) << (p << 3);
        remaining -= current -> command;
      } break;
      default:
        if (!(remaining --)) goto error;
        if ((current -> value = *(rp ++)) & LOOKBACK_LIMIT)
          current -> value = (LOOKBACK_LIMIT - 1) - current -> value;
        else {
          if (!(remaining --)) goto error;
          current -> value = (current -> value << 8) | *(rp ++);
        }
    }
    current ++;
  }
  if (slack) *slack = *file_size - (rp - file_buffer);
  *file_size = current - result;
  return realloc(result, (*file_size ? *file_size : 1) * sizeof(struct command));
  error:
  free(result);
  return NULL;
}

unsigned char * get_uncompressed_data (const struct command * commands, const unsigned char * compressed, unsigned short * file_size) {
  const struct command * limit = commands + *file_size;
  unsigned char * result = malloc(MAX_FILE_SIZE + MAX_COMMAND_COUNT);
  unsigned char * current = result;
  unsigned short p;
  for (; commands < limit; commands ++) {
    switch (commands -> command) {
      case LZ_DATA:
        memcpy(current, compressed + commands -> value, commands -> count);
        current += commands -> count;
        break;
      case LZ_REPEAT:
      case LZ_ALTERNATE:
        for (p = 0; p < commands -> count; p ++) *(current ++) = commands -> value >> ((p % commands -> command) << 3);
        break;
      case LZ_ZERO:
        memset(current, 0, commands -> count);
        current += commands -> count;
        break;
      case LZ_EXT:
        if (commands -> value < 0) {
          unsigned remaining = commands -> count;
          if (commands -> value < -MAX_FILE_SIZE) {
            // lzpacklo0
            const unsigned char * rp = compressed + (unsigned)(-commands -> value - 1 - MAX_FILE_SIZE);
            while (remaining) {
              unsigned char packed = *(rp ++);
              *(current ++) = packed >> 4;
              remaining--;
              if (remaining) {
                *(current ++) = packed & LZ_PACK16_NIBBLE_MASK;
                remaining--;
              }
            }
          } else {
            // lzpackhi0
            const unsigned char * rp = compressed + (unsigned)(-commands -> value - 1);
            while (remaining) {
              unsigned char packed = *(rp ++);
              *(current ++) = packed & 0xf0;
              remaining--;
              if (remaining) {
                *(current ++) = (unsigned char)((packed & LZ_PACK16_NIBBLE_MASK) << 4);
                remaining--;
              }
            }
          }
        } else {
          // lzpack16
          const unsigned char * rp = compressed + commands -> value;
          unsigned remaining = commands -> count;
          while (remaining) {
            unsigned char packed = *(rp ++);
            unsigned char hi = packed >> 4;
            unsigned char lo = packed & LZ_PACK16_NIBBLE_MASK;
            *(current ++) = pack16_table[hi];
            remaining--;
            if (remaining) {
              *(current ++) = pack16_table[lo];
              remaining--;
            }
          }
        }
        break;
      default: {
        const unsigned char * ref = ((commands -> value < 0) ? current : result) + commands -> value;
        for (p = 0; p < commands -> count; p ++) {
          current[p] = ref[(commands -> command == LZ_COPY_REVERSED) ? -(int) p : p];
          if (commands -> command == LZ_COPY_FLIPPED) current[p] = bit_flipping_table[current[p]];
        }
        current += commands -> count;
      }
    }
    if ((current - result) > MAX_FILE_SIZE) {
      free(result);
      return NULL;
    }
  }
  *file_size = current - result;
  return realloc(result, *file_size ? *file_size : 1);
}

void write_commands_to_textfile (const char * file, const struct command * commands, unsigned count, const unsigned char * input_stream,
                                 unsigned char alignment) {
  FILE * fp = file ? fopen(file, "w") : stdout;
  if (!fp) error_exit(1, "could not open file %s for writing", file);
  unsigned length = 0;
  while (count --) {
    write_command_to_textfile(fp, *commands, input_stream);
    length += command_size(*(commands ++));
  }
  if (fputs("\tlzend\n", fp) < 0) error_exit(1, "could not write terminator to compressed output");
  length = ~length & ((1 << alignment) - 1);
  if (length --) {
    int rv = fputs("\tdb 0", fp);
    while ((rv >= 0) && length --) rv = fputs(", 0", fp);
    if (rv >= 0) rv = -(putc('\n', fp) == EOF);
    if (rv < 0) error_exit(1, "could not write padding to compressed output");
  }
  if (file) fclose(fp);
}

void write_commands_and_padding_to_textfile (const char * file, const struct command * commands, unsigned count, const unsigned char * input_stream,
                                             unsigned padding_offset, unsigned padding_size) {
  FILE * fp = file ? fopen(file, "w") : stdout;
  if (!fp) error_exit(1, "could not open file %s for writing", file);
  while (count --) write_command_to_textfile(fp, *(commands ++), input_stream);
  if (fputs("\tlzend\n", fp) < 0) error_exit(1, "could not write terminator to compressed output");
  if (padding_size) {
    input_stream += padding_offset;
    int rv = 0;
    unsigned pos;
    const char * prefix = "\tdb";
    for (pos = 0; (rv >= 0) && (pos < padding_size); pos ++) {
      if (input_stream[pos])
        rv = fprintf(fp, "%s $%02hhx", prefix, input_stream[pos]);
      else
        rv = fprintf(fp, "%s 0", prefix);
      prefix = ",";
    }
    if (rv >= 0) rv = -(putc('\n', fp) == EOF);
    if (rv < 0) error_exit(1, "could not write padding to compressed output");
  }
  if (file) fclose(fp);
}

void write_command_to_textfile (FILE * fp, struct command command, const unsigned char * input_stream) {
  if ((!command.count) || (command.count > MAX_COMMAND_COUNT)) error_exit(2, "invalid command in output stream");
  int rv, pos;
  const char * kind;
  switch (command.command) {
    case LZ_DATA:
      if ((rv = fprintf(fp, "\tlzdata")) < 0) break;
      for (pos = 0; pos < command.count; pos ++) if ((rv = fprintf(fp, "%s$%02hhx", pos ? ", " : " ", input_stream[command.value + pos])) < 0) break;
      rv = putc('\n', fp);
      break;
    case LZ_REPEAT:
      if ((command.value < 0) || (command.value > 255)) error_exit(2, "invalid command in output stream");
      rv = fprintf(fp, "\tlzrepeat %u, $%02hhx\n", command.count, (unsigned char) command.value);
      break;
    case LZ_ALTERNATE:
      if (command.value < 0) error_exit(2, "invalid command in output stream");
      rv = fprintf(fp, "\tlzrepeat %u, $%02hhx, $%02hhx\n", command.count, (unsigned char) command.value, (unsigned char) (command.value >> 8));
      break;
    case LZ_ZERO:
      rv = fprintf(fp, "\tlzzero %u\n", command.count);
      break;
    case LZ_EXT:
      if (command.value < -MAX_FILE_SIZE) {
        rv = fprintf(fp, "\tlzpacklo0 %u\n", command.count);
      } else if (command.value < 0) {
        rv = fprintf(fp, "\tlzpackhi0 %u\n", command.count);
      } else {
        rv = fprintf(fp, "\tlzpack16 %u\n", command.count);
      }
      break;
    case LZ_COPY_NORMAL:
      kind = "normal";
      goto copy;
    case LZ_COPY_FLIPPED:
      kind = "flipped";
      goto copy;
    case LZ_COPY_REVERSED:
      kind = "reversed";
    copy:
      if ((command.value < -LOOKBACK_LIMIT) || (command.value >= MAX_FILE_SIZE)) error_exit(2, "invalid command in output stream");
      if (command.value < 0)
        rv = fprintf(fp, "\tlzcopy %s, %u, %d\n", kind, command.count, command.value);
      else
        rv = fprintf(fp, "\tlzcopy %s, %u, $%04hx\n", kind, command.count, (unsigned short) command.value);
      break;
    default:
      error_exit(2, "invalid command in output stream");
  }
  if (rv < 0) error_exit(1, "could not write command to compressed output");
}

void write_commands_to_file (const char * file, const struct command * commands, unsigned count, const unsigned char * input_stream, unsigned char alignment) {
  FILE * fp = file ? fopen(file, "wb") : stdout;
  if (!fp) error_exit(1, "could not open file %s for writing", file);
  unsigned length = 0;
  while (count --) {
    write_command_to_file(fp, *commands, input_stream);
    length += command_size(*(commands ++));
  }
  if (putc(LZ_END, fp) == EOF) error_exit(1, "could not write terminator to compressed output");
  length = ~length & ((1 << alignment) - 1);
  while (length --) if (putc(0, fp) == EOF) error_exit(1, "could not write padding to compressed output");
  if (file) fclose(fp);
}

void write_command_to_file (FILE * fp, struct command command, const unsigned char * input_stream) {
  unsigned char buf[4];
  unsigned char * pos = buf;
  int n;

  command.count -= minimum_count(command.command);

  /* Check for over and under sized commands */
  if (command.count > MAX_COMMAND_COUNT - 1) error_exit(2, "invalid command in output stream");

  if (command.command == LZ_EXT) {
    // Extended opcodes encoded with $fc-$fe.
    // After the header, packed-literal opcodes have ceil(count/2) payload bytes.
    unsigned original_count = command.count + minimum_count(command.command);
    if (original_count > MAX_EXT_COUNT) error_exit(2, "invalid command in output stream");

    if (command.value < 0) {
      unsigned payload = (original_count + 1) / 2;
      if (command.value < -MAX_FILE_SIZE) {
        // lzpacklo0: $fe <len-1> then ceil(len/2) packed low nibbles.
        *(pos ++) = LZ_EXT_PACKLO0;
        *(pos ++) = (unsigned char)(original_count - 1);
        if (fwrite(buf, 1, pos - buf, fp) != (unsigned)(pos - buf)) error_exit(1, "could not write command to compressed output");

        unsigned offset = (unsigned)(-command.value - 1 - MAX_FILE_SIZE);
        for (unsigned i = 0; i < payload; i++) {
          unsigned char a = input_stream[offset + i * 2];
          unsigned char b = (i * 2 + 1 < original_count) ? input_stream[offset + i * 2 + 1] : 0x00;
          if ((a & 0xf0) || (b & 0xf0)) error_exit(2, "invalid command in output stream");
          unsigned char packed = (unsigned char)((a << 4) | (b & LZ_PACK16_NIBBLE_MASK));
          if (putc(packed, fp) == EOF) error_exit(1, "could not write command to compressed output");
        }
        return;
      }

      // lzpackhi0: $fc <len-1> then ceil(len/2) packed bytes.
      *(pos ++) = LZ_EXT_PACKHI0;
      *(pos ++) = (unsigned char)(original_count - 1);
      if (fwrite(buf, 1, pos - buf, fp) != (unsigned)(pos - buf)) error_exit(1, "could not write command to compressed output");

      unsigned offset = (unsigned)(-command.value - 1);
      for (unsigned i = 0; i < payload; i++) {
        unsigned char a = input_stream[offset + i * 2];
        unsigned char b = (i * 2 + 1 < original_count) ? input_stream[offset + i * 2 + 1] : 0x00;
        if ((a & 0x0f) || (b & 0x0f)) error_exit(2, "invalid command in output stream");
        unsigned char packed = (a & 0xf0) | (unsigned char)((b >> 4) & 0x0f);
        if (putc(packed, fp) == EOF) error_exit(1, "could not write command to compressed output");
      }
      return;
    }

    // lzpack16: $fd <len-1> for 1..256
    *(pos ++) = LZ_EXT_PACK16_SHORT;
    *(pos ++) = (unsigned char)(original_count - 1);
    if (fwrite(buf, 1, pos - buf, fp) != (unsigned)(pos - buf)) error_exit(1, "could not write command to compressed output");

    // Build and write packed payload.
    unsigned payload = (original_count + 1) / 2;
    unsigned offset = (unsigned)command.value;
    for (unsigned i = 0; i < payload; i++) {
      unsigned char a = input_stream[offset + i * 2];
      unsigned char b = (i * 2 + 1 < original_count) ? input_stream[offset + i * 2 + 1] : 0x00;
      signed char ia = pack16_index_of(a);
      signed char ib = pack16_index_of(b);
      if (ia < 0 || ib < 0) error_exit(2, "invalid command in output stream");
      unsigned char packed = ((unsigned char)ia << 4) | (unsigned char)ib;
      if (putc(packed, fp) == EOF) error_exit(1, "could not write command to compressed output");
    }
    return;
  }
  else if (command.count < SHORT_COMMAND_COUNT)
    *(pos ++) = (command.command << 5) + command.count;
  else {
    *(pos ++) = (LZ_LONG << 5) + (command.command << 2) + (command.count >> 8);
    *(pos ++) = command.count;
  }
  switch (command.command) {
    case LZ_REPEAT:
    case LZ_ALTERNATE:
      if ((command.value < 0) || (command.value >= (1 << (command.command << 3)))) error_exit(2, "invalid command in output stream");
      for (n = 0; n < command.command; n ++) *(pos ++) = command.value >> (n << 3);
    case LZ_DATA:
    case LZ_ZERO:
      break;
    default:
      if ((command.value < -LOOKBACK_LIMIT) || (command.value >= MAX_FILE_SIZE)) error_exit(2, "invalid command in output stream");
      if (command.value < 0)
        *(pos ++) = command.value ^ (LOOKBACK_LIMIT - 1);
      else {
        *(pos ++) = command.value >> 8;
        *(pos ++) = command.value;
      }
  }
  if (fwrite(buf, 1, pos - buf, fp) != (unsigned)(pos - buf)) error_exit(1, "could not write command to compressed output");
  if (command.command) return;
  command.count ++;
  if (fwrite(input_stream + command.value, 1, command.count, fp) != command.count) error_exit(1, "could not write data to compressed output");
}

void write_raw_data_to_file (const char * file, const void * uncompressed, unsigned length) {
  FILE * fp = file ? fopen(file, "w") : stdout;
  if (!fp) error_exit(1, "could not open file %s for writing", file);
  while (length) {
    unsigned rv = fwrite(uncompressed, 1, length, fp);
    if (!rv) error_exit(1, "could not write raw data to output");
    uncompressed = (const char *) uncompressed + rv;
    length -= rv;
  }
  if (file) fclose(fp);
}

struct command * compress (const unsigned char * compressed, unsigned short * file_size) {
  unsigned char * _bitflipped = malloc(*file_size);
  unsigned current;
  for (current = 0; current < *file_size; current ++) _bitflipped[current] = bit_flipping_table[compressed[current]];
  struct command * result = compress_dp(compressed, _bitflipped, file_size);
  free(_bitflipped);
  return result;
}

int main (int argc, char ** argv) {
  struct options options = get_options(argc, argv);
  unsigned short file_size;
  unsigned char * file_buffer = read_file_into_buffer(options.input, &file_size);
  struct command * commands;
  if (options.mode & 2) {
    unsigned short original_size = file_size, remainder;
    commands = get_commands_from_file(file_buffer, &file_size, &remainder);
    if (!commands) error_exit(1, "invalid command stream");
    if (options.mode == 2) {
      unsigned char * uncompressed = get_uncompressed_data(commands, file_buffer, &file_size);
      if (!uncompressed) error_exit(1, "output data is too large");
      write_raw_data_to_file(options.output, uncompressed, file_size);
      free(uncompressed);
    } else
      write_commands_and_padding_to_textfile(options.output, commands, file_size, file_buffer, original_size - remainder, remainder);
  } else {
    commands = compress(file_buffer, &file_size);
    (options.mode ? write_commands_to_textfile : write_commands_to_file)(options.output, commands, file_size, file_buffer, options.alignment);
  }
  free(file_buffer);
  free(commands);
  return 0;
}
