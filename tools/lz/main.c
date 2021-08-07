#include "proto.h"

int main (int argc, char ** argv) {
  struct options options = get_options(argc, argv);
  unsigned short size;
  unsigned char * file_buffer = read_file_into_buffer(options.input, &size);
  struct command * commands;
  if (options.mode & 2) {
    unsigned short original_size = size, remainder;
    commands = get_commands_from_file(file_buffer, &size, &remainder);
    if (!commands) error_exit(1, "invalid command stream");
    if (options.mode == 2) {
      unsigned char * uncompressed = get_uncompressed_data(commands, file_buffer, &size);
      if (!uncompressed) error_exit(1, "output data is too large");
      write_raw_data_to_file(options.output, uncompressed, size);
      free(uncompressed);
    } else
      write_commands_and_padding_to_textfile(options.output, commands, size, file_buffer, original_size - remainder, remainder);
  } else {
    commands = compress(file_buffer, &size);
    (options.mode ? write_commands_to_textfile : write_commands_to_file)(options.output, commands, size, file_buffer, options.alignment);
  }
  free(file_buffer);
  free(commands);
  return 0;
}

struct command * compress (const unsigned char * data, unsigned short * size) {
  unsigned char * bitflipped = malloc(*size);
  unsigned current;
  for (current = 0; current < *size; current ++) bitflipped[current] = bit_flipping_table[data[current]];
  struct command * result = compress_dp(data, bitflipped, size);
  free(bitflipped);
  return result;
}
