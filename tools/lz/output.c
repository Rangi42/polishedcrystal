#include "proto.h"

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

void write_raw_data_to_file (const char * file, const void * data, unsigned length) {
  FILE * fp = file ? fopen(file, "w") : stdout;
  if (!fp) error_exit(1, "could not open file %s for writing", file);
  while (length) {
    unsigned rv = fwrite(data, 1, length, fp);
    if (!rv) error_exit(1, "could not write raw data to output");
    data = (const char *) data + rv;
    length -= rv;
  }
  if (file) fclose(fp);
}
