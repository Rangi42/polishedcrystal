#include "proto.h"

struct command * get_commands_from_file (const unsigned char * data, unsigned short * restrict size, unsigned short * restrict slack) {
  struct command * result = malloc(*size * sizeof(struct command));
  unsigned short remaining = *size;
  struct command * current = result;
  const unsigned char * rp = data;
  while (1) {
    if (!(remaining --)) goto error;
    current -> command = *rp >> 5;
    current -> count = *(rp ++) & 31;
    if (current -> command == LZ_LONG) {
      current -> command = current -> count >> 2;
      current -> count = (current -> count & 3) << 8;
      if (current -> command == LZ_LONG) {
        // long commands inside long commands are not allowed, but if the count is 0x300 here, it means that the original byte was 0xff
        if (current -> count == 0x300) break;
        goto error;
      }
      if (!(remaining --)) goto error;
      current -> count |= *(rp ++);
    }
    current -> count += minimum_count(current -> command);
    switch (current -> command) {
      case LZ_DATA:
        if (remaining <= current -> count) goto error;
        current -> value = rp - data;
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
        if ((current -> value = *(rp ++)) & 128)
          current -> value = 127 - current -> value;
        else {
          if (!(remaining --)) goto error;
          current -> value = (current -> value << 8) | *(rp ++);
        }
    }
    current ++;
  }
  if (slack) *slack = *size - (rp - data);
  *size = current - result;
  return realloc(result, (*size ? *size : 1) * sizeof(struct command));
  error:
  free(result);
  return NULL;
}

unsigned char * get_uncompressed_data (const struct command * commands, const unsigned char * compressed, unsigned short * size) {
  const struct command * limit = commands + *size;
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
  *size = current - result;
  return realloc(result, *size ? *size : 1);
}
