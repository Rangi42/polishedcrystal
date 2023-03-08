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

unsigned minimum_count (unsigned command) {
  switch (command) {
    case LZ_ALTERNATE:
        return 3;
    case LZ_REPEAT:
        return 2;
    default:
        return 1;
  }
}

short command_size (struct command command) {
  short header_size = 1 + (command.count - minimum_count(command.command) > SHORT_COMMAND_COUNT - 1);
  if (command.command & 4) return header_size + 1 + (command.value >= 0);
  return header_size + command.command[(short []) {command.count, 1, 2, 0}];
}

unsigned short compressed_length (const struct command * commands, unsigned short count) {
  unsigned short current, total = 0;
  for (current = 0; current < count; current ++) if (commands[current].command != 7) total += command_size(commands[current]);
  return total;
}
