# Newbox data format

> **Morimoto:** *(laughs)* I was really taken aback that you could get to grips with such a complicated program in such a short space of time.
>
> **Ishihara:** I remember thinking that there just weren't that many people out there who would be able to read the entire Game Boy source code, which was by no means written in a highly-refined programming language, and grasp how everything connected with everything else.
>
> — Shigeki Morimoto and Tsunekazu Ishihara, "[Iwata Asks – Pokémon HeartGold Version & SoulSilver Version](https://iwataasks.nintendo.com/interviews/ds/pokemon/0/2/)"


## Save file address locations

* 0x2d10-0x2f20: Gameplay newbox metadata (0x210 bytes)
* 0x2f20-0x3130: Saved newbox metadata (0x210 bytes)

Total boxes: 16 gameplay boxes, 16 saved boxes.
Extraction from a .sav should be done from 0x2f20 unless save was interrupted.
If saving was interrupted, box data *might* be in 0x2d10-0x2f20 instead,
depending on when in the process you interrupted the saving.

* 0x4000-0x5ff7: Pokémon database 1 (0x1ff7 bytes)
* 0x6000-0x7ff7: Pokémon database 2 (0x1ff7 bytes)

Total database entries: 167 per database, 334 total.
Pokémon data referenced by newbox metadata. Left unitialized on a new game,
there is no gurantee that data in here that isn't referenced by boxes above
isn't filled with garbage. Hence, always reference data here indirectly by
reading the newbox metadata.

## Newbox metadata format

Each individual "newbox" box is 0x21, or 33 bytes, long. It contains the
following data:

* 0x00-0x13: Database pointers for the species
* 0x14-0x16: Bitflags for which of the 2 databases the given entry uses
* 0x17-0x1F: Box name (9 characters in GSC character format, no string terminator)
* 0x20: Box theme

The pointers contains either 0, for a blank slot, or 1-167, corresponding to
a database entry. Each entry has a corresponding bitflag, which is unset if
database bank 1 is referenced, set if database bank 2 is. The entry referenced
can be somewhat arbitrary (each time a player adds a Pokémon to the storage,
the game looks up the lowest entry not marked as used, and thus over time the
pointer list can become somewhat haphazardly ordered). Thus, the pointers
should not be relied on to be in any particular order. This is a major reason
as to why you shouldn't try to reference pokedb Pokémon directly.

Slots are stored starting from the top left corner, then continuing on the same
row until switching to the next row. So the top left corner is the first slot,
the one right of it is slot 2 while the slot right below the first slot is the
5th slot.

0x14-0x16 contains bitflags for which of the 2 pokedb banks is used. The flags
are structured as follows:

    0x14        0x15        0x16
    0bHGFEDCBA  0bPONMLKJI  0b0000TSRQ

where A corresponds to the bank for slot 1, B for slot 2, etc up to slot 20.
The bits marked as zero above is unused.

For blank slots, the bitflag has no impact (and may be set if the slot used to
reference a Pokémon from storage database 2) and should be ignored.

Box name is stored as 9 characters with no terminator using the standard GSC
character map. Box theme can be anything between 0-29 for a valid theme.
The theme order is as follows:

* Standard
* Pro
* Mobile
* Classic
* Bliss
* Contrast
* Nature
* Truth
* Ideals
* Light
* Darkness
* Matte
* Normal
* Fighting
* Flying
* Poison
* Ground
* Rock
* Bug
* Ghost
* Steel
* Fire
* Water
* Grass
* Electric
* Psychic
* Ice
* Dragon
* Dark
* Fairy

## Pokémon database format

Each individual pokedb entry is 0x31, or 49 bytes, long. It contains the
following data:

* 0x00: Species
* 0x01: Item
* 0x02-0x05: Moves
* 0x06-0x07: OT ID
* 0x08-0x0A: Experience
* 0x0B-0x10: EVs (HP, Attack, Defense, Speed, Special)
* 0x11-0x13: DVs
* 0x14-0x15: Personality data
* 0x16: PP Up data
* 0x17: Friendship/Egg cycles
* 0x18: Pokérus data
* 0x19: OT gender, caught ball, caught time
* 0x1A: Caught level
* 0x1B: Caught location
* 0x1C: Level
* 0x1D: Hyper Training
* 0x1E-0x1F: Extra data (currently unused)
* 0x20-0x29: Nickname excluding terminator
* 0x2A-0x30: OT name excluding terminator (only 7 bytes are stored)
* 0x20-0x30 also contains the checksum.

Data in 0x00-0x15 is identical to a party Pokémon.

0x16 stores PP Up data as 0bDDCCBBAA where A is move 1, B is move 2,
C is move 3 and D is move 4.

Data in 0x17-0x1C is also identical to party, but shifted because instead of
storing 4 bytes for PP, newbox only stores a single byte for PP Up data.

0x20-0x29 and 0x2A-0x30 contains nickname and OT name respectively. They do not
include the terminator. These are for the most part GSC character data without
the 7th bit being part of the name. When interpreting the name here,
set the most significant bit, and do the following conversions:

* Treat 0xFA as a space (0x7F)
* Treat 0xFB as a terminator (0x53)
* Treat 0xFC as a zero (0x00)

The most significant bit in 0x20-0x29 (nickname) and 0x2A-0x30 (OT name) stores
a checksum. If this checksum is invalid, the game will decode the Pokémon into
a Bad Egg. This is NOT done as some sort of anticheat (despite what many people
believe about the purpose of Bad Eggs). The reason this is done is to act as a
failsafe against data corruption. If invalid Pokémon data were to be interpreted
by the game (a corrupted save file or similar), and said data would crash the
game with SRAM banks still open, there is a large chance that the save will be
irreparably broken. Bad Eggs is a failsafe against this, since the game isn't
going to crash by trying to interpret its data.

## Checksum

Each pokedb Pokémon entry is checksummed. The checksum is calculated as follows:

* Start with 127
* For bytes 0x00-0x1F, add the value times (byte + 1)
* For bytes 0x20-0x30, add the value of the lower 7 bits times (byte + 2)
* Clamp to 2 bytes (so 2 remains 2, 65536 becomes 0, etc)
* Treat the 2 bytes as a series of bits
* Write the most significant bit to 0x20's most significant bit
* Continue with the 2nd most significant bit to the most significant bit in 0x21
* Continue like this for the rest of the name fields
* Note that since 0x30 would be the 17th bit, and we only keep 16, its MSB is
  unset. It is still considered an invalid checksum if 0x30's MSB is set when
  decoded.

Having a checksum starting point of 127 ensures that a completely blank entry,
consisting only of zeroes, doesn't create a valid checksum.
