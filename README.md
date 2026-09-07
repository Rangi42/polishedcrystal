# Issue #1112 verification

Implemented and tested by Chatgpt Astra using vulcandth's account.

The PNGs are unmodified 160×144 framebuffer captures from vibeEmu. `description.png`, `physical.png`, and `description-restored.png` capture the same cursor position before Select, after Select, and after Select again. `status.png` shows Curse's unavailable power/accuracy; `surf.png` shows HM03 Surf.

Both standard and faithful ROMs were built from the issue branch. A temporary driver using the local vibe-emu-core crate injected all 75 TMs and 6 HMs, initialized graphics/menu state, and entered the real Pack routine directly. Only the emulator's in-memory entry point and setup data were manipulated; the pocket implementation and move tables were unmodified. No story playthrough or changes to a player's save were needed.

Assertions checked all 81 moves against each built ROM's move table with the physical/special split enabled and disabled, and again after sorting by name. They also checked exact description restoration, scrolling, the Cancel row, Select on an empty inventory, the Use/Quit submenu, pocket switching, and B exit. Both runs completed without crashes; see the test transcripts.

Reviewed https://github.com/pret/pokecrystal/wiki/Optimizing-assembly-code and ran `python3 utils/optimize.py` before and after the change: zero findings in both runs.

This evidence branch is separate from the code PR so screenshots and test transcripts do not enter master.
