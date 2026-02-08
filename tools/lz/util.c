#include "proto.h"

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
