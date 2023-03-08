#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define MAX_FILE_SIZE            32768
#define SHORT_COMMAND_COUNT         32
#define MAX_COMMAND_COUNT          512
#define LOOKBACK_LIMIT             128 /* highest negative valid count for a copy command */

#define LZ_DATA          0 /* Read literal data for n bytes.   */
#define LZ_REPEAT        1 /* Write the same byte for n bytes. */
#define LZ_ALTERNATE     2 /* Alternate two bytes for n bytes. */
#define LZ_ZERO          3 /* Write 0 for n bytes.             */
#define LZ_COPY_NORMAL   4 /* Repeat n bytes from the offset.  */
#define LZ_COPY_FLIPPED  5 /* Repeat n bitflipped bytes.       */
#define LZ_COPY_REVERSED 6 /* Repeat n bytes in reverse.       */
#define LZ_LONG          7 /* Expand n to 9 bits               */

#if __STDC_VERSION__ >= 201112L
	// <noreturn.h> forces "noreturn void", which is silly and redundant; this is simpler
	#define noreturn _Noreturn void
#else
	#define noreturn void /* fallback */
#endif

struct command {
  unsigned command: 3; // commands 0-6 as per compression spec; command 7 is used as a dummy placeholder
  unsigned count:  12; // always equals the uncompressed data length
  signed value:    17; // offset for commands 0 (into source) and 4-6 (into decompressed output); repeated bytes for commands 1-2
};

struct options {
  const char * input;
  const char * output;
  unsigned char mode; // 0: compress, 1: compress to text, 2: uncompress, 3: dump commands as text
  unsigned char alignment; // 1 << value
};

// global.c
extern const unsigned char bit_flipping_table[];
extern char option_name_buffer[];

// main.c
int main(int, char **);
struct command * compress(const unsigned char *, unsigned short *);

// options.c
struct options get_options(int, char **);
unsigned parse_numeric_option_argument(char ***, unsigned);
const char * get_argument_for_option(char ***, const char **);
noreturn usage(const char *);

// output.c
void write_commands_to_textfile(const char *, const struct command *, unsigned, const unsigned char *, unsigned char);
void write_commands_and_padding_to_textfile(const char *, const struct command *, unsigned, const unsigned char *, unsigned, unsigned);
void write_command_to_textfile(FILE *, struct command, const unsigned char *);
void write_commands_to_file(const char *, const struct command *, unsigned, const unsigned char *, unsigned char);
void write_command_to_file(FILE *, struct command, const unsigned char *);
void write_raw_data_to_file(const char *, const void *, unsigned);

// uncomp.c
struct command * get_commands_from_file(const unsigned char *, unsigned short * restrict, unsigned short * restrict);
unsigned char * get_uncompressed_data(const struct command *, const unsigned char *, unsigned short *);

// util.c
noreturn error_exit(int, const char *, ...);
unsigned char * read_file_into_buffer(const char *, unsigned short *);
unsigned minimum_count(unsigned command);
short command_size(struct command);
unsigned short compressed_length(const struct command *, unsigned short);

// dpcomp.c
struct command * compress_dp(const unsigned char * data, const unsigned char * bitflipped, unsigned short * size);
