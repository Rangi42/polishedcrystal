function BSPPatcher (bsp, input) {
  "use strict";

  var self = this;

  function ResizableMemoryBlock (initial_size = 0) {
    var self = this;

    var current_size;
    var parts = [];

    for (current_size = 0; current_size < initial_size; current_size += 8192) parts[current_size >>> 13] = new DataView(new ArrayBuffer(8192));
    current_size = initial_size;

    self.size = function () {
      return current_size;
    };

    function shrink (size) {
      var new_parts = (size + 8191) >>> 13;
      var old_offset = current_size & 8191, new_offset = size & 8191;
      if (old_offset === 0) old_offset = 8192;
      if (new_offset === 0) new_offset = 8192;
      if (new_parts != parts.length) {
        while (parts.length > new_parts) parts.pop();
        old_offset = 8192;
      }
      var offset, part = parts.length - 1;
      for (offset = new_offset; offset < old_offset; offset ++) parts[part].setUint8(offset, 0);
      current_size = size;
    }

    function expand (size) {
      var new_parts = (size + 8191) >>> 13;
      while (parts.length < new_parts) parts.push(new DataView(new ArrayBuffer(8192)));
      current_size = size;
    }

    self.resize = function (size) {
      if (size == current_size) return;
      if (size > current_size) return expand(size);
      return shrink(size);
    };

    function break_into_bytes (value, size) {
      var bytes = [];
      while (bytes.length < size) {
        bytes.push(value & 0xff);
        value >>>= 8;
      }
      return bytes;
    }

    self.set_byte = function (position, value) {
      if (position >= current_size) expand(position + 1);
      parts[position >>> 13].setUint8(position & 8191, value & 0xff);
    };

    self.set_halfword = function (position, value) {
      if (position > (current_size - 2)) expand(position + 2);
      var offset = position & 8191, part = position >>> 13;
      value &= 0xffff;
      if (offset <= 8190) return parts[part].setUint16(offset, value, true);
      var bytes = break_into_bytes(value, 2);
      while (bytes.length > 0) {
        parts[part].setUint8(offset ++, bytes.shift());
        if (offset == 8192) {
          part ++;
          offset = 0;
        }
      }
    };

    self.set_word = function (position, value) {
      if (position > (current_size - 4)) expand(position + 4);
      var offset = position & 8191, part = position >>> 13;
      value >>>= 0;
      if (offset <= 8188) return parts[part].setUint32(offset, value, true);
      var bytes = break_into_bytes(value, 4);
      while (bytes.length > 0) {
        parts[part].setUint8(offset ++, bytes.shift());
        if (offset == 8192) {
          part ++;
          offset = 0;
        }
      }
    };

    function gather_bytes (bytes) {
      var result = 0;
      while (bytes.length) result = ((result << 8) >>> 0) + bytes.pop();
      return result;
    }

    self.get_byte = function (position) {
      if (position >= current_size) throw "attempted to read past the end of the buffer";
      return parts[position >>> 13].getUint8(position & 8191);
    };

    self.get_halfword = function (position) {
      if (position > (current_size - 2)) throw "attempted to read past the end of the buffer";
      var offset = position & 8191, part = position >>> 13;
      if (offset <= 8190) return parts[part].getUint16(offset, true);
      var bytes = [];
      var count;
      for (count = 0; count < 2; count ++) {
        bytes.push(parts[part].getUint8(offset ++));
        if (offset == 8192) {
          offset = 0;
          part ++;
        }
      }
      return gather_bytes(bytes);
    };

    self.get_word = function (position) {
      if (position > (current_size - 4)) throw "attempted to read past the end of the buffer";
      var offset = position & 8191, part = position >>> 13;
      if (offset <= 8188) return parts[part].getUint32(offset, true);
      var bytes = [];
      var count;
      for (count = 0; count < 4; count ++) {
        bytes.push(parts[part].getUint8(offset ++));
        if (offset == 8192) {
          offset = 0;
          part ++;
        }
      }
      return gather_bytes(bytes);
    };

    self.generate_array_buffer = function () {
      var result = new ArrayBuffer(current_size);
      var view = new Uint8Array(result);
      var part_count = current_size >>> 13, extra_offset = current_size & 8191;
      var pos;
      for (pos = 0; pos < part_count; pos ++) view.set(new Uint8Array(parts[pos].buffer), (pos << 13) >>> 0);
      for (pos = 0; pos < extra_offset; pos ++) view[pos + ((part_count << 13) >>> 0)] = parts[part_count].getUint8(pos);
      return result;
    };

    self.calculate_sha1 = function () {
      function rotate (value, count) {
        return ((value << count) | (value >>> (32 - count))) >>> 0;
      }

      function mixing_function (counter, first, second, third) {
        if (counter < 20)
          return ((first & second) | (~first & third)) >>> 0;
        else if ((counter >= 40) && (counter < 60))
          return ((first & second) | (first & third) | (second & third)) >>> 0;
        else
          return (first ^ second ^ third) >>> 0;
      }

      function hash_constant (counter) {
        // constants used by SHA-1; they are actually simply the square roots of 2, 3, 5 and 10 as a fixed-point number (2.30 format)
        return ([0x5a827999, 0x6ed9eba1, 0x8f1bbcdc, 0xca62c1d6])[(counter / 20) >>> 0];
      }

      function process_block (state, block) {
        var words = new Uint32Array(80);
        var pos;
        for (pos = 0; pos < 16; pos ++) words[pos] = block.getUint32(pos << 2);
        for (; pos < 80; pos ++) words[pos] = rotate((words[pos - 3] ^ words[pos - 8] ^ words[pos - 14] ^ words[pos - 16]) >>> 0, 1);
        var temp, a = state[0], b = state[1], c = state[2], d = state[3], e = state[4];
        for (pos = 0; pos < 80; pos ++) {
          temp = (rotate(a, 5) + mixing_function(pos, b, c, d) + e + words[pos] + hash_constant(pos)) >>> 0;
          e = d;
          d = c;
          c = rotate(b, 30);
          b = a;
          a = temp;
        }
        return [(state[0] + a) >>> 0, (state[1] + b) >>> 0, (state[2] + c) >>> 0, (state[3] + d) >>> 0, (state[4] + e) >>> 0];
      }

      var state = [0x67452301, 0xefcdab89, 0x98badcfe, 0x10325476, 0xc3d2e1f0];
      var pos, buf;
      for (pos = 0; pos < ((current_size & 0xffffffc0) >>> 0); pos += 64)
        state = process_block(state, new DataView(parts[pos >>> 13].buffer.slice(pos & 8191, (pos & 8191) + 64)));
      buf = new DataView(new ArrayBuffer(64));
      for (; pos < current_size; pos ++) buf.setUint8(pos & 63, parts[pos >>> 13].getUint8(pos & 8191));
      buf.setUint8(pos & 63, 0x80);
      if ((pos & 63) >= 56) {
        state = process_block(state, buf);
        buf = new DataView(new ArrayBuffer(64));
      }
      buf.setUint8(59, current_size >>> 29);
      buf.setUint32(60, (current_size << 3) >>> 0);
      state = process_block(state, buf);
      buf = new Uint8Array(20);
      for (pos = 0; pos < 20; pos ++) buf[pos] = (state[pos >> 2] >>> ((3 - (pos & 3)) << 3)) & 0xff;
      return buf;
    };
  }

  self.success = undefined;
  self.failure = undefined;
  self.error = undefined;
  self.print = undefined;
  self.menu = undefined;

  var initialized = false;
  var done = false;
  var exit_status;
  var output;

  var file_buffer;
  var current_file_pointer;
  var current_file_pointer_locked;
  var frames;
  var selection_range_check;
  var dirty;
  var sha1;

  function get_byte (pos) {
    if (pos >= frames[0].patch_space.byteLength) throw "attempted to read past the end of the patch space";
    return frames[0].patch_space.getUint8(pos);
  }

  function get_halfword (pos) {
    if ((pos + 2) > frames[0].patch_space.byteLength) throw "attempted to read past the end of the patch space";
    return frames[0].patch_space.getUint16(pos, true);
  }

  function get_word (pos) {
    if ((pos + 4) > frames[0].patch_space.byteLength) throw "attempted to read past the end of the patch space";
    return frames[0].patch_space.getUint32(pos, true);
  }

  function next_patch_byte () {
    if (frames[0].patch_space.byteLength < (frames[0].instruction_pointer + 1)) throw "attempted to read past the end of the patch space";
    return frames[0].patch_space.getUint8(frames[0].instruction_pointer ++);
  }

  function next_patch_halfword () {
    if (frames[0].patch_space.byteLength < (frames[0].instruction_pointer + 2)) throw "attempted to read past the end of the patch space";
    var result = frames[0].patch_space.getUint16(frames[0].instruction_pointer, true);
    frames[0].instruction_pointer += 2;
    return result;
  }

  function next_patch_word () {
    if (frames[0].patch_space.byteLength < (frames[0].instruction_pointer + 4)) throw "attempted to read past the end of the patch space";
    var result = frames[0].patch_space.getUint32(frames[0].instruction_pointer, true);
    frames[0].instruction_pointer += 4;
    return result;
  }

  function next_patch_variable () {
    return get_variable(next_patch_byte());
  }
  
  function update_current_file_pointer (value) {
    if (current_file_pointer_locked) return;
    current_file_pointer = value >>> 0;
  }

  function read_byte (increment_file_pointer) {
    if (current_file_pointer >= file_buffer.size()) throw "attempted to read past the end of the file buffer";
    var result = file_buffer.get_byte(current_file_pointer);
    if (increment_file_pointer) update_current_file_pointer(current_file_pointer + 1);
    return result;
  }

  function read_halfword (increment_file_pointer) {
    if ((current_file_pointer + 2) > file_buffer.size()) throw "attempted to read past the end of the file buffer";
    var result = file_buffer.get_halfword(current_file_pointer);
    if (increment_file_pointer) update_current_file_pointer(current_file_pointer + 2);
    return result;
  }

  function read_word (increment_file_pointer) {
    if ((current_file_pointer + 4) > file_buffer.size()) throw "attempted to read past the end of the file buffer";
    var result = file_buffer.get_word(current_file_pointer);
    if (increment_file_pointer) update_current_file_pointer(current_file_pointer + 4);
    return result;
  }

  function write_byte (value) {
    if (current_file_pointer > 0xfffffffe) throw "current file pointer overflow";
    file_buffer.set_byte(current_file_pointer, value);
    dirty = true;
    update_current_file_pointer(current_file_pointer + 1);
  }

  function write_halfword (value) {
    if (current_file_pointer > 0xfffffffd) throw "current file pointer overflow";
    file_buffer.set_halfword(current_file_pointer, value);
    dirty = true;
    update_current_file_pointer(current_file_pointer + 2);
  }

  function write_word (value) {
    if (current_file_pointer > 0xfffffffb) throw "current file pointer overflow";
    file_buffer.set_word(current_file_pointer, value);
    dirty = true;
    update_current_file_pointer(current_file_pointer + 4);
  }

  function truncate (value) {
    if (value > 0xffffffff) throw "file buffer size overflow";
    if (value < 0) throw "file buffer size underflow";
    file_buffer.resize(value);
    dirty = true;
  }
  
  function utf8_decode (address) {
    var codepoints = [];
    var current_codepoint, remaining, next, peek;
    while ((next = get_byte(address ++)) !== 0) {
      if (remaining > 0) {
        if ((next < 0x80) || (next > 0xbf)) throw "invalid UTF-8 string";
        current_codepoint |= (next & 0x3f) << (6 * (-- remaining));
        if (remaining === 0) codepoints.push(current_codepoint);
        continue;
      }
      if (next < 0x80) {
        codepoints.push(next);
        continue;
      }
      if ((next < 0xc2) || (next > 0xf4)) throw "invalid UTF-8 string";
      peek = get_byte(address);
      if (
        ((next == 0xe0) && (peek < 0xa0)) ||
        ((next == 0xed) && (peek >= 0xa0)) ||
        ((next == 0xf0) && (peek < 0x90)) ||
        ((next == 0xf4) && (peek >= 0x90))
      ) throw "invalid UTF-8 string";
      if (next < 0xe0) {
        remaining = 1;
        current_codepoint = (next & 0x1f) << 6;
      } else if (next < 0xf0) {
        remaining = 2;
        current_codepoint = (next & 0x0f) << 12;
      } else {
        remaining = 3;
        current_codepoint = (next & 7) << 18;
      }
    }
    if (remaining > 0) throw "invalid UTF-8 string";
    var result = "";
    for (current_codepoint = 0; current_codepoint < codepoints.length; current_codepoint ++) {
      if (codepoints[current_codepoint] < 0x10000) {
        result += String.fromCharCode(codepoints[current_codepoint]);
        continue;
      }
      result += String.fromCharCode(0xd800 | ((codepoints[current_codepoint] - 0x10000) >> 10));
      result += String.fromCharCode(0xdc00 | (codepoints[current_codepoint] & 0x3ff));
    }
    return result;
  }
  
  function update_hashes () {
    if (!dirty) return;
    sha1 = file_buffer.calculate_sha1();
    dirty = false;
  }
  
  function write_data (position, address, len) {
    if (len === 0) return;
    while (len --) file_buffer.set_byte(position ++, get_byte(address ++));
    dirty = true;
  }
  
  function xor_data (position, address, len) {
    if (len === 0) return;
    var value;
    while (len --) {
      value = (get_byte(address ++) ^ file_buffer.get_byte(position)) & 0xff;
      file_buffer.set_byte(position ++, value);
    }
    dirty = true;
  }
  
  function calculate_real_stack_position (position) {
    if (position >= 0x80000000) position = frames[0].stack.length + (position - 0x100000000);
    if ((position < 0) || (position >= frames[0].stack.length)) throw "invalid stack position";
    return position;
  }
  
  function array_repeat (value, count) {
    var pos, array = [];
    for (pos = 31; pos >= 0; pos --) {
      array = array.concat(array);
      if ((count >> pos) & 1) array.push(value);
    }
    return array;
  }
  
  function resize_stack (size) {
    if (size < frames[0].stack.length) {
      frames[0].stack.splice(0, frames[0].stack.length - size);
      return;
    }
    while (frames[0].stack.length < size) push_to_stack(0);
  }

  function opcode_parameters (opcode) {
    switch (opcode) {
      case 0x00: case 0x01: case 0x80: case 0x81: case 0x82: case 0x92: case 0x93: case 0xa6: case 0xa7:
        return [];
      case 0x02: case 0x04: case 0x06: case 0x08: case 0x1c: case 0x1e: case 0x60: case 0x62: case 0x64: case 0x66: case 0x68: case 0x8e:
      case 0xa0: case 0xa2: case 0xa4: case 0xa8:
        return [next_patch_word];
      case 0x03: case 0x05: case 0x07: case 0x09: case 0x19: case 0x1b: case 0x1d: case 0x1f: case 0x61: case 0x63: case 0x65: case 0x67:
      case 0x69: case 0x83: case 0x8f: case 0x90: case 0x91: case 0xa1: case 0xa3: case 0xa5: case 0xa9:
        return [next_patch_variable];
      case 0x10: case 0x12: case 0x14: case 0x16: case 0x6a: case 0x84: case 0x86: case 0x8c:
        return [next_patch_byte, next_patch_word];
      case 0x11: case 0x13: case 0x15: case 0x17: case 0x6b: case 0x85: case 0x87: case 0x8d: case 0xaf:
        return [next_patch_byte, next_patch_variable];
      case 0x0a: case 0x0b: case 0x0c: case 0x0d: case 0x0e: case 0x0f: case 0x18: case 0x9b: case 0x9f: case 0xaa: case 0xac: case 0xad:
      case 0xae:
        return [next_patch_byte];
      case 0x1a:
        return [next_patch_halfword];
      case 0x20: case 0x24: case 0x28: case 0x2c: case 0x30: case 0x34: case 0x38: case 0x3c: case 0x94:
        return [next_patch_byte, next_patch_word, next_patch_word];
      case 0x21: case 0x25: case 0x29: case 0x2d: case 0x31: case 0x35: case 0x39: case 0x3d: case 0x95:
        return [next_patch_byte, next_patch_word, next_patch_variable];
      case 0x22: case 0x26: case 0x2a: case 0x2e: case 0x32: case 0x36: case 0x3a: case 0x3e: case 0x96:
        return [next_patch_byte, next_patch_variable, next_patch_word];
      case 0x23: case 0x27: case 0x2b: case 0x2f: case 0x33: case 0x37: case 0x3b: case 0x3f: case 0x97:
        return [next_patch_byte, next_patch_variable, next_patch_variable];
      case 0x40: case 0x44: case 0x48: case 0x4c: case 0x50: case 0x54:
        return [next_patch_variable, next_patch_word, next_patch_word];
      case 0x41: case 0x45: case 0x49: case 0x4d: case 0x51: case 0x55:
        return [next_patch_variable, next_patch_word, next_patch_variable];
      case 0x42: case 0x46: case 0x4a: case 0x4e: case 0x52: case 0x56:
        return [next_patch_variable, next_patch_variable, next_patch_word];
      case 0x43: case 0x47: case 0x4b: case 0x4f: case 0x53: case 0x57:
        return [next_patch_variable, next_patch_variable, next_patch_variable];
      case 0x58: case 0x5a: case 0x5c: case 0x5e: case 0x6e: case 0x7a: case 0x7e: case 0x8a:
        return [next_patch_variable, next_patch_word];
      case 0x59: case 0x5b: case 0x5d: case 0x5f: case 0x6f: case 0x73: case 0x77: case 0x7b: case 0x7f: case 0x8b:
        return [next_patch_variable, next_patch_variable];
      case 0x6c: case 0x78: case 0x7c: case 0x88:
        return [next_patch_word, next_patch_word];
      case 0x6d: case 0x71: case 0x75: case 0x79: case 0x7d: case 0x89:
        return [next_patch_word, next_patch_variable];
      case 0x70:
        return [next_patch_word, next_patch_byte];
      case 0x72:
        return [next_patch_variable, next_patch_byte];
      case 0x74:
        return [next_patch_word, next_patch_halfword];
      case 0x76:
        return [next_patch_variable, next_patch_halfword];
      case 0x98: case 0x99: case 0x9a: case 0x9c: case 0x9d: case 0x9e: case 0xab:
        return [next_patch_byte, next_patch_byte];
      case 0xb0: case 0xb4: case 0xb8: case 0xbc:
        return [next_patch_byte, next_patch_byte, next_patch_word, next_patch_word];
      case 0xb1: case 0xb5: case 0xb9: case 0xbd:
        return [next_patch_byte, next_patch_byte, next_patch_word, next_patch_variable];
      case 0xb2: case 0xb6: case 0xba: case 0xbe:
        return [next_patch_byte, next_patch_byte, next_patch_variable, next_patch_word];
      case 0xb3: case 0xb7: case 0xbb: case 0xbf:
        return [next_patch_byte, next_patch_byte, next_patch_variable, next_patch_variable];
      default:
        throw "undefined opcode";
    }
  }

  function return_opcode () {
    if (frames[0].stack.length < 1) return 0;
    frames[0].instruction_pointer = pop_from_stack();
    return true;
  }

  function jump_opcode (target) {
    frames[0].instruction_pointer = target;
    return true;
  }

  function call_opcode (target) {
    push_to_stack(frames[0].instruction_pointer);
    return jump_opcode(target);
  }

  function exit_opcode (value) {
    return value;
  }

  function push_opcode (value) {
    push_to_stack(value);
    return true;
  }

  function pop_opcode (variable) {
    set_variable(variable, pop_from_stack());
    return true;
  }

  function length_opcode (variable) {
    set_variable(variable, file_buffer.size());
    return true;
  }

  function readbyte_opcode (variable) {
    set_variable(variable, read_byte(true));
    return true;
  }

  function readhalfword_opcode (variable) {
    set_variable(variable, read_halfword(true));
    return true;
  }

  function readword_opcode (variable) {
    set_variable(variable, read_word(true));
    return true;
  }

  function pos_opcode (variable) {
    set_variable(variable, current_file_pointer);
    return true;
  }

  function getbyte_opcode (variable, address) {
    set_variable(variable, get_byte(address));
    return true;
  }

  function gethalfword_opcode (variable, address) {
    set_variable(variable, get_halfword(address));
    return true;
  }

  function getword_opcode (variable, address) {
    set_variable(variable, get_word(address));
    return true;
  }

  function checksha1_opcode (variable, address) {
    update_hashes();
    var pos, result = 0;
    for (pos = 0; pos < 20; pos ++) if (get_byte(address + pos) != sha1[pos]) result |= 1 << pos;
    set_variable(variable, result);
    return true;
  }

  function writebyte_opcode (value) {
    write_byte(value & 0xff);
    return true;
  }

  function writehalfword_opcode (value) {
    write_halfword(value & 0xffff);
    return true;
  }

  function writeword_opcode (value) {
    write_word(value);
    return true;
  }

  function truncate_opcode (value) {
    truncate(value);
    return true;
  }

  function calculation (op) {
    return function (variable, first, second) {
      var result = eval("first " + op + " second");
      result >>>= 0;
      set_variable(variable, result);
      return true;
    };
  }

  function guarded_calculation (op) {
    return function (variable, first, second) {
      if (second === 0) throw "division by zero";
      var result = eval("first " + op + " second");
      result >>>= 0;
      set_variable(variable, result);
      return true;
    };
  }

  function multiply (first, second) {
    // lots of silliness to ensure 32-bit precision when carrying out the multiplication
    var first_lower = first & 0xffff, first_upper = (first >>> 16) & 0xffff;
    var second_lower = second & 0xffff, second_upper = (second >>> 16) & 0xffff;
    var result_lower = first_lower * second_lower, result_upper = first_lower * second_upper + first_upper * second_lower;
    return (((result_upper << 16) + result_lower) & 0xffffffff) >>> 0;
  }

  function multiply_opcode (variable, first, second) {
    set_variable(variable, multiply(first, second));
    return true;
  }
  
  function conditional_jump_opcode (condition) {
    return function (first, second, address) {
      var check = eval("first " + condition + " second");
      if (!check) return true;
      return jump_opcode(address);
    };
  }
  
  function instruction_if_zero (fn, condition) {
    return function (comparand, address = undefined) {
      if ((comparand === 0) !== condition) return true;
      return fn(address);
    };
  }
  
  function seek_opcode (value) {
    update_current_file_pointer(value);
    return true;
  }
  
  function seekfwd_opcode (value) {
    if (current_file_pointer_locked) return true;
    if ((value + current_file_pointer) > 0xffffffff) throw "current file pointer overflow";
    current_file_pointer += value;
    return true;
  }
  
  function seekback_opcode (value) {
    if (current_file_pointer_locked) return true;
    if (value > current_file_pointer) throw "current file pointer overflow";
    current_file_pointer -= value;
    return true;
  }
  
  function seekend_opcode (value) {
    if (current_file_pointer_locked) return true;
    if (value > file_buffer.size()) throw "current file pointer overflow";
    current_file_pointer = file_buffer.size() - value;
    return true;
  }
  
  function print_opcode (address) {
    if (self.print === undefined) throw "could not display message to user";
    var msg = utf8_decode(address);
    queue_function(function () {self.print(msg);});
    return false;
  }
  
  function menu_opcode (variable, address) {
    var options = [];
    var option;
    while (true) {
      option = get_word(address);
      if (option === 0xffffffff) break;
      options.push(option);
      address += 4;
    }
    if (options.length === 0) {
      set_variable(variable, 0xffffffff);
      return true;
    }
    if (self.menu === undefined) throw "could not display menu to user";
    options = options.map(utf8_decode);
    frames[0].waiting_var = variable;
    selection_range_check = options.length;
    queue_function(function () {self.menu(options);});
    return false;
  }
  
  function xordata_opcode (start, len) {
    if ((current_file_pointer + len) > 0xffffffff) throw "file position overflow";
    if (current_file_pointer >= file_buffer.size()) return writedata_opcode(start, len);
    var bytes_to_end = file_buffer.size() - current_file_pointer;
    if (bytes_to_end >= len)
      xor_data(current_file_pointer, start, len);
    else {
      xor_data(current_file_pointer, start, bytes_to_end);
      write_data(current_file_pointer + bytes_to_end, start + bytes_to_end, len - bytes_to_end);
    }
    if (!current_file_pointer_locked) current_file_pointer += len;
    return true;
  }
  
  function fillbyte_opcode (count, value) {
    if (count === 0) return true;
    var address = current_file_pointer;
    value &= 0xff;
    if ((address + count) > 0xffffffff) throw "file position overflow";
    while (count --) file_buffer.set_byte(address ++, value);
    if (!current_file_pointer_locked) current_file_pointer = address;
    dirty = true;
    return true;
  }
  
  function fillhalfword_opcode (count, value) {
    if (count === 0) return true;
    var address = current_file_pointer;
    value &= 0xffff;
    if ((address + 2 * count) > 0xffffffff) throw "file position overflow";
    while (count --) {
      file_buffer.set_halfword(address, value);
      address += 2;
    }
    if (!current_file_pointer_locked) current_file_pointer = address;
    dirty = true;
    return true;
  }
  
  function fillword_opcode (count, value) {
    if (count === 0) return true;
    var address = current_file_pointer;
    if ((address + 4 * count) > 0xffffffff) throw "file position overflow";
    while (count --) {
      file_buffer.set_word(address, value);
      address += 4;
    }
    if (!current_file_pointer_locked) current_file_pointer = address;
    dirty = true;
    return true;
  }
  
  function writedata_opcode (start, len) {
    if ((current_file_pointer + len) > 0xffffffff) throw "file position overflow";
    write_data(current_file_pointer, start, len);
    if (!current_file_pointer_locked) current_file_pointer += len;
    return true;
  }
  
  function lockpos_opcode () {
    current_file_pointer_locked = true;
    return true;
  }
  
  function unlockpos_opcode () {
    current_file_pointer_locked = false;
    return true;
  }
  
  function truncatepos_opcode () {
    truncate(current_file_pointer);
    return true;
  }
  
  function jumptable_opcode (value) {
    var address = value * 4 + frames[0].instruction_pointer;
    if ((address + 4) > frames[0].patch_space.byteLength) throw "attempted to read past the end of the patch space";
    frames[0].instruction_pointer = get_word(address);
    return true;
  }
  
  function set_opcode (variable, value) {
    set_variable(variable, value);
    return true;
  }
  
  function ipspatch_opcode (variable, address) {
    var current_address = address;

    function get_next_byte () {
      return get_byte(current_address ++);
    }

    function get_next_value (bytes) {
      var result = 0;
      while (bytes > 0) {
        result = (result << 8) | get_next_byte();
        bytes --;
      }
      return result;
    }
    
    var header = [0x50, 0x41, 0x54, 0x43, 0x48];
    while (header.length > 0) if (get_next_byte() !== header.shift()) throw "invalid IPS header";
    var position, count, value;
    while (true) {
      position = get_next_value(3);
      if (position === 0x454f46) break;
      position += current_file_pointer;
      if (position >= 0xffffffff) throw "file position overflow";
      count = get_next_value(2);
      if (count === 0) {
        count = get_next_value(2);
        value = get_next_byte();
        while (count --) file_buffer.set_byte(position ++, value);
      } else
        while (count --) file_buffer.set_byte(position ++, get_next_byte());
    }
    set_variable(variable, current_address);
    dirty = true;
    return true;
  }
  
  function stackwrite_opcode (position, value) {
    frames[0].stack[calculate_real_stack_position(position)] = value;
    return true;
  }
  
  function stackread_opcode (variable, position) {
    set_variable(variable, frames[0].stack[calculate_real_stack_position(position)]);
    return true;
  }
  
  function stackshift_opcode (amount) {
    if (amount >= 0x80000000) amount -= 0x100000000;
    if ((amount + frames[0].stack.length) < 0) throw "stack underflow";
    resize_stack(amount + frames[0].stack.length);
    return true;
  }
  
  function pushpos_opcode () {
    push_to_stack(current_file_pointer);
    return true;
  }
  
  function poppos_opcode () {
    update_current_file_pointer(pop_from_stack());
    return true;
  }
  
  function bsppatch_opcode (variable, start, len) {
    if ((start + len) > frames[0].patch_space.byteLength) throw "attempted to read past the end of the patch space";
    if (len === 0) throw "invalid zero length";
    frames[0].waiting_var = variable;
    var new_frame = create_frame(new DataView(frames[0].patch_space.buffer.slice(start, start + len)));
    frames.unshift(new_frame);
    return true;
  }
  
  function getbyteinc_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address + 1) >>> 0);
    set_variable(value_var, get_byte(address));
    return true;
  }
  
  function gethalfwordinc_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address + 2) >>> 0);
    set_variable(value_var, get_halfword(address));
    return true;
  }
  
  function getwordinc_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address + 4) >>> 0);
    set_variable(value_var, get_word(address));
    return true;
  }
  
  function increment_opcode (variable) {
    set_variable(variable, (get_variable(variable) + 1) >>> 0);
    return true;
  }
  
  function getbytedec_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address - 1) >>> 0);
    set_variable(value_var, get_byte(address));
    return true;
  }
  
  function gethalfworddec_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address - 2) >>> 0);
    set_variable(value_var, get_halfword(address));
    return true;
  }
  
  function getworddec_opcode (value_var, address_var) {
    var address = get_variable(address_var);
    set_variable(address_var, (address - 4) >>> 0);
    set_variable(value_var, get_word(address));
    return true;
  }
  
  function decrement_opcode (variable) {
    set_variable(variable, (get_variable(variable) - 1) >>> 0);
    return true;
  }
  
  function bufstring_opcode (address) {
    frames[0].message_buffer += utf8_decode(address);
    return true;
  }
  
  function bufchar_opcode (character) {
    if ((character > 0x10ffff) || ((character & 0xfffff800) === 0xd800)) throw "invalid Unicode character";
    if (character > 0xffff)
      frames[0].message_buffer += String.fromCharCode(0xd800 | ((character - 0x10000) >>> 10)) + String.fromCharCode(0xdc00 | (character & 0x3ff));
    else if (character > 0)
      frames[0].message_buffer += String.fromCharCode(character);
    return true;
  }
  
  function bufnumber_opcode (value) {
    frames[0].message_buffer += value.toString();
    return true;
  }
  
  function printbuf_opcode () {
    var msg = frames[0].message_buffer;
    frames[0].message_buffer = "";
    queue_function(function () {self.print(msg);});
    return false;
  }
  
  function clearbuf_opcode () {
    frames[0].message_buffer = "";
    return true;
  }
  
  function setstacksize_opcode (size) {
    resize_stack(size);
    return true;
  }
  
  function getstacksize_opcode (variable) {
    var size = frames[0].stack.length;
    if (size > 0xffffffff) size = 0xffffffff;
    set_variable(variable, size);
    return true;
  }
  
  function bit_shifting_opcode (bitflags, variable) {
    var shift_count = bitflags & 31;
    var shift_type = (bitflags >> 5) & 3;
    var value;
    if (bitflags & 0x80)
      value = next_patch_variable();
    else
      value = next_patch_word();
    if (shift_count === 0) shift_count = next_patch_variable() & 31;
    switch (shift_type) {
      case 0: // shiftleft
        value <<= shift_count;
        value >>>= 0;
        break;
      case 1: // shiftright
        value >>>= shift_count;
        break;
      case 2: // rotateleft
        value = (value << shift_count) | (value >>> (32 - shift_count));
        value >>>= 0;
        break;
      case 3: // shiftrightarith
        value >>= shift_count;
        value >>>= 0;
    }
    set_variable(variable, value);
    return true;
  }
  
  function getfilebyte_opcode (variable) {
    set_variable(variable, read_byte(false));
    return true;
  }
  
  function getfilehalfword_opcode (variable) {
    set_variable(variable, read_halfword(false));
    return true;
  }
  
  function getfileword_opcode (variable) {
    set_variable(variable, read_word(false));
    return true;
  }
  
  function getvariable_opcode (variable, num) {
    set_variable(variable, get_variable(num));
    return true;
  }
  
  function addcarry_opcode (variable, carry, first, second) {
    var result = (first + second) >>> 0;
    if (result < first) set_variable(carry, (get_variable(carry) + 1) >>> 0);
    if (variable != carry) set_variable(variable, result);
    return true;
  }
  
  function subborrow_opcode (variable, borrow, first, second) {
    if (first < second) set_variable(borrow, (get_variable(borrow) - 1) >>> 0);
    if (variable != borrow) set_variable(variable, (first - second) >>> 0);
    return true;
  }
  
  function long_multiply (first, second) {
    // ensure 64-bit precision. This is even worse than the 32-bit case
    var first_low = first & 0xffff, first_high = first >>> 16, second_low = second & 0xffff, second_high = second >>> 16;
    var low = first_low * second_low, mid = first_low * second_high + first_high * second_low, high = first_high * second_high;
    if (mid >= 0x100000000) {
      high += 0x10000;
      mid -= 0x100000000;
    }
    var carry = low >>> 16;
    low &= 0xffff;
    mid = (mid + carry) >>> 0;
    if (mid < carry) high += 0x10000;
    high = (high + (mid >>> 16)) >>> 0;
    mid &= 0xffff;
    low = (low | (mid << 16)) >>> 0;
    return {high: high, low: low};
  }
  
  function longmul_opcode (low, high, first, second) {
    var result = long_multiply(first >>> 0, second >>> 0);
    set_variable(high, result.high);
    if (low != high) set_variable(low, result.low);
    return true;
  }
  
  function longmulacum_opcode (low, high, first, second) {
    if (low == high) {
      set_variable(low, (multiply(first, second) + get_variable(low)) >>> 0);
      return true;
    }
    var result = long_multiply(first >>> 0, second >>> 0);
    result.low += get_variable(low);
    if (result.low >= 0x100000000) {
      result.high ++;
      result.low -= 0x100000000;
    }
    result.high += get_variable(high);
    set_variable(low, result.low >>> 0);
    set_variable(high, result.high >>> 0);
    return true;
  }

  function opcode_function (opcode) {
    switch (opcode) {
      case 0x00: return function () {return true;}; // nop
      case 0x01: return return_opcode;
      case 0x02: case 0x03: return jump_opcode;
      case 0x04: case 0x05: return call_opcode;
      case 0x06: case 0x07: return exit_opcode;
      case 0x08: case 0x09: return push_opcode;
      case 0x0a: return pop_opcode;
      case 0x0b: return length_opcode;
      case 0x0c: return readbyte_opcode;
      case 0x0d: return readhalfword_opcode;
      case 0x0e: return readword_opcode;
      case 0x0f: return pos_opcode;
      case 0x10: case 0x11: return getbyte_opcode;
      case 0x12: case 0x13: return gethalfword_opcode;
      case 0x14: case 0x15: return getword_opcode;
      case 0x16: case 0x17: return checksha1_opcode;
      case 0x18: case 0x19: return writebyte_opcode;
      case 0x1a: case 0x1b: return writehalfword_opcode;
      case 0x1c: case 0x1d: return writeword_opcode;
      case 0x1e: case 0x1f: return truncate_opcode;
      case 0x20: case 0x21: case 0x22: case 0x23: return calculation("+"); // add
      case 0x24: case 0x25: case 0x26: case 0x27: return calculation("-"); // subtract
      case 0x28: case 0x29: case 0x2a: case 0x2b: return multiply_opcode;
      case 0x2c: case 0x2d: case 0x2e: case 0x2f: return guarded_calculation("/"); // divide
      case 0x30: case 0x31: case 0x32: case 0x33: return guarded_calculation("%"); // remainder
      case 0x34: case 0x35: case 0x36: case 0x37: return calculation("&"); // and
      case 0x38: case 0x39: case 0x3a: case 0x3b: return calculation("|"); // or
      case 0x3c: case 0x3d: case 0x3e: case 0x3f: return calculation("^"); // xor
      case 0x40: case 0x41: case 0x42: case 0x43: return conditional_jump_opcode("<"); // iflt
      case 0x44: case 0x45: case 0x46: case 0x47: return conditional_jump_opcode("<="); // ifle
      case 0x48: case 0x49: case 0x4a: case 0x4b: return conditional_jump_opcode(">"); // ifgt
      case 0x4c: case 0x4d: case 0x4e: case 0x4f: return conditional_jump_opcode(">="); // ifge
      case 0x50: case 0x51: case 0x52: case 0x53: return conditional_jump_opcode("==="); // ifeq
      case 0x54: case 0x55: case 0x56: case 0x57: return conditional_jump_opcode("!=="); // ifne
      case 0x58: case 0x59: return instruction_if_zero(jump_opcode, true); // jumpz
      case 0x5a: case 0x5b: return instruction_if_zero(jump_opcode, false); // jumpnz
      case 0x5c: case 0x5d: return instruction_if_zero(call_opcode, true); // callz
      case 0x5e: case 0x5f: return instruction_if_zero(call_opcode, false); // callnz
      case 0x60: case 0x61: return seek_opcode;
      case 0x62: case 0x63: return seekfwd_opcode;
      case 0x64: case 0x65: return seekback_opcode;
      case 0x66: case 0x67: return seekend_opcode;
      case 0x68: case 0x69: return print_opcode;
      case 0x6a: case 0x6b: return menu_opcode;
      case 0x6c: case 0x6d: case 0x6e: case 0x6f: return xordata_opcode;
      case 0x70: case 0x71: case 0x72: case 0x73: return fillbyte_opcode;
      case 0x74: case 0x75: case 0x76: case 0x77: return fillhalfword_opcode;
      case 0x78: case 0x79: case 0x7a: case 0x7b: return fillword_opcode;
      case 0x7c: case 0x7d: case 0x7e: case 0x7f: return writedata_opcode;
      case 0x80: return lockpos_opcode;
      case 0x81: return unlockpos_opcode;
      case 0x82: return truncatepos_opcode;
      case 0x83: return jumptable_opcode;
      case 0x84: case 0x85: return set_opcode;
      case 0x86: case 0x87: return ipspatch_opcode;
      case 0x88: case 0x89: case 0x8a: case 0x8b: return stackwrite_opcode;
      case 0x8c: case 0x8d: return stackread_opcode;
      case 0x8e: case 0x8f: return stackshift_opcode;
      case 0x90: return instruction_if_zero(return_opcode, true); // retz
      case 0x91: return instruction_if_zero(return_opcode, false); // retnz
      case 0x92: return pushpos_opcode;
      case 0x93: return poppos_opcode;
      case 0x94: case 0x95: case 0x96: case 0x97: return bsppatch_opcode;
      case 0x98: return getbyteinc_opcode;
      case 0x99: return gethalfwordinc_opcode;
      case 0x9a: return getwordinc_opcode;
      case 0x9b: return increment_opcode;
      case 0x9c: return getbytedec_opcode;
      case 0x9d: return gethalfworddec_opcode;
      case 0x9e: return getworddec_opcode;
      case 0x9f: return decrement_opcode;
      case 0xa0: case 0xa1: return bufstring_opcode;
      case 0xa2: case 0xa3: return bufchar_opcode;
      case 0xa4: case 0xa5: return bufnumber_opcode;
      case 0xa6: return printbuf_opcode;
      case 0xa7: return clearbuf_opcode;
      case 0xa8: case 0xa9: return setstacksize_opcode;
      case 0xaa: return getstacksize_opcode;
      case 0xab: return bit_shifting_opcode;
      case 0xac: return getfilebyte_opcode;
      case 0xad: return getfilehalfword_opcode;
      case 0xae: return getfileword_opcode;
      case 0xaf: return getvariable_opcode;
      case 0xb0: case 0xb1: case 0xb2: case 0xb3: return addcarry_opcode;
      case 0xb4: case 0xb5: case 0xb6: case 0xb7: return subborrow_opcode;
      case 0xb8: case 0xb9: case 0xba: case 0xbb: return longmul_opcode;
      case 0xbc: case 0xbd: case 0xbe: case 0xbf: return longmulacum_opcode;
      default:   throw "undefined opcode";
    }
  }

  function queue_function (fn) {
    setTimeout(fn.bind(self), 0);
  }

  function create_frame (patch) {
    return {
      instruction_pointer: 0,
      variables: new Uint32Array(256),
      patch_space: patch,
      stack: [],
      waiting_var: undefined,
      message_buffer: ""
    };
  }

  function initialize () {
    file_buffer = new ResizableMemoryBlock(input.byteLength);
    current_file_pointer = 0;
    current_file_pointer_locked = false;
    var file_buffer_reader = new Uint8Array(input);
    var pos;
    for (pos = 0; pos < input.byteLength; pos ++) file_buffer.set_byte(pos, file_buffer_reader[pos]);
    input = undefined;
    frames = [create_frame(new DataView(bsp))];
    initialized = true;
    dirty = true;
  }

  function set_variable (variable, value) {
    frames[0].variables[variable & 0xff] = value;
  }

  function get_variable (variable) {
    return frames[0].variables[variable & 0xff];
  }

  function push_to_stack (value) {
    frames[0].stack.unshift(value >>> 0);
  }

  function pop_from_stack () {
    if (frames[0].stack.length < 1) throw "popped empty stack";
    return frames[0].stack.shift();
  }

  function finish () {
    var callback;
    switch (get_state()) {
      case 2: callback = self.error; break;
      case 3: callback = self.failure; break;
      case 4: callback = self.success; break;
      default: return;
    }
    frames = undefined;
    file_buffer = undefined;
    bsp = undefined;
    if (callback === undefined) return;
    var result = get_result();
    queue_function(function () {callback(result);});
  }

  function step () {
    try {
      var opcode = next_patch_byte();
      var args = opcode_parameters(opcode);
      var pos;
      for (pos = 0; pos < args.length; pos ++) args[pos] = args[pos](); // no map because we need this to happen in order
      var result = opcode_function(opcode).apply(self, args);
      if (typeof result === "boolean") return result;
      frames.shift();
      if (frames.length > 0) {
        set_variable(frames[0].waiting_var, result);
        frames[0].waiting_var = undefined;
        return true;
      }
      done = true;
      exit_status = result;
      if (result === 0) output = file_buffer.generate_array_buffer();
      finish();
      return false;
    } catch (e) {
      done = true;
      exit_status = false;
      output = e;
      finish();
      return false;
    }
  }

  function execute () {
    while (step());
  }

  function run (param) {
    if (!initialized) return queue_function(function () {
      initialize();
      execute();
    });
    if (done) return;
    if (frames[0].waiting_var !== undefined) {
      if (typeof param !== "number") throw "invalid value selected";
      param >>>= 0;
      if ((selection_range_check !== undefined) && (param >= selection_range_check)) throw "selected value out of range";
      selection_range_check = undefined;
      set_variable(frames[0].waiting_var, param);
      frames[0].waiting_var = undefined;
    }
    queue_function(execute);
  }

  function get_state () {
    if (!initialized) return 0;
    if (!done) return 1;
    if (exit_status === false) return 2;
    if (exit_status === 0) return 4;
    return 3;
  }

  function get_result () {
    if (!(initialized && done)) return undefined;
    if ((exit_status === false) || (exit_status === 0)) return output;
    return exit_status;
  }

  Object.defineProperties(self, {
    run: {
      configurable: false,
      enumerable: true,
      writable: false,
      value: run
    },
    state: {
      configurable: false,
      enumerable: true,
      set: undefined,
      get: get_state
    },
    result: {
      configurable: false,
      enumerable: true,
      set: undefined,
      get: get_result
    }
  });
}
