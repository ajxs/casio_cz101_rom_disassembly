# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A hand-annotated, single-file disassembly of the Casio CZ-101 synthesizer's "v2" firmware ROM
(`casio_cz101_v2.asm`, ~18k lines). The goal is a byte-perfect reassembly of the original mask ROM
(`HN613256PS-40`, MD5 `d31cb89013579188fad4f53fdc2d04dd`), annotated with recovered labels, structure
comments, and hardware knowledge as reverse-engineering progresses. The disassembly is incomplete —
large stretches of the ROM are still unlabelled/unclear.

The CZ-101 runs an NEC μPD7811G in *expansion mode* (its internal 4K mask ROM is disabled by mode
pins; all code executes from the external 32K ROM this project disassembles). The CPU handles
MIDI/LFO/pitch/UI logic; actual voice synthesis happens on a separate NEC μPD933 ASIC that the CPU
talks to over memory-mapped I/O.

## Build & verify

Requires Alfred Arnold's AS macro-assembler (`asl`, `p2bin`) on `$PATH`.

```sh
make            # assembles casio_cz101_v2.asm -> casio_cz101_v2_rebuild.bin
make compare     # rebuilds, then diffs the MD5 against ROM_CHECKSUM in the makefile
make clean
```

`make compare` needs the original dump present as `casio_cz101_v2.bin` (gitignored, not included in
this repo) to print a byte-level diff; without it, it only reports pass/fail on the checksum.
There is no test suite — correctness is entirely "does the reassembled binary match the original ROM
byte-for-byte."

After any edit to `casio_cz101_v2.asm` — including comment-only changes — verify with `make compare`
directly rather than `make clean && make` plus a manual `md5sum`; it already rebuilds and checks the
checksum in one step, and there's no need to `make clean` first since the makefile's rule rebuilds
whenever the source is newer than the output.

### Encoding quirks

AS sometimes can't reproduce the original assembler's (probably NEC RA87) encoding for certain
addressing modes, notably *base index addressing* (e.g. `LDAX (DE+0)`). Where this happens, the raw
bytes are emitted with `DW`/`DB` and the intended mnemonic is preserved in a trailing comment, e.g.:

```
    DW 00ABh   ;    LDAX        (DE+00h)
```

Don't "fix" these back to the mnemonic form — that's what breaks the checksum.

## μCOM-87 / μPD7810 ISA quirks (know these before reading unfamiliar code)

The μPD7811G belongs to NEC's μCOM-87 family — an 8080/Z80-adjacent but idiosyncratic ISA. See
[this write-up](https://ajxs.me/blog/uCOM-87_The_Strangest_Architecture_Youve_Never_Worked_With.html)
for a fuller tour of the architecture; the parts most load-bearing for reading this disassembly:

### Control flow is skip-based, not branch-based

A large instruction family (`OFFI`, `ONI`, `EQI`, `NEI`, `GTI`, `LTI`, `BIT`, `EQA`, and others — the
same lineage as the PDP-8 and PIC's skip instructions) doesn't jump on a condition; it conditionally
*skips the following instruction*, which in this codebase is almost always the `JR`/`JRE`/`RET`
immediately after it. Read these as "if condition, skip the branch" — the code that actually executes
is the branch instruction being skipped *over*, not the one landed on. Getting this backwards inverts
the whole condition when tracing a routine's logic.

### The `V` working-vector register is fixed at RAM base throughout this ROM

This is the μCOM-87's analogue of the 6809's Direct Page register: `V:offset` forms an address from a
single-byte operand instead of a full 16-bit one, cutting instruction size roughly in half for RAM
accesses. In this ROM `V` is loaded once with `0x80` (`MVI V,80h`, casio_cz101_v2.asm:9223) and never
changed, i.e. it always points at `ram_start` (`0x8000`). The disassembly's `V_OFFSET()` macro
(casio_cz101_v2.asm:259, `offset - ram_start`) computes the corresponding single-byte offset, and every
`*W`-suffixed instruction (`MVIW`, `STAW`, `LDAW`, `ANIW`, `ORIW`, `EQIW`, `NEIW`,
`BIT n,(V_OFFSET(...))`, etc. — 867 uses across the file) is V-relative rather than absolute. All
`V_OFFSET()` targets fall within `0x8000-0x80ff`; RAM outside that single page (e.g.
`patch_buffer_internal_8800`, `patch_buffer_compare_8380`) is reached the ordinary way, with a 16-bit
`LXI`/`LDAX`/`STAX` instead.

### `EA` is not `A`

Despite the name, the μPD7810's "extended accumulator" pair `EA` (used by `LDEAX`/`STAX`/`DMOV`) is a
physically separate 16-bit register from the accumulator `A` — confirmed in the MAME core's register
layout (`cpu/upd7810/upd7810_macros.h`: `A` is `m_va.b.l`, `EAL`/`EAH` are `m_ea.b.l`/`m_ea.b.h`, distinct
storage, not overlapping `VA`/`DE`/`HL`/`BC` either). `LDEAX (HL)` therefore does **not** clobber `A`,
`B`, `C`, or `D`. This is easy to get wrong when reading `LDEAX`/`DMOV DE,EA`/`STAX` sequences in the
disassembly — a value staged in `A` (or `B`/`D`) survives an interleaved `LDEAX (HL)` used to pull in an
old/previous value for comparison, a common pattern in this ROM (e.g. `input_scan_keyboard_MAYBE_4670`
at casio_cz101_v2.asm:9853, which reads the raw keyboard matrix into `A`/`B`/`D`, then uses
`LDEAX`/`DMOV DE,EA` to pull in the previous scan's state without disturbing those registers).

Also note the two-register-operand mnemonic order is dest,src: e.g. `SUB C,A` means `C = C - A`,
confirmed via `SUB_C_A()` in `upd7810_opcodes.cpp` (`tmp = C - A; C = tmp`) as distinct from `SUB_A_C()`.

When an instruction pair's register semantics look ambiguous, check
`src/devices/cpu/upd7810/upd7810_opcodes.cpp` and `upd7810_macros.h` in the MAME tree for the
authoritative C++ implementation rather than guessing from the mnemonic alone.

### Instruction stacking

Repeated `MVI reg,imm` instructions targeting the same register only take effect on the first
instance — later ones are effectively NOPs, but still burn cycles. If a run of near-duplicate `MVI`s to
the same register looks redundant while reverse-engineering, consider that it may be deliberate timing
padding rather than a mistake worth "cleaning up" (any such cleanup would also break the checksum).

### Call table

The 32-entry `CALL_TABLE` at the top of `ORG 0` (casio_cz101_v2.asm:618) matches the shape of the
μCOM-87's dedicated `CALT` instruction — a single byte that calls through a vector table conventionally
based at `0x80`. Nothing in this disassembly currently calls through it by label or a decoded `CALT`
mnemonic; worth keeping in mind if an unexplained single-byte opcode or an otherwise-unresolved computed
call site turns up nearby.

### `JR`/`JRE` are relative — a byte search for an address will not find them

`JR` is a single byte (`11dddddd`) carrying a 6-bit signed displacement (−32..+31); `JRE` is two bytes
with a 9-bit signed displacement (−256..+255). Neither stores the target address anywhere in the ROM
image. `JMP`, `CALL` and `DW` dispatch-table entries do, as little-endian address bytes.

This matters when answering "what reaches routine X?". Scanning `casio_cz101_v2.bin` for the
little-endian bytes of X's address finds only the absolute references and **silently misses every
relative branch** — and short `JR`/`JRE` hops between adjacent routines are exactly how this ROM
threads its shared entry points together (`FUN_734d` reaches `note_UNKNOWN_736e` that way, and
`FUN_7354` reaches the same body further in at `LAB_7376`). A byte scan returning nothing is not
evidence that nothing reaches the address.

The reliable method is to grep the label name in the `.asm`. The source reassembles byte-for-byte and
every control transfer in it is symbolic — no branch uses a raw numeric target — so every reference in
the ROM, relative or absolute or a `DW` table entry, must appear as a textual use of the label. Keep
the byte scan for the one case grep cannot cover: a numeric, unlabelled pointer sitting in a data
table.

The same reasoning run backwards is positive evidence of dead code: if an address carries no label,
nothing can branch to it, so a block reachable only by fall-through from a preceding `RET` is
unreachable — e.g. the `; Unreachable code?` block at `0x4A55`, immediately after
`note_off_UNKNOWN_4a4a`.

## Testing changes against real hardware behavior

A separate MAME checkout with a Casio CZ-series driver lives in the other working directory
(`/home/ajxs/src/mame`, driver at `src/mame/casio/cz101.cpp`) and has a prebuilt `mame_cz101` binary.
Its `ROM_LOAD("hn613256ps40.bin", ...)` for the `"program"` region is the same ROM version this
repo disassembles ("Version II" — one of three MIDI-bug-fix revisions per a 1986 Casio service
bulletin), mapped at CPU addresses `0x0000-0x7fff`. The driver is the ground truth for hardware
register/port behavior referenced throughout the disassembly (`PB`, `PC`, `MM`, `upd933_*` labels) —
when a routine's purpose is unclear, check what device is mapped at the address/port it touches
before guessing. It's also the best way to sanity-check a reverse-engineering guess empirically: drop
a rebuilt ROM into `mame/roms/cz101/hn613256ps40.bin` and run it.

### CPU memory map (`cz101_state::maincpu_map`)

| Range             | Device                                                          |
|--------------------|------------------------------------------------------------------|
| `0x0000-0x7fff`    | external program ROM (this disassembly, `ORG 0` in the `.asm`)  |
| `0x8000-0x8fff`    | internal RAM (battery-backed via `nvram`/cart battery)          |
| `0x9000-0x97ff`    | RAM cartridge (`casio_ram_cart_device`, "RA3")                  |
| `0x9800-0x9fff`    | LED group 4 write (`led_4_w`)                                   |
| `0xa000-0xa7ff`    | LED group 3 write (`led_3_w`) — envelope-point LEDs              |
| `0xa800-0xafff`    | LED group 2 write (`led_2_w`) — tone-select LEDs + LED 7         |
| `0xb000-0xb7ff`    | LED group 1 write (`led_1_w`)                                   |
| `0xb800-0xbfff`    | keyboard/button matrix read (`keys_r`, selected by `PB` bits 0-3) |
| `0xc000-0xfeff`    | μPD933 voice-synthesis ASIC (`upd933_*` RAM-mirror equates map to this via the CPU's port B chip-select) |

Internal RAM writes are mirrored through `upd933_data_*`/`upd933_pending_data_*` staging variables
(e.g. `upd933_data_waveform_index_80c2`) before being pushed out to `0xc000+` — the firmware batches
writes to the ASIC rather than hitting the `0xc000` window directly in most places.

### CPU I/O ports (μPD7811 PA/PB/PC, referenced in the `.asm` as `PA`/`PB`/`PC`)

- **Port A** — 8-bit bidirectional bus to the HD44780 LCD controller (`db_r`/`db_w`).
- **Port B**: `7`=power switch (also wired to `/NMI`), `6`=μPD933 write-enable, `5`=μPD933 chip-select
  (`upd933->cs_w`), `4`=μPD933 IRQ input, `3-0`=keyboard/button matrix line select (indexes `keys_r`,
  and `input_active_line_8012` in RAM tracks the currently-scanned line — matches the service manual's
  "KC1-16" input-matrix terminology already used in the `.asm`'s `input_group_kc*` labels).
- **Port C**: `7`=LCD E, `6`=LCD R/W, `5`=LCD RS, `4`=unused/debug (MIDI CC#7 writes data to port A then
  toggles this bit), `3`=power-down output (driving this low forces a full reset: CPU reset line
  asserted, LCD/μPD933 reset, all LEDs cleared — see `power_down_4003`/`NMI` vector), `2`=MIDI clock,
  `1`=MIDI RX, `0`=MIDI TX.
- **AN1/AN2** (analog inputs): pitch-bend wheel and battery-level sense, respectively.

### Front panel / input matrix quirk

Bit 7 of `KC15` is normally unused, but if pulled low (via a diode on real hardware), bits 2-5 of `KC8`
(also normally unused) become DIP switches overriding the front-panel MIDI "basic channel" setting —
likely intended for a screenless MIDI-module variant. Relevant if `input_group_kc13_8178`/`KC8`/`KC15`
handling in the disassembly looks like it's reading more than the documented buttons.

### Diagnostic cartridge boot

Undumped, but documented in the driver's header comment: holding "env step +", "env step -",
"initialize", and "write" together, then pressing "load", boots a debug/diagnostic cartridge. Any
cartridge whose first 8 bytes are `5a 96 5a 96 5a 96 5a 96` gets its first 2KB copied to `$8800-8fff`
and control transferred to `$8810` — even without the normal cart-detect signal present (and this
wipes internal RAM patches). Useful context if disassembling cartridge-load code around `$8800`.

`preset_patch_rom.bin` (2KB, gitignored source excluded but tracked here) is `BINCLUDE`d directly into
the ROM image at `patch_rom_preset_6000` (casio_cz101_v2.asm:14313) — it's the factory preset patch
data table, not something to hand-edit as code.

## Synth performance modes (from the Owner's Manual)

The CZ-101 Owner's Manual (not included in this repo) describes front-panel performance modes that
map directly onto the `CHANNEL_INFO_FLAGS_*` bits driving NOTE ON/OFF dispatch
(`note_on_jumpoff_47db`/`note_off_jumpoff_4815`, casio_cz101_v2.asm ~10300):

- **Basic/Poly mode** (default, `SOLO`/`TONE MIX` both off): up to 8-voice polyphony (1 DCO/voice) or
  4-voice (2 DCOs/voice, Line Select 1+2/1+1'), voices dynamically allocated from a shared pool per
  channel (`note_on_basic_mode_find_voice_48d6`).
- **Solo mode** (`SOLO` key, `CHANNEL_INFO_FLAGS_SOLO`): "Only one note can now be played at a time,
  and the note played last will sound" — last-note-priority mono. This is what
  `CHANNEL_INFO_ACTIVE_NOTE_STACK_1..4` (the reverse-engineered 4-deep queued-note stack) implements:
  releasing a note falls back to whatever note is still held underneath it.
- **Tone Mix mode** (`TONE MIX` key, `CHANNEL_INFO_FLAGS_TONE_MIX`): mixes 2 tones on one note; "the
  keyboard then becomes monophonic" — also mono, using both DCO lines (voice N and its N+4 partner,
  see `note_on_tone_mix_4859`) for the single active note. The manual's MIDI section notes Tone Mix is
  *locally* monophonic but its MIDI mode setting still reads as Poly — i.e. it's a per-channel flag,
  not a switch to MIDI Mono mode, so all 4 channel structs can independently be in Tone Mix.
- **Portamento** (`CHANNEL_INFO_FLAGS_PORTA`): a fixed glide *time* regardless of pitch interval (not
  a fixed rate). In Solo/Tone Mix mode it "will only be obtained with a legato playing style (i.e.
  when the following note is played while the first one is still being held)" — precisely what
  `CHANNEL_INFO_FLAGS_8` gates: it's set once a channel already has a note held, and only then does a
  new NOTE ON glide (`note_on_trigger_voice_glide_4a90`) instead of hard-retriggering.

MIDI-wise ("Setting the Transmit and Receive Modes"): Poly mode transmits/receives on any of 16
channels; Mono mode (SOLO on) receives 4 independent monophonic voices on channels N, N+1, N+2, N+3 —
matching `currently_selected_solo_midi_channel_8025`/`midi_incoming_solo_voice_index_8034`/
`midi_solo_max_voice_index_8035` in the RAM equates.

Line Select (`channel_pflags_0_801b` bit 1, etc.) chooses which DCO/DCW/DCA line(s) a channel uses:
Line 1, Line 2, Line 1+2 (both, undetuned), or Line 1+1' (Line 1 plus a detuned copy of itself, for
chorus/ensemble effects). `DETUNE` is what produces that detuned "1'"/"2'" variant of either line.

## Source layout (`casio_cz101_v2.asm`)

Single file, organized top-to-bottom as:

1. **RAM variable equates** (`8000h`+) — internal RAM layout, one `EQU` per byte/flag, with comments
   where purpose is known.
2. **Bit-flag / constant equates** — grouped near where they're first used (LED bits, MIDI SysEx
   function IDs, UI flags, etc).
3. **`ORG 0`** — the actual ROM image, in three contiguous chunks matching gaps left by unused/hidden
   regions:
   - `ORG 0`: interrupt vector table (`RST0`, `NMI`, `INTT0_INTT1`, ... `SOFTI`), a jump `CALL_TABLE`,
     `reset_00c0`, then mainline code. Includes several `UNUSED_cz5000_*` / CZ230S-related routines
     that are dead code in this ROM (kept for provenance — likely shared code across the CZ synth
     family).
   - `ORG 4080h`: second code region (timer/interrupt handlers etc).
   - `ORG 6c00h`: final code region, immediately preceded by the `patch_rom_preset_6000` preset-patch
     data block.
   Start reading at `RST0` (offset `0x0`) to trace the reset vector into `reset_00c0` → `reset_4000`.

## Naming & annotation conventions (must follow when editing)

- Every label carries its address as a suffix: `important_subroutine_0f34`. This disambiguates unknown
  symbols and lets other tools (e.g. MAME) be cross-referenced against the source by address.
- Uncertain purpose is signalled in the label itself, not just in a comment:
  - `UNKNOWN_...` — purpose genuinely unknown.
  - `MAYBE_...` — best guess, unconfirmed.
  Don't downgrade one of these to a confident name without evidence; don't leave a confidently-named
  label that's actually a guess.
- **Constants** (bit masks, magic numbers, table indices) are UPPERCASE. **ROM/RAM address labels**
  (variables, subroutines) are lowercase.
- Domain terminology (deliberately diverging from Casio's own manual wording — keep using these, not
  the manual's terms):
  - **Channel** — one of the 4 MIDI channels the synth listens on.
  - **Voice** — one of the 8 simultaneous notes the synth can produce, allocated across channels.
  - **Patch** — a storable/recallable tone (Casio's manual calls this a "voice", which is why the
    terms above diverge from it).
- Section banners use the `; ====...====` rule (80 `=` chars) above/below a heading comment.
- `@TODO:`, `@NOTE:`, `@UNSURE:` prefixes mark open questions/uncertain reasoning inline; `@COMPLETE`
  marks a routine considered fully understood. Grep for these to find open reverse-engineering work.

## MIDI receive dispatch (dynamically validated)

Validated against the running machine by injecting each MIDI message type and tracing which
handlers execute — not by reading the code alone. Every label below was reached by its own
message type and by no other.

`midi_process_message_complete_312b` dispatches on the status byte via a jump table: the status
byte is shifted right 3 and masked with `0Eh`, indexing the `DW` table after `TABLE`/`JB`.

| Status | Message | Handler | Confirmed |
| --- | --- | --- | --- |
| `8x` | Note off | `midi_process_note_off_316a` | yes |
| `9x` | Note on | `midi_process_note_on_3180` | yes |
| `Ax` | Aftertouch | `return_4c35` | **ignored** — reaches no handler |
| `Bx` | Control change | `midi_process_cc_31a6` | yes |
| `Cx` | Program change | `midi_process_prog_change_32d5` | yes |
| `Dx` | Channel pressure | `return_4c35` | **ignored** — reaches no handler |
| `Ex` | Pitch bend | `midi_process_pitch_bend_330b` | yes |
| `Fx` | System | `return_4c35` | — |

Note off and note on both fall into the shared `midi_process_note_on_off_3172`, as the labels imply.

Within `midi_process_cc_31a6`, controller numbers `>= 7Ah` (122) branch to
`midi_process_mode_change_31c6`; everything below is compared against the individual controllers.
Confirmed by injection: CC#65 reaches only `midi_process_cc_portamento_on_off_323f`, CC#1 reaches
only `midi_process_cc_vibrato_on_off_UNKNOWN_3267`, CC#7 reaches only
`midi_process_cc_UNKNOWN_32b4`, and a mode message (CC#123) reaches `31c6` while an ordinary CC
does not.

- `@TODO:` `midi_process_cc_UNKNOWN_32b4` is the **CC#7 (Main Volume)** handler — it is the only
  controller that reaches it. Renaming it to reflect CC#7/volume would drop the `UNKNOWN`.

  It shares port A with the LCD rather than writing to the LCD. The sequence is: scale the value
  (`>> 3`, masked to `0Fh`), `MOV PA,A`, then `MOV MA,0F0h`, then strobe port C bit 4 low→high with
  three `NOP`s of settle time. On the μPD7810 an `MA` bit of **1 is input and 0 is output**
  (MAME: `data = (m_pa_in & m_ma) | (m_pa_out & ~m_ma)`), so `0F0h` drives **only port A's low
  nibble** and floats the high nibble — verified on the running machine by halting at `32c4`, where
  `MA` reads `F0`. The LCD's own control lines (`E`=PC7, `R/W`=PC6, `RS`=PC5) are never touched
  here, so the LCD does not latch the write: this is a second, 4-bit device on the shared bus,
  clocked by PC4.

  What that latch physically drives is **not confirmable from either direction**, so the `MAYBE_` in
  the label stays: the schematics show PC line 4 as not connected, and MAME does not model that bit
  either (`port_c_w` handles only bits 3, 5, 6 and 7). Only the CPU-side behaviour above is
  established. If PC4 really is unconnected on this revision, the routine may be vestigial — see the
  `@TODO:` on the routine itself.

- `midi_process_cc_porta_time_329b` — `MAYBE_` removed, verified in emulation. Sending CC#5 writes
  the data byte to `portamento_time_8004`; values `64h` and above are clamped to `63h` (99); other
  controllers leave the variable untouched. It also switches the UI to `UI_SCREEN_PORTAMENTO`.

### Voice table at `MAYBE_voice_data_8640`

The "8 entries size 0x28" comment is **confirmed**: reading `8640`–`877f` on the running machine
shows exactly 8 entries of 40 bytes, and the writer loop does `LXI HL,$8640` / `ADINC L,$28` with
`ONI C,$08` terminating at 8. Offset `+00` in each entry is the voice index (`00`–`07`), and
offsets `+05..+08` hold a pointer constant across all entries (to `patch_buffer_edit_8300`).

Offset `+14h` is a flags byte. Toggling **Portamento On/Off** on the front panel sets/clears
**bit 4** in all 8 entries — `VOICE_INFO_8640_14_PORTA`, matching the observed `08h` → `18h`.

Distinct from that, `UNKNOWN_called_during_irq_7d1d` (the loop labelled `_voice_loop_7d29`) walks
the same field across all 8 entries setting **bit 3** (`ORI A,08h`) or masking to `11h`, selected by
a per-voice bitmask in internal RAM `0FFD4h` that is shifted right once per iteration — so bit *n*
of that mask selects voice *n*. Both act on `+14h`, but they are different bits and different code.

### Verifying a guess against the running machine

When checking which routine handles a behaviour, prefer **tracing** over breakpoints. A breakpoint
halts mid-message; resuming lets the remainder of that message finish processing, so the next test's
breakpoint can catch leftovers and appear to prove a handler is reached by a message that never
reaches it. Tracing one message type and cross-tabulating the executed PCs against candidate
handlers has no such race. (Both were tried here; the breakpoint method produced two false
positives that the trace method disproved.)

**Change settings through the front panel, not by writing RAM.** Writing the line select bits into
`patch_buffer_edit_8300` directly does **not** reconfigure voice allocation — the firmware only
re-evaluates when the change arrives via the Line Select button. Poking that byte makes every mode
look like it allocates a pair, which is exactly the wrong answer. The same caution applies to any
patch parameter whose effect is computed at note-on rather than read live: set it the way the
firmware expects and let it do its own bookkeeping.

### Voice structure fields: what was established by triggering notes

Method: a logging watchpoint over the whole table
(`wpset 8640,140,w,1,{printf "W %04X=%02X pc=%04X",wpaddr,wpdata,pc;g}`) while eight MIDI notes
were injected. Fields written **once per note allocation** are setup; fields written hundreds of
times per note are per-tick state. Note that in a watchpoint *action* `pc` is the instruction
**after** the store, unlike the "Stopped at watchpoint" console message, which reports the storing
instruction itself.

**Multi-byte fields**, proven by a single `STEAX` writing both halves:

| Field | Writer | Note |
| --- | --- | --- |
| `+0F/+10` | `7BA1` | `+0E` is written separately at `7B93`, so it is its own byte — matches `_F_WORD` |
| `+14/+15` | `7CDD` | a `STEAX` writes both flag bytes as one word; `7D30` writes `+14` alone |
| `+11/+12` | `70B8` | frequency; clamped to `7100h` immediately above, at `70AE` |
| `+1E/+1F` | `7143`, `7153` | word, though `_1E_PITCH_UNKNOWN` is defined as a single byte |
| `+20/+21` | `715F` | word; `_20` and `_21` are defined separately |
| `+23/+24` | `711A` | word; there is no `_24` constant at all |

`+0C` could **not** be confirmed as a word: `+0C` is written at `70CA`/`70D2` but `+0D` at `6E16`,
by unrelated code. `_C_WORD` may still be correct via a path these tests did not reach.

`+17`, `+18`, `+19` are **zeroed together at note-on** (`70BD`/`70BF`/`70C1`), which is what
"current envelope step" for DCA/DCW/DCO should do — supporting those `_MAYBE` labels.

Purely per-tick fields are `+0E`, `+0F/+10`, and the flag bytes `+13`, `+14`, `+15`, `+16`.

**Portamento glide** (`LAB_7bba`, reached with portamento on and multiple notes active): loads
`+1E/+1F`, then adds or subtracts `+0F/+10` via
`add_de_to_ea_clamp_at_ffff_0245` / `subtract_de_from_ea_clamp_at_0_024b`, and stores back to
`+1E/+1F`. Direction is selected by `OFFI B,VOICE_INFO_8640_15_10`. So `+1E/+1F` reads as a current
pitch glided toward a target, `+0F/+10` as the per-tick step, and bit 4 of `+15` as the direction.
**Solo mode is required for the glide path to run at all.** With portamento enabled and two notes
held but Solo off, `LAB_7bba` is never reached — tracing shows it absent. Pressing **Solo**
(`kc10`, sets `FLAGS_8031_SOLO_MODE` in `UNKNOWN_flags_8031`) makes `LAB_7bba`, `LAB_7bcc`, `7B93`
and `7BA1` all execute. Enabling portamento itself is straightforward: CC#65 value `7Fh`, or the
front-panel button, sets `VOICE_INFO_8640_14_PORTA` (**bit 4** of `+14h`) in all 8 entries,
observed as `09h` → `19h`.

Watching every write to the table during a Solo-mode glide shows **the audible ramp is in
`+0E/+0F/+10`, not in `+1E/+1F`**:

- `+10` increments strictly monotonically (`00 01 02 03 04 …`, 29 distinct values in one glide)
- `+0F` advances by roughly `8Fh` per tick and wraps, `+0E` alternates `00`/`80`
- together they read as a **24-bit accumulator** (`+0E` low, `+10` high) stepped once per tick by
  the update at `7B93`/`7BA1`
- `+1E/+1F` meanwhile takes only **two** values across the whole glide (e.g. `3BF8` → `57F8`),
  which is target-like, not a ramp

So the earlier reading — `+1E/+1F` as the gliding pitch with `+0F/+10` as its step — is
**backwards**. The structure instead keeps **previous and target frequencies** either side of a
sweeping accumulator, the same shape as the DX7/DX9 firmware:

| Field | Role |
| --- | --- |
| `+1E/+1F` | frequency the glide started from (`_1E_PREV_FREQ_WORD`) |
| `+20/+21` | frequency it is heading to (`_20_TARGET_FREQ_WORD`) |
| `+0E/+0F/+10` | 24-bit accumulator sweeping between them |

Confirmed with a control: holding two notes in Solo mode with portamento **on**, `+1Eh` stayed at
the first note's value (`3BF8`) while `+20h` held the second's (`57F8`) for **38 of 70** samples,
with the accumulator taking 38 distinct values across that window, and the `+14h` PORTA bit read as
set throughout. With portamento **off** the two words never diverged in 70 samples. Outside a glide
both hold the current note's value, which is why they looked like duplicates at first. Both are
half the value of `+11h/+12h` for the same note.

`@UNSURE:` exactly how the accumulator feeds the μPD933 has not been traced.

Incidentally, a Solo-mode glide drives **two** voice entries with identical ramps (0 and 5 in the
observed run), not one.

In the routine spanning `LAB_7b6e`–`LAB_7bd3`, register **B holds a working copy of field `+15`**
and **C a working copy of field `+14`** (see `ANI B,~VOICE_INFO_8640_15_10`). Bit operations on
B/C there are therefore operating on those fields, not on whatever was last in A.

A scan of every `VOICE_INFO_8640_<field>_<mask>` use against the field it is applied to found **no
mismatches** — masks are only ever used on their own field.

`@TODO:` no field constants exist for `+24` (the high half of the `+23` word), `+26` or `+27`.
