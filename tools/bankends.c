#include <stdio.h>
#include <stdlib.h>

#include "parsemap.h"

#define BANKS 128
#define BANKSIZE 0x4000
#define ROMSIZE (BANKS * BANKSIZE)

#define EPIGRAPH \
"> Back in the day, the programming used up all the space on a cartridge, so if\n" \
"> we wanted to add something new, we had to clean it up first... First we'd\n" \
"> find enough space, then we could make what we wanted... It was a pain!\n" \
"> \n" \
"> -- Morimoto, Pok\xc3\xa9mon Ultra Sun/Ultra Moon\n" \
"> <https://www.serebii.net/ultrasunultramoon/virtualconsole.shtml>\n"

int compare_free_space (const void * first, const void * second) {
  const unsigned short * p1 = first;
  const unsigned short * p2 = second;
  if (*p1 != *p2) return (*p1 < *p2) - (*p1 > *p2);
  return (p1[1] > p2[1]) - (p1[1] < p2[1]);
}

int main (int argc, char ** argv) {
  if (argc != 2) {
    fprintf(stderr, "usage: %s file.map\n", *argv);
    return 1;
  }
  MapSection * sections = get_sections_from_map_file(argv[1]);
  if (!sections) {
    fprintf(stderr, "error: could not retrieve section data from %s\n", argv[1]);
    return 2;
  }
  unsigned short bank_ends[BANKS];
  unsigned p;
  *bank_ends = 0;
  for (p = 1; p < BANKS; p ++) bank_ends[p] = BANKSIZE;
  MapSection * section;
  for (section = sections; section -> type == SECTION_ROM; section ++) {
    if (section -> bank >= BANKS) {
      fprintf(stderr, "error: unknown ROM bank $%hx\n", section -> bank);
      return 3;
    }
    if ((section -> address + section -> length) > bank_ends[section -> bank])
      bank_ends[section -> bank] = section -> address + section -> length;
  }
  destroy_section_array(sections);
  unsigned short free_space[BANKS * 2];
  *free_space = BANKSIZE - *bank_ends;
  free_space[1] = 0;
  for (p = 1; p < BANKS; p ++) {
    free_space[p * 2] = BANKSIZE + BANKSIZE - bank_ends[p];
    free_space[p * 2 + 1] = p;
  }
  unsigned total_free_space = 0;
  for (p = 0; p < BANKS; p ++) {
    total_free_space += free_space[p * 2];
  }
  float percentage = total_free_space * 100.0f / ROMSIZE;
  puts(EPIGRAPH);
  printf("Free space: %u/%u (%.2f%%)\n\n", total_free_space, ROMSIZE, percentage);
  puts("bank\tend\tfree");
  for (p = 0; p < BANKS; p ++) printf("$%02x\t$%04hx\t$%04hx\n", p, bank_ends[p], free_space[p * 2]);
  return 0;
}
