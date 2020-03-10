#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parsemap.h"

#define TOKEN_DELIMITERS " \t:-"

static char * pm_get_line_from_file(FILE *);
static unsigned pm_check_first_token(const char *, const char *);
static unsigned short pm_load_address(char **);
static int pm_compare_sections(const void *, const void *);

MapSection * get_sections_from_map_file (const char * file) {
  FILE * fp = fopen(file, "r");
  if (!fp) return NULL;
  unsigned char current_type = 0;
  unsigned short current_bank = 0;
  MapSection section;
  MapSection * result = NULL;
  unsigned pos, count = 0;
  char * line;
  char * current;
  unsigned char current_flags, check_flags;
  while (!(feof(fp) || ferror(fp))) {
    line = pm_get_line_from_file(fp);
    current = line + strspn(line, " \t");
    if (!*current) goto line_done;
    current_flags = check_flags = 0;
    if (line == current) {
      if ((pos = pm_check_first_token(line, "ROM"))) {
        current_type = SECTION_ROM;
        check_flags = SECTION_FLAG_HOME_BANK;
      } else if ((pos = pm_check_first_token(line, "ROM0"))) {
        current_type = SECTION_ROM;
        current_flags = SECTION_FLAG_HOME_BANK;
      } else if ((pos = pm_check_first_token(line, "ROMX")))
        current_type = SECTION_ROM;
      else if ((pos = pm_check_first_token(line, "VRAM")))
        current_type = SECTION_VRAM;
      else if ((pos = pm_check_first_token(line, "SRAM")))
        current_type = SECTION_SRAM;
      else if ((pos = pm_check_first_token(line, "WRAM"))) {
        current_type = SECTION_WRAM;
        check_flags = SECTION_FLAG_HOME_BANK;
      } else if ((pos = pm_check_first_token(line, "WRAM0"))) {
        current_type = SECTION_WRAM;
        current_flags = SECTION_FLAG_HOME_BANK;
      } else if ((pos = pm_check_first_token(line, "WRAMX")))
        current_type = SECTION_WRAM;
      else if ((pos = pm_check_first_token(line, "OAM")))
        current_type = SECTION_OAM;
      else if ((pos = pm_check_first_token(line, "HRAM")))
        current_type = SECTION_HRAM;
      else
        current_type = SECTION_UNKNOWN;
      current = strchr(line + pos, '#');
      if (current) {
        pos = strspn(++ current, "0123456789");
        current[pos] = 0;
        current_bank = strtoul(current, NULL, 10);
      } else
        current_bank = 0;
      if ((check_flags & SECTION_FLAG_HOME_BANK) && !current_bank) current_flags = SECTION_FLAG_HOME_BANK;
    } else {
      if (!current_type) goto line_done;
      pos = pm_check_first_token(current, "SECTION");
      if (!pos) goto line_done;
      current += pos;
      if (*current == '$') current ++;
      section = (MapSection) {.type = current_type, .flags = current_flags, .bank = current_bank,
                              .address = pm_load_address(&current), .name = NULL};
      if (*current == '-') {
        current += strspn(current, TOKEN_DELIMITERS);
        if (*current == '$') current ++;
        section.length = pm_load_address(&current) + 1 - section.address;
      } else
        section.length = 0;
      current = strchr(current, '"');
      if (current) {
        current ++;
        pos = strcspn(current, "\"");
        section.name = memcpy(malloc(pos + 1), current, pos);
        section.name[pos] = 0;
      }
      result = realloc(result, sizeof(MapSection) * (count + 1));
      result[count ++] = section;
    }
    line_done:
    free(line);
  }
  fclose(fp);
  qsort(result, count, sizeof(MapSection), &pm_compare_sections);
  result = realloc(result, sizeof(MapSection) * (count + 1));
  result[count] = (MapSection) {0};
  return result;
}

void destroy_section_array (MapSection * sections) {
  MapSection * current = sections;
  while (current -> type) {
    free(current -> name);
    current ++;
  }
  free(sections);
}

static char * pm_get_line_from_file (FILE * fp) {
  char * result = NULL;
  unsigned length = 0;
  int c;
  while ((c = getc(fp)) != EOF) {
    if (c == '\r') continue;
    if (c == '\n') break;
    result = realloc(result, length + 1);
    result[length ++] = c;
  }
  result = realloc(result, length + 1);
  result[length] = 0;
  return result;
}

static unsigned pm_check_first_token (const char * string, const char * token) {
  const char * current = string;
  for (; *token; current ++, token ++) if (*current != *token) return 0;
  if (!strchr(TOKEN_DELIMITERS, *current)) return 0;
  return current - string + strspn(current, TOKEN_DELIMITERS);
}

static unsigned short pm_load_address (char ** string) {
  unsigned length = strspn(*string, "0123456789abcdefABCDEF");
  if (length > 4) {
    *string += length - 4;
    length = 4;
  }
  unsigned short result = 0;
  while (length --) {
    result <<= 4;
    if ((**string >= '0') && (**string <= '9'))
      result += **string - '0';
    else
      result += **string - ((unsigned) (**string - 'a') < 6 ? 'a' : 'A') + 10;
    ++ *string;
  }
  return result;
}

static int pm_compare_sections (const void * first, const void * second) {
  const MapSection * p1 = first;
  const MapSection * p2 = second;
  if (p1 -> type != p2 -> type)
    return (p1 -> type > p2 -> type) - (p1 -> type < p2 -> type);
  else if (p1 -> bank != p2 -> bank)
    return (p1 -> bank > p2 -> bank) - (p1 -> bank < p2 -> bank);
  else if (p1 -> address != p2 -> address)
    return (p1 -> address > p2 -> address) - (p1 -> address < p2 -> address);
  else
    return (p1 -> length > p2 -> length) - (p1 -> length < p2 -> length);
}
