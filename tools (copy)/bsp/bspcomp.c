#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#define LETTERS "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define LETTERS_OR_UNDERSCORE LETTERS "_"
#define DIGITS "0123456789"
#define VALID_ID_CHARACTERS LETTERS_OR_UNDERSCORE DIGITS
#define NUMERIC_CHARACTERS DIGITS "+-"

struct symbol {
  unsigned value;
  char name[];
};

struct script_data {
  unsigned length;
  unsigned symbol_count;
  unsigned definition_count;
  unsigned reference_count;
  struct symbol ** symbols;
  struct symbol ** definitions;
  struct symbol ** references;
  char data[];
};

struct file_stack_entry {
  FILE * fp;
  char * name;
  unsigned line;
};

struct command {
  const char * name;
  int argument;
  void (* parser) (int, char **);
};

struct argument {
  unsigned char kind; // 0: constant, 1: argument, 2: reference
  unsigned value;
  char reference[];
};

int main(int, char **);
void error_exit(int, const char *, ...);
void initialize_data(void);
void append_data_to_script(const char *, unsigned);
void append_binary_file_to_script(const char *);
void write_halfword_to_buffer(void *, unsigned short);
void write_word_to_buffer(void *, unsigned);
void write_number_to_buffer(unsigned char *, unsigned, unsigned char);
struct symbol * find_symbol(const char *);
struct symbol * find_definition(const char *);
struct symbol * find_identifier_by_name(const char *, struct symbol **, unsigned);
void create_symbol(const char *, unsigned);
void create_definition(const char *, unsigned);
void create_reference(const char *, unsigned);
struct symbol * new_symbol(const char *, unsigned);
void resolve(const struct symbol *);
int find_unquoted_character(const char *, char);
char * trim_string(char *);
char * duplicate_string(const char *);
char ** extract_components_from_line(const char *);
void destroy_component_array(char **);
unsigned count_parameters(char **);
unsigned char get_hex_digit(char);
unsigned convert_string_to_number(const char *);
FILE * open_text_file(const char *);
FILE * open_binary_file(const char *);
FILE * open_binary_file_for_writing(const char *);
FILE * open_file(const char *, const char *, const char *);
char * read_line(FILE *);
char * get_line_from_input(void);
void push_file(const char *);
void pop_file(void);
void write_data_to_file(FILE *, const char *, unsigned);
void process_input_line(const char *);
void declare_label(const char *);
struct command * find_command(const char *);
void flush_locals(void);
void flush_all_symbols(void);
int validate_label(const char *);
struct argument * get_argument(const char *);
char * get_string_argument(const char *);
void no_arguments_command(int, char **);
void one_argument_command(int, char **);
void two_arguments_command(int, char **);
void one_variable_command(int, char **);
void one_variable_one_argument_command(int, char **);
void one_variable_two_arguments_command(int, char **);
void two_variables_command(int, char **);
void two_variables_two_arguments_command(int, char **);
void one_byte_argument_command(int, char **);
void one_halfword_argument_command(int, char **);
void calculation_command(int, char **);
void bit_shift_command(int, char **);
void one_argument_one_byte_argument(int, char **);
void one_argument_one_halfword_argument(int, char **);
void mulacum_command(int, char **);
void standard_command(unsigned char, unsigned char, unsigned char, char **);
void data_command(int, char **);
void hexdata_command(int, char **);
void define_command(int, char **);
void include_command(int, char **);
void string_command(int, char **);
void align_command(int, char **);

char * current_file = NULL;
unsigned current_line = 0;

struct file_stack_entry * file_stack = NULL;
unsigned file_stack_length = 0;

struct script_data * script_data = NULL;

struct command script_commands[] = {
  {"add",               0x20, &calculation_command},
  {"addcarry",          0xb0, &two_variables_two_arguments_command},
  {"align",             0,    &align_command},
  {"and",               0x34, &calculation_command},
  {"bsppatch",          0x94, &one_variable_two_arguments_command},
  {"bufchar",           0xa2, &one_argument_command},
  {"bufnumber",         0xa4, &one_argument_command},
  {"bufstring",         0xa0, &one_argument_command},
  {"call",              0x04, &one_argument_command},
  {"callnz",            0x5e, &one_variable_one_argument_command},
  {"callz",             0x5c, &one_variable_one_argument_command},
  {"checksha1",         0x16, &one_variable_one_argument_command},
  {"clearbuf",          0xa7, &no_arguments_command},
  {"db",                1,    &data_command},
  {"decrement",         0x9f, &one_variable_command},
  {"define",            0,    &define_command},
  {"dh",                2,    &data_command},
  {"divide",            0x2c, &calculation_command},
  {"dw",                4,    &data_command},
  {"exit",              0x06, &one_argument_command},
  {"fillbyte",          0x70, &one_argument_one_byte_argument},
  {"fillhalfword",      0x74, &one_argument_one_halfword_argument},
  {"fillword",          0x78, &two_arguments_command},
  {"getbyte",           0x10, &one_variable_one_argument_command},
  {"getbytedec",        0x9c, &two_variables_command},
  {"getbyteinc",        0x98, &two_variables_command},
  {"getfilebyte",       0xac, &one_variable_command},
  {"getfilehalfword",   0xad, &one_variable_command},
  {"getfileword",       0xae, &one_variable_command},
  {"gethalfword",       0x12, &one_variable_one_argument_command},
  {"gethalfworddec",    0x9d, &two_variables_command},
  {"gethalfwordinc",    0x99, &two_variables_command},
  {"getstacksize",      0xaa, &one_variable_command},
  {"getvariable",       0xaf, &two_variables_command},
  {"getword",           0x14, &one_variable_one_argument_command},
  {"getworddec",        0x9e, &two_variables_command},
  {"getwordinc",        0x9a, &two_variables_command},
  {"hexdata",           0,    &hexdata_command},
  {"ifeq",              0x50, &one_variable_two_arguments_command},
  {"ifge",              0x4c, &one_variable_two_arguments_command},
  {"ifgt",              0x48, &one_variable_two_arguments_command},
  {"ifle",              0x44, &one_variable_two_arguments_command},
  {"iflt",              0x40, &one_variable_two_arguments_command},
  {"ifne",              0x54, &one_variable_two_arguments_command},
  {"incbin",            1,    &include_command},
  {"include",           0,    &include_command},
  {"increment",         0x9b, &one_variable_command},
  {"ipspatch",          0x86, &one_variable_one_argument_command},
  {"jump",              0x02, &one_argument_command},
  {"jumpnz",            0x5a, &one_variable_one_argument_command},
  {"jumptable",         0x83, &one_variable_command},
  {"jumpz",             0x58, &one_variable_one_argument_command},
  {"length",            0x0b, &one_variable_command},
  {"lockpos",           0x80, &no_arguments_command},
  {"longmul",           0xb8, &two_variables_two_arguments_command},
  {"longmulacum",       0xbc, &two_variables_two_arguments_command},
  {"menu",              0x6a, &one_variable_one_argument_command},
  {"mulacum",           0xbc, &mulacum_command},
  {"multiply",          0x28, &calculation_command},
  {"nop",               0x00, &no_arguments_command},
  {"or",                0x38, &calculation_command},
  {"pop",               0x0a, &one_variable_command},
  {"poppos",            0x93, &no_arguments_command},
  {"pos",               0x0f, &one_variable_command},
  {"print",             0x68, &one_argument_command},
  {"printbuf",          0xa6, &no_arguments_command},
  {"push",              0x08, &one_argument_command},
  {"pushpos",           0x92, &no_arguments_command},
  {"readbyte",          0x0c, &one_variable_command},
  {"readhalfword",      0x0d, &one_variable_command},
  {"readword",          0x0e, &one_variable_command},
  {"remainder",         0x30, &calculation_command},
  {"retnz",             0x91, &one_variable_command},
  {"return",            0x01, &no_arguments_command},
  {"retz",              0x90, &one_variable_command},
  {"rotateleft",        2,    &bit_shift_command},
  {"seek",              0x60, &one_argument_command},
  {"seekback",          0x64, &one_argument_command},
  {"seekend",           0x66, &one_argument_command},
  {"seekfwd",           0x62, &one_argument_command},
  {"set",               0x84, &one_variable_one_argument_command},
  {"setstacksize",      0xa8, &one_argument_command},
  {"shiftleft",         0,    &bit_shift_command},
  {"shiftright",        1,    &bit_shift_command},
  {"shiftrightarith",   3,    &bit_shift_command},
  {"stackread",         0x8c, &one_variable_one_argument_command},
  {"stackshift",        0x8e, &one_argument_command},
  {"stackwrite",        0x88, &two_arguments_command},
  {"string",            0,    &string_command},
  {"subborrow",         0xb4, &two_variables_two_arguments_command},
  {"subtract",          0x24, &calculation_command},
  {"truncate",          0x1e, &one_argument_command},
  {"truncatepos",       0x82, &no_arguments_command},
  {"unlockpos",         0x81, &no_arguments_command},
  {"writebyte",         0x18, &one_byte_argument_command},
  {"writedata",         0x7c, &two_arguments_command},
  {"writehalfword",     0x1a, &one_halfword_argument_command},
  {"writeword",         0x1c, &one_argument_command},
  {"xor",               0x3c, &calculation_command},
  {"xordata",           0x6c, &two_arguments_command},
  {NULL,                0,    NULL}
};

#define SET_OPCODE 0x84
#define SHIFT_OPCODE 0xab

int main (int argc, char ** argv) {
  if (argc != 3) {
    fprintf(stderr, "usage: %s <input file> <output file>\n", *argv);
    return 2;
  }
  initialize_data();
  push_file(argv[1]);
  char * line;
  int comment_start;
  while (file_stack_length) {
    current_line ++;
    line = get_line_from_input();
    comment_start = find_unquoted_character(line, ';');
    if (comment_start >= 0) line[comment_start] = 0;
    process_input_line(line);
    free(line);
    if (feof(file_stack -> fp)) pop_file();
  }
  current_file = NULL;
  flush_all_symbols();
  FILE * fp = open_binary_file_for_writing(argv[2]);
  write_data_to_file(fp, script_data -> data, script_data -> length);
  fclose(fp);
  return 0;
}

void error_exit (int status, const char * fmtstring, ...) {
  if (current_file)
    fprintf(stderr, "%s:%u: ", current_file, current_line);
  else
    fprintf(stderr, "error: ");
  va_list ap;
  va_start(ap, fmtstring);
  vfprintf(stderr, fmtstring, ap);
  va_end(ap);
  putc('\n', stderr);
  exit(status);
}

void initialize_data (void) {
  script_data = calloc(1, sizeof(struct script_data));
}

void append_data_to_script (const char * data, unsigned length) {
  script_data = realloc(script_data, sizeof(struct script_data) + script_data -> length + length);
  memcpy(script_data -> data + script_data -> length, data, length);
  script_data -> length += length;
}

void append_binary_file_to_script (const char * file) {
  char * prev_current_file = current_file;
  current_file = NULL;
  FILE * fp = open_binary_file(file);
  char * buffer = malloc(65536);
  unsigned rv;
  while (!feof(fp)) {
    rv = fread(buffer, 1, 65536, fp);
    if ((!rv) && ferror(fp)) error_exit(1, "could not read data from binary file %s", file);
    append_data_to_script(buffer, rv);
  }
  fclose(fp);
  free(buffer);
  current_file = prev_current_file;
}

void write_halfword_to_buffer (void * buffer, unsigned short number) {
  write_number_to_buffer(buffer, number, 2);
}

void write_word_to_buffer (void * buffer, unsigned number) {
  write_number_to_buffer(buffer, number, 4);
}

void write_number_to_buffer (unsigned char * buffer, unsigned number, unsigned char length) {
  unsigned char pos;
  for (pos = 0; pos < length; pos ++) {
    *(buffer ++) = number;
    number >>= 8;
  }
}

struct symbol * find_symbol (const char * name) {
  return find_identifier_by_name(name, script_data -> symbols, script_data -> symbol_count);
}

struct symbol * find_definition (const char * name) {
  return find_identifier_by_name(name, script_data -> definitions, script_data -> definition_count);
}

struct symbol * find_identifier_by_name (const char * identifier, struct symbol ** identifiers, unsigned count) {
  unsigned pos;
  for (pos = 0; pos < count; pos ++) if (!strcmp(identifiers[pos] -> name, identifier)) return identifiers[pos];
  return NULL;
}

void create_symbol (const char * name, unsigned value) {
  script_data -> symbols = realloc(script_data -> symbols, sizeof(struct symbol *) * (script_data -> symbol_count + 1));
  script_data -> symbols[script_data -> symbol_count ++] = new_symbol(name, value);
}

void create_definition (const char * name, unsigned value) {
  script_data -> definitions = realloc(script_data -> definitions, sizeof(struct symbol *) * (script_data -> definition_count + 1));
  script_data -> definitions[script_data -> definition_count ++] = new_symbol(name, value);
}

void create_reference (const char * target, unsigned value) {
  script_data -> references = realloc(script_data -> references, sizeof(struct symbol *) * (script_data -> reference_count + 1));
  script_data -> references[script_data -> reference_count ++] = new_symbol(target, value);
}

struct symbol * new_symbol (const char * name, unsigned value) {
  struct symbol * result = malloc(sizeof(struct symbol) + strlen(name) + 1);
  result -> value = value;
  strcpy(result -> name, name);
  return result;
}

void resolve (const struct symbol * symbol) {
  unsigned pos = 0;
  while (pos < script_data -> reference_count) {
    if (strcmp(symbol -> name, script_data -> references[pos] -> name)) {
      pos ++;
      continue;
    }
    write_word_to_buffer(script_data -> data + script_data -> references[pos] -> value, symbol -> value);
    free(script_data -> references[pos]);
    script_data -> references[pos] = script_data -> references[-- script_data -> reference_count];
    script_data -> references = realloc(script_data -> references, sizeof(struct symbol *) * script_data -> reference_count);
  }
}

int find_unquoted_character (const char * string, char character) {
  unsigned char in_quotes = 0;
  unsigned pos;
  const char * p;
  for (p = string, pos = 0; *p; p ++, pos ++) {
    if (*p == '"') {
      in_quotes ^= 1;
      continue;
    }
    if (in_quotes) continue;
    if (*p == character) return pos;
  }
  if (in_quotes) error_exit(1, "mismatched quotes in string: %s", string);
  return -1;
}

char * trim_string (char * string) {
  while ((*string == ' ') || (*string == '\t')) string ++;
  unsigned effective_length = strlen(string);
  while (effective_length && ((string[effective_length - 1] == ' ') || (string[effective_length - 1] == '\t'))) effective_length --;
  char * result = malloc(effective_length + 1);
  memcpy(result, string, effective_length);
  result[effective_length] = 0;
  return result;
}

char * duplicate_string (const char * string) {
  return strcpy(malloc(strlen(string) + 1), string);
}

char ** extract_components_from_line (const char * line) {
  char * copy = duplicate_string(line);
  int pos = find_unquoted_character(copy, ';');
  if (pos >= 0) copy[pos] = 0;
  char * current = copy + strspn(copy, " \t");
  if ((!*current)) {
    free(copy);
    return NULL;
  }
  pos = strcspn(current, " \t");
  char ** result;
  if (!current[pos]) {
    result = malloc(sizeof(char *) * 2);
    *result = duplicate_string(current);
    result[1] = NULL;
    return result;
  }
  result = malloc(sizeof(char *));
  current[pos] = 0;
  *result = duplicate_string(current);
  current += pos + 1;
  unsigned components = 1;
  char * component;
  while (pos >= 0) {
    pos = find_unquoted_character(current, ',');
    if (pos >= 0) current[pos] = 0;
    component = trim_string(current);
    if (pos >= 0) current += pos + 1;
    if (*component) {
      result = realloc(result, sizeof(char *) * (components + 1));
      result[components ++] = component;
    } else
      free(component);
  }
  result = realloc(result, sizeof(char *) * (components + 1));
  result[components] = NULL;
  return result;
}

void destroy_component_array (char ** array) {
  char ** current;
  for (current = array; *current; current ++) free(*current);
  free(array);
}

unsigned count_parameters (char ** components) {
  if (!components) return -1;
  unsigned count = 0;
  while (components[count ++]);
  return count - 1;
}

unsigned char get_hex_digit (char digit) {
  if ((digit >= '0') && (digit <= '9')) return digit - '0';
  if ((digit >= 'A') && (digit <= 'F')) return digit - ('A' - 10);
  if ((digit >= 'a') && (digit <= 'f')) return digit - ('a' - 10);
  return 0;
}

unsigned convert_string_to_number (const char * string) {
  if (!*string) error_exit(1, "argument is empty");
  char * error_pointer;
  unsigned long long value = strtoull(string, &error_pointer, 0);
  if (*error_pointer) error_exit(1, "invalid number: %s", string);
  return value;
}

FILE * open_text_file (const char * file) {
  return open_file(file, "r", "reading");
}

FILE * open_binary_file (const char * file) {
  return open_file(file, "rb", "reading");
}

FILE * open_binary_file_for_writing (const char * file) {
  return open_file(file, "wb", "writing");
}

FILE * open_file (const char * file, const char * mode, const char * mode_description) {
  FILE * fp = fopen(file, mode);
  if (!fp) error_exit(1, "could not open file %s for %s", file, mode_description);
  return fp;
}

char * read_line (FILE * fp) {
  char * line = NULL;
  unsigned length = 0;
  int c;
  while (1) {
    c = getc(fp);
    if ((c == EOF) || (c == '\n')) break;
    line = realloc(line, length + 1);
    line[length ++] = c;
  }
  line = realloc(line, length + 1);
  line[length] = 0;
  return line;
}

char * get_line_from_input (void) {
  return read_line(file_stack -> fp);
}

void push_file (const char * file) {
  current_file = NULL;
  FILE * fp = open_text_file(file);
  char * filename = duplicate_string(file);
  if (file_stack_length) file_stack -> line = current_line;
  file_stack = realloc(file_stack, sizeof(struct file_stack_entry) * (file_stack_length + 1));
  memmove(file_stack + 1, file_stack, file_stack_length * sizeof(struct file_stack_entry));
  file_stack_length ++;
  *file_stack = (struct file_stack_entry) {.fp = fp, .name = filename, .line = 0};
  current_file = filename;
  current_line = 0;
}

void pop_file (void) {
  fclose(file_stack -> fp);
  free(file_stack -> name);
  file_stack_length --;
  memmove(file_stack, file_stack + 1, file_stack_length * sizeof(struct file_stack_entry));
  if (file_stack_length) {
    file_stack = realloc(file_stack, sizeof(struct file_stack_entry) * file_stack_length);
    current_file = file_stack -> name;
    current_line = file_stack -> line;
  } else {
    free(file_stack);
    file_stack = NULL;
    current_file = NULL;
    current_line = 0;
  }
}

void write_data_to_file (FILE * fp, const char * data, unsigned length) {
  unsigned rv;
  while (length) {
    rv = fwrite(data, 1, (length > 65536) ? 65536 : length, fp);
    if (!rv) error_exit(1, "could not write output data");
    data += rv;
    length -= rv;
  }
}

void process_input_line (const char * line) {
  if (!*line) return;
  char * pos;
  char * copy;
  if (!strchr("\t ", *line)) {
    pos = strchr(line, ':');
    if (pos) {
      copy = malloc(pos - line + 1);
      memcpy(copy, line, pos - line);
      copy[pos - line] = 0;
      line = pos + 1;
    } else {
      copy = duplicate_string(line);
      line = NULL;
    }
    declare_label(copy);
    free(copy);
    if (!(line && *line)) return;
  }
  char ** components = extract_components_from_line(line);
  if (!components) return;
  struct command * command = find_command(*components);
  if (!command) error_exit(1, "unknown command: %s", *components);
  command -> parser(command -> argument, components + 1);
  destroy_component_array(components);
}

void declare_label (const char * label) {
  int valid;
  if (*label == '.')
    valid = validate_label(label + 1);
  else {
    flush_locals();
    valid = validate_label(label);
  }
  if (!valid) error_exit(1, "invalid label: %s", label);
  if (find_symbol(label)) error_exit(1, "label '%s' already exists", label);
  if (find_definition(label)) error_exit(1, "label '%s' overrides a define statement", label);
  create_symbol(label, script_data -> length);
}

struct command * find_command (const char * command_name) {
  struct command * result;
  for (result = script_commands; result -> name; result ++) if (!strcmp(result -> name, command_name)) return result;
  return NULL;
}

void flush_locals (void) {
  unsigned pos = 0;
  while (pos < script_data -> symbol_count) {
    if (*(script_data -> symbols[pos] -> name) != '.') {
      pos ++;
      continue;
    }
    resolve(script_data -> symbols[pos]);
    free(script_data -> symbols[pos]);
    script_data -> symbols[pos] = script_data -> symbols[-- script_data -> symbol_count];
    script_data -> symbols = realloc(script_data -> symbols, sizeof(struct symbol *) * script_data -> symbol_count);
  }
  for (pos = 0; pos < script_data -> reference_count; pos ++) if (*(script_data -> references[pos] -> name) == '.')
    error_exit(1, "encountered new global label before local '%s' was resolved", script_data -> references[pos] -> name);
}

void flush_all_symbols (void) {
  unsigned pos;
  for (pos = 0; pos < script_data -> symbol_count; pos ++) {
    resolve(script_data -> symbols[pos]);
    free(script_data -> symbols[pos]);
  }
  free(script_data -> symbols);
  script_data -> symbols = NULL;
  script_data -> symbol_count = 0;
  if (script_data -> reference_count) error_exit(1, "unresolved label: %s", (**(script_data -> references)).name);
  free(script_data -> references);
  script_data -> references = NULL;
}

int validate_label (const char * label) {
  return (*label) && (strspn(label, VALID_ID_CHARACTERS) == strlen(label)) && strchr(LETTERS_OR_UNDERSCORE, *label);
}

struct argument * get_argument (const char * string) {
  struct argument * result;
  if (*string == '#') {
    result = get_argument(string + 1);
    if (result -> kind) error_exit(1, "invalid variable argument: %s", string);
    if (result -> value > 255) error_exit(1, "invalid variable number: %u", result -> value);
    result -> kind = 1;
    return result;
  }
  if (strchr(NUMERIC_CHARACTERS, *string)) {
    result = malloc(sizeof(struct argument));
    result -> kind = 0;
    result -> value = convert_string_to_number(string);
    return result;
  }
  struct symbol * definition = find_definition(string);
  if (definition) {
    result = malloc(sizeof(struct argument));
    result -> kind = 0;
    result -> value = definition -> value;
    return result;
  }
  if (!(validate_label(string) || ((*string == '.') && validate_label(string + 1)))) error_exit(1, "invalid label identifier: %s", string);
  result = malloc(sizeof(struct argument) + strlen(string) + 1);
  result -> kind = 2;
  strcpy(result -> reference, string);
  return result;
}

char * get_string_argument (const char * argument) {
  if (*argument != '"') error_exit(1, "unquoted string");
  char * result = duplicate_string(argument + 1);
  unsigned length = strlen(result) - 1;
  if (result[length] != '"') error_exit(1, "unquoted string");
  result[length] = 0;
  char * pos = result;
  while ((pos = strstr(pos, "\"\""))) {
    pos ++;
    memmove(pos, pos + 1, strlen(pos));
  }
  result = realloc(result, strlen(result) + 1);
  return result;
}

void no_arguments_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 0, 0, arguments);
}

void one_argument_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 0, 1, arguments);
}

void two_arguments_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 0, 2, arguments);
}

void one_variable_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 1, 0, arguments);
}

void one_variable_one_argument_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 1, 1, arguments);
}

void one_variable_two_arguments_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 1, 2, arguments);
}

void two_variables_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 2, 0, arguments);
}

void two_variables_two_arguments_command (int opcode_byte, char ** arguments) {
  standard_command(opcode_byte, 2, 2, arguments);
}

void one_byte_argument_command (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 1) error_exit(1, "command expects 1 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*arguments);
  if (argument -> kind == 2) error_exit(1, "cannot use a reference as a byte-sized argument");
  char buffer[2];
  *buffer = opcode_byte + argument -> kind;
  buffer[1] = argument -> value;
  free(argument);
  append_data_to_script(buffer, 2);
}

void one_halfword_argument_command (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 1) error_exit(1, "command expects 1 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*arguments);
  if (argument -> kind == 2) error_exit(1, "cannot use a reference as a halfword-sized argument");
  char buffer[3];
  *buffer = opcode_byte + argument -> kind;
  if (argument -> kind) {
    buffer[1] = argument -> value;
    append_data_to_script(buffer, 2);
  } else {
    write_halfword_to_buffer(buffer + 1, argument -> value);
    append_data_to_script(buffer, 3);
  }
  free(argument);
}

void calculation_command (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 2) {
    standard_command(opcode_byte, 1, 2, arguments);
    return;
  }
  struct argument * argument = get_argument(*arguments);
  if (argument -> kind != 1) error_exit(1, "argument must be a variable");
  char buffer[7];
  *buffer = opcode_byte + 2;
  buffer[1] = buffer[2] = argument -> value;
  free(argument);
  argument = get_argument(arguments[1]);
  switch (argument -> kind) {
    case 0:
      write_word_to_buffer(buffer + 3, argument -> value);
      append_data_to_script(buffer, 7);
      break;
    case 1:
      buffer[3] = argument -> value;
      (*buffer) ++;
      append_data_to_script(buffer, 4);
      break;
    case 2:
      memset(buffer + 3, 0, 4);
      create_reference(argument -> reference, script_data -> length + 3);
      append_data_to_script(buffer, 7);
  }
  free(argument);
}

void bit_shift_command (int bit_shift_type, char ** arguments) {
  unsigned char shorthand;
  switch (count_parameters(arguments)) {
    case 2:
      shorthand = 1;
      break;
    case 3:
      shorthand = 0;
      break;
    default:
      error_exit(1, "command expects 3 argument(s), got %u", count_parameters(arguments));
  }
  struct argument * argument = get_argument(*arguments);
  if (argument -> kind != 1) error_exit(1, "argument must be a variable");
  unsigned char variable = argument -> value;
  free(argument);
  unsigned char shift_type, shift_count;
  argument = get_argument(arguments[shorthand ? 1 : 2]);
  if (argument -> kind == 2) error_exit(1, "cannot use a reference as a shift count");
  if ((!argument -> kind) && (argument -> value > 31) && (argument -> value < -31u)) error_exit(1, "shift count must be between -31 and 31");
  shift_type = argument -> kind;
  shift_count = argument -> value;
  free(argument);
  if (!shift_type) shift_count &= 31;
  argument = shorthand ? NULL : get_argument(arguments[1]);
  unsigned char buffer[8];
  unsigned char buffer_length;
  if (!(shift_type || shift_count)) {
    *buffer = SET_OPCODE;
    if (shorthand || (argument -> kind == 1)) (*buffer) ++;
    buffer_length = 1;
  } else {
    *buffer = SHIFT_OPCODE;
    bit_shift_type &= 3;
    buffer[1] = (shift_type ? 0 : shift_count) | (bit_shift_type << 5);
    if (shorthand || (argument -> kind == 1)) buffer[1] |= 0x80;
    buffer_length = 2;
  }
  buffer[buffer_length ++] = variable;
  if (shorthand)
    buffer[buffer_length ++] = variable;
  else
    switch (argument -> kind) {
      case 0:
        write_word_to_buffer(buffer + buffer_length, argument -> value);
        buffer_length += 4;
        break;
      case 1:
        buffer[buffer_length ++] = argument -> value;
        break;
      case 2:
        create_reference(argument -> reference, script_data -> length + buffer_length);
        memset(buffer + buffer_length, 0, 4);
        buffer_length += 4;
    }
  free(argument);
  if (shift_type) buffer[buffer_length ++] = shift_count;
  append_data_to_script((char *) buffer, buffer_length);
}

void one_argument_one_byte_argument (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 2) error_exit(1, "command expects 2 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*arguments);
  char buffer[6];
  char * current = buffer + 1;
  switch (argument -> kind) {
    case 0:
      write_word_to_buffer(current, argument -> value);
      current += 4;
      break;
    case 1:
      *(current ++) = argument -> value;
      opcode_byte += 2;
      break;
    case 2:
      create_reference(argument -> reference, script_data -> length + 1);
      memset(buffer, 0, 4);
      current += 4;
  }
  free(argument);
  argument = get_argument(arguments[1]);
  if (argument -> kind == 2) error_exit(1, "cannot use a reference as a byte-sized argument");
  opcode_byte += argument -> kind;
  *(current ++) = argument -> value;
  free(argument);
  *buffer = opcode_byte;
  append_data_to_script(buffer, current - buffer);
}

void one_argument_one_halfword_argument (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 2) error_exit(1, "command expects 2 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*arguments);
  char buffer[7];
  char * current = buffer + 1;
  switch (argument -> kind) {
    case 0:
      write_word_to_buffer(current, argument -> value);
      current += 4;
      break;
    case 1:
      *(current ++) = argument -> value;
      opcode_byte += 2;
      break;
    case 2:
      create_reference(argument -> reference, script_data -> length + 1);
      memset(buffer, 0, 4);
      current += 4;
  }
  free(argument);
  argument = get_argument(arguments[1]);
  if (argument -> kind == 2) error_exit(1, "cannot use a reference as a halfword-sized argument");
  opcode_byte += argument -> kind;
  if (argument -> kind)
    *(current ++) = argument -> value;
  else {
    write_halfword_to_buffer(current, argument -> value);
    current += 2;
  }
  free(argument);
  *buffer = opcode_byte;
  append_data_to_script(buffer, current - buffer);
}

void mulacum_command (int opcode_byte, char ** arguments) {
  if (count_parameters(arguments) != 3) error_exit(1, "command expects 3 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*(arguments ++));
  char buffer[11];
  char * current = buffer + 3;
  unsigned char arg_number = 2;
  *buffer = opcode_byte;
  if (argument -> kind != 1) error_exit(1, "argument must be a variable");
  buffer[1] = buffer[2] = argument -> value;
  free(argument);
  while (arg_number --) {
    argument = get_argument(*(arguments ++));
    switch (argument -> kind) {
      case 0:
        write_word_to_buffer(current, argument -> value);
        current += 4;
        break;
      case 1:
        *(current ++) = argument -> value;
        *buffer |= 1 << arg_number;
        break;
      case 2:
        create_reference(argument -> reference, script_data -> length + (current - buffer));
        memset(current, 0, 4);
        current += 4;
    }
    free(argument);
  }
  append_data_to_script(buffer, current - buffer);
}

void standard_command (unsigned char opcode_byte, unsigned char expected_variable_count, unsigned char expected_argument_count, char ** arguments) {
  unsigned temp = count_parameters(arguments);
  if (temp != (expected_variable_count + expected_argument_count))
    error_exit(1, "command expects %hhu argument(s), got %u", expected_variable_count + expected_argument_count, temp);
  unsigned char * buffer = calloc(1, 1 + expected_variable_count + 4 * expected_argument_count);
  unsigned char * current = buffer + 1;
  struct argument * argument;
  while (expected_variable_count --) {
    argument = get_argument(*(arguments ++));
    if (argument -> kind != 1) error_exit(1, "argument must be a variable");
    *(current ++) = argument -> value;
    free(argument);
  }
  while (expected_argument_count --) {
    argument = get_argument(*(arguments ++));
    switch (argument -> kind) {
      case 0:
        write_word_to_buffer(current, argument -> value);
        current += 4;
        break;
      case 1:
        *(current ++) = argument -> value;
        opcode_byte |= 1 << expected_argument_count;
        break;
      case 2:
        create_reference(argument -> reference, script_data -> length + (current - buffer));
        current += 4;
    }
    free(argument);
  }
  *buffer = opcode_byte;
  append_data_to_script((char *) buffer, current - buffer);
  free(buffer);
}

void data_command (int width, char ** arguments) {
  struct argument * argument;
  char buffer[4];
  char * string;
  unsigned length;
  for (; *arguments; arguments ++) {
    if (**arguments == '"') {
      string = get_string_argument(*arguments);
      memset(buffer, 0, 4);
      length = strlen(string);
      append_data_to_script(string, length);
      free(string);
      if (length % width) append_data_to_script(buffer, width - (length % width));
      continue;
    }
    argument = get_argument(*arguments);
    switch (argument -> kind) {
      case 0:
        write_word_to_buffer(buffer, argument -> value);
        append_data_to_script(buffer, width);
        break;
      case 1:
        error_exit(1, "variables are not allowed in data commands");
        // fallthrough
      case 2:
        if (width != 4) error_exit(1, "references are not allowed in data commands narrower than 32 bits");
        memset(buffer, 0, 4);
        create_reference(argument -> reference, script_data -> length);
        append_data_to_script(buffer, 4);
    }
    free(argument);
  }
}

void hexdata_command (__attribute__((unused)) int _, char ** arguments) {
  char * buffer;
  unsigned argument_number, length, pos;
  for (argument_number = 0; arguments[argument_number]; argument_number ++) {
    if (strspn(arguments[argument_number], "0123456789abcdefABCDEF") != strlen(arguments[argument_number]))
      error_exit(1, "argument %u to hexdata is not a valid hex string", argument_number + 1);
    length = (strlen(arguments[argument_number]) + 1) >> 1;
    buffer = malloc(length);
    for (pos = 0; pos < length; pos ++)
      buffer[pos] = (get_hex_digit(arguments[argument_number][pos << 1]) << 4) | get_hex_digit(arguments[argument_number][(pos << 1) + 1]);
    append_data_to_script(buffer, length);
    free(buffer);
  }
}

void define_command (__attribute__((unused)) int _, char ** arguments) {
  if (count_parameters(arguments) != 2) error_exit(1, "command expects 2 argument(s), got %u", count_parameters(arguments));
  if (!validate_label(*arguments)) error_exit(1, "'%s' is not a valid symbol name", *arguments);
  struct argument * argument = get_argument(arguments[1]);
  if (argument -> kind) error_exit(1, "the second argument to define must be a number (got: %s)", arguments[1]);
  unsigned value = argument -> value;
  free(argument);
  struct symbol * definition = find_definition(*arguments);
  if (definition)
    definition -> value = value;
  else
    create_definition(*arguments, value);
}

void include_command (int is_binary, char ** arguments) {
  if (count_parameters(arguments) != 1) error_exit(1, "command expects 1 argument(s), got %u", count_parameters(arguments));
  char * filename = get_string_argument(*arguments);
  if (is_binary)
    append_binary_file_to_script(filename);
  else
    push_file(filename);
  free(filename);
}

void string_command (__attribute__((unused)) int _, char ** arguments) {
  char * string;
  for (; *arguments; arguments ++) {
    string = get_string_argument(*arguments);
    append_data_to_script(string, strlen(string) + 1);
    free(string);
  }
}

void align_command (__attribute__((unused)) int _, char ** arguments) {
  if (count_parameters(arguments) != 1) error_exit(1, "command expects 1 argument(s), got %u", count_parameters(arguments));
  struct argument * argument = get_argument(*arguments);
  if (argument -> kind || !(argument -> value)) error_exit(1, "the argument to align must be a non-zero number (got: %s)", *arguments);
  unsigned alignment = argument -> value;
  free(argument);
  if (!(script_data -> length % alignment)) return;
  alignment -= script_data -> length % alignment;
  void * padding = calloc(alignment, 1);
  append_data_to_script(padding, alignment);
  free(padding);
}
