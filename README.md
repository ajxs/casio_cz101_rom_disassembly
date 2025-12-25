# Casio CZ101 ROM Disassembly

This repository contains an partially annotated disassembly of the Casio CZ101's v2 firmware ROM. It can be used to build a bit-perfect version of the Casio CZ101's firmware. The disassembly is currently incomplete, but can still be useful for research purposes.

The CZ101 runs on an NEC μPD7811G processor, running in *'expansion mode'*. The CPU is responsible for handling MIDI/LFO/Pitch functionality, with the actual voice synthesis happening on the NEC μPD933 ASIC.

A copy of the ROM can be obtained from [this site](https://dbwbp.com/index.php/9-misc/37-synth-eprom-dumps).

I'd like to acknowledge the amazing work of [Devin Acker](https://revenant1.net/), and the [MAME team](https://www.mamedev.org/) for making the Casio CZ101 MAME driver available. Without this invaluable tool, this work would have been nearly impossible.

Feel free to make any contributions or suggestions by emailing me, or directly raising a pull request to the repository!

## Where To Start

The best place to start looking into the ROM's functionality is right where it all begins... `RST0`, at offset `0x0`.

## Building the ROM

The ROM can be built with Alfred Arnold's [AS](http://john.ccac.rwth-aachen.de:8000/as/) macro-assembler. `makefile` contains a recipe for building the ROM, and checking the integrity of the build. If you have the assembler installed (and on your `$PATH`), you can run `make`.

## Naming Conventions

The following nomenclature is used in the disassembly. This might differ from official Casio documentation, however I've decided to stick to the modern synth terminology where appropriate. Such as *'voice'* rather than *'note'*, and *'patch'* rather than *'voice'*.

- **Channel** refers to the individual MIDI channels that the synth uses to play a different timbre. The synth has 4, which can be accessed via MIDI.
- **Voice** refers to the 8 individual notes that the synth can play simultaneously. These are divided between the synth's *channels*.
- **Patch** refers to the different tones the synth can store/recall to/from memory.

## Style Conventions

The following stylistic conventions have been used in the disassembly:

- Variables and subroutines have their address added as a suffix, e.g., `important_subroutine_0f34`. This helps name and distinguish unknown variables during disassembly, and makes it easy to reference the source code from other tools, such as MAME.
- When a variable or subroutine's purpose is still unknown, the labels sometimes include `UNKNOWN` or `MAYBE`. Disassembly involves a lot of guesswork. Sometimes it helps to label things with your best guess, until you're able to clarify its purpose later. E.g. the label `MAYBE_patch_index_save_8028` describes a variable that is *probably* used to track the patch save index; `UNKNOWN_keyboard_flags_8013` describes some kind of keyboard flags variable, whose actual purpose is unknown.
- Constants definitions are uppercase, while definitions relating to addresses in the ROM are lowercase.
- In certain places constants bytes have been added where the assembler (see above) has been unable to generate bit-perfect output. The equivalent assembly instruction is added in a comment. This has happened because of a difference in how AS encodes `LDAX (DE+0)` from whatever assembler the original engineers used (probably NEC's RA87).
Such as:
```
    DW 00ABh   ;    LDAX        (DE+00h)
```
