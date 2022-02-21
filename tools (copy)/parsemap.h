#ifndef ___PARSE_MAP

#define ___PARSE_MAP

// you never know when some crazy person will call your code from C++
#ifdef __cplusplus
  extern "C" {
#endif

enum {
  SECTION_ROM = 1,
  SECTION_VRAM = 2,
  SECTION_SRAM = 3,
  SECTION_WRAM = 4,
  SECTION_OAM = 5,
  SECTION_HRAM = 6,
  SECTION_UNKNOWN = 255
};

enum {
  SECTION_FLAG_HOME_BANK = 1
};

typedef struct {
  unsigned char type;
  unsigned char flags;
  unsigned short bank;
  unsigned short address;
  unsigned short length;
  char * name;
} MapSection;

MapSection * get_sections_from_map_file(const char * file);
void destroy_section_array(MapSection * sections);

#ifdef __cplusplus
  }
#endif

#endif
