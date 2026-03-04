; =============================================================================
; CASIO CZ101 V2 ROM DISASSEMBLY
; Annotated by AJXS: https://ajxs.me/ https://github.com/ajxs
; =============================================================================

; =============================================================================
; Variables in internal RAM.
; =============================================================================
ram_start:                                                      EQU 8000h
midi_channel_basic_8000:                                        EQU 8000h
master_tune_8001:                                               EQU 8001h
MAYBE_key_transpose_8002:                                       EQU 8002h
pitch_bend_range_8003:                                          EQU 8003h
portamento_time_8004:                                           EQU 8004h
tone_mix_UNKNOWN_8005:                                          EQU 8005h
tone_mix_UNKNOWN_8006:                                          EQU 8006h
patch_index_tone_mix_8007:                                      EQU 8007h
patch_index_compare_8008:                                       EQU 8008h
keyboard_UNKNOWN_8010:                                          EQU 8010h
keyboard_UNKNOWN_8011:                                          EQU 8011h
; The currently active input matrix line. e.g. KC1-16 in the service manual.
; Set to 0xFF when no input line is active.
input_active_line_8012:                                         EQU 8012h
UNKNOWN_keyboard_flags_8013:                                    EQU 8013h
; Set to 0x80 when MIDI note on.
; Set to 0 when keyboard note on.
current_note_event_origin_8015:                                 EQU 8015h
local_mode_keyboard_disabled_8016:                              EQU 8016h
led_4_state_8017:                                               EQU 8017h
led_3_state_8018:                                               EQU 8018h
led_2_state_8019:                                               EQU 8019h
led_1_state_801a:                                               EQU 801ah
channel_pflags_0_801b:                                          EQU 801bh
channel_pflags_1_801c:                                          EQU 801ch
channel_pflags_2_801d:                                          EQU 801dh
channel_pflags_3_801e:                                          EQU 801eh
write_button_currently_pressed_8021:                            EQU 8021h

; Set to 0 if cartridge is inserted, 1 if not.
cartridge_disconnected_8022:                                    EQU 8022h
ignore_sending_vibrato_enable_cc_8023:                          EQU 8023h
ui_flag_set_when_editing_8024:                                  EQU 8024h
currently_selected_solo_midi_channel_8025:                      EQU 8025h
patch_index_8026:                                               EQU 8026h
UNKNOWN_patch_index_8027:                                       EQU 8027h
MAYBE_patch_index_save_8028:                                    EQU 8028h
patch_index_channel_0_8029:                                     EQU 8029h
patch_index_channel_1_802a:                                     EQU 802ah
patch_index_channel_2_802b:                                     EQU 802bh
patch_index_channel_3_802c:                                     EQU 802ch
channel_flags_0_802d:                                           EQU 802dh
channel_flags_1_802e:                                           EQU 802eh
channel_flags_2_802f:                                           EQU 802fh
channel_flags_3_8030:                                           EQU 8030h
UNKNOWN_flags_8031:                                             EQU 8031h
midi_basic_channel_override_8032:                               EQU 8032h
midi_basic_channel_overridden_8033:                             EQU 8033h
midi_incoming_solo_voice_index_8034:                            EQU 8034h
; There seems to be some evidence that the code in this firmware is, or could
; have been shared between different CZ synths.
; Potentially this value could have been configured based on what degree of
; multitimbrality the synth supports.
midi_solo_max_voice_index_8035:                                 EQU 8035h
midi_prog_change_disabled_8036:                                 EQU 8036h
ui_flags_8037:                                                  EQU 8037h

; Bit 0 = Value Down.
; Bit 1 = Osc 2.
; Bit 2-5: Env type.
;  0b00000100 = DCA
;  0b00001000 = DCW
;  0b00010000 = DCO
; ...
ui_flags_8038:                                                  EQU 8038h
env_currently_selected_step_8039:                               EQU 8039h
env_currently_selected_end_803a:                                EQU 803ah
; Bit 7 indicates sustain.
MAYBE_env_currently_selected_level_803b:                        EQU 803bh
ui_env_level_print_value_803c:                                  EQU 803ch
ui_env_rate_print_value_803d:                                   EQU 803dh
env_currently_selected_data_ptr_803e:                           EQU 803eh
midi_tx_data_pending_8040:                                      EQU 8040h
battery_level_8041:                                             EQU 8041h
; This flag is set by all input handlers when a new input is received.
; It signals to ignore APO functionality.
input_received_ignore_apo_flag_8042:                            EQU 8042h
input_button_repeat_timer_current_8044:                         EQU 8044h
input_button_repeat_timer_max_8045:                             EQU 8045h
lcd_counter_update_8046:                                        EQU 8046h
; @TODO: Why does the firmware need two counters?
; Especially since the total value is the size of a single byte.
lcd_counter_blink_timeout_1_8047:                               EQU 8047h
lcd_counter_blink_timeout_2_8048:                               EQU 8048h
lcd_flags_8049:                                                 EQU 8049h
p_button_hold_counter_804a:                                     EQU 804ah
midi_pitch_bend_incoming_value_804b:                            EQU 804bh
apo_timeout_counter_1_804c:                                     EQU 804ch
apo_timeout_counter_2_804e:                                     EQU 804eh
power_button_blink_counter_8050:                                EQU 8050h
power_button_blink_flag_8051:                                   EQU 8051h
ui_current_screen_8052:                                         EQU 8052h
lcd_cursor_position_count_8053:                                 EQU 8053h
lcd_print_number_position_count_8054:                           EQU 8054h
ui_cursor_index_8055:                                           EQU 8055h
midi_buffer_offset_rx_write_8056:                               EQU 8056h
midi_buffer_offset_rx_read_8057:                                EQU 8057h
midi_buffer_offset_tx_write_8058:                               EQU 8058h
midi_buffer_offset_tx_read_8059:                                EQU 8059h
midi_incoming_command_byte_805a:                                EQU 805ah
; This flag byte is used to decide whether to store the incoming MIDI data byte
; in the first, or second position.
midi_incoming_data_index_flag_805b:                             EQU 805bh
midi_previous_message_type_805c:                                EQU 805ch
midi_incoming_data_first_byte_805d:                             EQU 805dh
midi_incoming_data_second_byte_805e:                            EQU 805eh
midi_sysex_rx_active_805f:                                      EQU 805fh
midi_sysex_rx_timeout_counter_2_8060:                           EQU 8060h
midi_sysex_rx_timeout_counter_1_8061:                           EQU 8061h
midi_sysex_rx_timeout_flag_8062:                                EQU 8062h

; The internal SysEx function.
; Used by the internal MIDI processing state machine to tell the synth
; which incoming data to expect next.
MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_SEND:                    EQU 1
MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_RECEIVE:                 EQU 2
MIDI_SYSEX_FUNCTION_QUERY_PROGRAMMER:                           EQU 4

midi_sysex_function_2_8063:                                     EQU 8063h
midi_sysex_incoming_header_stage_8064:                          EQU 8064h
UNKNOWN_midi_sysex_8065:                                        EQU 8065h
midi_sysex_function_8066:                                       EQU 8066h
MAYBE_midi_sysex_patch_pointer_8067:                            EQU 8067h
MAYBE_midi_sysex_patch_pointer_8068:                            EQU 8068h
sysex_patch_index_UNKNOWN_8069:                                 EQU 8069h
unknown_806a:                                                   EQU 806ah
UNKNOWN_counter_806b:                                           EQU 806bh

MAYBE_pitch_bend_increment_80c0:                                EQU 80c0h
upd933_data_waveform_index_80c2:                                EQU 80c2h
upd933_data_waveform_msb_80c3:                                  EQU 80c3h
upd933_data_waveform_lsb_80c4:                                  EQU 80c4h
upd933_data_pitch_index_80c5:                                   EQU 80c5h
upd933_data_pitch_msb_80c6:                                     EQU 80c6h
upd933_data_pitch_lsb_80c7:                                     EQU 80c7h

FLAGS_80C8_80:                                                  EQU 1 << 7
FLAGS_80C8_BEND_POLARITY_NEGATIVE_BIT:                          EQU 6
FLAGS_80C8_BEND_POLARITY_NEGATIVE:                              EQU 1 << 6
FLAGS_80C8_20_BIT:                                              EQU 5
FLAGS_80C8_20:                                                  EQU 1 << 5
FLAGS_80C8_10:                                                  EQU 10h
FLAGS_80C8_8_BIT:                                               EQU 3
FLAGS_80C8_8:                                                   EQU 8h
FLAGS_80C8_1_BIT:                                               EQU 0
FLAGS_80C8_1:                                                   EQU 1

UNKNOWN_flags_80c8:                                             EQU 80c8h

FLAGS_80C9_1:                                                   EQU 1
FLAGS_80C9_2:                                                   EQU 2
FLAGS_80C9_10:                                                  EQU 10h
FLAGS_80C9_PITCH_BEND_ACTIVE:                                   EQU 80h

UNKNOWN_flags_80c9:                                             EQU 80c9h
upd933_data_master_tune_80ca:                                   EQU 80cah
pitch_bend_input_80cc:                                          EQU 80cch
portamento_freq_increment_80cd:                              EQU 80cdh
UNKNOWN_pitch_bend_word_80cf:                                   EQU 80cfh
UNKNOWN_pointer_to_patch_data_80d1:                             EQU 80d1h
MAYBE_voice_number_80d3:                                        EQU 80d3h
UNKNOWN_voice_number_bitmask_80D4:                              EQU 80D4h
voice_number_80d5:                                              EQU 80d5h
data_80D6:                                                      EQU 80D6h
unknown_pointer_to_8600_array_80d7:                             EQU 80d7h
UNKNOWN_pointer_to_voice_data_80d9:                             EQU 80d9h
UNKNOWN_pointer_to_voice_data_80db:                             EQU 80dbh
UNKNOWN_pointer_to_voice_data_80dd:                             EQU 80ddh
UNKNOWN_pointer_80df:                                           EQU 80dfh
unknown_pointer_80e1:                                           EQU 80e1h
unknown_pointer_80e3:                                           EQU 80e3h
UNKNOWN_flags_80e5:                                             EQU 80e5h
data_80e6:                                                      EQU 80e6h
upd933_pending_data_80e7:                                       EQU 80e7h
intein_intad_pending_flag_80ea:                                 EQU 80eah
pitch_bend_value_initial_80eb:                                  EQU 80EBh
pitch_bend_input_threshold_upper_80ec:                          EQU 80ECh
pitch_bend_input_threshold_lower_80ed:                          EQU 80EDh
pitch_bend_input_threshold_range_80ee:                          EQU 80EEh
pitch_bend_value_new_80ef:                                      EQU 80EFh
pitch_bend_value_current_80f0:                                  EQU 80f0h
UNKNOWN_pitch_bend_80f1:                                        EQU 80f1h
MAYBE_pitch_bend_initial_polarity_80f2:                         EQU 80f2h
data_80f3:                                                      EQU 80f3h
data_80f4:                                                      EQU 80f4h
; Array with size 8...
voice_array_80f5:                                               EQU 80f5h
index_into_80f5_array_80fd:                                     EQU 80fdh
; Bit 0 = Wheel active?
MAYBE_pitch_bend_wheel_active_flag_80fe:                        EQU 80feh
channel_info_0_8100:                                            EQU 8100h
channel_info_1_810b:                                            EQU 810bh
channel_info_2_8116:                                            EQU 8116h
channel_info_3_8121:                                            EQU 8121h
keyboard_key_states_UNKNOWN_8130:                               EQU 8130h
switch_states_8134:                                             EQU 8134h
keyboard_key_states_UNKNOWN_8135:                               EQU 8135h
input_group_kc9_lines_2_6_8164:                                 EQU 8164h
input_group_kc10_8166:                                          EQU 8166h
; @TODO: Why is this referenced, as opposed to the start of the array?
input_group_kc10_UNKNOWN_816a:                                  EQU 816ah
input_group_kc13_8178:                                          EQU 8178h
input_group_kc16_818a:                                          EQU 818ah

; Length: 8.
; Stores the note number for each voice. Bit 7 indicates whether the note is
; currently active.
voice_note_numbers_8190:                                        EQU 8190h
voice_unknown_8198:                                             EQU 8198h
UNUSED_data_81a0:                                               EQU 81a0h
lcd_cursor_index_positions_81a2:                                EQU 81a2h
lcd_print_number_indexes_81a9:                                  EQU 81a9h
lcd_print_number_ascii_81b0:                                    EQU 81b0h
lcd_print_number_ascii_2_81b2:                                  EQU 81b2h
lcd_contents_line_1_81b4:                                       EQU 81b4h
lcd_contents_line_2_81c4:                                       EQU 81c4h
midi_outgoing_8200:                                             EQU 8200h
patch_buffer_edit_8300:                                         EQU 8300h
patch_buffer_compare_8380:                                      EQU 8380h
midi_data_incoming_8400:                                        EQU 8400h
midi_sysex_array_8500:                                          EQU 8500h
; 4 entries of size 0x10.
unknown_voice_data_8600:                                        EQU 8600h

; 8 entries size 0x28 = 320 bytes?
; Ends at 0x8780.
; See associated structure definitions.
MAYBE_voice_data_8640:                                          EQU 8640h
MAYBE_voice_data_entry_1_8668:                                  EQU 8668h
MAYBE_voice_data_entry_2_8690:                                  EQU 8690h
MAYBE_voice_data_entry_3_86b8:                                  EQU 86b8h
MAYBE_voice_data_entry_4_86e0:                                  EQU 86e0h
MAYBE_voice_data_entry_5_8708:                                  EQU 8708h
MAYBE_voice_data_entry_6_8730:                                  EQU 8730h
MAYBE_voice_data_entry_7_8758:                                  EQU 8758h

patch_buffer_internal_8800:                                     EQU 8800h
debug_function_8810:                                            EQU 8810h
cartridge_memory_9000:                                          EQU 9000h
led_4_9800:                                                     EQU 9800h
led_3_a000:                                                     EQU 0a000h
led_2_a800:                                                     EQU 0a800h
led_1_b000:                                                     EQU 0b000h
keyboard_switch_matrix_b800:                                    EQU 0b800h
upd933_c000:                                                    EQU 0c000h

; In the CZ-101 ROM the V register is always set to 0x8000, the start of RAM.
; This macro constructs the offset from the start of RAM used for all
; instructions taking a relative offset.
V_OFFSET FUNCTION offset, offset - ram_start

UI_SCREEN_DCO1_WAVEFORM:                        EQU 00h
UI_SCREEN_DCO1_ENV:                             EQU 01h
UI_SCREEN_DCW1_KEY_FOLLOW:                      EQU 02h
UI_SCREEN_DCW1_ENV:                             EQU 03h
UI_SCREEN_DCA1_KEY_FOLLOW:                      EQU 04h
UI_SCREEN_DCA1_ENV:                             EQU 05h
UI_SCREEN_DCO2_WAVEFORM:                        EQU 06h
UI_SCREEN_DCO2_ENV:                             EQU 07h
UI_SCREEN_DCW2_KEY_FOLLOW:                      EQU 08h
UI_SCREEN_DCW2_ENV:                             EQU 09h
UI_SCREEN_DCA2_KEY_FOLLOW:                      EQU 0Ah
UI_SCREEN_DCA2_ENV:                             EQU 0Bh
UI_SCREEN_VIBRATO:                              EQU 0Ch
UI_SCREEN_OCTAVE:                               EQU 0Dh
UI_SCREEN_DETUNE:                               EQU 0Eh
UI_SCREEN_F:                                    EQU 0Fh
UI_SCREEN_KEY_TRANSPOSE:                        EQU 10h
UI_SCREEN_BEND_RANGE:                           EQU 11h
UI_SCREEN_PORTAMENTO:                           EQU 13h
UI_SCREEN_PATCH_MAYBE:                          EQU 15h
UI_SCREEN_TONE_MIX:                             EQU 16h
UI_SCREEN_MIDI_SOLO_MODE:                       EQU 17h
UI_SCREEN_MIDI:                                 EQU 18h
UI_SCREEN_19:                                   EQU 19h
UI_SCREEN_WRITE_SAVE_SELECT_MEMORY:             EQU 1Ah
UI_SCREEN_WRITE_SAVE_OK:                        EQU 1Bh
UI_SCREEN_WRITE_SAVE:                           EQU 1Ch
UI_SCREEN_WRITE_LOAD:                           EQU 1Dh
UI_SCREEN_1E:                                   EQU 1Eh
UI_SCREEN_1F:                                   EQU 1Fh

FLAGS_8031_SOLO_MODE_BIT:                       EQU 2
FLAGS_8031_SOLO_MODE:                           EQU 1 << 2
FLAGS_8031_TONE_MIX_BIT:                        EQU 3
FLAGS_8031_TONE_MIX:                            EQU 1 << 3


MKL_MKT0:                                       EQU 1 << 1
MKL_MKT1:                                       EQU 1 << 2
MKL_MK1:                                        EQU 1 << 3
MKL_MK2:                                        EQU 1 << 4
MKL_MKE0:                                       EQU 1 << 5
MKL_MKE1:                                       EQU 1 << 6
MKL_MKEIN:                                      EQU 1 << 7

MKH_MKAD:                                       EQU 1

PATCH_FLAGS_MODIFIED:                           EQU 1 << 7
PATCH_FLAGS_CARTRIDGE:                          EQU 1 << 6
PATCH_FLAGS_INTERNAL:                           EQU 1 << 5
PATCH_FLAGS_10:                                 EQU 1 << 4

FLAGS_8037_80:                                  EQU 1 << 7
FLAGS_8037_40:                                  EQU 1 << 6
FLAGS_8037_BUTTON_HELD:                         EQU 1

UI_FLAGS_BIT_VALUE_DOWN:                        EQU 0
UI_FLAGS_ENV_OSC_2_BIT:                         EQU 1
UI_FLAGS_ENV_DCA_BIT:                           EQU 2
UI_FLAGS_ENV_DCW_BIT:                           EQU 3
UI_FLAGS_BIT_6:                                 EQU 6

UI_FLAGS_VALUE_DOWN:                            EQU 1 << 0
UI_FLAGS_ENV_OSC_2:                             EQU 1 << 1
UI_FLAGS_ENV_DCA:                               EQU 1 << 2
UI_FLAGS_ENV_DCW:                               EQU 1 << 3
UI_FLAGS_ENV_DCO:                               EQU 1 << 4
UI_FLAGS_20:                                    EQU 1 << 5
UI_FLAGS_40:                                    EQU 1 << 6

UPD933_DCA_STEP:                                EQU 0
UPD933_DCO_STEP:                                EQU 10h
UPD933_DCW_STEP:                                EQU 20h
UPD933_PITCH:                                   EQU 60h
UPD933_WAVEFORM:                                EQU 68h
UPD933_UNKNOWN:                                 EQU 98h

BUTTON_PORTA_ON                                 EQU 00h
BUTTON_PORTA_TIME                               EQU 02h
BUTTON_VIBRATO_ON_OFF                           EQU 04h
BUTTON_BEND_RANGE                               EQU 06h
BUTTON_PRESET                                   EQU 08h
BUTTON_INTERNAL                                 EQU 0Ah
BUTTON_CARTRIDGE                                EQU 0Ch
BUTTON_COMPARE                                  EQU 0Eh
BUTTON_SOLO                                     EQU 10h
BUTTON_TONE_MIX                                 EQU 12h
BUTTON_TONE_KEY_TRANSPOSE                       EQU 14h
BUTTON_WRITE                                    EQU 16h
BUTTON_MIDI                                     EQU 18h
BUTTON_SELECT                                   EQU 1Ch
BUTTON_PATCH_1                                  EQU 20h
BUTTON_PATCH_2                                  EQU 22h
BUTTON_PATCH_3                                  EQU 24h
BUTTON_PATCH_4                                  EQU 26h
BUTTON_PATCH_5                                  EQU 28h
BUTTON_PATCH_6                                  EQU 2Ah
BUTTON_PATCH_7                                  EQU 2Ch
BUTTON_PATCH_8                                  EQU 2Eh
BUTTON_VALUE_DOWN                               EQU 30h
BUTTON_VALUE_UP                                 EQU 32h
BUTTON_CURSOR_LEFT                              EQU 34h
BUTTON_CURSOR_RIGHT                             EQU 36h
BUTTON_ENV_STEP_DOWN                            EQU 38h
BUTTON_ENV_STEP_UP                              EQU 3Ah
BUTTON_ENV_SUSTAIN                              EQU 3Ch
BUTTON_ENV_END                                  EQU 3Eh
BUTTON_VIBRATO                                  EQU 42h
BUTTON_DCO1_WAVEFORM                            EQU 44h
BUTTON_DCO1_ENV                                 EQU 46h
BUTTON_DCW1_KEY_FOLLOW                          EQU 48h
BUTTON_DCW1_ENV                                 EQU 4Ah
BUTTON_DCA1_KEY_FOLLOW                          EQU 4Ch
BUTTON_DCA1_ENV                                 EQU 4Eh
BUTTON_INIT                                     EQU 50h
BUTTON_OCTAVE                                   EQU 52h
BUTTON_DCO2_WAVEFORM                            EQU 54h
BUTTON_DCO2_ENV                                 EQU 56h
BUTTON_DCW2_KEY_FOLLOW                          EQU 58h
BUTTON_DCW2_ENV                                 EQU 5Ah
BUTTON_DCA2_KEY_FOLLOW                          EQU 5Ch
BUTTON_DCA2_ENV                                 EQU 5Eh
BUTTON_DETUNE                                   EQU 60h
BUTTON_LINE_SELECT                              EQU 62h
BUTTON_MOD_RING                                 EQU 64h
BUTTON_MOD_NOISE                                EQU 66h
BUTTON_TUNE_DOWN                                EQU 68h
BUTTON_TUNE_UP                                  EQU 6Ah

KEYBOARD_NOTE_ON:                               EQU 80h

LCD_FLAGS_UPDATE_BIT:                           EQU 0
LCD_FLAGS_CURSOR_OFF_BIT:                       EQU 1
LCD_FLAGS_CURSOR_ENABLE_BIT:                    EQU 7

PATCH_PFLAG_LINE_SELECT_1:                      EQU 0
PATCH_PFLAG_LINE_SELECT_2:                      EQU 1
PATCH_PFLAG_LINE_SELECT_1_2:                    EQU 2
PATCH_PFLAG_LINE_SELECT_1_1:                    EQU 3

PATCH_PFLAG_OCTAVE_MASK:                        EQU 0Ch

; Line Select Values.
; 0b00: Line 1.
; 0b01: Line 2.
; 0b10: Line 1+2.
; 0b11: Line 1+1.
PATCH_PFLAG:                                    EQU 00h
PATCH_DETUNE_POLARITY:                          EQU 01h
PATCH_DETUNE_FINE:                              EQU 02h
PATCH_DETUNE_NOTES:                             EQU 03h
PATCH_LFO_WAVE:                                 EQU 04h
PATCH_LFO_DELAY:                                EQU 05h
PATCH_LFO_DELAY_LSB:                            EQU 06h
PATCH_LFO_RATE:                                 EQU 08h
PATCH_LFO_RATE_LSB:                             EQU 09h
PATCH_LFO_DEPTH:                                EQU 0Bh
PATCH_LFO_DEPTH_LSB:                            EQU 0Ch
PATCH_DCO1_WAVEFORM_1:                          EQU 0Eh
PATCH_F:                                        EQU 0Fh
PATCH_DCA1_KEY_FOLLOW:                          EQU 10h
PATCH_11:                                       EQU 11h
PATCH_DCW1_KEY_FOLLOW:                          EQU 12h
PATCH_13:                                       EQU 13h
PATCH_DCA1_ENV_STEP_END:                        EQU 14h
PATCH_DCA1_ENV_STEP_1_RATE:                     EQU 15h
PATCH_DCA1_ENV_STEP_1_LEVEL:                    EQU 16h
PATCH_DCW1_ENV_STEP_END:                        EQU 25h
PATCH_DCW1_ENV_STEP_1_RATE:                     EQU 26h
PATCH_DCO1_ENV_STEP_END:                        EQU 36h
PATCH_DCO1_ENV_STEP_1_RATE:                     EQU 37h
PATCH_DCO2_WAVEFORM_1:                          EQU 47h
PATCH_DCA2_KEY_FOLLOW:                          EQU 49h
PATCH_4A:                                       EQU 4Ah
PATCH_DCW2_KEY_FOLLOW:                          EQU 4Bh
PATCH_4C:                                       EQU 4Ch
PATCH_DCA2_ENV_STEP_END:                        EQU 4Dh
PATCH_DCA2_ENV_STEP_1_RATE:                     EQU 4Eh
PATCH_DCW2_ENV_STEP_END:                        EQU 5Eh
PATCH_DCW2_ENV_STEP_1_RATE:                     EQU 5Fh
PATCH_DCO2_ENV_STEP_END:                        EQU 6Fh
PATCH_DCO2_ENV_STEP_1_RATE:                     EQU 70h

; Channel flags array at 0x802D.
CHANNEL_FLAGS_TONE_MIX:                         EQU 1 << 0
CHANNEL_FLAGS_VIBRATO:                          EQU 1 << 4
CHANNEL_FLAGS_PORTA:                            EQU 1 << 5
CHANNEL_FLAGS_MODIFIED_MAYBE:                   EQU 1 << 7

; Channel info array 0x8100.
CHANNEL_INFO_FLAGS:                             EQU 0
CHANNEL_INFO_LAST_VOICE_NUMBER_MAYBE:           EQU 1
CHANNEL_INFO_NOTE_COUNT:                        EQU 2
CHANNEL_INFO_3:                                 EQU 3
CHANNEL_INFO_5:                                 EQU 5
CHANNEL_INFO_7:                                 EQU 7
CHANNEL_INFO_9:                                 EQU 9


CHANNEL_INFO_FLAGS_80:                          EQU 1 << 7
CHANNEL_INFO_FLAGS_8:                           EQU 1 << 3
CHANNEL_INFO_FLAGS_SOLO:                        EQU 1 << 2
CHANNEL_INFO_FLAGS_PORTA:                       EQU 1 << 1
CHANNEL_INFO_FLAGS_TONE_MIX:                    EQU 1 << 0

; Unknown voice data structure at 8600h
VOICE_DATA_8600_0:                              EQU 00h
VOICE_DATA_8600_0_2:                            EQU 10b
VOICE_DATA_8600_1:                              EQU 01h
VOICE_DATA_8600_2:                              EQU 02h
VOICE_DATA_8600_4:                              EQU 04h
VOICE_DATA_8600_6:                              EQU 06h
VOICE_DATA_8600_8:                              EQU 08h
VOICE_DATA_8600_A:                              EQU 0Ah
VOICE_DATA_8600_C:                              EQU 0Ch

; Voice info structure at 8640h
VOICE_INFO_8640_0_VOICE_NUMBER:                 EQU 00h
VOICE_INFO_8640_1_PTR_TO_OTHER_VOICE:           EQU 01h
VOICE_INFO_8640_2:                              EQU 02h
VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE:           EQU 03h
VOICE_INFO_8640_4:                              EQU 04h
VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT:        EQU 05h
VOICE_INFO_8640_6:                              EQU 06h
VOICE_INFO_8640_7_PTR_TO_8600:                  EQU 07h
VOICE_INFO_8640_8_WORD:                         EQU 08h
VOICE_INFO_8640_9:                              EQU 09h
VOICE_INFO_8640_a:                              EQU 0ah
VOICE_INFO_8640_b:                              EQU 0bh
VOICE_INFO_8640_C_WORD:                         EQU 0ch
VOICE_INFO_8640_d:                              EQU 0dh
VOICE_INFO_8640_e:                              EQU 0eh
VOICE_INFO_8640_F_WORD:                         EQU 0fh
VOICE_INFO_8640_10:                             EQU 010h
VOICE_INFO_8640_11_FREQUENCY:                   EQU 011h
VOICE_INFO_8640_12_FREQUENCY_HIGH:              EQU 012h

; Flags?
VOICE_INFO_8640_13_FLAGS_UNKNOWN:               EQU 013h

VOICE_INFO_8640_13_80:                          EQU 1 << 7
VOICE_INFO_8640_13_40:                          EQU 1 << 6
VOICE_INFO_8640_13_8:                           EQU 1 << 3
VOICE_INFO_8640_13_4:                           EQU 1 << 2
VOICE_INFO_8640_13_1:                           EQU 1


VOICE_INFO_8640_14_FLAGS_UNKNOWN:               EQU 014h

VOICE_INFO_8640_14_VIBRATO_ENABLED:             EQU 1
VOICE_INFO_8640_14_8:                           EQU 1 << 3
VOICE_INFO_8640_14_PORTA:                       EQU 1 << 4


VOICE_INFO_8640_15_FLAGS_UNKNOWN:               EQU 015h

; Top 4 bits seem to indicate line select / Vibrato.
VOICE_INFO_8640_15_80:                          EQU 1 << 7
; This bit seems to select between oscillators?
VOICE_INFO_8640_15_40:                          EQU 1 << 6
; This bit seems to be set when vibrato disabled.
VOICE_INFO_8640_15_20:                          EQU 1 << 5
VOICE_INFO_8640_15_10:                          EQU 1 << 4
VOICE_INFO_8640_15_8:                           EQU 1 << 3
VOICE_INFO_8640_15_4:                           EQU 1 << 2
VOICE_INFO_8640_15_TONE_MIX:                    EQU 1 << 1
VOICE_INFO_8640_15_1:                           EQU 1

; Flags?
VOICE_INFO_8640_16:                             EQU 016h

; These are set in the uPD933 IRQ handlers to indicate an envelope step
; is finished?
VOICE_INFO_8640_16_DCO_ENV_STEP_FINISHED_MAYBE: EQU 40h
VOICE_INFO_8640_16_DCW_ENV_STEP_FINISHED_MAYBE: EQU 20h
VOICE_INFO_8640_16_DCA_ENV_STEP_FINISHED_MAYBE: EQU 10h
VOICE_INFO_8640_16_4:                           EQU 4h
VOICE_INFO_8640_16_2:                           EQU 2
VOICE_INFO_8640_16_1:                           EQU 1

VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE:  EQU 017h
VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE:  EQU 018h

VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE:  EQU 019h
VOICE_INFO_8640_1A_WORD_UNKNOWN:                EQU 01ah
VOICE_INFO_8640_1E_PITCH_UNKNOWN:               EQU 01eh
VOICE_INFO_8640_1F:                             EQU 01fh
VOICE_INFO_8640_20:                             EQU 020h
VOICE_INFO_8640_21:                             EQU 021h
VOICE_INFO_8640_22:                             EQU 022h
VOICE_INFO_8640_23:                             EQU 023h
VOICE_INFO_8640_25:                             EQU 025h
VOICE_INFO_8640_47:                             EQU 047h

LED_1_COMPARE:                                  EQU 1 << 0
LED_1_CARTRIDGE:                                EQU 1 << 1
LED_1_INTERNAL:                                 EQU 1 << 2
LED_1_PRESET:                                   EQU 1 << 3
LED_1_TONE_MIX:                                 EQU 1 << 4
LED_1_SOLO:                                     EQU 1 << 5
LED_1_VIBRATO:                                  EQU 1 << 6
LED_1_PORTA:                                    EQU 1 << 7

LED_2_SELECT:                                   EQU 1 << 7

LED_4_POWER:                                    EQU 1 << 0
LED_4_RING:                                     EQU 1 << 1
LED_4_NOISE:                                    EQU 1 << 2
LED_4_LINE_1_1:                                 EQU 1 << 3
LED_4_LINE_1_2:                                 EQU 1 << 4
LED_4_LINE_2:                                   EQU 1 << 5
LED_4_LINE_1:                                   EQU 1 << 6


    ORG 0

; =============================================================================
RST0:
    JMP         reset_00c0
    DB          00h
NMI:
    JMP         power_down_4003
    DB          00h
INTT0_INTT1:
    JMP         INTT0_INTT1_4006
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
INT1_INT2:
    JMP         INT1_INT2_4009
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
INTE0_INTE1:
    JMP         INTE0_INTE1_400c
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
INTEIN_INTAD:
    JMP         INTEIN_INTAD_400f
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
INTSR_INTST:
    JMP         midi_handle_irq_4012
    DS 53
SOFTI:
    JMP         irq_return_4015
    DS 29
CALL_TABLE:
    DW          04020h
    DW          04023h
    DW          04026h
    DW          04029h
    DW          0402ch
    DW          0402fh
    DW          04032h
    DW          04035h
    DW          04038h
    DW          0403bh
    DW          0403eh
    DW          04041h
    DW          04044h
    DW          04047h
    DW          0404ah
    DW          0404dh
    DW          04050h
    DW          04053h
    DW          04056h
    DW          04059h
    DW          0405ch
    DW          0405fh
    DW          04062h
    DW          04065h
    DW          04068h
    DW          0406bh
    DW          0406eh
    DW          04071h
    DW          04074h
    DW          04077h
    DW          0407ah
    DW          0407dh

; =============================================================================
reset_00c0:
; Set memory mapping register.
; Enable on-chip RAM (RAE).
; Set MM0-MM2 to enable expansion mode.
    MVI         A,1111b
    MOV         MM,A
    JMP         reset_4000

; Unreachable code.
; This appears to be code for the CZ5000.
UNUSED_cz5000_read_from_upd933_00c7:
    ANI        PB,11111011b
    MOV        A,(8000h)
    ORI        PB,00000100b
    RET

UNUSED_cz5000_read_from_upd933_00d2:
    ANI        PB,11111011b
    LDAX       (HL)
    ORI        PB,00000100b
    RET

UNUSED_cz5000_read_from_upd933_2_00da:
    ANI        PB,11110111b
    MOV        A,(8000h)
    ORI        PB,00001000b
    RET

UNUSED_cz5000_read_from_upd933_00e5:
    ANI        PB,11110111b
    LDAX       (HL)
    ORI        PB,00001000b
    RET

; Probably for CZ230S?.
; Port B line matches Casio CZ230S schematic.
    ANI        PB,11011111b
    MOV        A,(2000h)
    ORI        PB,00100000b
    RET


; =============================================================================
upd933_read_byte_to_a_from_hl_00f8:
    ANI         PB,11011111b
    LDAX        (HL)
    ORI         PB,00100000b
    RET

; Unreachable code.
; This is possibly the UPD933 write routine for the CZ5000.
UNUSED_cz5000_write_to_upd933_0100:
    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11101011b
    JR         _write_to_upd933_0115

    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11100111b

_write_to_upd933_0115:
; Writes A, then EAL, then EAH to 0x8000.
    MOV        (8000h),A
    MOV        A,EAL
    MOV        (8000h),A
    MOV        A,EAH
    MOV        (8000h),A
    ORI        PB,00111100b
    EI
    RET

UNUSED_cz5000_write_to_upd933_0128:
    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11101011b
    JR         _write_to_upd933_013d

    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11100111b

_write_to_upd933_013d:
    MOV        (8000h),A
    MOV        A,EAL
    MOV        (8000h),A
    MOV        A,EAH
    MOV        (8000h),A
    SKIT       F2
    NOP
    ORI        PB,00111100b
    EI
    RET

UNUSED_cz5000_write_to_upd933_0153:
    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11101011b
    JR         _write_to_upd933_0168

    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11100111b

_write_to_upd933_0168:
    STAX       (HL)
    MOV        A,EAL
    STAX       (HL)
    MOV        A,EAH
    STAX       (HL)
    ORI        PB,00111100b
    EI
    RET

UNUSED_cz5000_write_to_upd933_0172:
    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11101011b
    JR         _write_to_upd933_0187
    ANI        PB,11011111b
    ORA        A,C
    NOP
    DI
    ANI        PB,11100111b

_write_to_upd933_0187:
    STAX       (HL)
    MOV        A,EAL
    STAX       (HL)
    MOV        A,EAH
    STAX       (HL)
    SKIT       F2
    NOP
    ORI        PB,00111100b
    EI
    RET

; Probably for CZ230S?.
; Port B line matches Casio CZ230S schematic.
    ANI        PB,01111111b
    ORA        A,C
    NOP
    DI
    ANI        PB,10011111b
    MOV        (2000h),A
    MOV        A,EAL
    MOV        (2000h),A
    MOV        A,EAH
    MOV        (2000h),A
    ORI        PB,11100000b
    EI
    RET

    ANI        PB,01111111b
    ORA        A,C
    NOP
    DI
    ANI        PB,10011111b
    MOV        (2000h),A
    MOV        A,EAL
    MOV        (2000h),A
    MOV        A,EAH
    MOV        (2000h),A
    SKIT       F1
    NOP
    ORI        PB,11100000b
    EI
    RET

    ANI        PB,01111111b
    ORA        A,C
    NOP
    DI
    ANI        PB,10011111b
    STAX       (HL)
    MOV        A,EAL
    STAX       (HL)
    MOV        A,EAH
    STAX       (HL)
    ORI        PB,11100000b
    EI
    RET

    ANI        PB,01111111b
    ORA        A,C
    NOP
    DI
    ANI        PB,10011111b
    STAX       (HL)
    MOV        A,EAL
    STAX       (HL)
    MOV        A,EAH
    STAX       (HL)
    SKIT       F1
    NOP
    ORI        PB,11100000b
    EI
    RET

    ORA        A,C
    DI
    ANI        PB,10011111b
    MOV        (2000h),A
    MOV        A,EAL
    MOV        (2000h),A
    MOV        A,EAH
    MOV        (2000h),A
    SKIT       F1
    NOP
    ORI        PB,01100000b
    EI
    RET


; =============================================================================
; @COMPLETE
; Selects the UPD933 register in C | A, then writes the voice data in EA.
; I'm not sure why the developers didn't hardcode the UPD933 address, possibly
; to allow for different UPD933 addresses in development hardware.
;
; HL: Pointer to the UPD933 address.
; EA: Voice data.
; A:  Voice number.
; C:  Register offset.
; =============================================================================
upd933_write_register_in_c_voice_a_data_in_ea_0218:
; Combine the register offset, and voice number.
    ORA         A,C
    DI

; Set write enable and chip select HIGH.
; The chip select line is used as part of R/W signalling.
    ANI         PB,10011111b
    STAX        (HL)
    MOV         A,EAL
    STAX        (HL)
    MOV         A,EAH
    STAX        (HL)
    SKIT        F1
    NOP
    ORI         PB,01100000b
    EI
    RET

; =============================================================================
; Performs a 16-bit multiplication.
; Essentially A * BC.
;
; Returns:
; EA: (A × BC) >> 8
; =============================================================================
multiply_a_by_bc_022b:
    PUSH        HL
; HL = A * C
    MUL         C
    DMOV        HL,EA
; EA = A * B
    MUL         B
; EA = EA + H
    MOV         A,H
    EADD        EA,A
    POP         HL
    RET

; =============================================================================
; Performs a 16-bit multiplication.
;
; Returns:
; EA: (A × BC) & 0xFFFF
; =============================================================================
multiply_a_by_bc_0236:
    PUSH        HL
; EA = A * C
    MUL         C
    PUSH        EA
; EA = A * B
    MUL         B

; HL = EA << 8.
    MOV         A,EAL
    MOV         H,A
    MVI         L,0

; EA = HL + EA.
    POP         EA
    DADD        EA,HL
    POP         HL
    RET

; =============================================================================
; 16-bit addition, saturating at 0xFFFF.
; =============================================================================
add_de_to_ea_clamp_at_ffff_0245:
    DADDNC      EA,DE
    LXI         EA,0ffffh
    RET

; =============================================================================
; 16-bit subtraction, saturating at 0x0000.
; =============================================================================
subtract_de_from_ea_clamp_at_0_024b:
    DSUBNB      EA,DE
    LXI         EA,0
    RET

; Unreachable code?
    DB          60h
    DB          025h
    DB          074h
    DB          044h
    DB          001h
    DB          0B8h
    DB          00Fh
    DB          048h
    DB          025h
    DB          01Fh
    DB          00Eh
    DB          048h
    DB          035h
    DB          01Eh
    DB          074h
    DB          034h
    DB          001h
    DB          0B8h
    DB          0F3h
    DB          00Eh
    DB          048h
    DB          021h
    DB          01Eh
    DB          00Fh
    DB          048h
    DB          031h
    DB          01Fh
    DB          074h
    DB          034h
    DB          001h
    DB          0B8h
    DB          0F3h
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          048h
    DB          0A8h
    DB          0B8h
    DB          001h
    DB          000h
    DB          002h
    DB          001h
    DB          004h
    DB          002h
    DB          008h
    DB          003h
    DB          010h
    DB          004h
    DB          020h
    DB          005h
    DB          40h
    DB          006h
    DB          80h
    DB          007h

; =============================================================================
; Very similar to vibrato update routines.
; Does this scale an 8-bit value into a 16-bit fixed point value?
; A:  100 - portamento_time
; Returns:
; BC: The calculated frequency increment.
; =============================================================================
portamento_time_modified_create_freq_increment_0287:
    MOV         C,A
    ANI         C,00001111b

    MOV         B,A
    ANI         B,01110000b

    MVI         A,0
    NEI         B,0
    JR          _exit_02a6

    ORI         C,10h

_loop_0298:
    NEI         B,10h
    JR          _exit_02a6

    SUI         B,10h
    STC
    RLL         C
    RLL         A
    JR          _loop_0298

_exit_02a6:
    MOV         B,A
    RET

; Unreachable code?
    DB          0B2h
    DB          01Ch
    DB          00Ah
    DB          40h
    DB          0F3h
    DB          002h
    DB          00Ch
    DB          03Bh
    DB          0A2h
    DB          0B8h
    DB          01Ch
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          40h
    DB          0F3h
    DB          002h
    DB          00Ch
    DB          03Bh
    DB          0B8h
    DB          01Ch
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          041h
    DB          40h
    DB          0F3h
    DB          002h
    DB          00Ch
    DB          03Bh
    DB          0B8h
    DB          40h
    DB          00Ah
    DB          003h
    DB          00Dh
    DB          03Dh
    DB          00Ch
    DB          03Dh
    DB          0B8h
    DB          00Ah
    DB          40h
    DB          0F3h
    DB          002h
    DB          02Bh
    DB          0B8h
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          40h
    DB          0F3h
    DB          002h
    DB          02Bh
    DB          0B8h
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          041h
    DB          40h
    DB          0F3h
    DB          002h
    DB          02Bh
    DB          0B8h
    DB          40h
    DB          00Ah
    DB          003h
    DB          02Dh
    DB          01Dh
    DB          02Dh
    DB          01Ch
    DB          0B8h
    DB          40h
    DB          00Bh
    DB          003h
    DB          0F7h
    DB          00Ah
    DB          60h
    DB          047h
    DB          048h
    DB          01Ah
    DB          074h
    DB          046h
    DB          001h
    DB          0B8h
    DB          00Ah
    DB          60h
    DB          045h
    DB          048h
    DB          01Ah
    DB          074h
    DB          044h
    DB          001h
    DB          0B8h
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          60h
    DB          0C1h
    DB          0E9h
    DB          00Ah
    DB          60h
    DB          0C1h
    DB          0E5h
    DB          00Dh
    DB          60h
    DB          047h
    DB          00Ch
    DB          60h
    DB          056h
    DB          0B8h
    DB          00Fh
    DB          60h
    DB          045h
    DB          00Eh
    DB          60h
    DB          054h
    DB          0B8h
    DB          00Bh
    DB          60h
    DB          047h
    DB          00Ah
    DB          60h
    DB          056h
    DB          0B8h
    DB          00Fh
    DB          60h
    DB          043h
    DB          00Eh
    DB          60h
    DB          052h
    DB          0B8h
    DB          00Dh
    DB          60h
    DB          067h
    DB          00Ch
    DB          60h
    DB          076h
    DB          0B8h
    DB          00Fh
    DB          60h
    DB          065h
    DB          00Eh
    DB          60h
    DB          074h
    DB          0B8h
    DB          40h
    DB          02Ah
    DB          003h
    DB          074h
    DB          16h
    DB          0FFh
    DB          074h
    DB          017h
    DB          0FFh
    DB          074h
    DB          047h
    DB          001h
    DB          048h
    DB          00Ah
    DB          0B8h
    DB          074h
    DB          046h
    DB          001h
    DB          0B8h
    DB          40h
    DB          031h
    DB          003h
    DB          074h
    DB          014h
    DB          0FFh
    DB          074h
    DB          015h
    DB          0FFh
    DB          074h
    DB          045h
    DB          001h
    DB          048h
    DB          00Ah
    DB          0B8h
    DB          074h
    DB          044h
    DB          001h
    DB          0B8h
    DB          00Eh
    DB          60h
    DB          0FCh
    DB          0CEh
    DB          00Fh
    DB          60h
    DB          0FDh
    DB          0C3h
    DB          069h
    DB          001h
    DB          0B8h
    DB          60h
    DB          0BDh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h
    DB          60h
    DB          0BCh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h
    DB          00Eh
    DB          60h
    DB          0FAh
    DB          0CEh
    DB          00Fh
    DB          60h
    DB          0FBh
    DB          0C3h
    DB          069h
    DB          001h
    DB          0B8h
    DB          60h
    DB          0BBh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h
    DB          60h
    DB          0BAh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h
    DB          00Ch
    DB          60h
    DB          0FAh
    DB          0CEh
    DB          00Dh
    DB          60h
    DB          0FBh
    DB          0C3h
    DB          069h
    DB          001h
    DB          0B8h
    DB          60h
    DB          0BBh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h
    DB          60h
    DB          0BAh
    DB          069h
    DB          002h
    DB          069h
    DB          004h
    DB          0B8h

pitch_bend_curve_03a9:
    DW          028h
    DW          051h
    DW          07Ah
    DW          0A3h
    DW          0CCh
    DW          0F5h
    DW          011Eh
    DW          0147h
    DW          0170h
    DW          0199h
    DW          01C2h
    DW          01EBh
    DB          00h
    DB          00h
    DB          1h
    DB          1h
    DB          1h
    DB          1h
    DB          2h
    DB          2h
    DB          2h
    DB          03h
    DB          03h
    DB          04h
    DB          04h
    DB          05h
    DB          05h
    DB          06h
    DB          06h
    DB          07h
    DB          07h
    DB          08h
    DB          09h
    DB          0Ah
    DB          0Bh
    DB          0Bh
    DB          0Ch
    DB          0Dh
    DB          0Eh
    DB          0Fh
    DB          011h
    DB          012h
    DB          013h
    DB          014h
    DB          16h
    DB          017h
    DB          019h
    DB          01Bh
    DB          01Dh
    DB          01Fh
    DB          021h
    DB          023h
    DB          025h
    DB          028h
    DB          02Ah
    DB          02Dh
    DB          30h
    DB          033h
    DB          036h
    DB          03Ah
    DB          03Dh
    DB          041h
    DB          045h
    DB          04Ah
    DB          04Eh
    DB          053h
    DB          059h
    DB          05Eh
    DB          064h
    DB          06Ah
    DB          071h
    DB          078h
    DB          07Fh
    DB          00h
    DB          2h
    DB          04h
    DB          06h
    DB          08h
    DB          0Ah
    DB          0Ch
    DB          0Eh
    DB          010h
    DB          013h
    DB          015h
    DB          017h
    DB          019h
    DB          01Bh
    DB          01Dh
    DB          01Fh
    DB          021h
    DB          023h
    DB          026h
    DB          028h
    DB          02Ah
    DB          02Ch
    DB          02Eh
    DB          30h
    DB          32h
    DB          034h
    DB          037h
    DB          039h
    DB          03Bh
    DB          03Dh
    DB          03Fh
    DB          041h
    DB          043h
    DB          045h
    DB          047h
    DB          04Ah
    DB          04Ch
    DB          04Eh
    DB          050h
    DB          052h
    DB          054h
    DB          056h
    DB          058h
    DB          05Bh
    DB          05Dh
    DB          05Fh
    DB          061h
    DB          063h
    DB          065h
    DB          067h
    DB          069h
    DB          06Bh
    DB          06Eh
    DB          070h
    DB          072h
    DB          074h
    DB          076h
    DB          078h
    DB          07Ah
    DB          07Ch
    DB          07Fh
    DB          00h
    DB          08h
    DB          011h
    DB          01Ah
    DB          024h
    DB          02Fh
    DB          03Ah
    DB          045h
    DB          052h
    DB          05Fh
    DB          00h
    DB          01Fh
    DB          02Ch
    DB          039h
    DB          046h
    DB          053h
    DB          60h
    DB          06Eh
    DB          092h
    DB          0FFh

data_044f:
    DB          066h
    DB          066h
    DB          065h
    DB          065h
    DB          064h
    DB          064h
    DB          063h
    DB          063h
    DB          062h
    DB          062h
    DB          061h
    DB          061h
    DB          60h
    DB          60h
    DB          05Fh
    DB          05Fh
    DB          05Eh
    DB          05Eh
    DB          05Dh
    DB          05Dh
    DB          05Ch
    DB          05Ch
    DB          05Bh
    DB          05Bh
    DB          05Ah
    DB          05Ah
    DB          059h
    DB          059h
    DB          058h
    DB          058h
    DB          057h
    DB          057h
    DB          056h
    DB          056h
    DB          055h
    DB          055h
    DB          054h
    DB          054h
    DB          053h
    DB          053h
    DB          052h
    DB          052h
    DB          051h
    DB          051h
    DB          050h
    DB          050h
    DB          04Fh
    DB          04Fh
    DB          04Eh
    DB          04Eh
    DB          04Dh
    DB          04Dh
    DB          04Ch
    DB          04Ch
    DB          04Bh
    DB          04Bh
    DB          04Ah
    DB          04Ah
    DB          049h
    DB          049h
    DB          048h
    DB          048h
    DB          047h
    DB          047h
    DB          046h
    DB          046h
    DB          045h
    DB          045h
    DB          044h
    DB          044h
    DB          038h
    DB          30h
    DB          028h
    DB          020h
    DB          018h
    DB          010h
    DB          08h

    DS 2913
    JMP         RST0
    DS 4093
    JMP         RST0

; =============================================================================
input_master_tune_up_2000:
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_VALUE_DOWN
    JR          input_master_tune_2007

; =============================================================================
input_master_tune_down_2004:
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN

; =============================================================================
input_master_tune_2007:
    ANIW        (V_OFFSET(ui_flags_8037)),00111111b
    ORIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_40

; Skips on return if button inactive.
    CALL        button_check_tune_down_501e
    JR          _is_tune_up_button_active_2014

    JMP         input_master_tune_inactive_2587
_is_tune_up_button_active_2014:
; Skips on return if button inactive.
    CALL        button_check_tune_up_501b

; If both master tune buttons active, reset?
    JMP         input_master_tune_both_active_2592
    CALL        input_master_tune_inactive_2587
    RET

; =============================================================================
input_value_up_201e:
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_VALUE_DOWN
    JR          input_value_up_down_2025

; =============================================================================
input_value_down_2022:
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN

input_value_up_down_2025:
    ANIW        (V_OFFSET(ui_flags_8037)),~(FLAGS_8037_80 | FLAGS_8037_40) & 0FFh
    ORIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_80

    CALL        ui_get_table_index_from_active_screen_2071
    TABLE
    JB
    DW          input_up_down_waveform_2512         ; 0x0
    DW          input_up_down_env_24ce
    DW          input_up_down_dcw1_key_follow_24e8
    DW          input_up_down_env_24ce
    DW          input_up_down_dca1_env_24e2         ; 0x4
    DW          input_up_down_env_24ce
    DW          input_up_down_waveform_2512
    DW          input_up_down_env_24ce
    DW          input_up_down_dcw2_key_follow_24eb  ; 0x8
    DW          input_up_down_env_24ce
    DW          input_up_down_dca2_env_24e5
    DW          input_up_down_env_24ce
    DW          input_up_down_vibrato_24e5          ; 0xC
    DW          input_up_down_octave_2548
    DW          input_up_down_detune_2526
    DW          return_4c35
    DW          input_up_down_key_transpose_257c    ; 0x10
    DW          input_up_down_bend_range_2571
    DW          return_4c35
    DW          input_up_down_portamento_2566
    DW          return_4c35                         ; 0x14
    DW          return_4c35
    DW          MAYBE_input_up_down_tone_mix_260c
    DW          input_up_down_midi_solo_mode_2622
    DW          input_up_down_midi_2617       ; 0x18
    DW          return_4c35
    DW          debug_mode_entry_25a2
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35

; =============================================================================
ui_get_table_index_from_active_screen_2071:
    MOV         A,(ui_current_screen_8052)
    SLL         A
    ANI         A,00111110b
    RET

; =============================================================================
MAYBE_main_button_hold_check_207a:
; Test if the a button has reached its hold-repeat threshold.
    ONIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_BUTTON_HELD
    RET

; Button held flag set.
; Clear flag.
    ANIW        (V_OFFSET(ui_flags_8037)),~FLAGS_8037_BUTTON_HELD
    OFFIW       (V_OFFSET(ui_flags_8037)),FLAGS_8037_80
    JR          _button_held_jumpoff_2099

; 80 flag not set.
    ONIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_40
    RET

; 40 flag set.
; Check if the 'Master Tune Down' button is active.
; Skips on return if button inactive.
    CALL        button_check_tune_down_501e
    JR          _button_tune_down_active_501e

    JMP         input_master_tune_not_both_active_2589

_button_tune_down_active_501e:
; Check if the 'Master Tune Up' button is also active.
; Skips on return if button inactive.
    CALL        button_check_tune_up_501b
    JMP         input_master_tune_both_active_2592

    JMP         input_master_tune_not_both_active_2589

; reached if the value up/down buttons are held for over a second.
_button_held_jumpoff_2099:
    CALL        ui_get_table_index_from_active_screen_2071
    TABLE
    JB
    DW          input_up_down_held_waveform_2514               ; 0x0
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_dcw1_key_follow_24f9
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_dca1_key_follow_24f3        ; 0x4
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_waveform_2514
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_dcw2_key_follow_24fc        ; 0x8
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_dca2_key_follow_24f6
    DW          input_up_down_held_env_24d0
    DW          input_up_down_held_vibrato_2553                ; 0xC
    DW          input_up_down_held_octave_254a
    DW          input_up_down_held_detune_2529
    DW          return_4c35
    DW          input_up_down_held_key_transpose_257e          ; 0x10
    DW          input_up_down_held_bend_range_2573
    DW          return_4c35
    DW          input_up_down_held_portamento_time_2568
    DW          return_4c35                                    ; 0x14
    DW          return_4c35
    DW          MAYBE_input_up_down_held_tone_mix_260e
    DW          input_up_down_held_midi_solo_mode_2624
    DW          input_up_down_held_midi_2619             ; 0x18
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35                                    ; 0x1C
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35

; =============================================================================
input_dco1_waveform_20df:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_20fb

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCO1_WAVEFORM

    LXI         DE,patch_buffer_edit_8300
    LDEAX       (DE+PATCH_DCO1_WAVEFORM_1)
    MOV         A,EAH
    ANI         A,00111111b
    LXI         EA,0
    MOV         EAH,A
    STEAX       (DE+PATCH_DCO1_WAVEFORM_1)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          _update_ui_and_exit_20ff

_init_button_inactive_20fb:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCO1_WAVEFORM

_update_ui_and_exit_20ff:
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_ENV_OSC_2
    CALL        led_3_dco_1_waveform_4cf3
    CALL        ui_reset_cursor_index_550d
    LDED        (patch_buffer_edit_8300 + PATCH_DCO1_WAVEFORM_1)
    CALL        ui_waveform_2a3c
    RET

; =============================================================================
input_dco2_waveform_2110:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_2125

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCO2_WAVEFORM

    LXI         DE,patch_buffer_edit_8300
    LXI         EA,0
    STEAX       (DE+PATCH_DCO2_WAVEFORM_1)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          _update_ui_and_exit_2129

_init_button_inactive_2125:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCO2_WAVEFORM

_update_ui_and_exit_2129:
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_OSC_2
    CALL        led_3_dco_2_waveform_4cff
    CALL        ui_reset_cursor_index_550d
    LDED        (patch_buffer_edit_8300 + PATCH_DCO2_WAVEFORM_1)
    CALL        ui_waveform_2a3c
    RET

; =============================================================================
; Skips on return if init button active.
; Pops HL if write button active, which will effectively cause the function to
; return one step higher in the call chain.
; Returns without doing either if both buttons inactive.
; =============================================================================
button_check_init_cancel_if_write_button_held_213a:
    CALL        button_check_write_5000
    JR          _write_button_active_2143

; Write button inactive.
    CALL        button_check_initialise_500f
    RETS

; Init button inactive.
    RET

_write_button_active_2143:
    POP         HL
    RET

; =============================================================================
; THIS FUNCTION LOADS A BYTE FROM AFTER THE
; FUNCTION CALL ADDRESS!!!!
; =============================================================================
set_current_ui_screen_2145:
    POP         HL
    LDAX        (HL+)
    PUSH        HL
    MOV         (ui_current_screen_8052),A
    RET

; =============================================================================
input_dca1_env_214d:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_2162

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCA1_ENV

; Copy init data into patch edit buffer.
    LXI         HL,patch_init_data_dca_2fac
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCA1_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          _initialise_dca_env_ui_2166

_init_button_inactive_2162:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCA1_ENV

_initialise_dca_env_ui_2166:
; Reset the currently selected step, and load the envelope's end point.
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCA1_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))
; Store a pointer to the envelope data.
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCA1_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
; Set the flags to indicate that this is a DCA envelope.
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_DCA

    CALL        led_3_dca_1_env_4cf9
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; Unreachable.
    RET

; =============================================================================
; Skips on return if:
; - Line select 2, and DCO1/DCW1/DCA1 screen active.
; - Line select 1, and DCO2/DCW2/DCA2 screen active.
; - Line select 1+2, and DCO2/DCW2/DCA2 screen active.
; =============================================================================
skips_on_return_based_on_ui_screen_and_line_select_2185:
; Load the pflag setting.
    LXI         DE,patch_buffer_edit_8300 + PATCH_PFLAG
    DW 00ABh   ;    LDAX        (DE+00h)
; Mask the line select setting.
    ANI         A,00000011b

; Return if line select is set to 1+1.
    NEI         A,PATCH_PFLAG_LINE_SELECT_1_1       ; Skip if (r≠byte)
    RET

; Is line 2 selected?
    NEI         A,PATCH_PFLAG_LINE_SELECT_2         ; Skip if (r≠byte)
    JR          _line_select_2_219d

    MOV         A,(ui_current_screen_8052)

; Skip on return if a DCO2/DCW2/DCA2 screen is active.
    LTI         A,12                                ; Skip if (r<byte)
    RET

    GTI         A,5                                 ; Skip if (r>byte)
    RET

    RETS

_line_select_2_219d:
; Skip on return if a DCO1/DCW1/DCA1 screen is active.
    MOV         A,(ui_current_screen_8052)
    LTI         A,12
    RET

    GTI         A,5
    RETS

    RET

; =============================================================================
input_dca2_env_21a8:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_21bd

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCA2_ENV

    LXI         HL,patch_init_data_dca_2fac
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCA2_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          LAB_21c1

_init_button_inactive_21bd:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCA2_ENV

LAB_21c1:
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCA2_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCA2_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_OSC_2 | UI_FLAGS_ENV_DCA
    CALL        led_3_dca_2_env_4d05
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; =============================================================================
input_dcw1_env_21df:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          init_button_inactive_21f4

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCW1_ENV

    LXI         HL,patch_init_data_dcw_UNKNOWN_2fbd
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCW1_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          LAB_21f8

init_button_inactive_21f4:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCW1_ENV

; Reset selected env sustain point??
LAB_21f8:
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCW1_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCW1_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_DCW
    CALL        led_3_dcw_1_env_4cf5
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; =============================================================================
input_dcw2_env_2216:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          LAB_222b

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCW2_ENV

    LXI         HL,patch_init_data_dcw_UNKNOWN_2fbd
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCW2_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          LAB_222f

LAB_222b:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCW2_ENV

LAB_222f:
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCW2_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCW2_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_OSC_2 | UI_FLAGS_ENV_DCW
    CALL        led_3_dcw_2_env_4d01
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; =============================================================================
input_dco1_env_224d:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          init_button_inactive_2262

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCO1_ENV

    LXI         HL,patch_init_data_dco_UNKNOWN_2fce
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCO1_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          reset_selected_env_step_2266

init_button_inactive_2262:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCO1_ENV

reset_selected_env_step_2266:
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCO1_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCO1_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_DCO
    CALL        led_3_dco_1_env_4cf1
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; =============================================================================
input_dco2_env_2284:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          init_button_inactive_2299

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCO2_ENV

    LXI         HL,patch_init_data_dco_UNKNOWN_2fce
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCO2_ENV_STEP_END
    MVI         C,10h
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          reset_selected_env_step_229d

init_button_inactive_2299:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCO2_ENV

reset_selected_env_step_229d:
    MVIW        (V_OFFSET(env_currently_selected_step_8039)),0
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCO2_ENV_STEP_END)
    STAW        (V_OFFSET(env_currently_selected_end_803a))

; Store a pointer to the currently selected envelope data.
    LXI         HL,patch_buffer_edit_8300 + PATCH_DCO2_ENV_STEP_1_RATE
    SHLD        (env_currently_selected_data_ptr_803e)
    ANIW        (V_OFFSET(ui_flags_8038)),11100001b
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_OSC_2 | UI_FLAGS_ENV_DCO
    CALL        led_3_dco_2_env_4cfd
    CALL        ui_reset_cursor_and_print_env_ui_2a58
    RET

; =============================================================================
input_dca1_key_follow_22bb:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          init_button_inactive_22d0

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCA1_KEY_FOLLOW

    LXI         DE,patch_buffer_edit_8300
    LXI         EA,0
    STEAX       (DE+PATCH_DCA1_KEY_FOLLOW)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          update_led_and_print_ui_22d4

init_button_inactive_22d0:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCA1_KEY_FOLLOW

update_led_and_print_ui_22d4:
    CALL        led_3_dca_1_key_follow_4cfb
    CALL        ui_reset_cursor_index_550d
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCA1_KEY_FOLLOW)
    CALL        prints_string_amp_range_2acf
    RET

; =============================================================================
input_dca2_key_follow_22e3:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_22f8

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCA2_KEY_FOLLOW

    LXI         DE,patch_buffer_edit_8300
    LXI         EA,0
    STEAX       (DE+PATCH_DCA2_KEY_FOLLOW)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          _update_led_and_print_ui_22fc

_init_button_inactive_22f8:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCA2_KEY_FOLLOW

_update_led_and_print_ui_22fc:
    CALL        led_3_dca_2_key_follow_4d07
    CALL        ui_reset_cursor_index_550d
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCA2_KEY_FOLLOW)
    CALL        prints_string_amp_range_2acf
    RET

; =============================================================================
input_dcw1_key_follow_230b:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          init_button_inactive_2320

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCW1_KEY_FOLLOW

    LXI         DE,patch_buffer_edit_8300
    LXI         EA,0
    STEAX       (DE+PATCH_DCW1_KEY_FOLLOW)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          update_led_and_print_ui_2324

init_button_inactive_2320:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCW1_KEY_FOLLOW

update_led_and_print_ui_2324:
    CALL        led_3_dcw_1_key_follow_4cf7
    CALL        ui_reset_cursor_index_550d
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCW1_KEY_FOLLOW)
    CALL        prints_wave_range_key_follow_2ad4
    RET

; =============================================================================
input_dcw2_key_follow_2333:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_2348

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DCW2_KEY_FOLLOW

    LXI         DE,patch_buffer_edit_8300
    LXI         EA,0
    STEAX       (DE+PATCH_DCW2_KEY_FOLLOW)
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    JR          _update_led_and_print_ui_234c

_init_button_inactive_2348:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DCW2_KEY_FOLLOW

_update_led_and_print_ui_234c:
    CALL        led_3_dcw_2_key_follow_4d03
    CALL        ui_reset_cursor_index_550d
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DCW2_KEY_FOLLOW)
    CALL        prints_wave_range_key_follow_2ad4
    RET

; =============================================================================
input_detune_235b:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_2372

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_DETUNE

; Initialise these variables to 0.
    MVI         A,0
    LXI         DE,patch_buffer_edit_8300
    STAX        (DE+PATCH_DETUNE_POLARITY)
    STAX        (DE+PATCH_DETUNE_FINE)
    STAX        (DE+PATCH_DETUNE_NOTES)
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    JR          _set_cursor_index_and_print_ui_2376

_init_button_inactive_2372:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_DETUNE

_set_cursor_index_and_print_ui_2376:
    CALL        ui_set_cursor_index_1_5507
    CALL        ui_detune_2ae6
    RET

; =============================================================================
input_octave_237d:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_2392

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_OCTAVE

; Clear these two bits to reset the octave shift setting.
    LXI         DE,patch_buffer_edit_8300 + PATCH_PFLAG
    DW 00ABh   ;    LDAX        (DE+00h)
    ANI         A,11110011b
    DW 00BBh   ;    STAX        (DE+00h)
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    JR          _set_cursor_index_and_print_ui_2396

_init_button_inactive_2392:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_OCTAVE

_set_cursor_index_and_print_ui_2396:
    CALL        ui_reset_cursor_index_550d
    CALL        ui_octave_range_2b2e
    RET

; =============================================================================
input_vibrato_239d:
    CALL        button_check_init_cancel_if_write_button_held_213a
    JR          _init_button_inactive_23b5

; Init button active.
    CALL        set_current_ui_screen_2145
    DB          UI_SCREEN_VIBRATO

    LXI         HL,patch_lfo_init_data_2fa2
    LXI         DE,patch_buffer_edit_8300 + PATCH_LFO_WAVE
    MVI         C,9
    BLOCK

    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        voice_update_vibrato_4db0
    JR          _set_cursor_index_and_print_ui_23b9

_init_button_inactive_23b5:
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_VIBRATO

_set_cursor_index_and_print_ui_23b9:
    CALL        ui_reset_cursor_index_550d
    CALL        ui_print_vibrato_info_2b51
    RET

; =============================================================================
input_line_select_23c0:
    CALL        button_check_write_5000
    RET

    LXI         DE,patch_buffer_edit_8300
    DW 00ABh   ;    LDAX        (DE+00h)
    MOV         C,A
    ANI         A,3
    LXI         HL,line_select_data_UNKNOWN_23e3
    LDAX        (HL+A)
    ANI         C,11111100b
    ORA         A,C
    DW 00BBh   ;    STAX        (DE+00h)
    CALL        patch_copy_from_edit_to_compare_531c
    LDAW        (V_OFFSET(patch_index_8026))
    CALL        patch_set_modified_flag_and_update_indexes_4eb5
    CALL        reset_solo_mode_selected_voice_modified_UNKNOWN_5231
    RET

line_select_data_UNKNOWN_23e3:
    DB          1h
    DB          03h
    DB          00h
    DB          2h

; =============================================================================
input_mod_noise_23e7:
    CALL        button_check_write_5000
    RET

; Write button inactive.
    LXI         DE,patch_buffer_edit_8300
    DW 00ABh   ;    LDAX        (DE+00h)
    ONI         A,2
    RET

    LDAX        (DE+0Fh)
    ONI         A,010h

    JR          LAB_23fb

    ANI         A,0c3h

    JR          LAB_23ff

LAB_23fb:
    ANI         A,0DBh
    ORI         A,018h

LAB_23ff:
    STAX        (DE+0Fh)
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        led_4_set_ring_noise_leds_based_on_waveform_4d26
    RET

; =============================================================================
input_mod_ring_2408:
    CALL        button_check_write_5000
    RET

    LXI         DE,patch_buffer_edit_8300
    DW 00ABh   ;    LDAX        (DE+00h)
    ONI         A,2
    RET

    LDAX        (DE+PATCH_F)
    ONI         A,020h
    JR          LAB_241c

    ANI         A,0c3h
    JR          LAB_2420

LAB_241c:
    ANI         A,0e7h
    ORI         A,020h

LAB_2420:
    STAX        (DE+PATCH_F)
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        led_4_set_ring_noise_leds_based_on_waveform_4d26
    RET

; =============================================================================
input_env_point_end_2429:
; Skip if current screen is an env screen.
    CALL        check_if_ui_screen_is_env_2c9c
    RET

; Load the currently selected step.
; If it's equal to the current end step, reset to step 8.
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    NEAW        (V_OFFSET(env_currently_selected_end_803a))  ; Skip if (A≠(V.wa)).
    MVI         A,7

; Store the new end step.
    STAW        (V_OFFSET(env_currently_selected_end_803a))

; Load the pointer to the env data,
; Decrement...
    LHLD        (env_currently_selected_data_ptr_803e)
    DCX         HL
    STAX        (HL+)
    CALL        UNKNOWN_ui_env_2ca7
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    CALL        ui_env_2a5f
    RET

; =============================================================================
input_env_point_sustain_2446:
; Skip if current screen is an env screen.
    CALL        check_if_ui_screen_is_env_2c9c
    RET

    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    NEAW        (V_OFFSET(env_currently_selected_end_803a))
    RET
    CALL        get_ptr_to_currently_selected_env_step_data_2c90
    PUSH        HL
    INX         HL
    LDAX        (HL+B)
    PUSH        V
    PUSH        HL
    MVI         C,7
LAB_245a:
    LDAX        (HL)
    ANI         A,01111111b
    STAX        (HL+)
    INX         HL
    DCR         C
    JR          LAB_245a

    POP         HL
    POP         V
    OFFI        A,80h
    JR          LAB_246a

    LDAX        (HL+B)
    ORI         A,10000000b
    STAX        (HL+B)
LAB_246a:
    POP         HL
    CALL        UNKNOWN_ui_env_2ca7
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    CALL        ui_env_2a5f
    RET

; =============================================================================
input_env_step_up_2475:
; Skip if current screen is an env screen.
    CALL        check_if_ui_screen_is_env_2c9c
    RET

; Test that current step isn't equal to the currently selected
; end step.
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    NEAW        (V_OFFSET(env_currently_selected_end_803a))     ; Skip if 08039h != 0803Ah.

; If the step is the last step, set A to 0FFh,
; so that it overflows back to 0.
    MVI         A,0FFh

; Increment, and store.
    ADI         A,1
    STAW        (V_OFFSET(env_currently_selected_step_8039))
    CALL        ui_reset_cursor_index_550d
    CALL        ui_env_2a5f
    RET

; =============================================================================
input_env_step_down_248b:
; Skip if current screen is an env screen.
    CALL        check_if_ui_screen_is_env_2c9c
    RET

; Test if the currently selected step is already 0.
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    EQI         A,0                                 ; Skip if equal to 0.
    JR          _decrement_step_2497

; Load the currently selected end step.
    LDAW        (V_OFFSET(env_currently_selected_end_803a))
    JR          _store_current_step_2498

_decrement_step_2497:
    DCR         A

_store_current_step_2498:
    STAW        (V_OFFSET(env_currently_selected_step_8039))
    CALL        ui_reset_cursor_index_550d
    CALL        ui_env_2a5f
    RET

; =============================================================================
input_portamento_time_24a1:
    CALL        button_check_write_5000
    RET

    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_PORTAMENTO

    CALL        ui_reset_cursor_index_550d
    CALL        ui_portamento_time_2b96
    RET

; =============================================================================
input_bend_range_24b0:
    CALL        button_check_write_5000 ; Skips on return in some cases.
    RET

    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_BEND_RANGE

    CALL        ui_reset_cursor_index_550d
    CALL        ui_prints_str_bend_range_2b9f
    RET

; =============================================================================
input_key_transpose_24bf:
    CALL        button_check_write_5000
    RET

; Write button inactive.
    CALL        set_current_ui_screen_or_cancel_2be8
    DB          UI_SCREEN_KEY_TRANSPOSE

    CALL        ui_reset_cursor_index_550d
    CALL        ui_key_transpose_2bb1
    RET

; =============================================================================
input_up_down_env_24ce:
    MVI         A,35h

; =============================================================================
input_up_down_held_env_24d0:
    MVI         A,3
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd

    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_40
    CALL        input_up_down_env_262d

    BIT         UI_FLAGS_BIT_6,(V_OFFSET(ui_flags_8038))
    RET

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    RET

; =============================================================================
input_up_down_dca1_env_24e2:
    LXI         HL,UNKNOWN_dca_key_follow_2681

; =============================================================================
input_up_down_dca2_env_24e5:
    LXI         HL,UNKNOWN_dca2_key_follow_2685

; =============================================================================
input_up_down_dcw1_key_follow_24e8:
    LXI         HL,UNKNOWN_dcw_key_follow_268c

; =============================================================================
input_up_down_dcw2_key_follow_24eb:
    LXI         HL,UNKNOWN_dcw2_key_follow_2690
    PUSH        HL
    MVI         A,35h
    JRE         release_int1_mask_pop_call_bc_2502

; =============================================================================
input_up_down_held_dca1_key_follow_24f3:
    LXI         HL,UNKNOWN_dca_key_follow_2681

; =============================================================================
input_up_down_held_dca2_key_follow_24f6:
    LXI         HL,UNKNOWN_dca2_key_follow_2685

; =============================================================================
input_up_down_held_dcw1_key_follow_24f9:
    LXI         HL,UNKNOWN_dcw_key_follow_268c

; =============================================================================
input_up_down_held_dcw2_key_follow_24fc:
    LXI         HL,UNKNOWN_dcw2_key_follow_2690
    PUSH        HL
    MVI         A,1Ah

; =============================================================================
; A = Button hold timer reset value.
; =============================================================================
release_int1_mask_pop_call_bc_2502:
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    POP         BC
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_40
    CALB
    BIT         UI_FLAGS_BIT_6,(V_OFFSET(ui_flags_8038))
    RET
    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    RET

; =============================================================================
input_up_down_waveform_2512:
    MVI         A,35h

; =============================================================================
input_up_down_held_waveform_2514:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_40
    CALL        edit_waveform_UNKNOWN_26b4

    BIT         UI_FLAGS_BIT_6,(V_OFFSET(ui_flags_8038))
    RET

    CALL        UNKNOWN_called_when_patch_value_modified_0_52eb
    RET

; =============================================================================
input_up_down_detune_2526:
    MVI         A,35h
    JR          LAB_253a

; =============================================================================
input_up_down_held_detune_2529:
    MOV         A,(ui_cursor_index_8055)
    NEI         A,1
    MVI         C,035h
    NEI         A,2
    MVI         C,1Ah
    NEI         A,3
    MVI         C,3
    MOV         A,C

LAB_253a:
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        ui_detune_modified_UNKNOWN_276e
    RET

    ANIW        (V_OFFSET(ui_flags_8037)),11111110b
    ORI         MKL,04h
    RET

; =============================================================================
input_up_down_octave_2548:
    MVI         A,35h

; =============================================================================
input_up_down_held_octave_254a:
    MVI         A,35h
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        input_octave_288f
    RET

; =============================================================================
input_up_down_held_vibrato_2553:
    MOV         A,(ui_cursor_index_8055)
    NEI         A,0
    MVI         A,35h
    MVI         A,3

; =============================================================================
input_up_down_vibrato_24e5:
    MVI         A,35h
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        vibrato_modified_27f5
    RET

; =============================================================================
input_up_down_portamento_2566:
    MVI         A,35h

; =============================================================================
input_up_down_held_portamento_time_2568:
    MVI         A,3
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        portamento_time_modified_28c0
    RET

; =============================================================================
input_up_down_bend_range_2571:
    MVI         A,35h

; =============================================================================
input_up_down_held_bend_range_2573:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        bend_range_modified_28de
    RET

input_up_down_key_transpose_257c:
    MVI         A,35h

; =============================================================================
input_up_down_held_key_transpose_257e:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        key_transpose_increment_decrement_UNKNOWN_28f0
    RET

; =============================================================================
input_master_tune_inactive_2587:
    MVI         A,35h

; =============================================================================
input_master_tune_not_both_active_2589:
    MVI         A,5
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        master_tune_inc_dec_UNKNOWN_294e
    RET

; =============================================================================
; @COMPLETE
; If both master tune buttons are active, reset the setting.
; =============================================================================
input_master_tune_both_active_2592:
    MVI         A,0a0h
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd

; If the master tune setting isn't already 0x40, set it to 0x40 and update.
    NEIW        (V_OFFSET(master_tune_8001)),40h
    RET

    MVIW        (V_OFFSET(master_tune_8001)),40h
    CALL        master_tune_update_28fe
    RET

; =============================================================================
; @COMPLETE
; Enter the synth's 'Debug Mode'.
; From Devin Acker's CZ101 MAME Driver cz101.cpp:
;  To run a (currently undumped) test/diagnostic/debug cartridge:
;  Hold "env step +", "env step -", "initialize", and "write" all at once,
;  then press "load". If a cartridge is inserted that begins with the 8 bytes
;  "5a 96 5a 96 5a 96 5a 96", then the CZ-101 firmware will copy the first 2kb
;  of the cart to $8800-8fff and then call $8810.
;  This works even when the normal "cart detect" signal isn't present.
;  (Note that this will wipe out all patches saved to the internal RAM.)
; =============================================================================
debug_mode_entry_25a2:
; Exit if 'Write' button not pressed.
    CALL        button_check_write_5000
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))
    RET

; Write button is ACTIVE.
    CALL        debug_mode_entry_check_debug_header_4660
    JRE         _debug_header_present_25e7

; Debug header not present.
; Test if cartridge inserted.
    MVI         A,PATCH_FLAGS_CARTRIDGE
    CALL        patch_test_save_memory_selected_429a
    JRE         _cartridge_not_inserted_25e3

; Cartridge is inserted.
; Check whether the synth is write protected. Skip if inactive.
    CALL        button_check_protect_5003
    RET

; Synth is not write protected.
; @UNSURE: If the 'Down' button is pressed, copy the RAM to the cart?
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          _copy_cartridge_to_ram_25c2

; Down button active.
    LXI         DE,cartridge_memory_9000
    LXI         HL,patch_buffer_internal_8800
    JR          _setup_bulk_copy_25c8

_copy_cartridge_to_ram_25c2:
    LXI         HL,cartridge_memory_9000
    LXI         DE,patch_buffer_internal_8800

; Copy 0x10 * 0x80 = 2KiB from the cartridge to RAM.
_setup_bulk_copy_25c8:
    MVI         A,0Fh

_bulk_copy_loop_25ca:
    MVI         C,7Fh
    BLOCK
    DCR         A
    JR          _bulk_copy_loop_25ca

    CALL        UNKNOWN_patch_4ea3
    CALL        voice_update_vibrato_4db0

; @UNSURE: If down button pressed...
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          _write_load_ok_and_exit_25df

    CALL        ui_set_screen_write_save_and_print_save_ok_5753

_exit_25db:
    MVIW        (V_OFFSET(write_button_currently_pressed_8021)),0
    RET

_write_load_ok_and_exit_25df:
    CALL        ui_set_screen_write_load_and_print_load_ok_575b
    JR          _exit_25db

_cartridge_not_inserted_25e3:
    CALL        print_str_not_ready_insert_cartridge_572b
    JR          _exit_25db

_debug_header_present_25e7:
    CALL        button_check_env_step_up_5012
    JR          _check_env_step_down_button_25ec

    RET

_check_env_step_down_button_25ec:
    CALL        button_check_env_step_down_5015
    JR          _check_initialise_button_25f1

    RET

_check_initialise_button_25f1:
    CALL        button_check_initialise_500f
    JR          _check_down_button_25f6

    RET

_check_down_button_25f6:
    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN
    JR          _exit_25db

; Setup bulk copy.
    LXI         HL,cartridge_memory_9000
    LXI         DE,patch_buffer_internal_8800

; Copy 0x8 * 0x100 = 2KiB from the cartridge to RAM.
    MVI         A,7
_bulk_copy_loop_2602:
    MVI         C,0FFh
    BLOCK
    DCR         A
    JR          _bulk_copy_loop_2602

    CALL        debug_function_8810
    JRE         _exit_25db

; =============================================================================
MAYBE_input_up_down_tone_mix_260c:
    MVI         A,35h

; =============================================================================
MAYBE_input_up_down_held_tone_mix_260e:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        UNKNOWN_tone_mix_2987
    RET

; =============================================================================
input_up_down_midi_2617:
    MVI         A,35h

; =============================================================================
input_up_down_held_midi_2619:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        input_up_down_midi_29b8
    RET

; =============================================================================
input_up_down_midi_solo_mode_2622:
    MVI         A,35h

; =============================================================================
input_up_down_held_midi_solo_mode_2624:
    MVI         A,1Ah
    CALL        input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd
    CALL        input_up_down_midi_solo_mode_29ea
    RET

; =============================================================================
input_up_down_env_262d:
    CALL        ui_env_convert_step_data_to_printable_format_2ab8
    MOV         A,(ui_cursor_index_8055)
    NEI         A,0
    JRE         _cursor_index_is_0_2658

; Cursor index not zero. Level selected.
; Exit if the selected step is the end step, since the end level
; is always zero.
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    NEAW        (V_OFFSET(env_currently_selected_end_803a))
    RET

; Env step not end.
    LDAW        (V_OFFSET(ui_env_level_print_value_803c))
    CALL        ui_increment_decrement_max_63_2c7a
    CALL        MAYBE_ui_env_convert_level_to_serialisable_value_2d8e
    MOV         C,A
    CALL        get_ptr_to_currently_selected_env_step_data_2c90
    INX         HL
    OFFIW       (V_OFFSET(MAYBE_env_currently_selected_level_803b)),80h
    ORI         C,10000000b
    CALL        UNKNOWN_ui_env_2673
    MOV         A,C
    STAX        (HL+B)
    DCX         HL
    JR          LAB_2669

_cursor_index_is_0_2658:
    LDAW        (V_OFFSET(ui_env_rate_print_value_803d))
    CALL        ui_increment_decrement_max_63_2c7a
    CALL        UNKNOWN_ui_env_rate_2d70
    MOV         C,A
    CALL        get_ptr_to_currently_selected_env_step_data_2c90
    CALL        UNKNOWN_ui_env_2673
    MOV         A,C
    STAX        (HL+B)

LAB_2669:
    BIT         UI_FLAGS_BIT_6,(V_OFFSET(ui_flags_8038))
    RET

    CALL        UNKNOWN_ui_env_2ca7
    CALL        ui_env_2a5f
    RET

; =============================================================================
UNKNOWN_ui_env_2673:
    PUSH        BC
    ANI         C,7Fh
    LDAX        (HL+B)
    ANI         A,01111111b
    EQA         A,C
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_40
    POP         BC
    RET

; =============================================================================
UNKNOWN_dca_key_follow_2681:
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCA1_KEY_FOLLOW
    JR          LAB_2688

; =============================================================================
UNKNOWN_dca2_key_follow_2685:
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCA2_KEY_FOLLOW
LAB_2688:
    LXI         HL,patch_init_data_dca_UNKNOWN_2f8e
    JR          LAB_2696

; =============================================================================
UNKNOWN_dcw_key_follow_268c:
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCW1_KEY_FOLLOW
    JR          LAB_2693

; =============================================================================
UNKNOWN_dcw2_key_follow_2690:
    LXI         DE,patch_buffer_edit_8300 + PATCH_DCW2_KEY_FOLLOW
LAB_2693:
    LXI         HL,patch_init_data_dcw_UNKNOWN_2693
LAB_2696:
    LDAX        (DE)
    CALL        ui_increment_decrement_max_9_2c77
    MOV         C,A
    LDAX        (DE)
    NEA         A,C
    RET
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_40
    MOV         A,C
    STAX        (DE)
    PUSH        V
    LDAX        (HL+A)
    STAX        (DE+1)
    POP         V
    ORI         A,30h
    MOV         C,A
    MOV         A,(ui_cursor_index_8055)
    CALL        lcd_print_number_to_cursor_position_and_update_547c
    RET

; =============================================================================
edit_waveform_UNKNOWN_26b4:
    LDED        (patch_buffer_edit_8300 + PATCH_DCO2_WAVEFORM_1)
    BIT         UI_FLAGS_ENV_OSC_2_BIT,(V_OFFSET(ui_flags_8038))
    LDED        (patch_buffer_edit_8300 + PATCH_DCO1_WAVEFORM_1)
    CALL        ui_waveform_get_wave_numbers_2c21
    MOV         A,(ui_cursor_index_8055)
    EQI         A,0
    JRE         LAB_26f4

    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN
    JR          LAB_26e3

    NEI         B,8
    RET
    NEI         C,0
    JR          LAB_26e0

    GTI         C,05h
    JR          LAB_26e0

    NEI         B,05h
    RET
    INR         B
    JRE         LAB_270e

LAB_26e0:
    INR         B
    JRE         LAB_2713

LAB_26e3:
    NEI         B,1
    RET
    NEI         C,0
    JR          LAB_26f1

    GTI         C,05h
    JR          LAB_26f1

    DCR         B
    JR          LAB_270e

LAB_26f1:
    DCR         B
    JRE         LAB_2713

LAB_26f4:
    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN
    JR          LAB_2708

    NEI         C,08h
    RET

    GTI         B,05h
    JR          LAB_2706

    NEI         C,05h
    RET

    INR         C
    JR          LAB_2713

LAB_2706:
    INR         C
    JR          LAB_2713

LAB_2708:
    NEI         C,0
    RET

    DCR         C
    JR          LAB_2713

LAB_270e:
    CALL        edit_waveform_UNKNOWN_272a
    JR          LAB_2716

; Unreachable?
    DCR         C

LAB_2713:
    CALL        edit_waveform_UNKNOWN_271d

LAB_2716:
    CALL        ui_waveform_2a3c
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_40
    RET

; =============================================================================
edit_waveform_UNKNOWN_271d:
    ANI         D,03fh
    MOV         A,B
    LTI         B,06h
    JR          edit_waveform_UNKNOWN_272d

    MOV         A,C
    LTI         C,06h
    JR          edit_waveform_UNKNOWN_272d

; =============================================================================
edit_waveform_UNKNOWN_272a:
    MVI         A,0
    JR          LAB_273b

edit_waveform_UNKNOWN_272d:
    SUI         A,5
    SLL         A
    SLL         A
    SLL         A
    SLL         A
    SLL         A
    SLL         A

LAB_273b:
    ORA         D,A
    LXI         HL,byte_array_2765
    LDAX        (HL+B)
    MOV         E,A
    MOV         A,C
    LDAX        (HL+A)
    SLR         A
    SLR         A
    SLR         A
    ORA         E,A
    ORI         E,2h
    NEI         C,0
    ANI         E,0E0h
    ANI         E,0FEh
    BIT         UI_FLAGS_ENV_OSC_2_BIT,(V_OFFSET(ui_flags_8038))
    JR          LAB_2760

    SDED        (patch_buffer_edit_8300 + PATCH_DCO2_WAVEFORM_1)
    RET

LAB_2760:
    SDED        (patch_buffer_edit_8300 + PATCH_DCO1_WAVEFORM_1)
    RET

byte_array_2765:
    DB          00h
    DB          00h
    DB          020h
    DB          40h
    DB          80h
    DB          0A0h
    DB          0C0h
    DB          0C0h
    DB          0C0h

; =============================================================================
ui_detune_modified_UNKNOWN_276e:
    LXI         DE,patch_buffer_edit_8300
    MOV         A,(ui_cursor_index_8055)
    ADD         A,A
    TABLE
    JB
    DW          ui_detune_modified_UNKNOWN_polarity_27c6
    DW          ui_detune_modified_UNKNOWN_oct_27ac
    DW          ui_detune_modified_note_279d
    DW          ui_detune_modified_fine_2782

; =============================================================================
ui_detune_modified_fine_2782:
    LDAX        (DE+2)
    SLR         A
    SLR         A
    CALL        ui_detune_convert_fine_value_2c0d
    MOV         C,A

    CALL        ui_increment_decrement_max_60_2c6b
    NEA         A,C
    RET

    CALL        ui_detune_modified_fine_serialise_2bfb
    SLL         A
    SLL         A
    STAX        (DE+2)
    JRE         ui_detune_modified_exit_27d6

; =============================================================================
ui_detune_modified_note_279d:
    CALL        FUN_27dd
    PUSH        BC
    MOV         A,C
    CALL        ui_increment_decrement_max_11_2c7d
    POP         BC
    NEA         A,C
    RET
    MOV         C,A
    JRE         LAB_27c2

; =============================================================================
ui_detune_modified_UNKNOWN_oct_27ac:
    CALL        FUN_27dd
    LTI         B,03h
    MVI         B,03h
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          LAB_27bd

    NEI         B,0
    RET
    DCR         B
    JR          LAB_27c2

LAB_27bd:
    NEI         B,03h
    RET
    INR         B
LAB_27c2:
    CALL        FUN_27eb
    JR          ui_detune_modified_exit_27d6

; =============================================================================
ui_detune_modified_UNKNOWN_polarity_27c6:
    LDAX        (DE+1)
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          LAB_27cf

    OFFI        A,1
    RET
    JR          LAB_27d2

LAB_27cf:
    ONI         A,1
    RET
LAB_27d2:
    XRI         A,1
    STAX        (DE+1)

ui_detune_modified_exit_27d6:
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        ui_detune_2ae6
    RET

; =============================================================================
FUN_27dd:
    LDAX        (DE+3)
    LXI         EA,0
    MOV         EAL,A
    MVI         A,0Ch
    DIV         A
    MOV         C,A
    MOV         A,EAL
    MOV         B,A
    RET

; =============================================================================
FUN_27eb:
    MVI         A,0Ch
    MUL         B
    MOV         A,EAL
    ADD         A,C
    STAX        (DE+3)
    RET

; =============================================================================
vibrato_modified_27f5:
    LXI         DE,patch_buffer_edit_8300
    MOV         A,(ui_cursor_index_8055)
    ADD         A,A
    TABLE
    JB
    DW          vibrato_modified_wave_2809
    DW          vibrato_modified_delay_2836
    DW          vibrato_modified_rate_2862
    DW          vibrato_modified_depth_2849

; =============================================================================
; DE: Patch Buffer Edit.
; =============================================================================
vibrato_modified_wave_2809:
    LDAX        (DE+PATCH_LFO_WAVE)
    OFFI        A,2
    JR          LAB_2829

    OFFI        A,04h
    JR          LAB_281b

    OFFI        A,020h
    JR          LAB_2822

    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN
    RET
    MVI         B,04h
    JR          LAB_282e

LAB_281b:
    MVI         B,08h
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    MVI         B,020h
    JR          LAB_282e

LAB_2822:
    MVI         B,04h
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    MVI         B,2h
    JR          LAB_282e

LAB_2829:
    MVI         B,020h
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    RET

LAB_282e:
    ANI         A,0d1h
    ORA         A,B
    STAX        (DE+PATCH_LFO_WAVE)
    JRE         vibrato_modified_287e

; =============================================================================
; DE: Patch Buffer Edit.
; =============================================================================
vibrato_modified_delay_2836:
    LDAX        (DE+PATCH_LFO_DELAY)
    MOV         C,A
    CALL        ui_increment_decrement_max_63_2c7a
    NEA         A,C
    RET

    STAX        (DE+PATCH_LFO_DELAY)
    CALL        UNKNOWN_vibrato_2ced
    STEAX       (DE+PATCH_LFO_DELAY_LSB)
    JRE         vibrato_modified_287e

; =============================================================================
; DE: Patch Buffer Edit.
; =============================================================================
vibrato_modified_depth_2849:
    LDAX        (DE+PATCH_LFO_DEPTH)
    MOV         C,A
    CALL        ui_increment_decrement_max_63_2c7a
    NEA         A,C
    RET

    STAX        (DE+PATCH_LFO_DEPTH)
    INR         A
    LXI         EA,0300h
    EQI         A,064h
    CALL        UNKNOWN_vibrato_2ced
    STEAX       (DE+PATCH_LFO_DEPTH_LSB)
    JRE         UNKNOWN_vibrato_modified_2885

; =============================================================================
; DE: Patch Buffer Edit.
; =============================================================================
vibrato_modified_rate_2862:
    LDAX        (DE+PATCH_LFO_RATE)
    MOV         C,A
    CALL        ui_increment_decrement_max_63_2c7a
    NEA         A,C
    RET
    STAX        (DE+PATCH_LFO_RATE)

    INR         A
    CALL        UNKNOWN_vibrato_2ced
    DSLL        EA
    DSLL        EA
    DSLL        EA
    DSLL        EA
    DSLL        EA
    STEAX       (DE+PATCH_LFO_RATE_LSB)

vibrato_modified_287e:
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        ui_print_vibrato_info_2b51
    RET

; =============================================================================
UNKNOWN_vibrato_modified_2885:
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        ui_print_vibrato_info_2b51
    CALL        voice_update_vibrato_4db0
    RET

; =============================================================================
; Updates the patch octave setting based on user input.
; =============================================================================
input_octave_288f:
    LXI         DE,patch_buffer_edit_8300
    DW 00ABh   ;    LDAX        (DE+00h)

    OFFI        A,100b
    JR          _value_is_positive_28a1

    OFFI        A,1000b
    JR          _value_is_negative_28a7

    MVI         B,8
; Test whether down button pressed.
; Skip if bit set.
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    MVI         B,4

    JR          _store_value_28ad

_value_is_positive_28a1:
; If the down button is pressed, load 0 into B to reset the octave value to 0.
; Otherwise, skip, and store B, since no action is happening.
    MVI         B,0
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    RET
    JR          _store_value_28ad

_value_is_negative_28a7:
; If the up button is pressed, load 0 into B to reset the octave value to 0.
; Otherwise, skip, and store B, since no action is happening.
    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_VALUE_DOWN
    RET

    MVI         B,0

_store_value_28ad:
    ANI         A,11110011b
    ORA         A,B
    DW 00BBh   ;    STAX        (DE+00h)

    PUSH        V
    CALL        channel_get_selected_solo_channel_pflags_pointer_4d6f
    POP         V
    STAX        (BC)
    CALL        UNKNOWN_called_when_patch_value_modified_1_52ed
    CALL        ui_octave_range_2b2e
    RET

; =============================================================================
portamento_time_modified_28c0:
    LDAW        (V_OFFSET(portamento_time_8004))
    CALL        ui_increment_decrement_max_63_2c7a
    NEAW        (V_OFFSET(portamento_time_8004))
    RET

    STAW        (V_OFFSET(portamento_time_8004))
    CALL        ui_portamento_time_2b96
; Falls-through below.

; =============================================================================
; A: Portamento time value.
; =============================================================================
portamento_time_modified_update_28ce:
    CALL        UNKNOWN_patch_load_41d8
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    CALL        initialise_channel_info_5094
    CALL        reset_solo_mode_selected_voice_modified_UNKNOWN_5231
    CALL        portamento_time_calculate_final_value_7a16
    RET

; =============================================================================
bend_range_modified_28de:
    LDAW        (V_OFFSET(pitch_bend_range_8003))
    CALL        ui_increment_decrement_max_12_2c80

; Return if the new pitch bend range value is identical to the old one.
    NEAW        (V_OFFSET(pitch_bend_range_8003))   ; Skip if (A≠(V.wa)).
    RET

; Store the new value.
    STAW        (V_OFFSET(pitch_bend_range_8003))
    CALL        pitch_bend_range_modified_79d0
    CALL        ui_prints_str_bend_range_2b9f
    RET

; =============================================================================
key_transpose_increment_decrement_UNKNOWN_28f0:
    LDAW        (V_OFFSET(MAYBE_key_transpose_8002))
    CALL        ui_increment_decrement_max_11_2c7d
    NEAW        (V_OFFSET(MAYBE_key_transpose_8002))
    RET
    STAW        (V_OFFSET(MAYBE_key_transpose_8002))
    CALL        ui_key_transpose_2bb1

; =============================================================================
master_tune_update_28fe:
    CALL        UNKNOWN_master_tune_get_transpose_offset_290e
    DMOV        DE,EA
    PUSH        DE
    CALL        master_tune_calculate_value_in_ea_2969
    POP         DE
    CALL        UNKNOWN_master_tune_2917
    CALL        UNKNOWN_master_tune_79f0
    RET

; =============================================================================
UNKNOWN_master_tune_get_transpose_offset_290e:
    LDAW        (V_OFFSET(MAYBE_key_transpose_8002))
    MVI         B,5
    CALL        signed_subtract_b_from_a_clear_ea_2c5c
    MOV         EAH,A
    RET

; =============================================================================
UNKNOWN_master_tune_2917:
    MOV         A,EAH
    OFFI        A,80h
    JR          UNKNOWN_master_tune_292e

    OFFI        D,80h
    JR          UNKNOWN_master_tune_293d

; =============================================================================
UNKNOWN_master_tune_291f:
    ANI         D,7Fh
    ANI         A,01111111b
    MOV         EAH,A
    DADD        EA,DE
    MOV         A,EAH
    LTI         A,80h
    LXI         EA,07fffh
    RET

; =============================================================================
UNKNOWN_master_tune_292e:
    ONI         D,80h
    JR          LAB_2939

    CALL        UNKNOWN_master_tune_291f

LAB_2935:
    ORI         A,10000000b
    MOV         EAH,A
    RET
LAB_2939:
    PUSH        EA
    PUSH        DE
    POP         EA
    POP         DE

; =============================================================================
UNKNOWN_master_tune_293d:
    ANI         D,7Fh
    DLT         EA,DE
    JR          LAB_294b

    PUSH        EA
    PUSH        DE
    POP         EA
    POP         DE
    DSUB        EA,DE
    MOV         A,EAH
    JR          LAB_2935

LAB_294b:
    DSUB        EA,DE
    RET

; =============================================================================
master_tune_inc_dec_UNKNOWN_294e:
    LDAW        (V_OFFSET(master_tune_8001))
    CALL        ui_increment_decrement_max_128_2c6e

; =============================================================================
master_tune_update_2953:
; Don't process if the new master tune value is identical
; to the old one.
    NEAW        (V_OFFSET(master_tune_8001)) ; Skip if A !== 08001h.
    RET

    STAW        (V_OFFSET(master_tune_8001))
    CALL        master_tune_calculate_value_in_ea_2969
    DMOV        DE,EA
    PUSH        DE
    CALL        UNKNOWN_master_tune_get_transpose_offset_290e
    POP         DE
    CALL        UNKNOWN_master_tune_2917
    CALL        UNKNOWN_master_tune_79f0
    RET

; =============================================================================
; Returns 100h if master tune is 80h.
; Returns 08100h if master tune is 0.
; ...
; =============================================================================
master_tune_calculate_value_in_ea_2969:
    LDAW        (V_OFFSET(master_tune_8001))

; Return 100h if master tune is 80h.
    LXI         EA,100h
    NEI         A,80h   ; Skip if A !== 80h.
    JR          _exit_2986

; Return 08100h if master tune is 0.
    LXI         EA,08100h
    NEI         A,0   ; Skip if A !== 0.
    JR          _exit_2986

; A !== 0.
    MVI         B,40h

; Subtract 40h from A, then shift left to test if the sign bit is set.
    CALL        signed_subtract_b_from_a_clear_ea_2c5c
    SLL         A
; Skip if carry flag NOT set.
    SKN         CY

; Load 8000h into EA if the value was negative.
    LXI         EA,8000h

    SLL         A
    MOV         EAL,A

_exit_2986:
    RET

; =============================================================================
UNKNOWN_tone_mix_2987:
    LDAW        (V_OFFSET(tone_mix_UNKNOWN_8006))
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          LAB_2990

    NEI         A,1
    RET
    JR          LAB_2993

LAB_2990:
    NEI         A,09h
    RET

LAB_2993:
    CALL        ui_increment_decrement_max_9_2c77
    STAW        (V_OFFSET(tone_mix_UNKNOWN_8006))

; =============================================================================
UNKNOWN_tone_mix_2998:
    LXI         HL,byte_array_29ae
    LDAX        (HL+A)
    STAW        (V_OFFSET(tone_mix_UNKNOWN_8005))
    CALL        ui_print_tone_mix_56a6
    CALL        UNKNOWN_patch_load_41d8
    LXI         HL,channel_info_0_8100
    CALL        initialise_channel_info_5094
    CALL        UNKNOWN_tone_mix_7626
    RET

byte_array_29ae:
    DB          024h
    DB          020h
    DB          01Ch
    DB          018h
    DB          014h
    DB          010h
    DB          0Ch
    DB          08h
    DB          04h
    DB          00h

; =============================================================================
; @COMPLETE
; Handles up/down button presses on the MIDI screen.
; =============================================================================
input_up_down_midi_29b8:
; Test cursor index.
    MOV         A,(ui_cursor_index_8055)
    OFFI        A,1
    JR          _cursor_index_1_29d9

; Cursor index 0.
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          _up_button_pressed_29c8

; Button Down was pressed.
; Test whether the value is already equal to 0. If so, return.
    NEI         A,0
    RET

    JR          _change_midi_channel_value_29cb

_up_button_pressed_29c8:
    NEI         A,0Fh
    RET

_change_midi_channel_value_29cb:
    CALL        patch_UNKNOWN_29e0
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    CALL        ui_increment_decrement_max_15_2c71
    STAW        (V_OFFSET(midi_channel_basic_8000))

_print_ui_and_exit_29d5:
    CALL        ui_midi_basic_5781
    RET

_cursor_index_1_29d9:
    LDAW        (V_OFFSET(midi_prog_change_disabled_8036))
    XRI         A,1
    STAW        (V_OFFSET(midi_prog_change_disabled_8036))
    JR          _print_ui_and_exit_29d5

; =============================================================================
patch_UNKNOWN_29e0:
    CALL        UNKNOWN_patch_load_41d8
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    CALL        initialise_channel_info_5094
    RET

; =============================================================================
; This function is called when a new solo voice is selected in the UI.
; e.g. Scrolling 'VO' up/down in the 'MIDI' screen when 'solo mode' is active.
; =============================================================================
input_up_down_midi_solo_mode_29ea:
; Determine which option is selected by checking the current cursor index.
; Position 0 = MIDI Channel;
; Position 1 = Selected Voice;
; Position 2 = Program Change Enable/Disable.
    MOV         A,(ui_cursor_index_8055)
    NEI         A,2
    JRE         _cursor_index_2_2a34

    NEI         A,1
    JRE         _cursor_index_1_2a13

; Test for Up/Down button press?
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          _is_value_15_29ff

; Button Down was pressed.
; Test whether the value is already equal to 0. If so, return.
    NEI         A,0                                 ; Skip if not equal to 0.
    RET

    JR          _adjust_midi_channel_value_2a02

_is_value_15_29ff:
; Button Up was pressed.
    NEI         A,15
    RET

_adjust_midi_channel_value_2a02:
    CALL        patch_UNKNOWN_29e0
    CALL        midi_solo_mode_voice_switch_512d
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    CALL        ui_increment_decrement_max_15_2c71
    STAW        (V_OFFSET(midi_channel_basic_8000))

_update_ui_and_exit_2a0f:
    CALL        ui_midi_solo_57af
    RET

_cursor_index_1_2a13:
; Cursor index 1 = Selected Voice.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))

; Test whether Up/Down was pressed.
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))  ; Skip if 08038h & 1 == 1.
    JR          _is_solo_voice_index_3_2a1c

; Return if A == 0, or A == 3.
    NEI         A,0                                 ; Skip if A !== 0.
    RET

    JR          _solo_mode_selected_voice_update_2a1f

_is_solo_voice_index_3_2a1c:
    NEI         A,3                                 ; Skip if A !== 3.
    RET

_solo_mode_selected_voice_update_2a1f:
    PUSH        V
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    CALL        UNKNOWN_solo_mode_patch_load_41f5
    CALL        initialise_channel_info_5094
    POP         V
    CALL        ui_increment_decrement_max_3_2c74
    STAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    CALL        called_when_selected_solo_voice_updated_521a
    JRE         _update_ui_and_exit_2a0f

_cursor_index_2_2a34:
; Toggle whether program change enabled.
    LDAW        (V_OFFSET(midi_prog_change_disabled_8036))
    XRI         A,1
    STAW        (V_OFFSET(midi_prog_change_disabled_8036))
    JRE         _update_ui_and_exit_2a0f

; =============================================================================
; DE: Patch MFW Data (DCO Waveform 1+2)
; =============================================================================
ui_waveform_2a3c:
    PUSH        DE
    LXI         HL,str_wave_form
    CALL        lcd_clear_buffer_and_copy_2_lines_53de

    POP         DE
    CALL        ui_waveform_get_wave_numbers_2c21
    PUSH        BC

; Use logical OR to convert the number to ASCII.
    ORI         B,30h
    MOV         A,B
    MOV         C,A
    CALL        lcd_print_number_cursor_position_0_542b

    POP         BC
; Use logical OR to convert the number to ASCII.
    ORI         C,30h
    CALL        lcd_print_number_to_cursor_position_1_and_update_5476
    RET

; =============================================================================
ui_reset_cursor_and_print_env_ui_2a58:
    CALL        ui_reset_cursor_index_550d
    CALL        ui_env_2a5f
    RET

; =============================================================================
ui_env_2a5f:
; Determine which envelope type is selected based on the UI flags.
; Load the appropriate string (amp/pitch/wave) into HL.
    LXI         HL,str_amp_step
    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_DCA  ; Skip if ((V.wa) & byte == 0)
    JR          _print_env_ui_2a70

    LXI         HL,str_wave_step
    OFFIW       (V_OFFSET(ui_flags_8038)),UI_FLAGS_ENV_DCW
    JR          _print_env_ui_2a70

    LXI         HL,str_pitch_step

_print_env_ui_2a70:
    LXI         DE,str_rate_level
    CALL        lcd_print_2_lines_53fe

    CALL        ui_env_convert_step_data_to_printable_format_2ab8
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    ADI         A,1
    MOV         C,A

; Logical OR to convert the value to ASCII.
    ORI         C,30h
    CALL        lcd_print_number_position_0_5422

    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    NEAW        (V_OFFSET(env_currently_selected_end_803a))
    JR          _env_step_is_end_2a99

; Test whether this step is selected for sustain.
    BIT         7,(V_OFFSET(MAYBE_env_currently_selected_level_803b))
    JR          _env_step_is_not_end_or_sustain_2a93

; Load ASCII values for 'SUS'.
    MVI         E,'S'
    LXI         BC,"US"
    JR          _print_env_stage_type_2aa4

_env_step_is_not_end_or_sustain_2a93:
    MVI         E,'*'
    LXI         BC,"**"
    JR          _print_env_stage_type_2aa4

_env_step_is_end_2a99:
; Load ASCII values for 'END'.
    MVI         E,'D'
    LXI         BC,"NE"
    MVIW        (V_OFFSET(MAYBE_env_currently_selected_level_803b)),0
    MVIW        (V_OFFSET(ui_env_level_print_value_803c)),0

_print_env_stage_type_2aa4:
    CALL        lcd_print_number_position_1_5424

    LDAW        (V_OFFSET(ui_env_rate_print_value_803d))
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_0_542b

    LDAW        (V_OFFSET(ui_env_level_print_value_803c))
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_to_cursor_position_1_and_update_5476
    RET

; =============================================================================
ui_env_convert_step_data_to_printable_format_2ab8:
; Convert Rate.
    CALL        get_ptr_to_currently_selected_env_step_data_2c90
    LDAX        (HL+B)
    ANI         A,01111111b
    CALL        ui_env_convert_rate_to_0_99_range_2da7
    STAW        (V_OFFSET(ui_env_rate_print_value_803d))

; Convert Level.
    INR         B
    LDAX        (HL+B)
    STAW        (V_OFFSET(MAYBE_env_currently_selected_level_803b))
    ANI         A,01111111b
    CALL        ui_env_convert_level_to_0_99_range_2dcc
    STAW        (V_OFFSET(ui_env_level_print_value_803c))
    RET

; =============================================================================
prints_string_amp_range_2acf:
    PUSH        V
    LXI         DE,str_amp_range
    JR          prints_string_key_follow_UNKNOWN_2ad8

; =============================================================================
prints_wave_range_key_follow_2ad4:
    PUSH        V
    LXI         DE,str_wave_range

; =============================================================================
prints_string_key_follow_UNKNOWN_2ad8:
    LXI         HL,str_key_follow
    CALL        lcd_print_2_lines_53fe
    POP         V
    ORI         A,30h
    MOV         C,A
    CALL        lcd_print_number_to_cursor_position_0_and_update_5474
    RET

; =============================================================================
ui_detune_2ae6:
    LXI         HL,str_detune
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    LXI         DE,patch_buffer_edit_8300

; Check detune polarity?
    LDAX        (DE+PATCH_DETUNE_POLARITY)
    ONI         A,1
    JR          _print_detune_notes_2af9

; Print '-' symbol?
    MVI         C,'-'
    CALL        lcd_print_number_cursor_position_0_542b

_print_detune_notes_2af9:
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DETUNE_NOTES)
    ANI         A,01111111b

; Divide by 12 to get the octave?
    LXI         EA,0
    MOV         EAL,A
    MVI         A,12
    DIV         A
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    PUSH        EA
    CALL        lcd_print_number_cursor_position_2_542f
    POP         EA
    MOV         A,EAL
    MOV         C,A

; Logical OR to convert value to ASCII.
    ORI         C,30h
    CALL        lcd_print_number_cursor_position_1_542d

; Print the detune fine value.
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_DETUNE_FINE)
    SLR         A
    SLR         A
    CALL        ui_detune_convert_fine_value_2c0d
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_to_cursor_position_3_and_update_547a
    CALL        led_3_all_off_4d09
    RET

; =============================================================================
; Prints the octave UI to the LCD.
; =============================================================================
ui_octave_range_2b2e:
    LXI         HL,str_octave
    CALL        lcd_clear_buffer_and_copy_2_lines_53de

; Load the octave setting.
    LXI         DE,patch_buffer_edit_8300
    DW 00ABh   ;    LDAX        (DE+00h)

; Mask these two bits, which indicate the polarity of the octave setting.
    ANI         A,00001100b

; This bit indicates whether the value is negative.
    ONI         A,00001000b                         ; Skip if A & ? != 0.
    JR          _value_is_positive_2b42

    LXI         BC,"1-"
    JR          _print_number_and_exit_2b4a

_value_is_positive_2b42:
    LXI         BC,"1+"
    NEI         A,0                                 ; Skip if (r≠byte)
    LXI         BC,"0 "

_print_number_and_exit_2b4a:
    CALL        lcd_print_number_to_cursor_position_0_and_update_5474
    CALL        led_3_all_off_4d09
    RET

; =============================================================================
ui_print_vibrato_info_2b51:
    LXI         HL,str_wave
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_LFO_WAVE)
    OFFI        A,2
    JR          LAB_2b6b

    OFFI        A,04h
    JR          LAB_2b67

    OFFI        A,020h
    JR          LAB_2b69

    MVI         A,031h
LAB_2b67:
    MVI         A,32h
LAB_2b69:
    MVI         A,033h
LAB_2b6b:
    MVI         A,034h
    MOV         C,A
    CALL        lcd_print_number_cursor_position_0_542b
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_LFO_DELAY)
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_1_542d
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_LFO_RATE)
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_2_542f
    LXI         DE,patch_buffer_edit_8300
    LDAX        (DE+PATCH_LFO_DEPTH)
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_to_cursor_position_3_and_update_547a
    CALL        led_3_all_off_4d09
    RET

; =============================================================================
ui_portamento_time_2b96:
    LXI         HL,str_portamento_time
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    LDAW        (V_OFFSET(portamento_time_8004))
    JR          ui_print_byte_value_2ba7

; =============================================================================
ui_prints_str_bend_range_2b9f:
    LXI         HL,str_bend_range
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    LDAW        (V_OFFSET(pitch_bend_range_8003))

; =============================================================================
; A: Value to print.
; =============================================================================
ui_print_byte_value_2ba7:
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_to_cursor_position_0_and_update_5474
    CALL        led_3_all_off_4d09
    RET

; =============================================================================
ui_key_transpose_2bb1:
    LXI         HL,str_key_transpose
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    LDAW        (V_OFFSET(MAYBE_key_transpose_8002))
    ADD         A,A
    LXI         HL,note_names_2bd0
    LDEAX       (HL+A)
    PUSH        EA
    MOV         A,EAL
    MOV         C,A
    CALL        lcd_print_number_cursor_position_0_542b
    POP         EA
    MOV         A,EAH
    MOV         C,A
    CALL        lcd_print_number_0_5465
    CALL        led_3_all_off_4d09
    RET

; The extra bytes contain the CGROM entries for the 'sharp' and 'flat' symbols.
note_names_2bd0:
    DB          "G "
    DB          "A", 1
    DB          "A "
    DB          "B", 1
    DB          "B "
    DB          "C "
    DB          "C", 0
    DB          "D "
    DB          "E", 1
    DB          "E "
    DB          "F "
    DB          "F", 0

; =============================================================================
; Sets the current UI screen, or cancels the current screen and prints the
; patch screen if it was already selected.
;
; This function appears TO LOAD THE BYTE
; POSITIONED AFTER THE CALLING ADDRESS!!!!!
; @TODO
; =============================================================================
set_current_ui_screen_or_cancel_2be8:
; Load the byte after the calling address into B.
    POP         HL
    LDAX        (HL+)
    MOV         B,A

; Test if this screen is already selected.
; If the specified screen is already selected, exit and print the patch screen.
    MOV         A,(ui_current_screen_8052)
    NEA         A,B                                 ; Skip if A != B.
    JMP         ui_print_patch_or_tone_mix_5537

; Save the new screen number.
    MOV         A,B
    MOV         (ui_current_screen_8052),A

; Restore the stack and exit.
    PUSH        HL
    RET

; =============================================================================
; from: https://www.youngmonkey.ca/nose/audio_tech/synth/Casio-CZ.html
; FINE:   0..15   16..30  31..45  46..60
; Byte:   00..0F  11..1F  21..2F  31..3F
;
; This function converts the fine detune value from a linear value to the
; format it is serialised in.
; =============================================================================
ui_detune_modified_fine_serialise_2bfb:
    GTI         A,15                                ; Skip if (r>byte)
    RET

    GTI         A,30                                ; Skip if (r>byte)
    JR          _add_1_and_return_2c07

    GTI         A,45                                ; Skip if (r>byte)
    JR          _add_2_and_return_2c0a

; Add 3 and return.
    ADI         A,3
    RET

_add_1_and_return_2c07:
    ADI         A,1
    RET

_add_2_and_return_2c0a:
    ADI         A,2
    RET

; =============================================================================
; This converts the fine tuning value from the serialised format to a linear
; value which can be incremented/decremented.
; =============================================================================
ui_detune_convert_fine_value_2c0d:
    ANI         A,00111111b
    GTI         A,0Fh
    RET

    GTI         A,1Fh
    JR          _subtract_1_and_return_2c1b

    GTI         A,02fh
    JR          _subtract_2_and_return_2c1e

    SUI         A,3
    RET

_subtract_1_and_return_2c1b:
    SUI         A,1
    RET

_subtract_2_and_return_2c1e:
    SUI         A,2
    RET

; =============================================================================
; DE: Patch MFW Data (DCO Waveform 1+2)
; Returns:
; BC: Waveform 1+2 in human readable form.
; =============================================================================
ui_waveform_get_wave_numbers_2c21:
; Clear C in-case waveform 2 isn't set.
    MVI         C,0
; Test whether a second waveform is set.
    ONI         E,00000010b
    JR          _waveform_1_2c32

; Waveform 2.
    MOV         A,E
    SLR         A
    SLR         A
    ANI         A,00000111b
    CALL        ui_waveform_get_wave_number_from_mfw_data_2c3d
    MOV         C,A

; Waveform 1.
_waveform_1_2c32:
    MOV         A,E
    CALL        ui_waveform_shift_right_4_times_2d67
    SLR         A
    CALL        ui_waveform_get_wave_number_from_mfw_data_2c3d
    MOV         B,A
    RET

; =============================================================================
; Gets the waveform number from the MFW data.

; Arguments:
; A: Masked waveform number (0-7).
; DE: Patch MFW Data (DCO Waveform 1+2)
; Returns:
; A: Waveform number.
; =============================================================================
ui_waveform_get_wave_number_from_mfw_data_2c3d:
; Look up the value in this table based on the masked waveform.
    LXI         HL,waveform_number_conversion_table_2c54
    LDAX        (HL+A)
; If this value is 6, it indicates waveform 6-8.
    EQI         A,6                                 ; Skip if A=byte.
    RET

; Waveform 6-8.
; Query the second byte.
    MOV         A,D
; Mask these two bits to determine the waveform.
    ANI         A,11000000b

; This bit by itself indicates waveform 7.
    NEI         A,80h
    JR          _return_7_2c4f

; These two bits together indicates waveform 8.
    NEI         A,0C0h
    JR          _return_8_2c51

; Anything else is waveform 6.
    MVI         A,6

_return_7_2c4f:
    MVI         A,7

_return_8_2c51:
    MVI         A,8
    RET

waveform_number_conversion_table_2c54:
    DB          1
    DB          2
    DB          3
    DB          1
    DB          4
    DB          5
    DB          6
    DB          1

; =============================================================================
; Signed subtraction of B from A.
; If A < B, A is subtracted from B, and the
; sign-bit is set to indicate the result is negative.
;
; Return:
; A:  Result.
; EA: 0
; =============================================================================
signed_subtract_b_from_a_clear_ea_2c5c:
    LXI         EA,0
    LTA         A,B                                 ; Skip if A < B.
    JR          _return_positive_subtraction_2c68

; If the result is negative:
; Subtract A from B.
; Set bit 7 to indicate a negative result, and return.
    SUB         B,A
    MOV         A,B
    ORI         A,10000000b
    RET

_return_positive_subtraction_2c68:
; Subtract B from A.
    SUB         A,B
    RET


; =============================================================================
ui_increment_decrement_max_60_2c6b:
    MVI         B,3Ch
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_128_2c6e:
    MVI         B,80h
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_15_2c71:
    MVI         B,0Fh
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_3_2c74:
    MVI         B,3
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_9_2c77:
    MVI         B,9
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_63_2c7a:
    MVI         B,63h
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_11_2c7d:
    MVI         B,11
    JR          increment_decrement_value_2c82

; =============================================================================
ui_increment_decrement_max_12_2c80:
    MVI         B,12

; =============================================================================
; A = Value to increment/decrement.
; B = Maximum value.
; =============================================================================
increment_decrement_value_2c82:
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          _increment_value_2c8a

    SUINB       A,1                               ; Skip if no borrow.

; Clamp at 0.
    MVI         A,0
    RET

_increment_value_2c8a:
    ADI         A,1
    LTA         A,B
    MOV         A,B
    RET

; =============================================================================
; Returns:
; HL: Pointer to the currently selected envelope data.
; B:  The offset to the currently selected step's data?
; =============================================================================
get_ptr_to_currently_selected_env_step_data_2c90:
    PUSH        V
    LHLD        (env_currently_selected_data_ptr_803e)
    LDAW        (V_OFFSET(env_currently_selected_step_8039))
    ADD         A,A
    MOV         B,A
    POP         V
    RET

; =============================================================================
; Skips on return if the current screen is an env screen.
; =============================================================================
check_if_ui_screen_is_env_2c9c:
    MOV         A,(ui_current_screen_8052)

; Test if the active UI screen corresponds to DCO/DCW/DCA.
    LTI         A,0Ch                               ; Skip if A < 0Ch.
    RET

; Test if the active UI screen corresponds to env.
    ONI         A,1                                 ; Skip if A & 1h != 0.
    RET

    RETS

; =============================================================================
UNKNOWN_ui_env_2ca7:
    ANIW        (V_OFFSET(ui_flags_8038)),~UI_FLAGS_20
    LXI         BC,0
    DCX         HL
    LDAX        (HL)
    ANI         A,7
    STAX        (HL+)
    PUSH        V

LAB_2cb3:
    POP         V
    NEA         A,B
    JRE         LAB_2cdc

    PUSH        V
    LDAX        (HL+)
    ANI         A,01111111b
    MOV         D,A
    LDAX        (HL-)
    MOV         E,A
    ONI         A,80h
    JR          LAB_2ccb

    OFFIW       (V_OFFSET(ui_flags_8038)),00100000b
    ANI         E,7Fh
    ORIW        (V_OFFSET(ui_flags_8038)),UI_FLAGS_20

LAB_2ccb:
    ANI         A,01111111b
    SUBNB       A,C
    ORI         D,80h
    MOV         A,D
    STAX        (HL+)
    MOV         A,E
    STAX        (HL+)
    ANI         A,01111111b
    MOV         C,A
    INR         B
    JRE         LAB_2cb3

LAB_2cdc:
    RET

; =============================================================================
; A: Button hold timer reset value.
; =============================================================================
input_reset_btn_hold_unmask_intt1_reset_ft1_2cdd:
    DI

; Reset TIMER1 interrupt request flag.
    SKIT        FT1
    NOP

; Reset the button release timer, and button held flag.
    STAW        (V_OFFSET(input_button_repeat_timer_max_8045))
    STAW        (V_OFFSET(input_button_repeat_timer_current_8044))

; Clear the 'Button Held' flag.
    ANIW        (V_OFFSET(ui_flags_8037)),~FLAGS_8037_BUTTON_HELD

; Release INTT1 masking.
    ANI         MKL,~MKL_MKT1

    EI
    RET

; =============================================================================
; Performs an unknown arithmetic transformation.
; A: ?
; Returns:
; EA: ?
; =============================================================================
UNKNOWN_vibrato_2ced:
    PUSH        BC
    PUSH        V

; C = A & 0xF.
    MOV         C,A
    ANI         C,1111b

; B = A & 0x70.
    MOV         B,A
    ANI         B,01110000b

; A = 0.
; If B = 0, exit.
    MVI         A,0
    NEI         B,0
    JR          _exit_2d0e

    ORI         C,00010000b

_loop_2d00:
    NEI         B,10h
    JR          _exit_2d0e

; B = B - 10.
    SUI         B,10h
; Set carry.
    STC
    RLL         C
    RLL         A
    JR          _loop_2d00

_exit_2d0e:
    MOV         B,A
    DMOV        EA,BC
    JRE         pop_va_bc_ret_2d36

; =============================================================================
; Arguments:
; A:  Number to convert.
;
; Returns:
; BC: Number in two-digit ASCII form.
; =============================================================================
lcd_convert_2_digit_number_to_ascii_2d12:
    PUSH        EA
    PUSH        V

    LXI         EA,0
    MOV         EAL,A

; Divide EA by 10...
    MVI         A,10
    DIV         A

; Add 30 to the remainder.
; Since the number is always less than 10, this can be done with OR.
; This converts the least-significant digit to ASCII form. i.e.
; 32 / 10 = 3, remainder 2. 2 + 0x30 = 0x32 = '2'.
    ORI         A,00110000b
; Store the least-significant ASCII character in B.
    MOV         B,A

; The most-significant digit is in EAL. Convert this to ASCII.
    MOV         A,EAL
    ORI         A,00110000b
    MOV         C,A

    POP         V
    POP         EA
    RET

; Unreachable code?
    DB          0B1h
    DB          0B0h
    DB          01Ah
    DB          009h
    DB          060h
    DB          0C2h
    DB          061h
    DB          019h
    DB          048h
    DB          00Ah
    DB          0C5h
    DB          008h
    DB          046h
    DB          001h
    DB          061h
    DB          018h

; =============================================================================
pop_va_bc_ret_2d36:
    JR          pop_va_bc_ret_2d47

; Unreachable code?
    DB          0B1h
    DB          0B0h
    DB          01Ah
    DB          009h
    DB          060h
    DB          0E2h
    DB          061h
    DB          019h
    DB          048h
    DB          00Ah
    DB          0C5h
    DB          008h
    DB          066h
    DB          001h
    DB          061h
    DB          018h

; =============================================================================
pop_va_bc_ret_2d47:
    POP         V
    POP         BC
    RET

; Unreachable code?
    DB          0B0h
    DB          008h
    DB          040h
    DB          067h
    DB          02Dh
    DB          017h
    DB          30h
    DB          01Bh
    DB          008h
    DB          007h
    DB          00Fh
    DB          017h
    DB          30h
    DB          01Ah
    DB          009h
    DB          40h
    DB          067h
    DB          02Dh
    DB          017h
    DB          30h
    DB          01Dh
    DB          009h
    DB          007h
    DB          00Fh
    DB          017h
    DB          30h
    DB          01Ch
    DB          0A0h
    DB          0B8h

ui_waveform_shift_right_4_times_2d67:
    SLR         A
    SLR         A
    SLR         A
    SLR         A
    RET

; =============================================================================
UNKNOWN_ui_env_rate_2d70:
    PUSH        BC
    PUSH        EA
    LTI         A,99
    MVI         A,99
    ONIW        (V_OFFSET(ui_flags_8038)),0Ch
    JR          LAB_2d88

    MVI         B,119
    MUL         B
    MVI         B,99
    DIV         B
    MOV         A,EAL
    BIT         2,(V_OFFSET(ui_flags_8038))
    ADI         A,8
    JR          LAB_2d8b

LAB_2d88:
    CALL        MAYBE_ui_env_convert_dcw_level_to_serialisable_value_2de0

LAB_2d8b:
    POP         EA
    POP         BC
    RET

; =============================================================================
; Does this convert the Env level value shown in the UI to a format
; that can be serialised?
; A: Incremented/Decremented level value?
; =============================================================================
MAYBE_ui_env_convert_level_to_serialisable_value_2d8e:
    BIT         UI_FLAGS_ENV_DCA_BIT,(V_OFFSET(ui_flags_8038))
    JR          _not_dca_2d9b

; DCA.
; Clamp at 99.
    LTI         A,99
    MVI         A,99

    NEI         A,0
    JR          _exit_2da6

    ADI         A,28
    JR          _exit_2da6

_not_dca_2d9b:
    BIT         UI_FLAGS_ENV_DCW_BIT,(V_OFFSET(ui_flags_8038))
    JR          _dco_2da2

; DCW.
    CALL        MAYBE_ui_env_convert_dcw_level_to_serialisable_value_2de0
    JR          _exit_2da6

_dco_2da2:
; DCO.
    LTI         A,64
    ADI         A,4

_exit_2da6:
    RET

; =============================================================================
; Converts an env rate value to a 0-99 range.
;
; A: Env step rate.
; Returns:
; A: The env rate converted to a range of 0-99.
; =============================================================================
ui_env_convert_rate_to_0_99_range_2da7:
    PUSH        BC
    PUSH        EA

; Test if the selected envelope is DCA or DCW. Skip if so.
    ONIW        (V_OFFSET(ui_flags_8038)),(UI_FLAGS_ENV_DCA | UI_FLAGS_ENV_DCW)
    JR          _env_is_dco_2dc6

; Test if env is DCA.
; Subtract 8 if DCW?
    BIT         UI_FLAGS_ENV_DCA_BIT,(V_OFFSET(ui_flags_8038))
    SUI         A,8
    NEI         A,0
    JR          _exit_2dc9

    NEI         A,119
    JR          _value_at_maximum_2dc3

; Convert the value to a 0-99 range.
; A = (((A * 99) / 119) & 0xFF) + 1.
    MVI         B,99
    MUL         B
    MVI         B,119
    DIV         B
    MOV         A,EAL
    ADI         A,1
    JR          _exit_2dc9

_value_at_maximum_2dc3:
    MVI         A,99
    JR          _exit_2dc9

_env_is_dco_2dc6:
    CALL        ui_env_convert_dco_rate_to_0_99_range_2df0

_exit_2dc9:
    POP         EA
    POP         BC
    RET

; =============================================================================
ui_env_convert_level_to_0_99_range_2dcc:
    BIT         UI_FLAGS_ENV_DCA_BIT,(V_OFFSET(ui_flags_8038))
    JR          _not_dca_2dd4

    EQI         A,0
    SUI         A,28
    JR          _exit_2ddf

_not_dca_2dd4:
    BIT         UI_FLAGS_ENV_DCW_BIT,(V_OFFSET(ui_flags_8038))
    JR          _dco_2ddb

    CALL        ui_env_convert_dco_rate_to_0_99_range_2df0
    JR          _exit_2ddf

_dco_2ddb:
    LTI         A,64
    SUI         A,4

_exit_2ddf:
    RET

; =============================================================================
; A: DCW level?
; =============================================================================
MAYBE_ui_env_convert_dcw_level_to_serialisable_value_2de0:
    PUSH        BC
    PUSH        EA
; Clamp at 99.
    LTI         A,99
    MVI         A,99

    MVI         B,127
    MUL         B

    MVI         B,99
    DIV         B

    MOV         A,EAL
    JR          _exit_2e06

; =============================================================================
ui_env_convert_dco_rate_to_0_99_range_2df0:
    PUSH        BC
    PUSH        EA

    NEI         A,0
    JR          _exit_2e06

    NEI         A,127
    JR          _value_at_maximum_2e04

    MVI         B,99
    MUL         B
    MVI         B,127
    DIV         B
    MOV         A,EAL
    ADI         A,1
    JR          _exit_2e06

_value_at_maximum_2e04:
    MVI         A,99

_exit_2e06:
    POP         EA
    POP         BC
    RET

str_amp_step:
    DB          020h
    DB          0Ah
    DB          04Fh
    DB          "AMP   STEP      "
    DB          01Fh
str_wave_step:
    DB          020h
    DB          0Ah
    DB          04Fh
    DB          "WAVE  STEP      "
    DB          01Fh
str_pitch_step:
    DB          020h
    DB          0Ah
    DB          04Fh
    DB          "PITCH STEP      "
    DB          01Fh
str_rate_level:
    DB          2h
    DB          036h
    DB          03Fh
    DB          "RATE=   LEVEL=  "
    DB          01Fh
str_key_follow:
    DB          00h
    DB          "   KEY FOLLOW   "
    DB          01Fh
str_amp_range:
    DB          1h
    DB          01Dh
    DB          " AMP   RANGE=   "
    DB          01Fh
str_wave_range:
    DB          1h
    DB          01Dh
    DB          " WAVE  RANGE=   "
    DB          01Fh
str_detune:
    DB          04h
    DB          08h
    DB          0Fh
    DB          036h
    DB          03Fh
    DB          "DETUNE (+) OCT= NOTE=    FINE=  "
    DB          01Fh
str_octave:
    DB          1h
    DB          03Bh
    DB          "     OCTAVE         RANGE=      "
    DB          01Fh
str_wave:
    DB          04h
    DB          05h
    DB          02Fh
    DB          036h
    DB          03Fh
    DB          "WAVE=   DELAY=  RATE=   DEPTH=  "
    DB          01Fh
str_portamento_time:
    DB          1h
    DB          03Bh
    DB          "   PORTAMENTO        TIME=      "
    DB          01Fh
str_bend_range:
    DB          1h
    DB          03Bh
    DB          "   BEND RANGE       RANGE=      "
    DB          01Fh
str_wave_form:
    DB          2h
    DB          16h
    DB          01Fh
    DB          "   WAVE FORM    FIRST=  SECOND= "
    DB          01Fh
str_key_transpose:
    DB          011h
    DB          019h
    DB          01Ah
    DB          " KEY TRANSPOSE       KEY=       "
    DB          01Fh
patch_init_data_dca_UNKNOWN_2f8e:
    DB          00h
    DB          08h
    DB          011h
    DB          01Ah
    DB          024h
    DB          02Fh
    DB          03Ah
    DB          045h
    DB          052h
    DB          05Fh
patch_init_data_dcw_UNKNOWN_2693:
    DB          00h
    DB          01Fh
    DB          02Ch
    DB          039h
    DB          046h
    DB          053h
    DB          60h
    DB          06Eh
    DB          092h
    DB          0FFh
patch_lfo_init_data_2fa2:
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h

patch_init_data_dca_2fac:
    DB          07h
    DB          077h
    DB          0FFh
    DB          0BCh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          0BCh
    DB          00h
patch_init_data_dcw_UNKNOWN_2fbd:
    DB          07h
    DB          07Fh
    DB          0FFh
    DB          0C4h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          0C4h
    DB          00h
patch_init_data_dco_UNKNOWN_2fce:
    DB          07h
    DB          40h
    DB          80h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0C0h
    DB          00h

; =============================================================================
; Stores the pending incoming byte.
; =============================================================================
midi_store_incoming_2fdf:
    PUSH        V
    MOV         A,RXB
    MVIW        (V_OFFSET(input_received_ignore_apo_flag_8042)),1

; Did a serial error occur?
    SKNIT       ER                                  ; Skips if irf is 0.
    JR          _serial_error

    INRW        (V_OFFSET(midi_buffer_offset_rx_write_8056))
    NOP

; Set HL to the incoming MIDI buffer address, and save the incoming byte.
    PUSH        HL
    MVI         H,(midi_data_incoming_8400 >> 8)
    MOV         L,(midi_buffer_offset_rx_write_8056)
    STAX        (HL)

; If the ring buffer wraps around it means that the buffer has overflowed.
    LDAW        (V_OFFSET(midi_buffer_offset_rx_write_8056))
    NEAW        (V_OFFSET(midi_buffer_offset_rx_read_8057))
    JR          _midi_rx_buffer_overflow_3000

_exit_2ff9:
    POP         HL

_exit_2ffa:
    POP         V
    RET

_serial_error:
    MVIW        (V_OFFSET(midi_incoming_command_byte_805a)),0
    JR          _exit_2ffa

_midi_rx_buffer_overflow_3000:
    MVI         A,0
    STAW        (V_OFFSET(midi_incoming_command_byte_805a))
    STAW        (V_OFFSET(midi_buffer_offset_rx_write_8056))
    STAW        (V_OFFSET(midi_buffer_offset_rx_read_8057))

    PUSH        BC
    PUSH        DE
    PUSH        EA

; Clear the incoming MIDI buffer.
    LXI         DE,midi_data_incoming_8400
    MVI         C,0FFh
    CALL        clear_memory_block_4144
    CALL        patch_UNKNOWN_29e0
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    CALL        midi_solo_mode_voice_switch_512d
    CALL        FUN_7354
    CALL        prints_midi_data_full_5720

    POP         EA
    POP         DE
    POP         BC
    JRE         _exit_2ff9

; =============================================================================
; Sends the next pending byte in the MIDI TX buffer.
; =============================================================================
midi_send_next_pending_byte_3027:
    PUSH        V

; Check whether the write and read offsets are equal, indicating that the
; MIDI TX buffer is empty.
    LDAW        (V_OFFSET(midi_buffer_offset_tx_read_8059))
    EQAW        (V_OFFSET(midi_buffer_offset_tx_write_8058))    ; Skip if (A=(V.wa)).
    JR          _send_byte_3033

    MVIW        (V_OFFSET(midi_tx_data_pending_8040)),1

_exit_3031:
    POP         V
    RET

_send_byte_3033:
; Set HL to 08200h + Read offset.
    INR         A
    NOP
    STAW        (V_OFFSET(midi_buffer_offset_tx_read_8059))
    PUSH        HL
    MVI         H,(midi_outgoing_8200 >> 8)
    MOV         L,A

; Load the next byte to send, and write it to TXB.
    LDAX        (HL)
    MOV         TXB,A
    POP         HL
    JR          _exit_3031

; =============================================================================
midi_get_incoming_data_and_process_3040:
; This function skips on return if incoming data is ready to be preocessed.
; This means that this function will loop until no more data is pending.
    CALL        midi_get_incoming_data_3048
    RET

    CALL        midi_process_message_30a1
    JR          midi_get_incoming_data_and_process_3040

; =============================================================================
midi_get_incoming_data_3048:
    DI

; Test whether these are equal, if so the buffer is empty.
    LDAW        (V_OFFSET(midi_buffer_offset_rx_read_8057))
    NEAW        (V_OFFSET(midi_buffer_offset_rx_write_8056))
    JR          _rx_buffer_empty_3065

; Increment and store read offset.
    INR         A
    NOP
    STAW        (V_OFFSET(midi_buffer_offset_rx_read_8057))

; Set HL to the incoming MIDI data buffer + Read Offset, read the incoming
; data, and return.
    MOV         L,A
    MVI         H,(midi_data_incoming_8400 >> 8)
    LDAX        (HL)
    ONIW        (V_OFFSET(midi_sysex_rx_active_805f)),1     ; Skip if A & (V.wa) != 0.
    RETS

; Reset SysEx timeout counters?
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_flag_8062)),0
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_2_8060)),0
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_1_8061)),010h
    RETS

_rx_buffer_empty_3065:
    EI

; Return if SysEx inactive.
    ONIW        (V_OFFSET(midi_sysex_rx_active_805f)),1     ; Skip if 0805fh & 1 != 0.
    RET

; Test whether the SysEx timeout timer has elapsed.
    ONIW        (V_OFFSET(midi_sysex_rx_timeout_flag_8062)),1   ; Skip if flag set.
    JR          _sysex_hasnt_timed_out_3072

; Timer elapsed. End SysEx processing?
    CALL        midi_sysex_set_inactive_and_reset_30fd
    RET

_sysex_hasnt_timed_out_3072:
    EQIW        (V_OFFSET(midi_sysex_function_2_8063)),0
    JRE         midi_get_incoming_data_3048

    RET

; =============================================================================
; A: Byte to set as last byte, and send.
; =============================================================================
midi_clear_last_message_and_send_3078:
    MVIW        (V_OFFSET(midi_previous_message_type_805c)),0

; =============================================================================
midi_add_byte_to_tx_buffer_and_send_307b:
    PUSH        BC
    PUSH        HL

; Save the outgoing byte in C.
    MOV         C,A

; Setup HL as a pointer to the MIDI TX buffer.
    MVI         H,(midi_outgoing_8200 >> 8)

; Load the TX buffer write offset, and increment.
    LDAW        (V_OFFSET(midi_buffer_offset_tx_write_8058))
    INR         A
    NOP

; Loops continuously until the TX write/read pointers aren't equal.
_wait_until_all_data_is_sent_3084:
    NEAW        (V_OFFSET(midi_buffer_offset_tx_read_8059))
    JR          _wait_until_all_data_is_sent_3084

    DI

; Store the incremented write offset.
    STAW        (V_OFFSET(midi_buffer_offset_tx_write_8058))

; Set L to the buffer TX offset to setup HL as a pointer to the current
; position in the MIDI TX buffer.
    MOV         L,A

; Restore the outgoing byte to A, and store in the TX buffer.
    MOV         A,C
    STAX        (HL)

; If the pending data flag isn't set, skip sending.
; Skip if ((V.wa) & byte == 0
    OFFIW       (V_OFFSET(midi_tx_data_pending_8040)),1
    CALL        midi_send_next_byte_3098

    EI
    POP         HL
    POP         BC
    RET

; =============================================================================
; Sends the next pending byte in the MIDI TX buffer.
; =============================================================================
midi_send_next_byte_3098:
; Increment the TX buffer read offset.
    INRW        (V_OFFSET(midi_buffer_offset_tx_read_8059))
    NOP
; Move the data to the serial TX register.
    MOV         TXB,A
; Reset the data output pending flag.
    MVIW        (V_OFFSET(midi_tx_data_pending_8040)),0
    RET

; =============================================================================
midi_process_message_30a1:
; Is this a data or status message?
    ONI         A,80h                               ; Skip if A & 80h != 0.
    JRE         midi_process_message_data_3102

; Skip if A > 0xEF, meaning this is a SysEx or unsupported message.
    GTI         A,0EFh
    JR          midi_process_message_command_30b6

    EI

; Is this a SysEx start message?
    NEI         A,0F0h
    JRE         midi_sysex_process_start_30d7

; Is this a SysEx end message?
    NEI         A,0F7h
    JRE         midi_sysex_set_inactive_and_reset_30fd

; System real-time messages (> 0xF6) are ignored.
; System common messages (0xF1-0xF6) reset SysEx state.
    GTI         A,0F6h
    JRE         midi_sysex_set_inactive_and_reset_30fd

    RET

; =============================================================================
; A: The incoming MIDI command byte.
; =============================================================================
midi_process_message_command_30b6:
    STAW        (V_OFFSET(midi_incoming_command_byte_805a))
    EI

    MVIW        (V_OFFSET(midi_sysex_rx_active_805f)),0

; Temporarily move the incoming status byte in A.
    MOV         C,A

; Is SysEx active?
; Skip if ((V.wa)≠byte)
    NEIW        (V_OFFSET(midi_sysex_function_2_8063)),0
    JR          _sysex_inactive_30c9

; Send SysEx end.
    MVI         A,0F7h
    CALL        midi_clear_last_message_and_send_3078
    MVIW        (V_OFFSET(midi_sysex_function_2_8063)),0

_sysex_inactive_30c9:
; Restore the incoming status byte.
    MOV         A,C

    MVIW        (V_OFFSET(midi_incoming_data_index_flag_805b)),1

; If the status byte is between 0xBF and 0xE0, only one data byte is expected.
    GTI         A,0BFh                              ; Skip if incoming status > BFh.
    RET

    LTI         A,0E0h                              ; Skip if incoming status < E0h.
    RET

    MVIW        (V_OFFSET(midi_incoming_data_index_flag_805b)),0
    RET

; =============================================================================
midi_sysex_process_start_30d7:
    MVIW        (V_OFFSET(midi_sysex_rx_active_805f)),1
; Reset timeout counters.
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_flag_8062)),0
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_2_8060)),0
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_1_8061)),10h

; =============================================================================
midi_sysex_reset_30e3:
; If SysEx is active, send a SysEx end message.
    MVI         A,0F7h
    EQIW        (V_OFFSET(midi_sysex_function_2_8063)),0
    CALL        midi_clear_last_message_and_send_3078

; Reset SysEx data.
    MVI         A,0
    STAW        (V_OFFSET(midi_incoming_command_byte_805a))
    STAW        (V_OFFSET(midi_sysex_function_2_8063))
    STAW        (V_OFFSET(midi_sysex_incoming_header_stage_8064))
    STAW        (V_OFFSET(midi_sysex_function_8066))
    STAW        (V_OFFSET(UNKNOWN_midi_sysex_8065))
    STAW        (V_OFFSET(MAYBE_midi_sysex_patch_pointer_8067))

    MVIW        (V_OFFSET(MAYBE_midi_sysex_patch_pointer_8068)),88h
    RET

; =============================================================================
midi_sysex_set_inactive_and_reset_30fd:
    MVIW        (V_OFFSET(midi_sysex_rx_active_805f)),0
    JR          midi_sysex_reset_30e3

; Unreachable code.
    RET

; =============================================================================
; A: Incoming MIDI data byte.
; =============================================================================
midi_process_message_data_3102:
    EI

; If SysEx is active...
    OFFIW       (V_OFFSET(midi_sysex_rx_active_805f)),1      ;Skip if AND result is zero.
    JMP         midi_process_message_data_sysex_active_332d

; Check whether the incoming MIDI message byte was 0.
; If so, return.
    NEIW        (V_OFFSET(midi_incoming_command_byte_805a)),0 ; If not the same, skip.
    RET

; Skips if a borrow is generated by the decrement.
    DCRW        (V_OFFSET(midi_incoming_data_index_flag_805b))
    JR          _store_first_incoming_byte_3126

; This appears to re-process the command message?
; If the incoming MIDI command expected a second byte, and the first has
; already been stored, the control flow will end up here.
; Reprocessing the MIDI command will set the flag again, and the second byte
; will be stored below.
; Alternatively, if more bytes are sent, e.g. A 'running status' message, this
; reprocessing the comamand byte will set this flag appropriately.
    PUSH        V
    DI
    LDAW        (V_OFFSET(midi_incoming_command_byte_805a))
    CALL        midi_process_message_command_30b6
    EI
    POP         V

; Test whether to store in the first or second incoming MIDI byte.
; Skip if bit 1 set.
    BIT         0,(V_OFFSET(midi_incoming_data_index_flag_805b))
    LXI         HL,midi_incoming_data_first_byte_805d
    LXI         HL,midi_incoming_data_second_byte_805e
    STAX        (HL)
    CALL        midi_process_message_complete_312b
    RET

_store_first_incoming_byte_3126:
    LXI         HL,midi_incoming_data_first_byte_805d
    STAX        (HL)
    RET

; =============================================================================
midi_process_message_complete_312b:
; Test the channel of the incoming MIDI message.
    LDAW        (V_OFFSET(midi_incoming_command_byte_805a))
    ANI         A,00001111b
    PUSH        V

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    MOV         B,A
    POP         V

; Test if solo mode active.
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE  ; Skip if 08031h & 04h == 0.
    JRE         midi_process_message_complete_solo_mode_active_3161

; If the MIDI channel doesn't match the message, return.
    EQA         A,B ; Skip if equal.
    RET

    MVI         A,0

store_midi_voice_index_3142:
    STAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))

; Load MIDI status byte.
; Shift right 3 times and mask to create an index
; into the table.
    LDAW        (V_OFFSET(midi_incoming_command_byte_805a))
    SLR         A

    SLR         A
    SLR         A
    ANI         A,00001110b
    TABLE
    JB
    DW          midi_process_note_off_316a
    DW          midi_process_note_on_3180
    DW          return_4c35                         ; Aftertouch.
    DW          midi_process_cc_31a6
    DW          midi_process_prog_change_32d5
    DW          return_4c35
    DW          midi_process_pitch_bend_330b
    DW          return_4c35

; A = Incoming MIDI channel.
; B = Base MIDI RX channel.
; This calculates the solo voice channel.
midi_process_message_complete_solo_mode_active_3161:
    SUBNB       A,B                                 ; Skip if no borrow.
    RET

    GTAW        (V_OFFSET(midi_solo_max_voice_index_8035))       ; Skip if A > 08035h.
    JRE         store_midi_voice_index_3142

    RET

; =============================================================================
midi_process_note_off_316a:
    LDAW        (V_OFFSET(midi_incoming_data_first_byte_805d))
    CALL        midi_process_note_on_off_validate_note_318f
    CALL        midi_process_note_off_clear_msb_flag_317c
; Falls-through below.

; =============================================================================
midi_process_note_on_off_3172:
    CALL        channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6
    MVIW        (V_OFFSET(current_note_event_origin_8015)),80h
    CALL        note_on_off_47be
    RET

; =============================================================================
midi_process_note_off_clear_msb_flag_317c:
    ANI         A,01111111b
    MOV         E,A
    RET

; =============================================================================
midi_process_note_on_3180:
; Test whether the second byte (velocity) is zero.
; If so, this is treated as a note-off message.
    NEIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),0
    JRE         midi_process_note_off_316a

    LDAW        (V_OFFSET(midi_incoming_data_first_byte_805d))
    CALL        midi_process_note_on_off_validate_note_318f

; Set the MSB of the note number?
; Is this a flag to indicate NOTE ON?
    ORI         A,10000000b
    MOV         E,A
    JRE         midi_process_note_on_off_3172

; =============================================================================
; A: Incoming MIDI note number.
; =============================================================================
midi_process_note_on_off_validate_note_318f:
    GTI         A,023h                              ; Skip if A > 023h.
    CALL        midi_process_note_on_off_note_too_low_319a
    LTI         A,061h                              ; Skip if A < 061h.
    CALL        midi_process_note_on_off_note_too_high_31a0
    RET

; =============================================================================
; Keep adding an octave to the note until it's valid.
; =============================================================================
midi_process_note_on_off_note_too_low_319a:
    ADI         A,0Ch
    GTI         A,023h
    JR          midi_process_note_on_off_note_too_low_319a

    RET

; =============================================================================
; Keep subtracting an octave from the note until it's valid.
; =============================================================================
midi_process_note_on_off_note_too_high_31a0:
    SUI         A,0Ch
    LTI         A,061h
    JR          midi_process_note_on_off_note_too_high_31a0

    RET

; =============================================================================
midi_process_cc_31a6:
    LDAW        (V_OFFSET(midi_incoming_data_first_byte_805d))
    LTI         A,07ah                              ; Skip if A is less than 07Ah.
    JRE         midi_process_mode_change_31c6

    NEI         A,41h                               ; Skip if A != 41.
    JMP         midi_process_cc_portamento_on_off_323f

    NEI         A,1
    JMP         midi_process_cc_vibrato_on_off_UNKNOWN_3267

    NEI         A,5
    JMP         MAYBE_midi_process_cc_porta_time_329b

    NEI         A,06h
    JMP         midi_process_cc_master_tune_32af

    NEI         A,7
    JMP         midi_process_cc_UNKNOWN_32b4
    RET

; =============================================================================
midi_process_mode_change_31c6:
    MOV         C,A

; Validate incoming MIDI channel.
; Mask the incoming message's MIDI channel.
    LDAW        (V_OFFSET(midi_incoming_command_byte_805a))
    ANI         A,00001111b
    MOV         B,A

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    EQA         A,B                                 ; Skip if equal.
    RET

    MOV         A,C

; A = ((A - 0x7A) & 0b111) << 1.
    SUI         A,07Ah
    ANI         A,00000111b
    SLL         A
    TABLE
    JB
    DW          midi_process_mode_change_local_31ef
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          midi_process_mode_change_poly_off_320b
    DW          midi_process_mode_change_poly_on_322d
    DW          return_4c35
    DW          return_4c35

; =============================================================================
midi_process_mode_change_local_31ef:
    NEIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),7Fh
    JR          _local_mode_enable_3207

; Is the second MIDI message byte 0?
    EQIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),0
    RET

; Disable local mode.
    MVIW        (V_OFFSET(local_mode_keyboard_disabled_8016)),1
    CALL        patch_UNKNOWN_29e0
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    CALL        midi_solo_mode_voice_switch_512d
    CALL        FUN_7354
    RET

_local_mode_enable_3207:
    MVIW        (V_OFFSET(local_mode_keyboard_disabled_8016)),0
    RET

; =============================================================================
midi_process_mode_change_poly_off_320b:
; Load the incoming MIDI byte...
; If less than 0, set to 4.
    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    GTI         A,0                                 ; Skip if (r>byte)
    MVI         A,4

; If less than 4, set to 4.
    LTI         A,4                                 ; Skip if (r<byte)
    MVI         A,4
    DCR         A

; Test if solo mode active.
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    JR          _solo_mode_disabled_321e

; Solo mode active.
    NEAW        (V_OFFSET(midi_solo_max_voice_index_8035))
    RET

_solo_mode_disabled_321e:
    STAW        (V_OFFSET(midi_solo_max_voice_index_8035))

; Disable tone mix.
    ANIW        (V_OFFSET(UNKNOWN_flags_8031)),~FLAGS_8031_TONE_MIX

; Enable solo mode.
    ORIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    LXI         HL,channel_info_0_8100
    CALL        midi_process_mode_change_poly_unknown_UNKNOWN_510c
    RET

; =============================================================================
midi_process_mode_change_poly_on_322d:
; Exit if synth not in solo mode.
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    RET

; Exit if second MIDI data byte is not 0.
    EQIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),0
    RET

; Disable solo mode.
    ANIW        (V_OFFSET(UNKNOWN_flags_8031)),~FLAGS_8031_SOLO_MODE
    MVIW        (V_OFFSET(midi_solo_max_voice_index_8035)),3

    CALL        midi_process_mode_change_poly_unknown_UNKNOWN_510c
    RET

; =============================================================================
midi_process_cc_portamento_on_off_323f:
    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    PUSH        V
    CALL        channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
    POP         V

; Is this message turning portamento off?
    NEI         A,0
    JR          _portamento_off_3250

; Is this message turning portamento on?
    NEI         A,7Fh
    JR          _portamento_on_3254

; Any other value is considered invalid.
    RET

_portamento_off_3250:
    LDAX        (BC)
    ANI         A,~CHANNEL_FLAGS_PORTA
    JR          _store_voice_flags_3257

_portamento_on_3254:
    LDAX        (BC)
    ORI         A,CHANNEL_FLAGS_PORTA

_store_voice_flags_3257:
    STAX        (BC)
    CALL        resets_channel_flags_UNKNOWN_50a1
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    NEAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    JMP         input_solo_4e17
    CALL        UNKNOWN_midi_portamento_519b
    RET

; =============================================================================
midi_process_cc_vibrato_on_off_UNKNOWN_3267:
    NEIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),0 ; Skip if 0805eh != 0.
    JR          _incoming_vibrato_off_3280

; If the incoming vibrato value is not zero,
; exit if it's anything other than 07Fh.
    EQIW        (V_OFFSET(midi_incoming_data_second_byte_805e)),7Fh ; Skip if 0805eh == 07Fh.
    RET

; The incoming vibrato value is 07Fh = On.
; Test if 08034h the same as the selected solo voice index?
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    EQAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))  ; Skip if equal.
    JR          _incoming_vibrato_on_voice_not_selected_3279

; @NOTE: Turns vibrato on?
    CALL        voice_update_vibrato_4db0
    RET

_incoming_vibrato_on_voice_not_selected_3279:
    CALL        channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6
    CALL        vibrato_on_51ae
    RET

_incoming_vibrato_off_3280:
    CALL        channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
    LDAX        (BC)
    ANI         A,~CHANNEL_FLAGS_VIBRATO
    STAX        (BC)
    MOV         B,A

; Test again if 08034h the same as the selected solo voice index?
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    EQAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))  ; Skip if equal.
    JR          _incoming_vibrato_off_voice_not_selected_3296

    MOV         A,B
    CALL        UNKNOWN_vibrato_4dc9
    RET

_incoming_vibrato_off_voice_not_selected_3296:
    MOV         D,A
    CALL        voice_vibrato_on_off_UNKNOWN_0_7976
    RET

; =============================================================================
MAYBE_midi_process_cc_porta_time_329b:
    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    LTI         A,064h
    MVI         A,063h
    STAW        (V_OFFSET(portamento_time_8004))
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_PORTAMENTO
    CALL        ui_reset_cursor_index_550d
    CALL        ui_portamento_time_2b96
    JMP         portamento_time_modified_update_28ce

; =============================================================================
midi_process_cc_master_tune_32af:
; Load incoming data byte, and pass to function.
    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    JMP         master_tune_update_2953

; =============================================================================
midi_process_cc_UNKNOWN_32b4:
    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    SLR         A
    SLR         A
    SLR         A
    ANI         A,00001111b
    MOV         PA,A
    MVI         A,0F0h
    MOV         MA,A
    ANI         PC,11101111b
    NOP
    NOP
    NOP
    ORI         PC,00010000b
    NOP
    NOP
    NOP
    MVI         A,0FFh
    MOV         MA,A
    RET

; =============================================================================
midi_process_prog_change_32d5:
    OFFIW       (V_OFFSET(midi_prog_change_disabled_8036)),1    ; Skip if 08036h & 1h == 0.
    RET

    LDAW        (V_OFFSET(midi_incoming_data_first_byte_805d))
    MOV         B,A
    ANI         B,00001111b
    ANI         A,01100000b

; Test whether the patch number is too high (60h or above)
; or too low (0).
    NEI         A,60h                              ; Skip if A !== 60h.
    RET

; In the case it's too low, clamp at 16?
    NEI         A,0
    MVI         A,010h

; Recombine the upper+lower parts of the patch number.
    ORA         A,B

; Check whether the currently selected solo MIDI voice
; is the same as the incoming MIDI message channel.
; 08034h is set in the main MIDI message complete handler.
    PUSH        V
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    NEAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))     ; Skip if 025h !== 034h.
    JR          selected_solo_voice_same_as_midi_channel_32f9

; Get pointer to voice indexed by A.
    CALL        channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6
    POP         V
    CALL        midi_prog_change_solo_voice_520d
    RET

selected_solo_voice_same_as_midi_channel_32f9:
    POP         V

; Is tone mix active?
; Skip if tone mix active.
    BIT         FLAGS_8031_TONE_MIX_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JR          tone_mix_inactive_3304

; Test if the incoming patch index is equal to the
; tone mix patch index?
; Return if equal.
    EQAW        (V_OFFSET(patch_index_tone_mix_8007))   ; Skip if A == 08037h.
    CALL        midi_process_prog_change_solo_tone_mix_active_UNKNOWN_4f2d
    RET
tone_mix_inactive_3304:
    EQAW        (V_OFFSET(patch_index_8026))
    CALL        patch_load_validate_flags_4e90
    RET

; =============================================================================
; Quantises the incoming two-byte pitch bend value from MIDI into a single
; value.
; @TODO: Why is only the lower byte used?
; =============================================================================
midi_process_pitch_bend_330b:
; Test if this MIDI message for the currently selected solo MIDI voice.
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    EQAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    RET

    LDAW        (V_OFFSET(midi_incoming_data_second_byte_805e))
    SLL         A

; Test the polarity of the high-order byte.
; 0x4000 is the center (no pitch bend).
; If the bend is positive, set bit 0 of A (lower byte).
    OFFIW       (V_OFFSET(midi_incoming_data_first_byte_805d)),40h
    ORI         A,1

; Is A < 0x80?
    MVI         B,80h
    LTA         A,B
    JR          _subtract_b_from_a_3322

; A < 0x80.
; A = 0xFF - A.
    MOV         B,A
    MVI         A,0FFh

_subtract_b_from_a_3322:
    SUB         A,B

; Skip if A > 0x80.
    ONI         A,80h
    JR          _store_value_and_exit_332a

; If A == 0xFF, increment to overflow back to 0.
    EQI         A,0FFh
    INR         A

_store_value_and_exit_332a:
    STAW        (V_OFFSET(midi_pitch_bend_incoming_value_804b))
    RET

; =============================================================================
; Reached when an incoming MIDI data byte is received, and SysEx is active.
; This is the main jumpoff for sysex functionality.
; =============================================================================
midi_process_message_data_sysex_active_332d:
; Skip if ((V.wa)≠byte)
    NEIW        (V_OFFSET(midi_sysex_function_2_8063)),0
    JRE         _sysex_function_not_set_3344

    NEIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_SEND
    JMP         midi_sysex_remote_programming_send_patch_3505

    NEIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_RECEIVE
    JMP         midi_sysex_remote_programming_receive_patch_3532

    NEIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_QUERY_PROGRAMMER
    JMP         midi_sysex_process_incoming_data_mode_query_3618

_sysex_function_not_set_3344:
    PUSH        V
    LDAW        (V_OFFSET(midi_sysex_incoming_header_stage_8064))
    ANI         A,00000111b
    SLL         A
    TABLE
    JB
    DW          midi_sysex_test_manufacturer_id_3363
    DW          midi_sysex_test_sysex_header_byte_is_zero_336e
    DW          midi_sysex_test_sysex_header_byte_is_zero_336e
    DW          midi_sysex_test_channel_3375
    DW          midi_sysex_receive_incoming_function_3385
    DW          midi_sysex_function_jumpoff_33aa
    DW          midi_sysex_pop_va_set_inactive_and_reset_335e
    DW          midi_sysex_pop_va_set_inactive_and_reset_335e

midi_sysex_pop_va_set_inactive_and_reset_335e:
    POP         V
    CALL        midi_sysex_set_inactive_and_reset_30fd
    RET

; =============================================================================
; Incoming SysEx header byte is on stack.
; =============================================================================
midi_sysex_test_manufacturer_id_3363:
    POP         V

; Test if SysEx manufacturer ID is correct for Casio (044h).
    EQI         A,044h  ; Skip if A=byte.
    JR          midi_sysex_end_336a

; =============================================================================
midi_sysex_increment_current_header_stage_3367:
    INRW        (V_OFFSET(midi_sysex_incoming_header_stage_8064))
    RET

; =============================================================================
midi_sysex_end_336a:
    CALL        midi_sysex_set_inactive_and_reset_30fd
    RET

; =============================================================================
; Tests that the incoming MIDI SysEx value is zero.
; =============================================================================
midi_sysex_test_sysex_header_byte_is_zero_336e:
    POP         V
    EQI         A,0
    JRE         midi_sysex_end_336a ; Skip if A=byte.

    JRE         midi_sysex_increment_current_header_stage_3367

; =============================================================================
midi_sysex_test_channel_3375:
; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
; All SysEx transmissions specify the channel by 0x70 + Channel.
; Mask these bits when testing the value.
    ORI         A,01110000b
    MOV         B,A
    POP         V
    EQA         A,B
    JRE         midi_sysex_end_336a

    JRE         midi_sysex_increment_current_header_stage_3367

; =============================================================================
midi_sysex_receive_incoming_function_3385:
    POP         V
    NEI         A,010h
    JR          _function_remote_programming_send_339a

    NEI         A,019h
    JR          _function_query_programmer_339c

    NEI         A,020h
    JR          _function_remote_programming_receive_339e

    NEI         A,40h
    JR          _function_set_bend_range_33a0

    NEI         A,041h
    JR          _function_key_transpose_33a2

    NEI         A,042h
    JR          _function_tone_mix_33a4

    JRE         midi_sysex_end_336a

_function_remote_programming_send_339a:
    MVI         A,1

_function_query_programmer_339c:
    MVI         A,2

_function_remote_programming_receive_339e:
    MVI         A,3

_function_set_bend_range_33a0:
    MVI         A,4

_function_key_transpose_33a2:
    MVI         A,5

_function_tone_mix_33a4:
    MVI         A,6

    STAW        (V_OFFSET(midi_sysex_function_8066))
    JRE         midi_sysex_increment_current_header_stage_3367

; =============================================================================
; Jump off to the correct function to handle the selected SysEx function.
; =============================================================================
midi_sysex_function_jumpoff_33aa:
; Load the selected SysEx function, mask it, and load the associated function
; pointer from the table.
    LDAW        (V_OFFSET(midi_sysex_function_8066))
    ANI         A,00000111b
    SLL         A
    TABLE
    JB
    DW          midi_sysex_pop_va_set_inactive_and_reset_335e
    DW          midi_sysex_remote_programming_send_342b
    DW          midi_sysex_send_query_response_34a7
    DW          midi_sysex_remote_programming_receive_3465
    DW          midi_sysex_bend_range_33c3
    DW          midi_sysex_key_transpose_33d8
    DW          midi_sysex_tone_mix_33fe
    DW          midi_sysex_pop_va_set_inactive_and_reset_335e

; =============================================================================
midi_sysex_bend_range_33c3:
    POP         V
    LTI         A,0dh
    MVI         A,0Ch
    STAW        (V_OFFSET(pitch_bend_range_8003))
    CALL        pitch_bend_range_modified_79d0
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_BEND_RANGE
    CALL        ui_reset_cursor_index_550d
    CALL        ui_prints_str_bend_range_2b9f
    JRE         midi_sysex_end_336a

; =============================================================================
midi_sysex_key_transpose_33d8:
    POP         V
    LTI         A,40h
    JR          LAB_33f2

    LTI         A,7
    MVI         A,6
    ADI         A,5
LAB_33e2:
    STAW        (V_OFFSET(MAYBE_key_transpose_8002))
    CALL        master_tune_update_28fe
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_KEY_TRANSPOSE
    CALL        ui_reset_cursor_index_550d
    CALL        ui_key_transpose_2bb1
    JRE         midi_sysex_end_336a

LAB_33f2:
    SUI         A,40h
    LTI         A,06h
    MVI         A,5
    MOV         B,A
    MVI         A,5
    SUB         A,B
    JR          LAB_33e2

; =============================================================================
midi_sysex_tone_mix_33fe:
    POP         V
    ONI         A,40h  ; Skip if A & ? != 0.
    JR          disable_tone_mix_MAYBE_341e

; Disable solo mode.
; Enable tone mix?
    ANIW        (V_OFFSET(UNKNOWN_flags_8031)),~FLAGS_8031_SOLO_MODE
    ORIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX

; Mask incoming value:
; Subtract 40h and construct an index between 1-9.
    ANI         A,00111111b
    NEI         A,0   ; Skip if ((V.wa)≠byte)
    MVI         A,1
    LTI         A,0ah   ; Skip if (r<byte)
    MVI         A,09h
    STAW        (V_OFFSET(tone_mix_UNKNOWN_8006))
    CALL        patch_tone_mix_UNKNOWN_5276
    LDAW        (V_OFFSET(tone_mix_UNKNOWN_8006))
    CALL        UNKNOWN_tone_mix_2998
    JRE         midi_sysex_end_336a

; Test if tone mix enabled.
; If so, disable.
disable_tone_mix_MAYBE_341e:
; Skip if A & ? != 0.
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX
    JRE         midi_sysex_end_336a

    ANIW        (V_OFFSET(UNKNOWN_flags_8031)),~FLAGS_8031_TONE_MIX
    CALL        patch_tone_mix_UNKNOWN_5276
    JRE         midi_sysex_end_336a

; =============================================================================
; Stores the pointer to the patch to send in EA.
;
; A: The incoming MIDI data byte specifying which program to send.
; =============================================================================
midi_sysex_remote_programming_send_342b:
    POP         V

    NEI         A,60h
    JRE         _edit_buffer_selected_3441

    MOV         B,A
    ANI         B,00001111b

    ANI         A,01100000b

    NEI         A,0                                 ; Skip if (r≠byte)
    JR          _patch_preset_344d

; Is patch internal?
    NEI         A,PATCH_FLAGS_INTERNAL
    JR          _patch_internal_344f

; Is patch cartridge?
    NEI         A,PATCH_FLAGS_CARTRIDGE
    JR          _is_cartridge_inserted_3446

    JRE         midi_sysex_end_336a

_edit_buffer_selected_3441:
    LXI         EA,patch_buffer_edit_8300
    JRE         _acknowledge_request_3456

_is_cartridge_inserted_3446:
; Check if CRT is inserted. Exit if not.
    OFFIW       (V_OFFSET(cartridge_disconnected_8022)),1      ; Skip if ((V.wa) & byte = 0)
    JRE         midi_sysex_end_336a

; Construct the patch index argument.
    MVI         A,PATCH_FLAGS_CARTRIDGE

_patch_preset_344d:
    MVI         A,PATCH_FLAGS_10

_patch_internal_344f:
    MVI         A,PATCH_FLAGS_INTERNAL
    ORA         A,B
    CALL        patch_get_pointer_to_index_5072

_acknowledge_request_3456:
    LXI         HL,MAYBE_midi_sysex_patch_pointer_8067
    STEAX       (HL)
    CALL        midi_sysex_send_remote_programming_response_34e0
    MVIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_SEND
    MVIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0
    RET

; =============================================================================
; A: The incoming MIDI data byte specifying which program to send.
; =============================================================================
midi_sysex_remote_programming_receive_3465:
; Skips on return if protect inactive.
    CALL        button_check_protect_5003
    JRE         _exit_memory_protected_34a3

; Is the incoming byte 60, specifying the edit buffer?
    POP         V
    NEI         A,60h
    JRE         _edit_buffer_selected_349e

    MOV         B,A
; Mask the bits in the patch index indicating cartridge, and internal.
    ANI         A,60h
; If nothing is selected, exit.
    NEI         A,0
    JMP         midi_sysex_end_336a

; If both are selected, exit.
    NEI         A,60h
    JMP         midi_sysex_end_336a

    EQI         A,PATCH_FLAGS_CARTRIDGE
    JR          _patch_is_internal_3485

; Exit if the cartridge is disconnected.
    OFFIW       (V_OFFSET(cartridge_disconnected_8022)),1
    JMP         midi_sysex_end_336a

_patch_is_internal_3485:
    ANI         B,1111b
    ORA         A,B
    STAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    CALL        patch_get_pointer_to_index_5072

_store_pointer_and_send_response_348f:
    LXI         HL,MAYBE_midi_sysex_patch_pointer_8067
    STEAX       (HL)
    CALL        midi_sysex_send_remote_programming_response_34e0
    MVIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_REMOTE_PROGRAMMING_RECEIVE
    MVIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0
    RET

_edit_buffer_selected_349e:
    LXI         EA,patch_buffer_edit_8300
    JRE         _store_pointer_and_send_response_348f

_exit_memory_protected_34a3:
    POP         V
    JMP         midi_sysex_end_336a

; =============================================================================
midi_sysex_send_query_response_34a7:
; Send SysEx response header.
    POP         V
    MVI         A,0F0h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,44h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,0
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,0
    CALL        midi_clear_last_message_and_send_3078

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    ANI         A,00001111b
    MOV         B,A

; Load the currently selected MIDI voice, and add this to the
; base MIDI channel.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    ANI         A,11b
    ADD         A,B
    LTI         A,10h
    MVI         A,0Fh

; Add 0x70 to create the MIDI byte to send.
    ORI         A,70h
    CALL        midi_clear_last_message_and_send_3078

    MVI         A,30h
    CALL        midi_clear_last_message_and_send_3078
    MVIW        (V_OFFSET(midi_sysex_function_2_8063)),MIDI_SYSEX_FUNCTION_QUERY_PROGRAMMER
    MVIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0
    RET

; =============================================================================
midi_sysex_send_remote_programming_response_34e0:
    MVI         A,0F0h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,044h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,0
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,0
    CALL        midi_clear_last_message_and_send_3078

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
; All SysEx transmissions specify the channel by 0x70 + Channel.
; Mask these bits when testing the value.
    ORI         A,070h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,30h
    CALL        midi_clear_last_message_and_send_3078
    RET

; =============================================================================
; Responds to a SysEx remote programming request by sending the selected patch.
; =============================================================================
midi_sysex_remote_programming_send_patch_3505:
    PUSH        V
    GTIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0
    JMP         midi_sysex_test_channel_3375

    POP         V
    EQI         A,031h
    JMP         midi_sysex_end_336a

    LXI         HL,MAYBE_midi_sysex_patch_pointer_8067
    LDEAX       (HL)
    DMOV        HL,EA
    MVI         C,7Fh

send_patch_byte_loop_351a:
    LDAX        (HL+)
    PUSH        V
    ANI         A,00001111b
    CALL        midi_clear_last_message_and_send_3078
    POP         V
    SLR         A
    SLR         A
    SLR         A
    SLR         A
    CALL        midi_clear_last_message_and_send_3078
    DCR         C
    JR          send_patch_byte_loop_351a

    JMP         midi_sysex_end_336a

; =============================================================================
midi_sysex_remote_programming_receive_patch_3532:
    PUSH        V
    OFFIW       (V_OFFSET(UNKNOWN_midi_sysex_8065)),1
    JRE         LAB_35b9

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
; All SysEx transmissions specify the channel by 0x70 + Channel.
; Mask these bits when testing the value.
    ORI         A,070h
    MOV         B,A
    POP         V
    NEA         A,B
    JRE         LAB_35b5

; MIDI channels not equal.
    LTI         A,010h
    JMP         midi_sysex_end_336a

    BIT         0,(V_OFFSET(midi_sysex_incoming_header_stage_8064))
    JRE         LAB_35b1

    SLL         A
    SLL         A
    SLL         A
    SLL         A
    MOV         B,A
    LDAW        (V_OFFSET(unknown_806a))
    ORA         B,A
    LDAW        (V_OFFSET(midi_sysex_incoming_header_stage_8064))
    SLR         A
    LXI         EA,midi_sysex_array_8500
    EADD        EA,A
    DMOV        HL,EA
    MOV         A,B
    STAX        (HL)

LAB_3568:
    MVIW        (V_OFFSET(UNKNOWN_midi_sysex_8065)),0
    EQIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0FFh
    JMP         midi_sysex_increment_current_header_stage_3367

    MVI         A,0F7h
    CALL        midi_clear_last_message_and_send_3078
    MVIW        (V_OFFSET(midi_sysex_function_2_8063)),0
    CALL        patch_UNKNOWN_29e0
    LXI         HL,MAYBE_midi_sysex_patch_pointer_8067
    LDEAX       (HL)
    PUSH        EA
    DMOV        DE,EA
    LXI         HL,midi_sysex_array_8500
    MVI         C,7Fh
    BLOCK
    POP         EA
    LXI         HL,patch_buffer_edit_8300
    DEQ         EA,HL
    JMP         LAB_35d3

    LDAX        (HL)
    PUSH        V
    CALL        channel_get_selected_solo_channel_pflags_pointer_4d6f
    POP         V
    STAX        (BC)
    CALL        FUN_50e3
    CALL        voice_update_vibrato_4db0
    CALL        led_4_set_line_select_leds_from_pflags_4d4a
    CALL        led_4_set_ring_noise_leds_based_on_waveform_4d26
    EQIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    CALL        ui_print_patch_or_tone_mix_5537
    CALL        led_3_all_off_4d09
    JMP         midi_sysex_end_336a

LAB_35b1:
    STAW        (V_OFFSET(unknown_806a))
    JRE         LAB_3568

LAB_35b5:
    MVIW        (V_OFFSET(UNKNOWN_midi_sysex_8065)),1
    RET

LAB_35b9:
    POP         V
    EQI         A,32h
    JMP         midi_sysex_end_336a

    MVIW        (V_OFFSET(UNKNOWN_midi_sysex_8065)),0

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
; All SysEx transmissions specify the channel by 0x70 + Channel.
; Mask these bits when testing the value.
    ORI         A,070h
    CALL        midi_clear_last_message_and_send_3078
    MVI         A,30h
    CALL        midi_clear_last_message_and_send_3078
    RET

LAB_35d3:
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX
    JMP         LAB_360a
    LDAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    NEAW        (V_OFFSET(patch_index_8026))
    CALL        patch_load_validate_flags_4e90
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    JMP         midi_sysex_end_336a

    LDAW        (V_OFFSET(patch_index_channel_0_8029))
    NEAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    CALL        midi_sysex_UNKNOWN_voice_0_5162

    LDAW        (V_OFFSET(patch_index_channel_1_802a))
    NEAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    CALL        midi_sysex_UNKNOWN_voice_1_5165

    LDAW        (V_OFFSET(patch_index_channel_2_802b))
    NEAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    CALL        midi_sysex_UNKNOWN_voice_2_5168

    LDAW        (V_OFFSET(patch_index_channel_3_802c))
    NEAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    CALL        midi_sysex_UNKNOWN_voice_3_516b

    JMP         midi_sysex_end_336a
LAB_360a:
    LDAW        (V_OFFSET(sysex_patch_index_UNKNOWN_8069))
    EQAW        (V_OFFSET(patch_index_8026))
    NEAW        (V_OFFSET(patch_index_tone_mix_8007))
    CALL        patch_tone_mix_UNKNOWN_5276
    JMP         midi_sysex_end_336a

; =============================================================================
; Handle receiving incoming data when the synth is in SysEx query mode.
; =============================================================================
midi_sysex_process_incoming_data_mode_query_3618:
    PUSH        V
    NEIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),0
    JMP         midi_sysex_test_channel_3375

; The synth expects the byte 0x31.
    POP         V
    NEI         A,031h
    EQIW        (V_OFFSET(midi_sysex_incoming_header_stage_8064)),1
    JMP         midi_sysex_end_336a

; Send currently selected patch index.
    LDAW        (V_OFFSET(patch_index_8026))
    ANI         A,01111111b
    OFFI        A,PATCH_FLAGS_10
    ANI         A,00001111b
    CALL        midi_clear_last_message_and_send_3078

    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)
    ANI         A,30h
    CALL        midi_clear_last_message_and_send_3078
    JMP         midi_sysex_end_336a

; =============================================================================
; E: Note#
; =============================================================================
midi_send_key_event_363f:
    ORI         MKL,MKL_MKE1
    CALL        midi_construct_message_byte_note_on_3675

; Is this the same as the last sent MIDI status byte?
    NEAW        (V_OFFSET(midi_previous_message_type_805c))
    JRE         _same_as_last_message_byte_3663

    STAW        (V_OFFSET(midi_previous_message_type_805c))
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

_send_data_364f:
    MOV         A,E
    ANI         A,01111111b
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

; Test whether the key event was key on/off, and set the velocity value
; accordingly. With a note off event being sent as a note on event with
; velocity 0.
    ONI         E,KEYBOARD_NOTE_ON
    MVI         A,0
    MVI         A,40h
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

    ANI         MKL,~MKL_MKE1
    RET

_same_as_last_message_byte_3663:
    PUSH        V
    PUSH        HL
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d

    LDAX        (HL+CHANNEL_INFO_NOTE_COUNT)
    MOV         B,A
    POP         HL
    POP         V
    GTI         B,0
    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    JRE         _send_data_364f

; =============================================================================
midi_construct_message_byte_note_on_3675:
    MVI         A,090h

; =============================================================================
midi_construct_message_byte_cc_3677:
    MVI         A,0B0h

; =============================================================================
midi_construct_message_byte_prog_change_3679:
    MVI         A,0C0h

; =============================================================================
midi_construct_message_byte_pitch_bend_367b:
    MVI         A,0E0h

    CALL        midi_get_midi_channel_3683
    ORA         A,B
    RET

; =============================================================================
; Gets the MIDI channel.
; If in solo mode, this will get the MIDI channel of the current active voice.
;
; Returns in B.
; =============================================================================
midi_get_midi_channel_3683:
    PUSH        V

; Load the currently selected mono MIDI voice.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    ANI         A,00000011b
    MOV         B,A

; If the MIDI channel has been overriden in hardware, use this channel
; setting instead of the basic MIDI channel.
    LDAW        (V_OFFSET(midi_basic_channel_override_8032))
    BIT         0,(V_OFFSET(midi_basic_channel_overridden_8033))
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    ANI         A,00001111b

; Add the currently selected mono MIDI voice to the base channel,
; clamp the final channel value at 0-15.
    ADD         B,A
    LTI         B,16                                ; Skip if B < 16.
    MVI         B,15
    POP         V
    RET

; =============================================================================
; A: Patch index?
; =============================================================================
midi_send_prog_change_369a:
; Test if MIDI program changes are disabled.
    BIT         0,(V_OFFSET(midi_prog_change_disabled_8036))    ; Skip if bit is high.
    OFFI        A,80h                                           ; Skip if (A & byte == 0)
    RET

; Mask INTE1.
    ORI         MKL,MKL_MKE1
    PUSH        V

; Construct the MIDI program change message byte, and test if it is identical
; to the last sent byte.
    CALL        midi_construct_message_byte_prog_change_3679
    NEAW        (V_OFFSET(midi_previous_message_type_805c))      ; Skip if (A≠(V.wa)).
    JR          _send_prog_change_data_byte_36af

    STAW        (V_OFFSET(midi_previous_message_type_805c))
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

_send_prog_change_data_byte_36af:
    POP         V
    PUSH        V

; Clamp at 0-15.
    OFFI        A,10h
    ANI         A,00001111b
    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    POP         V

; Release INTE1 mask.
    ANI         MKL,~MKL_MKE1
    RET

; =============================================================================
midi_send_pitch_bend_36bd:
; Return if Sysex receive active?
    OFFIW       (V_OFFSET(midi_sysex_rx_active_805f)),1
    RET

    PUSH        V
    PUSH        BC

    CALL        midi_construct_message_byte_pitch_bend_367b
    NEAW        (V_OFFSET(midi_previous_message_type_805c))
    JR          LAB_36cf

    STAW        (V_OFFSET(midi_previous_message_type_805c))
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

LAB_36cf:
    BIT         0,(V_OFFSET(UNKNOWN_pitch_bend_80f1))
    MVI         A,0
    MVI         A,40h
    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    LDAW        (V_OFFSET(UNKNOWN_pitch_bend_80f1))
    SLR         A
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

    POP         BC
    POP         V
    RET

; =============================================================================
midi_send_cc_portamento_36e2:
    ORI         MKL,MKL_MKE1
    PUSH        BC
    PUSH        V
    CALL        midi_construct_message_byte_cc_3677
    NEAW        (V_OFFSET(midi_previous_message_type_805c))
    JR          _prepare_message_data_36f3

    STAW        (V_OFFSET(midi_previous_message_type_805c))
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

_prepare_message_data_36f3:
    MVI         A,041h
    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    POP         V
    PUSH        V

; Test whether porta is active, and set the message byte accordingly.
    ONI         A,CHANNEL_FLAGS_PORTA
    MVI         A,0
    MVI         A,7Fh

    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    POP         V
    POP         BC
    ANI         MKL,~MKL_MKE1
    RET

; =============================================================================
midi_send_cc_vibrato_3709:
    ORI         MKL,MKL_MKE1
    PUSH        BC
    PUSH        V
    CALL        midi_construct_message_byte_cc_3677
    NEAW        (V_OFFSET(midi_previous_message_type_805c))
    JR          _construct_message_data_371a

    STAW        (V_OFFSET(midi_previous_message_type_805c))
    CALL        midi_add_byte_to_tx_buffer_and_send_307b

_construct_message_data_371a:
    MVI         A,1
    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    POP         V
    PUSH        V

; Set message data based on whether vibrato is active.
    ONI         A,CHANNEL_FLAGS_VIBRATO
    MVI         A,0
    MVI         A,7Fh

    CALL        midi_add_byte_to_tx_buffer_and_send_307b
    POP         V
    POP         BC
    ANI         MKL,~MKL_MKE1
    RET

    DS 205
    JMP         RST0

default_internal_data_3800:
    DB          2h
    DB          00h
    DB          01Ch
    DB          00h
    DB          08h
    DB          03Eh
    DB          07Bh
    DB          00h
    DB          027h
    DB          020h
    DB          06h
    DB          06h
    DB          07h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          092h
    DB          2h
    DB          077h
    DB          07Fh
    DB          0CBh
    DB          0F6h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          07Fh
    DB          067h
    DB          0CAh
    DB          09Dh
    DB          0B4h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          092h
    DB          2h
    DB          077h
    DB          07Fh
    DB          0CBh
    DB          0F6h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          07Fh
    DB          067h
    DB          0CAh
    DB          09Dh
    DB          0B4h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          2h
    DB          00h
    DB          018h
    DB          00h
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          04h
    DB          077h
    DB          04Eh
    DB          05Ch
    DB          07Fh
    DB          0D0h
    DB          0F7h
    DB          0DEh
    DB          057h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03h
    DB          063h
    DB          07Fh
    DB          0C0h
    DB          07Bh
    DB          0B4h
    DB          0C2h
    DB          0A7h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          1h
    DB          07Fh
    DB          021h
    DB          0D7h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          04h
    DB          077h
    DB          04Eh
    DB          05Ch
    DB          07Fh
    DB          0D0h
    DB          0F7h
    DB          0DEh
    DB          057h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03h
    DB          063h
    DB          07Fh
    DB          0C0h
    DB          07Bh
    DB          0B4h
    DB          0C2h
    DB          0A7h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          1h
    DB          07Fh
    DB          021h
    DB          0D7h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          06h
    DB          00h
    DB          0FCh
    DB          02Eh
    DB          08h
    DB          01Bh
    DB          01Bh
    DB          00h
    DB          03Dh
    DB          60h
    DB          0Fh
    DB          014h
    DB          015h
    DB          00h
    DB          020h
    DB          020h
    DB          00h
    DB          00h
    DB          09h
    DB          0FFh
    DB          1h
    DB          072h
    DB          07Fh
    DB          0A4h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          03Eh
    DB          096h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          09h
    DB          0FFh
    DB          1h
    DB          072h
    DB          07Fh
    DB          0A4h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          03Eh
    DB          096h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          2h
    DB          00h
    DB          01Ch
    DB          00h
    DB          2h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          07h
    DB          06Eh
    DB          2h
    DB          05Ah
    DB          60h
    DB          042h
    DB          0FFh
    DB          0C2h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          077h
    DB          07Fh
    DB          0D0h
    DB          0EFh
    DB          0BAh
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          07h
    DB          06Eh
    DB          2h
    DB          05Ah
    DB          60h
    DB          042h
    DB          0FFh
    DB          0C2h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          077h
    DB          07Fh
    DB          0D0h
    DB          0EFh
    DB          0BAh
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          06h
    DB          00h
    DB          04h
    DB          00h
    DB          2h
    DB          010h
    DB          010h
    DB          00h
    DB          03Dh
    DB          60h
    DB          0Fh
    DB          0Ch
    DB          0Dh
    DB          00h
    DB          0B2h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          60h
    DB          0F3h
    DB          0DAh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          07h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          06Fh
    DB          0FFh
    DB          088h
    DB          00h
    DB          2h
    DB          07Fh
    DB          045h
    DB          03Ch
    DB          0C6h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0B2h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          60h
    DB          0F3h
    DB          0DAh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          07h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          070h
    DB          07Fh
    DB          0F0h
    DB          60h
    DB          06Fh
    DB          0FFh
    DB          088h
    DB          00h
    DB          2h
    DB          07Fh
    DB          045h
    DB          03Ch
    DB          0C6h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          03h
    DB          00h
    DB          00h
    DB          028h
    DB          08h
    DB          034h
    DB          053h
    DB          00h
    DB          32h
    DB          0E0h
    DB          09h
    DB          0Eh
    DB          0Fh
    DB          00h
    DB          0A0h
    DB          00h
    DB          04h
    DB          024h
    DB          00h
    DB          00h
    DB          2h
    DB          077h
    DB          07Fh
    DB          0C2h
    DB          075h
    DB          0BEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          00h
    DB          0FFh
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0A0h
    DB          00h
    DB          04h
    DB          024h
    DB          00h
    DB          00h
    DB          1h
    DB          077h
    DB          06Bh
    DB          0BAh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          014h
    DB          0D2h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          04h
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          01Eh
    DB          01Eh
    DB          00h
    DB          02Fh
    DB          60h
    DB          08h
    DB          03h
    DB          04h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          08h
    DB          00h
    DB          00h
    DB          06h
    DB          05Ah
    DB          07Fh
    DB          0DAh
    DB          0F0h
    DB          0BAh
    DB          047h
    DB          03Ah
    DB          05Fh
    DB          0BAh
    DB          034h
    DB          03Ah
    DB          059h
    DB          0AEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          00h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          08h
    DB          00h
    DB          00h
    DB          06h
    DB          05Ah
    DB          07Fh
    DB          0DAh
    DB          0F0h
    DB          0BAh
    DB          047h
    DB          03Ah
    DB          05Fh
    DB          0BAh
    DB          034h
    DB          03Ah
    DB          059h
    DB          0AEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          00h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0Bh
    DB          00h
    DB          30h
    DB          00h
    DB          08h
    DB          036h
    DB          05Bh
    DB          00h
    DB          031h
    DB          60h
    DB          09h
    DB          0Ch
    DB          0Dh
    DB          00h
    DB          16h
    DB          020h
    DB          09h
    DB          05Fh
    DB          09h
    DB          0FFh
    DB          2h
    DB          077h
    DB          07Fh
    DB          0A1h
    DB          00h
    DB          0C3h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          06Ah
    DB          070h
    DB          0BAh
    DB          050h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          03h
    DB          054h
    DB          03Ah
    DB          0DCh
    DB          00h
    DB          037h
    DB          05h
    DB          0D3h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          07h
    DB          06Eh
    DB          2h
    DB          06Ch
    DB          07Fh
    DB          0A7h
    DB          00h
    DB          0E7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          076h
    DB          066h
    DB          0BCh
    DB          04Fh
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          03h
    DB          00h
    DB          018h
    DB          0Ch
    DB          04h
    DB          02Bh
    DB          037h
    DB          00h
    DB          03Ch
    DB          0E0h
    DB          0Eh
    DB          00h
    DB          1h
    DB          00h
    DB          05Ah
    DB          80h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          03h
    DB          077h
    DB          076h
    DB          0A7h
    DB          02Ch
    DB          0C4h
    DB          80h
    DB          0F7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          0C0h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          2h
    DB          07Fh
    DB          046h
    DB          0FFh
    DB          80h
    DB          0FFh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          05Ah
    DB          80h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          04h
    DB          05Bh
    DB          01Dh
    DB          070h
    DB          07Fh
    DB          0C5h
    DB          076h
    DB          0B4h
    DB          80h
    DB          0F7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          0C0h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          1h
    DB          07Fh
    DB          80h
    DB          0FFh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0Bh
    DB          00h
    DB          00h
    DB          024h
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          092h
    DB          1h
    DB          063h
    DB          0FFh
    DB          0C6h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          0D5h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          04h
    DB          046h
    DB          1h
    DB          064h
    DB          0D4h
    DB          0C6h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          0D5h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          0B9h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          03h
    DB          00h
    DB          0BCh
    DB          019h
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          017h
    DB          00h
    DB          03h
    DB          2h
    DB          03h
    DB          00h
    DB          020h
    DB          020h
    DB          2h
    DB          011h
    DB          1h
    DB          01Fh
    DB          1h
    DB          072h
    DB          07Fh
    DB          0A4h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          0Fh
    DB          096h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          020h
    DB          00h
    DB          2h
    DB          011h
    DB          1h
    DB          01Fh
    DB          1h
    DB          072h
    DB          07Fh
    DB          09Bh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Dh
    DB          053h
    DB          0B5h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          06h
    DB          00h
    DB          01Ch
    DB          00h
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h
    DB          08Ah
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          2h
    DB          077h
    DB          073h
    DB          0CAh
    DB          0E7h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          07Fh
    DB          067h
    DB          059h
    DB          0FFh
    DB          0B4h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          03h
    DB          00h
    DB          00h
    DB          03Ch
    DB          02Ch
    DB          0D7h
    DB          80h
    DB          0CCh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          08Ah
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          2h
    DB          077h
    DB          073h
    DB          0CAh
    DB          0E7h
    DB          0A7h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          2h
    DB          07Fh
    DB          067h
    DB          059h
    DB          0FFh
    DB          0B4h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          03h
    DB          00h
    DB          00h
    DB          03Ch
    DB          02Ch
    DB          0D7h
    DB          80h
    DB          0CCh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          06h
    DB          00h
    DB          028h
    DB          00h
    DB          08h
    DB          07h
    DB          07h
    DB          00h
    DB          035h
    DB          60h
    DB          0Bh
    DB          012h
    DB          013h
    DB          00h
    DB          012h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          06Fh
    DB          0F3h
    DB          0AEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03h
    DB          07Fh
    DB          07Fh
    DB          0EBh
    DB          07Bh
    DB          0B4h
    DB          0EAh
    DB          0B9h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          012h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          06Fh
    DB          0F3h
    DB          0AEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03h
    DB          07Fh
    DB          07Fh
    DB          0EBh
    DB          07Bh
    DB          0B4h
    DB          0EAh
    DB          0B9h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          07h
    DB          00h
    DB          07Ch
    DB          08h
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          1h
    DB          00h
    DB          020h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          077h
    DB          07Fh
    DB          0C4h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          063h
    DB          035h
    DB          0F2h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          0FFh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          1h
    DB          077h
    DB          07Fh
    DB          0C4h
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          063h
    DB          035h
    DB          0F2h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          00h
    DB          0FFh
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          047h
    DB          0BFh
    DB          00h
    DB          028h
    DB          60h
    DB          06h
    DB          027h
    DB          031h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          09h
    DB          0FFh
    DB          07h
    DB          064h
    DB          0FFh
    DB          0ADh
    DB          03Eh
    DB          054h
    DB          68h
    DB          0B4h
    DB          042h
    DB          057h
    DB          06Fh
    DB          0B8h
    DB          042h
    DB          057h
    DB          073h
    DB          0A2h
    DB          00h
    DB          2h
    DB          020h
    DB          03Bh
    DB          0A9h
    DB          00h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          04h
    DB          052h
    DB          044h
    DB          052h
    DB          045h
    DB          052h
    DB          046h
    DB          052h
    DB          0C6h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          09h
    DB          0FFh
    DB          07h
    DB          064h
    DB          0FFh
    DB          0ADh
    DB          03Eh
    DB          054h
    DB          68h
    DB          0B4h
    DB          042h
    DB          057h
    DB          06Fh
    DB          0B8h
    DB          042h
    DB          057h
    DB          073h
    DB          0A2h
    DB          00h
    DB          2h
    DB          020h
    DB          03Bh
    DB          0A9h
    DB          00h
    DB          088h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          04h
    DB          052h
    DB          044h
    DB          052h
    DB          045h
    DB          052h
    DB          046h
    DB          052h
    DB          0C6h
    DB          80h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          2h
    DB          00h
    DB          020h
    DB          01Bh
    DB          08h
    DB          00h
    DB          00h
    DB          00h
    DB          026h
    DB          0E0h
    DB          05h
    DB          0Fh
    DB          010h
    DB          00h
    DB          0A0h
    DB          020h
    DB          2h
    DB          011h
    DB          00h
    DB          00h
    DB          1h
    DB          077h
    DB          07Fh
    DB          0BEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          06Ah
    DB          0C5h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          1h
    DB          07Fh
    DB          03Eh
    DB          0E1h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          0A0h
    DB          00h
    DB          2h
    DB          011h
    DB          00h
    DB          00h
    DB          1h
    DB          077h
    DB          07Fh
    DB          0BEh
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          03Ch
    DB          00h
    DB          1h
    DB          07Fh
    DB          06Ah
    DB          0C5h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          044h
    DB          00h
    DB          1h
    DB          07Fh
    DB          03Eh
    DB          0E1h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h
    DB          40h
    DB          00h

; =============================================================================
reset_4000:
    JMP         reset_4333

; =============================================================================
power_down_4003:
    JMP         power_down_4521

; =============================================================================
INTT0_INTT1_4006:
    JMP         INTT0_INTT1_4080

; =============================================================================
INT1_INT2_4009:
    JMP         INT1_INT2_4093

; =============================================================================
INTE0_INTE1_400c:
    JMP         INTE0_INTE1_40a9

; =============================================================================
INTEIN_INTAD_400f:
    JMP         INTEIN_INTAD_40bf

; =============================================================================
midi_handle_irq_4012:
    JMP         midi_handle_irq_40d2

; =============================================================================
irq_return_4015:
    JMP         irq_return_413e

; =============================================================================
; This space is where the functions referenced in the call table would be
; defined, however the area is just filled with zeroes.
; =============================================================================
    DS 104

    ORG 4080h
; =============================================================================
INTT0_INTT1_4080:
; Test whether INTT0 masked?
    OFFI        MKL,MKL_MKT0                        ; Skip if MKL & 0b10 == 0.
    JRE         input_decrement_button_repeat_timer_UNKNOWN_411e

; Test timer 0 interrupted?
    SKNIT       FT0                                 ; Skip if FT0 == 0. Reset if 1.
    JRE         timer_0_irq_40e0

; Test whether INT1 masked?
    OFFI        MKL,MKL_MKT1                        ; Skip if MKL & 0b100 == 0.
    JRE         timer_0_irq_40e0

    SKNIT       FT1                                 ; Skip if FT1 == 0. Reset if 1.
    NOP
    JRE         input_decrement_button_repeat_timer_UNKNOWN_411e

; =============================================================================
INT1_INT2_4093:
    OFFI        MKL,08h
    JRE         irq_reenable_and_return_4138

    SKNIT       F1
    JMP         called_during_irq_6dab
    OFFI        MKL,010h
    JMP         called_during_irq_6dab
    SKNIT       F2
    JRE         irq_reenable_and_return_4138

    JRE         irq_reenable_and_return_40de

; =============================================================================
INTE0_INTE1_40a9:
; Skip if INTE0 not masked.
    OFFI        MKL,MKL_MKE0
    JMP         called_during_irq_updates_upd933_pitch_7a3c

    SKNIT       FE0
    JRE         irq_reenable_and_return_413a

    OFFI        MKL,MKL_MKE1
    JRE         irq_reenable_and_return_413a

; Test if INTFE1 triggered, reset flag if so.
    SKNIT       FE1
    JMP         called_during_irq_updates_upd933_pitch_7a3c

    JRE         irq_reenable_and_return_40de

; =============================================================================
INTEIN_INTAD_40bf:
; Skip if MKEIN is unmasked.
    OFFI        MKL,MKL_MKEIN
    JRE         intein_intad_occurred_4140

; Skip if FEIN is 0 (INTEIN didn't occur).
; Clear FEIN.
    SKNIT       FEIN
    JRE         irq_reenable_and_return_413c

; Skip if INTAD is unmasked.
    OFFI        MKH,MKH_MKAD
    JRE         irq_reenable_and_return_413c

; Skip if FAD is 0 (INTAD didn't occur).
    SKNIT       FAD
    JRE         intein_intad_occurred_4140

    JR          irq_reenable_and_return_40de

; =============================================================================
midi_handle_irq_40d2:
; Check whether FSR is set, indicating there is pending incoming data.
    SKNIT       FSR                                 ; Skips if irf is 0.
    CALL        midi_store_incoming_2fdf

; Check whether FST is set, indicating the serial transmit buffer is empty.
    SKNIT       FST
    CALL        midi_send_next_pending_byte_3027

    EI
    RETI

; =============================================================================
irq_reenable_and_return_40de:
    EI
irq_return_40df:
    RETI

; =============================================================================
; Timer 0 IRQ Handler.
; @TODO.
; =============================================================================
timer_0_irq_40e0:
    SKIT        FT0
    NOP
    PUSH        V
    MOV         A,MKL
    MVI         MKL,0FFh
    EI

; Decrement the counter.
; Skips when a value of zero is decremented (borrow generated).
    DCRW        (V_OFFSET(lcd_counter_update_8046))
    JR          _counter_not_finished_40f3

; Counter passed zero.
; Reset counter and set update flag.
    MVIW        (V_OFFSET(lcd_counter_update_8046)),35h
    ORIW        (V_OFFSET(lcd_flags_8049)),(1 << LCD_FLAGS_UPDATE_BIT)

_counter_not_finished_40f3:
    DCRW        (V_OFFSET(lcd_counter_blink_timeout_1_8047))
    JR          _process_power_button_counter_4102

    DCRW        (V_OFFSET(lcd_counter_blink_timeout_2_8048))
    JR          _process_power_button_counter_4102

; Both counters have passed zero.
; Reset counters, and set blink flag.
    MVIW        (V_OFFSET(lcd_counter_blink_timeout_1_8047)),64
    MVIW        (V_OFFSET(lcd_counter_blink_timeout_2_8048)),4
    ORIW        (V_OFFSET(lcd_flags_8049)),(1 << LCD_FLAGS_CURSOR_OFF_BIT)

_process_power_button_counter_4102:
    DCRW        (V_OFFSET(power_button_blink_counter_8050))
    JR          _process_sysex_timeout_counters_410b

; Counter passed zero.
    MVIW        (V_OFFSET(power_button_blink_counter_8050)),20h
    ORIW        (V_OFFSET(power_button_blink_flag_8051)),1

_process_sysex_timeout_counters_410b:
    DCRW        (V_OFFSET(midi_sysex_rx_timeout_counter_2_8060))
    JR          _exit_411a

; Counter passed zero.
    DCRW        (V_OFFSET(midi_sysex_rx_timeout_counter_1_8061))
    JR          _exit_411a

; Counter passed zero.
; Set timeout flag, reset counters.
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_flag_8062)),1
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_2_8060)),0
    MVIW        (V_OFFSET(midi_sysex_rx_timeout_counter_1_8061)),010h

_exit_411a:
    MOV         MKL,A
    POP         V
    RETI

; =============================================================================
input_decrement_button_repeat_timer_UNKNOWN_411e:
; Clear FT1.
    SKIT        FT1
    NOP
    PUSH        V

; Save IRQ status.
    MOV         A,MKL
    PUSH        V

; Mask all interrupts.
    MVI         MKL,0FFh
    EI
    DCRW        (V_OFFSET(input_button_repeat_timer_current_8044))
    JR          _exit_4133

; This seems like it's a timer mechanism to detect at what point
; a UI press should be repeated continuously.
; This seems to reset the timer when it's run out?
    LDAW        (V_OFFSET(input_button_repeat_timer_max_8045))
    STAW        (V_OFFSET(input_button_repeat_timer_current_8044))
; Set the 'Button Held' flag.
    ORIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_BUTTON_HELD

_exit_4133:
    POP         V
    MOV         MKL,A
    POP         V
    RETI

; =============================================================================
irq_reenable_and_return_4138:
    JRE         irq_reenable_and_return_40de

; =============================================================================
irq_reenable_and_return_413a:
    JRE         irq_reenable_and_return_40de

; =============================================================================
irq_reenable_and_return_413c:
    JRE         irq_reenable_and_return_40de

; =============================================================================
irq_return_413e:
    JRE         irq_return_40df

; =============================================================================
intein_intad_occurred_4140:
    MVIW        (V_OFFSET(intein_intad_pending_flag_80ea)),0
    RETI

; =============================================================================
; Arguments:
; C:  Number of bytes to clear.
; DE: Pointer to the memory block to clear.
; =============================================================================
clear_memory_block_4144:
    MOV         A,C

; Set up the counter for the BLOCK transfer instruction.
; Perform a modulo operation, in case the total number of bytes is below 64.
    ANI         C,63
_clear_memory_block_loop_4148:
    LXI         HL,block_of_64_zeroes_4152
    BLOCK

; Skip if no borrow, i.e. A > 64.
    SUINB       A,40h
    RET

    MVI         C,63
    JR          _clear_memory_block_loop_4148

block_of_64_zeroes_4152:
    DS 64

MAYBE_voice_info_init_data_4192:
    DB          0FFh
    DB          00h
    DB          0FFh
    DB          00h
    DB          0FFh
    DB          00h
    DB          0FFh
    DB          00h

; =============================================================================
clear_voice_note_numbers_419a:
    MVI         C,15
    LXI         DE,voice_note_numbers_8190
    JRE         clear_buffer_41c1

; =============================================================================
keyboard_clear_state_UNKNOWN_41a1:
    MVI         C,53
    LXI         DE,keyboard_key_states_UNKNOWN_8130
    CALL        clear_memory_block_4144
    RET

; =============================================================================
UNKNOWN_clear_42_bytes_at_8166_41aa:
    MVI         C,41
    LXI         DE,input_group_kc10_8166
    CALL        clear_memory_block_4144
    RET

; =============================================================================
; Arguments:
; HL: Pointer to channel info.
; =============================================================================
MAYBE_voice_clears_data_in_voice_info_41b3:
    PUSH        HL
; Set (HL+3) up as destination for copy.
    MVI         A,3
    DMOV        EA,HL
    EADD        EA,A
    DMOV        DE,EA
    CALL        copies_8_bytes_0FF00_41d1h

    POP         HL
    RET

; Unreachable?
    MVI         C,2h

; =============================================================================
; Arguments:
; C:  Number of bytes to clear.
; DE: Pointer to the memory block to clear.
; =============================================================================
clear_buffer_41c1:
    LXI         HL,block_of_64_zeroes_4152
    BLOCK
    RET

; =============================================================================
FUN_41c6:
    LDAX        (HL+1)
    MOV         E,A
    MVI         D,81h
    MVI         A,0
    STAX        (DE)
    STAX        (DE+8)
    RET

; =============================================================================
copies_8_bytes_0FF00_41d1h:
    MVI         C,7
    LXI         HL,MAYBE_voice_info_init_data_4192
    BLOCK
    RET

; =============================================================================
UNKNOWN_patch_load_41d8:
    PUSH        HL
    CALL        UNKNOWN_copies_1_byte_to_next_in_loop_4225
    CALL        keyboard_handle_active_keys_472e
    CALL        clear_voice_note_numbers_419a
    CALL        FUN_7354
    PUSH        BC

    LXI         BC,300h
    CALL        delay_441e

    POP         BC
    CALL        patch_call_function_per_channel_7793
    CALL        keyboard_clear_state_UNKNOWN_41a1
    POP         HL
    RET

; =============================================================================
UNKNOWN_solo_mode_patch_load_41f5:
    PUSH        HL
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    DMOV        EA,HL
    POP         HL
    PUSH        HL
    DEQ         EA,HL
    JR          LAB_4208

    CALL        UNKNOWN_copies_1_byte_to_next_in_loop_4225
    CALL        keyboard_handle_active_keys_472e
    CALL        keyboard_clear_state_UNKNOWN_41a1

LAB_4208:
    POP         HL
    PUSH        HL
    CALL        FUN_41c6
    LDAX        (HL+1)
    MOV         D,A
    CALL        FUN_734d

; Delay.
    PUSH        BC
    LXI         BC,300h
    CALL        delay_441e
    POP         BC

    POP         HL
    PUSH        HL
    CALL        channel_get_index_from_pointer_to_info_50c7
    CALL        patch_called_per_channel_7776
    POP         HL
    RET

; =============================================================================
UNKNOWN_copies_1_byte_to_next_in_loop_4225:
    LXI         HL,switch_states_8134
    MVI         C,7

LAB_422a:
; Copies *(HL) to *(HL+1)
    LDAX        (HL+)
    STAX        (HL-)
; Clear *(HL)
    MVI         A,0
    STAX        (HL+)
; HL = HL + 5
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    DCR         C
    JR          LAB_422a

    LDAX        (HL)
    PUSH        V
    ANI         A,11111110b
    STAX        (HL+)
    POP         V
    ANI         A,1
    ORAX        (HL)
    STAX        (HL)
    MVIW        (V_OFFSET(keyboard_UNKNOWN_8010)),0
    MVIW        (V_OFFSET(keyboard_UNKNOWN_8011)),08h
    RET

_cartridge_insert_check_inserted_4248:
    MVIW        (V_OFFSET(cartridge_disconnected_8022)),0
    RET

; =============================================================================
cartridge_insert_check_424c:
; Skips if cartridge not inserted.
    CALL        button_check_pack_detect_5018
    JRE         _cartridge_insert_check_inserted_4248

; Cartridge not inserted.
    LDAW        (V_OFFSET(cartridge_disconnected_8022))
    MVIW        (V_OFFSET(cartridge_disconnected_8022)),1

; Test whether the value has not changed.
    EQI         A,0                                 ; Skip if A=byte.
    RET

; The cartridge has been disconnected.
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX       ; Skip if 08031h & 08h == 0.
    JRE         _cart_disconnected_tone_mix_active_426e

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE      ; Skip if 08031h & 04h == 0.
    JRE         _cart_disconnected_solo_mode_active_427c

; Test whether the patch needs to be reloaded.
; If the patch is in the cartridge, reload.
    LDAW        (V_OFFSET(patch_index_8026))
    OFFI        A,PATCH_FLAGS_MODIFIED          ; Skip if A & 80h == 0.
    RET

    OFFI        A,PATCH_FLAGS_CARTRIDGE       ; Skip if A & 40h == 0.
    CALL        patch_load_validate_flags_4e90

    RET

_cart_disconnected_tone_mix_active_426e:
; Test whether the tone mix patch needs to be reloaded.
    LDAW        (V_OFFSET(patch_index_8026))
    OFFI        A,PATCH_FLAGS_MODIFIED
    JR          _is_tone_mix_patch_from_cart_4275

; Patch not modified.
; Skip if current patch loaded from cartridge.
    ONI         A,PATCH_FLAGS_CARTRIDGE

_is_tone_mix_patch_from_cart_4275:
    OFFIW       (V_OFFSET(patch_index_tone_mix_8007)),PATCH_FLAGS_CARTRIDGE
    CALL        patch_tone_mix_UNKNOWN_5276
    RET

_cart_disconnected_solo_mode_active_427c:
    MVI         A,3

_solo_mode_active_patch_test_loop_427e:
    PUSH        V
    CALL        channel_get_info_table_ptr_47bb
    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    LDAX        (BC)

    OFFI        A,PATCH_FLAGS_MODIFIED
    JRE         _check_next_voice_4295

    ONI         A,PATCH_FLAGS_CARTRIDGE
    JRE         _check_next_voice_4295

; Select a preset patch?
    ANI         A,00001111b
    ORI         A,PATCH_FLAGS_10
    CALL        midi_prog_change_solo_voice_520d

_check_next_voice_4295:
    POP         V
    DCR         A
    JRE         _solo_mode_active_patch_test_loop_427e

    RET

; =============================================================================
; A: Patch index with flags?
; Skips on return if successful?
; =============================================================================
patch_test_save_memory_selected_429a:
; Test if patch bit 7 set...
    OFFI        A,PATCH_FLAGS_MODIFIED                    ; Skip if A & 80h == 0.
    RETS

; Test if bit 6 is set...
; Does this indicate saving to cartridge?
    ONI         A,PATCH_FLAGS_CARTRIDGE                    ; Skip if A & 40h == 1.
    RETS

; Test if cart inserted. Skip if cartridge is NOT inserted.
; Return skip if cartridge is inserted.
    BIT         0,(V_OFFSET(cartridge_disconnected_8022))
    RETS

    RET

; =============================================================================
patch_load_validate_flags_UNKNOWN_42a4:
    CALL        patch_test_save_memory_selected_429a
    JR          LAB_42a9

    RET

LAB_42a9:
    ANI         A,00001111b
    ORI         A,PATCH_FLAGS_10
    RET

; =============================================================================
; Unused?
; =============================================================================
UNUSED_42ae:
    CALL        UNUSED_42d4
    DMOV        BC,EA

LAB_42b2:
    SBCD        (81a0h)
    CALL        UNUSED_lcd_4305
    CALL        lcd_update_blink_off_cursor_off_42de
    RET

    LBCD        (81a0h)
    ADI         C,08h
    ACI         B,0
    JR          LAB_42b2

    LBCD        (81a0h)
    SUI         C,08h
    SBI         B,0
    JRE         LAB_42b2

; =============================================================================
UNUSED_42d4:
    MOV         C,(8188h)
    MOV         B,(818eh)
    DMOV        EA,BC
    RET

; =============================================================================
lcd_update_blink_off_cursor_off_42de:
    CALL        lcd_update_5326
    CALL        lcd_write_instruction_blink_off_cursor_off_53c2
    RET

; =============================================================================
; Returns:
; EA: Hexadecimal ASCII representation of the byte in A.
; =============================================================================
UNUSED_lcd_convert_byte_to_hex_ascii_42e5:
    MOV         B,A
    CALL        UNUSED_lcd_convert_digit_to_hex_ascii_42f8
    MOV         EAH,A
    SLR         B
    SLR         B
    SLR         B
    SLR         B
    MOV         A,B
    CALL        UNUSED_lcd_convert_digit_to_hex_ascii_42f8
    MOV         EAL,A
    RET

; =============================================================================
; Converts the digit to a hex ASCII character.
; A: Digit to convert.
; Returns:
; A: Digit as a hexadecimal ASCII character.
; =============================================================================
UNUSED_lcd_convert_digit_to_hex_ascii_42f8:
    ANI         A,00001111b
    LTI         A,10
    JR          _digit_above_9_4300

; If the digit is between 0-9, add '30' to conver to ASCII.
    ORI         A,30h
    RET

_digit_above_9_4300:
; If the digit is above 9, subtract 9, and add '40' to conver to ASCII.
    SUI         A,9
    ORI         A,40h
    RET

; =============================================================================
; This appears to be some kind of unused debug function.
; =============================================================================
UNUSED_lcd_4305:
    LDED        (UNUSED_data_81a0)
    LXI         HL,lcd_contents_line_1_81b4
    MOV         A,D
    CALL        UNUSED_lcd_convert_byte_to_hex_ascii_42e5
    STEAX       (HL++)
    MOV         A,E
    CALL        UNUSED_lcd_convert_byte_to_hex_ascii_42e5
    STEAX       (HL++)
    CALL        UNUSED_lcd_4325
; The 0xA0 value used here appears to just be a blank character in the
; HD44780 character set.
    MVI         A,0A0h
    STAX        (HL+)
    STAX        (HL+)
    STAX        (HL+)
    STAX        (HL+)
    CALL        UNUSED_lcd_4325
    RET

; =============================================================================
; Appears to be some kind of unused debug function.
; =============================================================================
UNUSED_lcd_4325:
    MVI         C,3
_convert_character_loop_4327:
    MVI         A,0A0h
    STAX        (HL+)
    LDAX        (DE+)
    CALL        UNUSED_lcd_convert_byte_to_hex_ascii_42e5
    STEAX       (HL++)
    DCR         C
    JR          _convert_character_loop_4327

    RET

; =============================================================================
reset_4333:
; On-chip RAM used as stack.
    LXI         SP,0

; Set V and alternate V registers to 80h.
; The working vector window is 0x8000 to 0x80FF.
    MVI         V,80h
    EXA
    MVI         V,80h
    EXA

    CALL        reset_setup_port_modes_4358
    CALL        UNKNOWN_clears_blocks_of_memory_43a1
    CALL        clears_memory_43d8
    CALL        led_reset_4388
    CALL        lcd_init_43f0
    CALL        MAYBE_reset_timers_flags_upd933_4428
    CALL        lcd_load_cgram_data_53a1
    CALL        MAYBE_reset_all_voices_and_load_patch_4474

main_loop_4354:
    CALL        main_44a7
    JR          main_loop_4354

; =============================================================================
reset_setup_port_modes_4358:
; Mask all interrupts?
    MVI         A,0FFh
    MOV         MKL,A
    MOV         MKH,A
    MOV         MA,A

; Set Port B mode.
    MVI         PB,11110000b
    MVI         A,10010000b
    MOV         MB,A

; Set Port C mode.
    MVI         PC,11111000b
    MVI         A,00000111b
    MOV         MCC,A
    MVI         A,0
    MOV         MC,A

; Set A/D channel mode.
; Refer to page 142 of uPD78c18 User manual.
; - Scan mode.
; - AN0-AN3.
; - 192 states.
    MVI         ANM,0

; Setup serial port.
; Refer to page 109 of uPD78c18 User manual.
; Set serial mode to use external clock.
; TxE and RxE are enabled.
    MVI         SMH,1111b
; Clock rate = x64.
; Char length = 8 bits.
; Stop bits = 1.
    MVI         A,01001111b
    MOV         SML,A

; TIMER0 = Internal clock.
; TIMER1 = Internal clock.
    MVI         TMM,00100100b

    MVI         A,0FFh
    MOV         TM0,A
    MVI         A,0FFh
    MOV         TM1,A
    RET

; =============================================================================
led_reset_4388:
    MVIW        (V_OFFSET(led_4_state_8017)),0FEh
    CALL        led_4_update_4ce6
    MVIW        (V_OFFSET(led_3_state_8018)),0Fh
    CALL        led_3_update_4d0d
    MVIW        (V_OFFSET(led_2_state_8019)),0F0h
    CALL        led_2_update_4c85
    MVIW        (V_OFFSET(led_1_state_801a)),0FFh
    CALL        led_1_update_4c74
    RET

; =============================================================================
UNKNOWN_clears_blocks_of_memory_43a1:
    CALL        keyboard_clear_state_UNKNOWN_41a1
    CALL        UNKNOWN_clear_42_bytes_at_8166_41aa
    LXI         DE,voice_note_numbers_8190
    MVI         C,0Fh
    CALL        clear_memory_block_4144
    LXI         DE,midi_outgoing_8200
    MVI         C,0FFh
    CALL        clear_memory_block_4144
    LXI         DE,midi_data_incoming_8400
    MVI         C,0FFh
    CALL        clear_memory_block_4144
    LXI         DE,midi_sysex_array_8500
    MVI         C,0FFh
    CALL        clear_memory_block_4144

; Clear these two blocks of 0x100 bytes.
    LXI         DE,8600h
    MVI         C,0FFh
    CALL        clear_memory_block_4144

    LXI         DE,8700h
    MVI         C,0FFh
    CALL        clear_memory_block_4144
    RET

; =============================================================================
clears_memory_43d8:
    LXI         DE,keyboard_UNKNOWN_8010
    MVI         C,0EFh
    CALL        clear_memory_block_4144
    MVI         A,010h
    STAW        (V_OFFSET(patch_index_8026))
    STAW        (V_OFFSET(patch_index_channel_0_8029))
    STAW        (V_OFFSET(patch_index_channel_1_802a))
    STAW        (V_OFFSET(patch_index_channel_2_802b))
    STAW        (V_OFFSET(patch_index_channel_3_802c))
    MVIW        (V_OFFSET(midi_channel_basic_8000)),0
    RET

; =============================================================================
lcd_init_43f0:
    LXI         BC,0a00h
    CALL        delay_441e

    CALL        lcd_write_instruction_data_length_lines_53ba
    LXI         BC,0400h
    CALL        delay_441e

    CALL        lcd_write_instruction_data_length_lines_53ba
    LXI         BC,10h
    CALL        delay_441e

    CALL        lcd_write_instruction_data_length_lines_53ba
    LXI         BC,10h
    CALL        delay_441e

    CALL        lcd_write_instruction_data_length_lines_53ba
    CALL        lcd_write_instruction_display_off_53ca
    CALL        lcd_write_instruction_clear_53b2
    CALL        lcd_write_instruction_entry_mode_set_53b6
    RET

; =============================================================================
; Is this a delay function?
; It seems to subtract 1 from C, then subtract the value of the carry bit from B.
; This looks like it's just a delay based on BC.
;
; BC = B * C 'periods'?
; =============================================================================
delay_441e:
    SUI         C,1     ; Subtract 1.
    SBI         B,0     ; Subtract carry value (0 or 1).
    SK          CY      ; skip if carry set.
    JR          delay_441e

    RET

; =============================================================================
; Called on device reset.
; =============================================================================
MAYBE_reset_timers_flags_upd933_4428:
; Copy first preset into the patch edit buffer.
    LXI         DE,patch_buffer_edit_8300
    LXI         HL,patch_rom_preset_6000
    MVI         C,127
    BLOCK

    CALL        MAYBE_upd933_reset_6c00

; Clamp at 11.
    LTIW        (V_OFFSET(MAYBE_key_transpose_8002)),0Ch
    MVIW        (V_OFFSET(MAYBE_key_transpose_8002)),0bh
    CALL        master_tune_update_28fe

    CALL        portamento_time_calculate_final_value_7a16
    CALL        pitch_bend_range_modified_79d0
    MVI         A,0
    MOV         ETMM,A

    LXI         EA,0d55h
    DMOV        ETM1,EA

    MVI         A,0Ch
    MOV         ETMM,A

    MVIW        (V_OFFSET(power_button_blink_counter_8050)),40h
    MVIW        (V_OFFSET(power_button_blink_flag_8051)),0

; Reset LCD flags?
    MVIW        (V_OFFSET(lcd_flags_8049)),0
    MVIW        (V_OFFSET(lcd_counter_update_8046)),035h
    MVIW        (V_OFFSET(lcd_counter_blink_timeout_1_8047)),40h
    MVIW        (V_OFFSET(lcd_counter_blink_timeout_2_8048)),04h

    ANI         MKL,0b5h
    MVI         A,0
    MOV         TXB,A
    MVIW        (V_OFFSET(midi_tx_data_pending_8040)),1
    SKIT        FST
    NOP
    ANI         MKH,0f9h
    EI
    RET

; =============================================================================
MAYBE_reset_all_voices_and_load_patch_4474:
    CALL        MAYBE_initialise_all_voices_4480
    LXI         HL,channel_info_0_8100
    LDAW        (V_OFFSET(patch_index_8026))
    CALL        patch_load_4e93
    RET

; =============================================================================
MAYBE_initialise_all_voices_4480:
    LXI         HL,channel_info_0_8100
    MVI         C,3
_initialise_voice_loop_4485:
    PUSH        BC
    CALL        initialise_channel_info_5094
    POP         BC

; Add 0xB to HL to point to the next voice's info structure.
    LXI         EA,0Bh
    DADD        EA,HL
    DMOV        HL,EA

    DCR         C
    JRE         _initialise_voice_loop_4485

    RET

; Unreachable?
    MVI         A,024h
    MVI         C,03ch
LAB_4498:
    PUSH        V
    PUSH        BC
    ANI         A,01111111b
    MOV         E,A
    CALL        midi_send_key_event_363f
    POP         BC
    POP         V
    INR         A
    DCR         C
    JRE         LAB_4498

    RET

; =============================================================================
main_44a7:
    CALL        input_scan_keyboard_MAYBE_4670
    EQIW        (V_OFFSET(keyboard_UNKNOWN_8010)),0FFh
    CALL        keyboard_handle_active_keys_472e
    CALL        input_scan_switches_MAYBE_46cd

; Check if any input lines are active. If so, handle the button event.
; If no lines are active, it will be 0xFF.
    EQIW        (V_OFFSET(input_active_line_8012)),0FFh
    CALL        input_handle_button_events_4ac6

    CALL        main_check_midi_channel_override_45fd
    CALL        cartridge_insert_check_424c
    CALL        lcd_update_cursor_and_leds_44eb
    CALL        main_p_button_check_5006
    CALL        check_battery_level_452e
    CALL        main_apo_check_4562
    CALL        power_input_check_4515
    CALL        midi_get_incoming_data_and_process_3040

    INRW        (V_OFFSET(UNKNOWN_counter_806b))
    GTIW        (V_OFFSET(UNKNOWN_counter_806b)),4
    RET

    CALL        MAYBE_main_button_hold_check_207a
    MVIW        (V_OFFSET(UNKNOWN_counter_806b)),0
    RET

; =============================================================================
led_update_all_44de:
    CALL        led_4_update_4ce6
    CALL        led_3_update_4d0d
    CALL        led_2_update_4c85
    CALL        led_1_update_4c74
    RET

; =============================================================================
lcd_update_cursor_and_leds_44eb:
; Test if there are cursor positions in the current UI screen.
    NEIW        (V_OFFSET(lcd_cursor_position_count_8053)),0
    JRE         _no_cursor_4511

; Cursor positions exist.
; Test if update flag set?
    BIT         LCD_FLAGS_UPDATE_BIT,(V_OFFSET(lcd_flags_8049))     ; Skip if bit set.
    RET

; Clear update flag.
; Toggle bit 7.
    DI
    LDAW        (V_OFFSET(lcd_flags_8049))
    ANI         A,~(1 << LCD_FLAGS_UPDATE_BIT)

; Toggle this flag.
    XRI         A,(1 << LCD_FLAGS_CURSOR_ENABLE_BIT)
    STAW        (V_OFFSET(lcd_flags_8049))
    EI

    BIT         LCD_FLAGS_CURSOR_ENABLE_BIT,(V_OFFSET(lcd_flags_8049))
    JMP         lcd_write_instruction_blink_off_cursor_off_53c2

    BIT         LCD_FLAGS_CURSOR_OFF_BIT,(V_OFFSET(lcd_flags_8049))
    JMP         lcd_write_instruction_blink_off_cursor_on_53c6

_blink_off_cursor_off_update_led_and_exit_4507:
    ANIW        (V_OFFSET(lcd_flags_8049)),~(1 << LCD_FLAGS_CURSOR_OFF_BIT)
    CALL        lcd_update_set_cursor_off_blink_off_and_update_cursor_534d
    CALL        led_update_all_44de
    RET

_no_cursor_4511:
    BIT         LCD_FLAGS_CURSOR_OFF_BIT,(V_OFFSET(lcd_flags_8049))   ; Skip if 08049h & 2h == 1.
    RET
    JR          _blink_off_cursor_off_update_led_and_exit_4507

; =============================================================================
power_input_check_4515:
    MVI         C,0Fh

; Set Port B lines 4 and 7 to input lines.
    MVI         A,10010000b

    MOV         MB,A

_power_input_check_loop_451b:
; Poll the power line input.
; If a signal isn't detected in 16 iterations,
; then fall-through to power down.
    OFFI        PB,80h ; Skip if zero.
    RET

    DCR         C
    JR          _power_input_check_loop_451b

; =============================================================================
power_down_4521:
    MVI         A,00000111b

; Set the Mode C registers (MCC/MC) so that
; line 3 of Port C is an output.
; Pull this low to power down the synth.
    MOV         MCC,A
    MVI         A,0
    MOV         MC,A
    ANI         PC,11110111b

; Loop until the synth powers off.
    JRE         power_down_4521

; =============================================================================
check_battery_level_452e:
; Read battery level into EA.
    MOV         A,CR2
    LXI         EA,0
    MOV         EAL,A

; C = Current battery level.
    LDAW        (V_OFFSET(battery_level_8041))
    MOV         C,A

    EADD        EA,A
    DSLR        EA
    MOV         A,EAL

    GTA         A,C
    STAW        (V_OFFSET(battery_level_8041))
    ADI         C,05h
    GTA         A,C
    JR          LAB_4548

    STAW        (V_OFFSET(battery_level_8041))

LAB_4548:
    LDAW        (V_OFFSET(battery_level_8041))
    GTI         A,06fh
    JRE         LAB_4552

    CALL        led_4_power_on_4ce3
    RET

LAB_4552:
; If this flag is clear, exit.
    BIT         0,(V_OFFSET(power_button_blink_flag_8051))
    RET

; Clear flag.
    ANIW        (V_OFFSET(power_button_blink_flag_8051)),11111110b

; Toggle LED4 Line 0 (Power Button)
    LDAW        (V_OFFSET(led_4_state_8017))
    XRI         A,1
    STAW        (V_OFFSET(led_4_state_8017))
    CALL        led_4_update_4ce6
    RET

; =============================================================================
main_apo_check_4562:
    CALL        button_check_apo_5021
    JRE         _apo_active_4569

    JRE         _apo_inactive_4594

_apo_active_4569:
; If this flag is set, act as though the APO is inactive.
    OFFIW       (V_OFFSET(input_received_ignore_apo_flag_8042)),1
    JRE         _apo_inactive_4594

    CALL        main_apo_check_for_input_45ad
    JRE         _apo_inactive_4594

; Increment the counter, and check if it's over the threshold.
    LXI         HL,apo_timeout_counter_1_804c
    LDEAX       (HL)
    INX         EA
    STEAX       (HL)
    LXI         DE,274Eh
    DGT         EA,DE                               ; Skip if (EA>rp3).
    RET

; Reset the APO timeout counter.
    LXI         EA,0
    STEAX       (HL++)

; Increment the second APO counter.
; Once it gets over 11, power down the synth.
    LDEAX       (HL)
    INX         EA
    STEAX       (HL)
    LXI         DE,0bh
; Skip if (EA<DE).
    DLT         EA,DE
    CALL        power_down_4521
    RET

_apo_inactive_4594:
    MVIW        (V_OFFSET(input_received_ignore_apo_flag_8042)),0

; Reset both APO timeout counters.
    LXI         HL,apo_timeout_counter_1_804c
    LXI         EA,0
    STEAX       (HL++)
    STEAX       (HL)
    RET

; =============================================================================
;  C = Number of consecutive keygroups to check.
;  A = Mask.
;  Skips on return if bitmask not matched.
; =============================================================================
main_apo_check_test_switch_group_45a2:
    OFFAX       (HL+)   ; Skip if A & *(HL) == 0; HL+
    RET

    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    DCR         C
    JR          main_apo_check_test_switch_group_45a2

    RETS

; =============================================================================
; Checks for input activity that would disable APO.
; Returns:
; Skips on return if no activity detected.
; =============================================================================
main_apo_check_for_input_45ad:
    LXI         HL,switch_states_8134
    MVI         C,7
    MVI         A,00111111b
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,1
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,0FFh
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,11011111b
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,1
    MVI         A,0FFh
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,11111110b
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,0FFh
    CALL        main_apo_check_test_switch_group_45a2
    RET

    MVI         C,0
    MVI         A,00111111b
    CALL        main_apo_check_test_switch_group_45a2
    RET

; Test whether any of the 8 voices is active.
    LXI         HL,voice_note_numbers_8190
    MVI         C,7
    MVI         A,KEYBOARD_NOTE_ON

_test_for_active_voice_loop_45f7:
    OFFAX       (HL+)
    RET
    DCR         C
    JR          _test_for_active_voice_loop_45f7

    RETS

; =============================================================================
; From Devin Acker's CZ101 MAME Driver cz101.cpp:
;  Unused input matrix bits:
;  Bit 7 of KC15 is normally unused, but if pulled low using a diode, then
;  bits 2-5 of KC8 (also normally unused) become DIP switches that override
;  the normal MIDI "basic channel" setting from the front panel (possibly
;  planned for use on a screenless MIDI module).
; =============================================================================
main_check_midi_channel_override_45fd:
    CALL        button_check_midi_channel_override_5024
    JR          _switch_active_4605

; Switch inactive. Clear override flag.
    MVIW        (V_OFFSET(midi_basic_channel_overridden_8033)),0
    RET

_switch_active_4605:
    LXI         HL,input_group_kc9_lines_2_6_8164
    LDAX        (HL)
    SLR         A
    SLR         A
    ANI         A,00001111b
    STAW        (V_OFFSET(midi_basic_channel_override_8032))
    MVIW        (V_OFFSET(midi_basic_channel_overridden_8033)),1
    RET

; =============================================================================
; Checks whether the P button is held down
; If it's held for 16 cycles, it will copy the preset data into memory.
; =============================================================================
main_p_button_check_5006:
    CALL        button_check_p_5006
    JR          _p_button_held_461d

_p_button_counter_reset_4619:
    MVIW        (V_OFFSET(p_button_hold_counter_804a)),0
    RET

_p_button_held_461d:
; Check if P button held for 16 cycles.
    INRW        (V_OFFSET(p_button_hold_counter_804a))
    GTIW        (V_OFFSET(p_button_hold_counter_804a)),16   ; Skip if greater than 16.
    RET

; P button held for 16 cycles.
    DI
    CALL        _p_button_counter_reset_4619

    LXI         HL,patch_rom_preset_6000
    LXI         DE,patch_buffer_compare_8380
    MVI         C,7Fh
    BLOCK

    LXI         DE,patch_buffer_internal_8800
    LXI         HL,default_internal_data_3800
    MVI         C,0Fh

_copy_preset_data_loop_4638:
    PUSH        BC
    MVI         C,7Fh
    BLOCK

    POP         BC
    DCR         C
    JR          _copy_preset_data_loop_4638

    CALL        patch_UNKNOWN_29e0
    MVIW        (V_OFFSET(master_tune_8001)),40h
    MVIW        (V_OFFSET(MAYBE_key_transpose_8002)),05h
    MVIW        (V_OFFSET(tone_mix_UNKNOWN_8006)),09h
    MVIW        (V_OFFSET(tone_mix_UNKNOWN_8005)),0
    MVIW        (V_OFFSET(midi_channel_basic_8000)),0
    MVIW        (V_OFFSET(patch_index_tone_mix_8007)),010h
    MVIW        (V_OFFSET(patch_index_compare_8008)),010h
    MVIW        (V_OFFSET(pitch_bend_range_8003)),03h
    MVIW        (V_OFFSET(portamento_time_8004)),01eh
    JMP         reset_4333

; =============================================================================
; Tests whether the first 8 bytes of the cartridge contain the debug header.
; Skips on return if debug header not present.
; =============================================================================
debug_mode_entry_check_debug_header_4660:
    LXI         HL,cartridge_memory_9000
    LXI         DE,965Ah
    MVI         C,3

_compare_bytes_loop_4668:
    LDEAX       (HL++)
    DEQ         EA,DE                               ; Skip if (EA=rp3).
    RETS

    DCR         C
    JR          _compare_bytes_loop_4668

    RET

; =============================================================================
input_scan_keyboard_MAYBE_4670:
    MVIW        (V_OFFSET(keyboard_UNKNOWN_8010)),0FFh
    MVI         C,0
    MVIW        (V_OFFSET(UNKNOWN_keyboard_flags_8013)),0
    LXI         HL,keyboard_key_states_UNKNOWN_8130
    ANI         PB,11110000b

_scan_key_group_loop_467e:
; Looks like it reads 3 times, and then
; checks all reads are identical.
    DI
    MOV         B,(keyboard_switch_matrix_b800)
    MOV         A,(keyboard_switch_matrix_b800)
    MOV         D,(keyboard_switch_matrix_b800)
    EI

    ADI         PB,1

; Is A == B?
; If not, skip this group.
    EQA         A,B
    JRE         _skip_to_next_group_46c6

; Is A == D?
; If not, skip this group.
    EQA         A,D
    JRE         _skip_to_next_group_46c6

; Load the previous state of this key block?
    LDEAX       (HL)
    DMOV        DE,EA

; The state where no keys are pressed is 0FFh.
; XOR with 0FFh will show if the state has changed.
    XRI         A,0FFh

; Store the changed state in group[0], and increment.
    STAX        (HL+)

; Combine with previous state?
; Store in group[1], and increment.
    ORA         A,E
    STAX        (HL+)

    LDEAX       (HL)
    ORA         A,D
    STAX        (HL+)

    DMOV        DE,EA
    ORA         A,E
    STAX        (HL+)
    LDEAX       (HL)
    ORA         A,D
    STAX        (HL+)
    DMOV        DE,EA
    XRA         A,E
    STAX        (HL+)
    ONI         A,00111111b
    JR          _advance_loop_46bf

    MOV         A,C
    BIT         0,(V_OFFSET(UNKNOWN_keyboard_flags_8013))
    STAW        (V_OFFSET(keyboard_UNKNOWN_8010))
    STAW        (V_OFFSET(keyboard_UNKNOWN_8011))
    ORIW        (V_OFFSET(UNKNOWN_keyboard_flags_8013)),1

_advance_loop_46bf:
    INR         C
    LTI         C,09h   ;Skip if C < 9
    RET

    JRE         _scan_key_group_loop_467e

_skip_to_next_group_46c6:
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    JR          _advance_loop_46bf

; =============================================================================
input_scan_switches_MAYBE_46cd:
    MVIW        (V_OFFSET(input_active_line_8012)),0FFh

; The front-panel buttons start at input matrix group 9.
    MVI         C,9
    LXI         HL,input_group_kc10_8166

    ANI         PB,11111001b
    ORI         PB,1001b

_scan_switch_group_46db:
; Looks like it reads 3 times, and then
; checks all reads are identical.
    DI
    MOV         B,(keyboard_switch_matrix_b800)
    MOV         A,(keyboard_switch_matrix_b800)
    MOV         D,(keyboard_switch_matrix_b800)
    EI

    LTI         C,0Fh
    JRE         LAB_4722

    ADI         PB,1

LAB_46f1:
; Is A == B?
; If not, skip this group.
    EQA         A,B
    JRE         _skip_to_next_group_4727

; Is A == D?
; If not, skip this group.
    EQA         A,D
    JRE         _skip_to_next_group_4727

    LDEAX       (HL)
    DMOV        DE,EA

; Invert the value read.
    XRI         A,0FFh

; Store the read bitmask in group[0].
    STAX        (HL+)

; Combine this value with the existing input line bitmask read from DE, and
; group[1] = All active lines.
    ORA         A,E
    STAX        (HL+)

; Combine this value with the existing input line bitmask read from DE, and
; group[2] = All active lines?
    LDEAX       (HL)
    ORA         A,D
    STAX        (HL+)

; group[3] = Existing value combined with new input?
    DMOV        DE,EA
    ORA         A,E
    STAX        (HL+)

; group[4] = Existing value combined with new input?
    LDEAX       (HL)
    ORA         A,D
    STAX        (HL+)

; group[5] = Changed input?
    DMOV        DE,EA
    XRA         A,E
    STAX        (HL+)

    ONI         A,0FFh
    JR          _advance_loop_471b

    MOV         A,C
    STAW        (V_OFFSET(input_active_line_8012))
    RET

_advance_loop_471b:
    INR         C
    LTI         C,10h
    RET

    JRE         _scan_switch_group_46db

LAB_4722:
    ANI         PB,11110000b
    JRE         LAB_46f1

_skip_to_next_group_4727:
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    JR          _advance_loop_471b

; =============================================================================
keyboard_handle_active_keys_472e:
    MVIW        (V_OFFSET(input_received_ignore_apo_flag_8042)),1

; C = 08011h - 08010h.
    LDAW        (V_OFFSET(keyboard_UNKNOWN_8011))
    MOV         C,A
    LDAW        (V_OFFSET(keyboard_UNKNOWN_8010))
    SUB         C,A

; B = A * 6.
    MOV         B,A
    ADD         B,A
    ADD         B,A
    SLL         B

; EA = 8135[B].
    LXI         EA,keyboard_key_states_UNKNOWN_8135
    EADD        EA,B
    LXI         HL,keyboard_test_note_offsets_475d
    LDAX        (HL+A)
    MOV         B,A
    DMOV        HL,EA
    JR          _MAYBE_test_key_group_4751

_MAYBE_advance_to_next_key_group_474b:
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL
    INX         HL

_MAYBE_test_key_group_4751:
    LDAX        (HL)

; If no keys are active, skip.
    OFFI        A,00111111b                         ; Skip if (A & byte = 0)
    CALL        keyboard_test_keygroup_4766

; Add 6 to the note number.
    ADI         B,06h
    DCR         C
    JR          _MAYBE_advance_to_next_key_group_474b

    RET

keyboard_test_note_offsets_475d:
    DB          024h
    DB          02Ah
    DB          30h
    DB          036h
    DB          03Ch
    DB          042h
    DB          048h
    DB          04Eh
    DB          054h

; =============================================================================
; Tests a keygroup.
; This is only called when at least one key is active.
; Calls the note handler for the active keys.
; A: Key bitmask.
; B: Current note number being tested.
; =============================================================================
keyboard_test_keygroup_4766:
    PUSH        BC

; Gets the key number within the group.
; Shifts the key bitmask left,
; until it correctly masks the keyboard scan bitmask.
; Adding 1 to the note number with each iteration.
    MVI         C,1

; If the note bitmask in C matches A, call the handler.
; Otherwise skip.
_get_note_number_loop_4769:
    OFFA        A,C
    CALL        keyboard_handle_note_event_4779

; Add 1 to the note number, and shift the test bitmask.
    ADI         B,1
    SLL         C

; Skip once the shift goes past the block of 6 keys.
    ONI         C,11000000b ; Skip if A & ? != 0.
    JR          _get_note_number_loop_4769

    POP         BC
    RET

; =============================================================================
; B: Note#.
; HL: ?
; =============================================================================
keyboard_handle_note_event_4779:
    PUSH        V
    PUSH        BC
    PUSH        HL
    DCX         HL
    MOV         A,B
    MOV         E,A
    LDAX        (HL)
    LTI         E,55h
    JR          _exit_4799

    OFFA        A,C
    ORI         E,KEYBOARD_NOTE_ON
    CALL        midi_send_key_event_363f

; Exit if local mode is enabled.
    OFFIW       (V_OFFSET(local_mode_keyboard_disabled_8016)),1      ; Skip if (A & byte == 0)
    JR          _exit_4799

    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    MVIW        (V_OFFSET(current_note_event_origin_8015)),0
    CALL        note_on_off_47be

_exit_4799:
    POP         HL
    POP         BC
    POP         V
    RET

; =============================================================================
; Returns:
; HL: Pointer to channel info.
; =============================================================================
channel_get_info_table_ptr_for_selected_solo_voice_479d:
    PUSH        EA
    PUSH        V

; Load the currently selected solo MIDI voice.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
; Falls-through below.

; =============================================================================
; Gets a pointer to the voice info for index in A.
; Returns:
; HL: Pointer to channel info.
; =============================================================================
channel_get_info_table_ptr_for_index_in_a_47a1:
    ANI         A,00000011b
    SLL         A
    LXI         HL,channel_info_ptr_table_47ae
    LDEAX       (HL+A)
    DMOV        HL,EA
    POP         V
    POP         EA
    RET

channel_info_ptr_table_47ae:
    DW          channel_info_0_8100
    DW          channel_info_1_810b
    DW          channel_info_2_8116
    DW          channel_info_3_8121

; =============================================================================
; Gets a pointer to the channel info for the last solo MIDI voice.
; Returns:
; HL: Pointer to channel info.
; =============================================================================
channel_get_ptr_to_info_table_for_incoming_midi_voice_47b6:
    PUSH        EA
    PUSH        V
    LDAW        (V_OFFSET(midi_incoming_solo_voice_index_8034))
    JR          channel_get_info_table_ptr_for_index_in_a_47a1

; =============================================================================
; Returns:
; HL: Pointer to channel info.
; =============================================================================
channel_get_info_table_ptr_47bb:
    PUSH        EA
    PUSH        V
    JR          channel_get_info_table_ptr_for_index_in_a_47a1

; =============================================================================
; Initiates handling of note on/off events.
; E:  Note#.
; HL: Channel info (0x8100).
; =============================================================================
note_on_off_47be:
; Does this MSB flag indicate NOTE ON/OFF?
; MSB is set in NOTE ON.
; MSB is cleared in NOTE OFF?
    ONI         E,KEYBOARD_NOTE_ON              ; Skip if NOTE ON.
    CALL        note_off_4800                   ; Skips on return.
    CALL        note_on_47c8
    RET

; =============================================================================
; E:  Note#.
; HL: Channel info (0x8100).
; =============================================================================
note_on_47c8:
; Add 1 to the note count?
    LDAX        (HL+CHANNEL_INFO_NOTE_COUNT)
    ADI         A,1
    STAX        (HL+CHANNEL_INFO_NOTE_COUNT)

    ORI         E,KEYBOARD_NOTE_ON

    LDAX        (HL+CHANNEL_INFO_LAST_VOICE_NUMBER_MAYBE)
    MOV         D,A

    LDAX        (HL+CHANNEL_INFO_FLAGS)
    SLL         A

    CALL        note_on_jumpoff_47db
    RET

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
note_on_jumpoff_47db:
; Mask the shifted channel flags to clamp it to 0-30.
; This will serve as an index into the table of 16 pointers below.
    ANI         A,00011110b
    TABLE
    JB
    DW          note_on_basic_mode_483a
    DW          note_on_tone_mix_MAYBE_4859
    DW          note_on_basic_porta_on_4881
    DW          UNKNOWN_note_on_sub_solo_mode_4894
    DW          UNKNOWN_note_on_solo_mode_porta_on_48b4
    DW          UNKNOWN_note_on_solo_mode_porta_on_48b4
    DW          UNKNOWN_note_on_solo_mode_porta_on_48cf
    DW          UNKNOWN_note_on_solo_mode_porta_on_48cf
    DW          MAYBE_note_on_basic_mode_note_not_found_4842
    DW          UNKNOWN_note_on_sub_4868
    DW          UNKNOWN_note_on_basic_porta_on_488c
    DW          UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_4896
    DW          UNKNOWN_note_on_solo_mode_multiple_voices_48be
    DW          UNKNOWN_note_on_solo_mode_multiple_voices_48be
    DW          UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_48be
    DW          UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_48be

; =============================================================================
note_off_4800:
; Load value, subtract 1, clamp at 0.
    LDAX        (HL+CHANNEL_INFO_NOTE_COUNT)
    SUINB       A,1
    MVI         A,0
    STAX        (HL+CHANNEL_INFO_NOTE_COUNT)

; Reset note on/off flag.
    ANI         E,(~KEYBOARD_NOTE_ON & 0FFh)
    LDAX        (HL+CHANNEL_INFO_LAST_VOICE_NUMBER_MAYBE)
    MOV         D,A
    LDAX        (HL)
    SLL         A

    CALL        note_off_jumpoff_4815
    RETS

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
note_off_jumpoff_4815:
    ANI         A,00011110b
    TABLE
    JB
    DW          note_off_basic_mode_4849
    DW          returns_4871
    DW          note_off_basic_porta_on_4890
    DW          returns_48a2
    DW          returns_48c4
    DW          returns_48c4
    DW          returns_48d3
    DW          returns_48d3
    DW          UNKNOWN_note_off_sub_4858
    DW          UNKNOWN_note_off_sub_4872
    DW          UNKNOWN_note_off_sub_4892
    DW          UNKNOWN_note_off_sub_48a3
    DW          UNKNOWN_note_off_solo_mode_porta_on_48c5
    DW          UNKNOWN_note_off_solo_mode_porta_on_48c5
    DW          UNKNOWN_note_off_sub_48d4
    DW          UNKNOWN_note_off_sub_48d4

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
note_on_basic_mode_483a:
    CALL        note_on_basic_mode_find_voice_48d6
    JR          MAYBE_note_on_basic_mode_note_not_found_4842

    CALL        note_on_basic_mode_voice_found_49f8
    RET

; =============================================================================
; HL: Channel Info.
; =============================================================================
MAYBE_note_on_basic_mode_note_not_found_4842:
    CALL        MAYBE_increment_voice_number_in_d_4977
    CALL        note_on_basic_mode_voice_found_49f8
    RET

; =============================================================================
note_off_basic_mode_4849:
; Find voice with note. Skip if found.
    CALL        find_active_voice_with_note_49ce
    RET

    CALL        note_off_UNKNOWN_4959
; Falls-through below.

note_off_clear_flag_and_exit_UNKNOWN_4850:
    CALL        note_off_clears_channel_flag_UNKNOWN_4954
    RET

; =============================================================================
FUN_4854:
    CALL        FUN_4995
    RET

; =============================================================================
UNKNOWN_note_off_sub_4858:
    JR          note_off_basic_mode_4849

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
note_on_tone_mix_MAYBE_4859:
; Add 4 to voice#.
; If this overflows 0x90-0x97, clamp at 0x90.
    ADI         D,04h
    LTI         D,098h
    MVI         D,090h
    CALL        note_on_basic_mode_voice_found_49f8
; D = Free Voice#.
    CALL        note_on_sets_channel_flag_UNKNOWN_494f
    RET

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
UNKNOWN_note_on_sub_4868:
    PUSH        DE
    CALL        note_on_UNKNOWN_4a1a
    CALL        note_off_UNKNOWN_4959
    POP         DE
    JR          note_on_tone_mix_MAYBE_4859

; =============================================================================
returns_4871:
    RET

; =============================================================================
UNKNOWN_note_off_sub_4872:
    CALL        UNKNOWN_note_off_sub_4960
    JRE         FUN_4854

    CALL        note_off_UNKNOWN_4959
    CALL        FUN_4986
    JRE         note_off_clear_flag_and_exit_UNKNOWN_4850

    JRE         note_on_tone_mix_MAYBE_4859

; =============================================================================
note_on_basic_porta_on_4881:
    CALL        FUN_492e
    JR          UNKNOWN_note_on_basic_porta_on_488c

; =============================================================================
UNKNOWN_note_on_basic_porta_on_4885:
    CALL        note_on_UNKNOWN_49ff
    CALL        FUN_4a7f
    RET

; =============================================================================
UNKNOWN_note_on_basic_porta_on_488c:
    CALL        MAYBE_increment_voice_number_in_d_4977
    JR          UNKNOWN_note_on_basic_porta_on_4885

; =============================================================================
note_off_basic_porta_on_4890:
    JRE         note_off_basic_mode_4849

; =============================================================================
UNKNOWN_note_off_sub_4892:
    JRE         note_off_basic_mode_4849

; =============================================================================
UNKNOWN_note_on_sub_solo_mode_4894:
    JRE         note_on_tone_mix_MAYBE_4859

; =============================================================================
UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_4896:
    PUSH        DE
    CALL        note_on_UNKNOWN_4a1a
    POP         DE

LAB_489b:
    CALL        note_on_UNKNOWN_49ff
    CALL        FUN_4a90
    RET

; =============================================================================
returns_48a2:
    RET

; =============================================================================
UNKNOWN_note_off_sub_48a3:
    CALL        UNKNOWN_note_off_sub_4960
    JRE         FUN_4854

    CALL        FUN_4986
    JR          FUN_48ad

    JR          LAB_489b

; =============================================================================
FUN_48ad:
    CALL        note_off_UNKNOWN_4959
    CALL        note_off_clears_channel_flag_UNKNOWN_4954
    RET

; =============================================================================
UNKNOWN_note_on_solo_mode_porta_on_48b4:
    CALL        note_on_sets_channel_flag_UNKNOWN_494f
    CALL        note_on_UNKNOWN_49ff
    CALL        note_on_UNKNOWN_4a6e
    RET

; =============================================================================
UNKNOWN_note_on_solo_mode_multiple_voices_48be:
    PUSH        DE
    CALL        note_on_UNKNOWN_4a1a
    POP         DE
    JR          UNKNOWN_note_on_solo_mode_porta_on_48b4

; =============================================================================
returns_48c4:
    RET

UNKNOWN_note_off_solo_mode_porta_on_48c5:
    CALL        UNKNOWN_note_off_sub_4960
    JRE         FUN_4854

    CALL        FUN_4986
    JRE         FUN_48ad

    JR          UNKNOWN_note_on_solo_mode_porta_on_48b4

; =============================================================================
UNKNOWN_note_on_solo_mode_porta_on_48cf:
    JR          UNKNOWN_note_on_solo_mode_porta_on_48b4

; =============================================================================
UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_48be:
    JRE         UNKNOWN_note_on_solo_mode_porta_on_multiple_voices_4896

; =============================================================================
returns_48d3:
    RET

UNKNOWN_note_off_sub_48d4:
    JRE         UNKNOWN_note_off_sub_48a3

; =============================================================================
; HL: Channel Info (0x8100).
;
; Returns:
; Skips if voice found?
; =============================================================================
note_on_basic_mode_find_voice_48d6:
    PUSH        DE
    PUSH        HL
    MVI         B,097h
    LXI         DE,voice_note_numbers_8190

; This creates a pointer to the voice note number array. 8190 + x...
; HL = 0x8190[last voice index].
    LDAX        (HL+CHANNEL_INFO_LAST_VOICE_NUMBER_MAYBE)
    MOV         L,A
    MVI         H,081h

; B = 0x97 - 0x90 + voice number.
    SUB         B,A

; C = 0x90 + Voice# - 90.
    SUB         A,E
    MOV         C,A

; Test whether channel Line Select setting contains multiple lines,
; e.g. 1+2, or 1+1'.
    BIT         1,(V_OFFSET(channel_pflags_0_801b))
    JR          note_on_basic_mode_find_voice_single_line_48f9

    JRE         note_on_basic_mode_find_voice_two_lines_490e

; =============================================================================
; A: 0x90 + Found voice index.
; =============================================================================
note_on_basic_mode_voice_not_found_48ec:
    POP         HL
    POP         DE
    LDAX        (HL)
    ORI         A,8
    STAX        (HL)
    RET

; =============================================================================
; A: 0x90 + Found voice index.
; =============================================================================
note_on_basic_mode_voice_found_48f3:
; Subtract 1, because the found voice index is 1-based.
    SUI         A,1
    POP         HL
    POP         DE
    MOV         D,A
    RETS

; =============================================================================
; B:  0x97 - 0x90 + voice number.
; C:  7 - Voice#.
; DE: 0x8190[0]: Voice note numbers.
; HL: 0x8190[last voice index]: Voice note numbers
; =============================================================================
note_on_basic_mode_find_voice_single_line_48f9:
    MVI         A,KEYBOARD_NOTE_ON
    SUINB       B,1                                 ; Skip if no borrow.
    JR          _find_voice_from_start_loop_4906

    INX         HL

; First loop from the last used voice, until the end of the array.
; If a free voice is not found, loop from the start of the array until the
; last used voice is reached.
_find_voice_from_end_loop_4900:
; If the voice at (HL) is active, exit.
    ONAX        (HL+)                               ; Skip if (A & rpa != 0)
    JRE         note_on_basic_mode_voice_found_from_end_4928

    DCR         B
    JR          _find_voice_from_end_loop_4900

_find_voice_from_start_loop_4906:
    ONAX        (DE+)
    JRE         note_on_basic_mode_voice_found_from_start_492b

    DCR         C
    JR          _find_voice_from_start_loop_4906

    JRE         note_on_basic_mode_voice_not_found_48ec

; =============================================================================
; B:  0x97 - 0x90 + voice number.
; C:  7 - Voice#.
; DE: 0x8190[0]: Voice note numbers.
; HL: 0x8190[last voice index]: Voice note numbers
; =============================================================================
note_on_basic_mode_find_voice_two_lines_490e:
    MVI         A,KEYBOARD_NOTE_ON
    SLR         B
    SLR         C
    SUINB       B,1
    JR          _find_voice_from_start_loop_4920

    INX         HL
    INX         HL

; First loop from the last used voice, until the end of the array.
; If a free voice is not found, loop from the start of the array until the
; last used voice is reached.
_find_voice_from_end_loop_491a:
; If the voice at (HL) is active, exit.
    ONAX        (HL+)
    JR          note_on_basic_mode_voice_found_from_end_4928

    INX         HL
    DCR         B
    JR          _find_voice_from_end_loop_491a

_find_voice_from_start_loop_4920:
    ONAX        (DE+)
    JR          note_on_basic_mode_voice_found_from_start_492b

    INX         DE
    DCR         C
    JR          _find_voice_from_start_loop_4920

    JRE         note_on_basic_mode_voice_not_found_48ec

note_on_basic_mode_voice_found_from_end_4928:
    MOV         A,L
    JRE         note_on_basic_mode_voice_found_48f3

note_on_basic_mode_voice_found_from_start_492b:
    MOV         A,E
    JRE         note_on_basic_mode_voice_found_48f3

; =============================================================================
FUN_492e:
    PUSH        DE
    LXI         DE,voice_note_numbers_8190
    MVI         A,80h
    MVI         B,07h
    OFFIW       (V_OFFSET(channel_pflags_0_801b)),2
    SLR         B

LAB_493b:
    ONAX        (DE+)
    JR          LAB_494a

    OFFIW       (V_OFFSET(channel_pflags_0_801b)),2
    INX         DE
    DCR         B
    JR          LAB_493b

    LDAX        (HL)
    ORI         A,8
    STAX        (HL)
    POP         DE
    RET

LAB_494a:
    DCX         DE
    MOV         A,E
    POP         DE
    MOV         D,A
    RETS

; =============================================================================
; HL: Channel Info (0x8100).
; =============================================================================
note_on_sets_channel_flag_UNKNOWN_494f:
    LDAX        (HL+CHANNEL_INFO_FLAGS)
    ORI         A,CHANNEL_INFO_FLAGS_8
    STAX        (HL+CHANNEL_INFO_FLAGS)
    RET

; =============================================================================
; HL: Channel Info (0x8100).
; =============================================================================
note_off_clears_channel_flag_UNKNOWN_4954:
    LDAX        (HL+CHANNEL_INFO_FLAGS)
    ANI         A,(~CHANNEL_INFO_FLAGS_8)
    STAX        (HL+CHANNEL_INFO_FLAGS)
    RET

; =============================================================================
note_off_UNKNOWN_4959:
    CALL        note_off_UNKNOWN_4a15
    CALL        note_off_UNKNOWN_4a4a
    RET

; =============================================================================
; Is this searching for a note?
; Seems to be only reached in solo mode.
; D: Voice#.
; E: Note#.
; Returns:
; Skips on return if...
; =============================================================================
UNKNOWN_note_off_sub_4960:
    LXI         BC,voice_note_numbers_8190

; C = D.
; This sets BC to equal 0x8190 + Voice#.
    MOV         A,D
    MOV         C,A
; A = E.
    MOV         A,E
    ORI         A,KEYBOARD_NOTE_ON
; Skip if A == (BC).
    EQAX        (BC)
    RET

; BC = 0x8190 + Voice# + 8.
    ADI         C,8
    ACI         B,0
; Check whether this note event has the same origin as the note event at
; this index (MIDI/Keyboard event).
    LDAW        (V_OFFSET(current_note_event_origin_8015))
    EQAX        (BC)
    RET
    RETS

; =============================================================================
MAYBE_increment_voice_number_in_d_4977:
    ADI         D,1
; Test if multiple lines selected (1+2 / 1+1').
; If so, an extra voice is used.
    OFFIW       (V_OFFSET(channel_pflags_0_801b)),2
    ADI         D,1
; Clamp at 0x98.
    LTI         D,098h
    MVI         D,090h
    RET

; =============================================================================
; EA: ?
; HL: Channel info (0x8100).
; =============================================================================
FUN_4986:
    LDEAX       (HL+CHANNEL_INFO_3)
    MOV         A,EAL
    NEI         A,0FFh
    RET
    MOV         E,A
    MOV         A,EAH
    STAW        (V_OFFSET(current_note_event_origin_8015))
    CALL        FUN_49b5
    RETS

; =============================================================================
FUN_4995:
    MOV         A,E
    ANI         A,01111111b
    MOV         C,A
    LDAW        (V_OFFSET(current_note_event_origin_8015))
    MOV         B,A
    LDEAX       (HL+3)
    DNE         EA,BC
    JR          FUN_49b5

    LDEAX       (HL+5)
    DNE         EA,BC
    JR          LAB_49bb

    LDEAX       (HL+7)
    DNE         EA,BC
    JR          LAB_49c1

    LDEAX       (HL+9)
    DNE         EA,BC
    JR          LAB_49c7

    RET

; =============================================================================
FUN_49b5:
    LDEAX       (HL+5)
    STEAX       (HL+3)

LAB_49bb:
    LDEAX       (HL+7)
    STEAX       (HL+5)

LAB_49c1:
    LDEAX       (HL+9)
    STEAX       (HL+7)

LAB_49c7:
    LXI         EA,0FFh
    STEAX       (HL+9)
    RET

; =============================================================================
; E: Note number.
; Returns:
;  Skips on return if note found.
;  D : Voice number.
; =============================================================================
find_active_voice_with_note_49ce:
    PUSH        HL
    PUSH        DE

; This looks like it's looping over each voice.
    MVI         B,7
    MOV         A,E
    ORI         A,KEYBOARD_NOTE_ON
    LXI         DE,voice_note_numbers_8190

; Test whether multiple lines enabled?
; If so, the number of iterations is halved.
    OFFIW       (V_OFFSET(channel_pflags_0_801b)),2
    SLR         B
_find_note_loop_49dd:
    NEAX        (DE+)
    JR          _note_found_49e9

_check_next_voice_49e0:
; If multiple lines, increase DE by 2 each iteration instead of 1.
    OFFIW       (V_OFFSET(channel_pflags_0_801b)),2
    INX         DE
    DCR         B
    JR          _find_note_loop_49dd

    POP         DE
    POP         HL
    RET

_note_found_49e9:
; Temporarily store A in L.
    MOV         L,A
    LDAX        (DE+7)
    NEAW        (V_OFFSET(current_note_event_origin_8015))
    JR          _exit_49f2

    MOV         A,L
    JR          _check_next_voice_49e0

_exit_49f2:
    DCX         DE
    MOV         A,E
    POP         DE
    POP         HL
    MOV         D,A
    RETS

; ============================================================================
; D: 0x90 + Voice#.
; E: Note# & 0x80.
; =============================================================================
note_on_basic_mode_voice_found_49f8:
    CALL        note_on_UNKNOWN_49ff
    CALL        note_on_UNKNOWN_4a6e
    RET

; ============================================================================
; D: 0x90 + Voice#.
; E: Note# & 0x80.
; =============================================================================
note_on_UNKNOWN_49ff:
    ORI         E,KEYBOARD_NOTE_ON
    MOV         A,D
    STAX        (HL+CHANNEL_INFO_LAST_VOICE_NUMBER_MAYBE)
; Falls-through below.

; ============================================================================
; D: 0x90 + Voice#.
; E: Note#. (MSB decides note on or off)
; =============================================================================
note_on_off_UNKNOWN_4a05:
; 0x8190[Voice#] = Note#.
    PUSH        HL
    MOV         L,A
    MVI         H,081h
    MOV         A,E
    STAX        (HL)

; Is this a note on event?
    ONI         E,KEYBOARD_NOTE_ON
    JR          _note_off_4a13

; Note on.
; 0x8198[Voice#] = (0x8015).
    LDAW        (V_OFFSET(current_note_event_origin_8015))
    STAX        (HL+8)

_note_off_4a13:
    POP         HL
    RET

; =============================================================================
note_off_UNKNOWN_4a15:
    ANI         E,(~KEYBOARD_NOTE_ON & 0FFh)
    MOV         A,D
    JR          note_on_off_UNKNOWN_4a05

; =============================================================================
; A:  Channel flags shifted.
; D:  Voice#.
; E:  Note# & 0x80.
; HL: Channel Info (0x8100).
; =============================================================================
note_on_UNKNOWN_4a1a:
    MVI         B,081h
; C = Voice#.
    MOV         A,D
    MOV         C,A

; A = 0x8100[voice#].
    LDAX        (BC)
    ANI         A,(~KEYBOARD_NOTE_ON & 0FFh)

    MOV         E,A
    CALL        note_UNKNOWN_4a26
    RET

; =============================================================================
; HL: Channel Info (0x8100).
; D:  Voice#.
; E:  Note#.
; =============================================================================
note_UNKNOWN_4a26:
    PUSH        DE

    LDEAX       (HL+CHANNEL_INFO_7)
    STEAX       (HL+CHANNEL_INFO_9)

    LDEAX       (HL+CHANNEL_INFO_5)
    STEAX       (HL+CHANNEL_INFO_7)

    LDEAX       (HL+CHANNEL_INFO_3)
    STEAX       (HL+CHANNEL_INFO_5)

; EAL = Note# & 0x7F.
    MOV         A,E
    ANI         A,(~KEYBOARD_NOTE_ON & 0FFh)
    MOV         EAL,A

; DE = 0x8190[Voice#].
    MOV         A,D
    LXI         DE,voice_note_numbers_8190
    MOV         E,A

; A = 0x8198[Voice#].
    LDAX        (DE+8)

    MOV         EAH,A
    STEAX       (HL+CHANNEL_INFO_3)
    POP         DE
    RET

; =============================================================================
; D: 0x90 + Voice#.
; =============================================================================
note_off_UNKNOWN_4a4a:
    PUSH        HL
    PUSH        DE
    CALL        note_on_off_UNKNOWN_4a63
    CALL        note_off_UNKNOWN_7363
    POP         DE
    POP         HL
    RET

; =============================================================================
; Unreachable code?
; =============================================================================
    PUSH        HL
    PUSH        DE
    CALL        note_on_off_UNKNOWN_4a63
    CALL        FUN_734d
    POP         DE
    POP         HL
    RET

; =============================================================================
; Unreachable code?
; =============================================================================
    LDAX        (HL+1)
    MOV         D,A
; Falls-through below.

; =============================================================================
; D: 0x90 + Voice#.
; =============================================================================
note_on_off_UNKNOWN_4a63:
    MOV         A,D
    SUI         A,090h
    OFFI        A,1
    XRI         A,04h
    ANI         A,00001111b
    MOV         D,A
    RET

; =============================================================================
note_on_UNKNOWN_4a6e:
    PUSH        HL
    PUSH        DE
    CALL        note_UNKNOWN_4aba
    CALL        note_on_off_UNKNOWN_4a63
    CALL        FUN_4a9e
    CALL        FUN_6ed0
    POP         DE
    POP         HL
    RET

; =============================================================================
FUN_4a7f:
    PUSH        HL
    PUSH        DE
    CALL        note_UNKNOWN_4aba
    CALL        note_on_off_UNKNOWN_4a63
    CALL        FUN_4a9e
    CALL        FUN_6ece
    POP         DE
    POP         HL
    RET

; =============================================================================
FUN_4a90:
    PUSH        HL
    PUSH        DE
    CALL        note_UNKNOWN_4aba
    CALL        note_on_off_UNKNOWN_4a63
    CALL        FUN_7842
    POP         DE
    POP         HL
    RET

; =============================================================================
FUN_4a9e:
    PUSH        HL
    PUSH        DE
    LDAX        (HL+2)
    NEI         A,1
    CALL        UNKNOWN_set_up_channel_4aaa
    POP         DE
    POP         HL
    RET

; =============================================================================
UNKNOWN_set_up_channel_4aaa:
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    JR          _solo_mode_active_4ab2

    CALL        patch_call_function_per_channel_7793
    RET

_solo_mode_active_4ab2:
    MOV         A,D
    SLR         A
    MOV         D,A
    CALL        patch_called_per_channel_7776

    RET

; =============================================================================
note_UNKNOWN_4aba:
    PUSH        HL
    PUSH        DE
    MOV         A,E
    ANI         A,01111111b
    SUI         A,7
    MOV         E,A
    POP         DE
    POP         HL
    MOV         E,A
    RET

; =============================================================================
; Handles any active button up/down events.
; EAH: Triggering input line.
; EAL: All active input lines.
; =============================================================================
input_handle_button_events_4ac6:
    MVIW        (V_OFFSET(input_received_ignore_apo_flag_8042)),1

; Mask the active input line, and subtract 9, because all front-panel buttons
; are wired to input lines 9-15.
    LDAW        (V_OFFSET(input_active_line_8012))
    ANI         A,1111b
    SUI         A,9

; B = A * 3.
    MOV         B,A
    ADD         B,A
    ADD         B,A

; EA = 816a[B * 2].
    PUSH        BC
    SLL         B

    LXI         HL,input_group_kc10_UNKNOWN_816a
    LDEAX       (HL+B)
    POP         BC

; B = ((B + A) * 2) + 7
    ADD         B,A
    SLL         B
    ADI         B,7

; A = Triggering input line.
    MOV         A,EAH
    MVI         C,80h

; C is set to 10000000b.
; This checks the bitmask in A against C, and shifts C right with each
; iteration.
_read_bitmask_loop_4ae7:
    OFFA        A,C
    CALL        input_button_up_down_4af3
    SUI         B,1
    SLRC        C
    JR          _read_bitmask_loop_4ae7

    RET

; =============================================================================
; Handles individual button up/down events.
; B:   Button code.
; EAH: Triggering input line.
; EAL: All active input lines.
; =============================================================================
input_button_up_down_4af3:
    PUSH        BC
    PUSH        EA

    MOV         A,EAL
    ANA         C,A

    MOV         A,B
    SLL         A
    ONI         C,0FFh
    JR          _button_up_4b06

    CALL        input_button_down_4b0a

_exit_4b02:
    POP         EA
    POP         BC
    MOV         A,EAH
    RET

_button_up_4b06:
    CALL        input_button_up_4bb0
    JR          _exit_4b02

; =============================================================================
; A: Button code.
; =============================================================================
input_button_down_4b0a:
    ONIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_80     ; Skip if 08037h & 80h == 1.
    JRE         LAB_4b18

; Flag 80 set.
    NEI         A,BUTTON_VALUE_DOWN                         ; Skip if A !== 30h.
    JRE         _input_button_down_table_jumpoff_4b23

    NEI         A,BUTTON_VALUE_UP                           ; Skip if A !== 32h.
    JRE         _input_button_down_table_jumpoff_4b23

    RET

LAB_4b18:
    ONIW        (V_OFFSET(ui_flags_8037)),FLAGS_8037_40     ; Skip if 08037h & 40h == 1.
    JR          _input_button_down_table_jumpoff_4b23

    NEI         A,BUTTON_TUNE_DOWN                          ; Skip if A !== 68h.
    JR          _input_button_down_table_jumpoff_4b23

    NEI         A,BUTTON_TUNE_UP                            ; Skip if A !== 06Ah.
    JR          _input_button_down_table_jumpoff_4b23

    RET

_input_button_down_table_jumpoff_4b23:
    TABLE
    JB
    DW          input_portamento_4e1e
    DW          input_portamento_time_24a1
    DW          input_vibrato_4db6
    DW          input_bend_range_24b0
    DW          input_memory_select_preset_4f42
    DW          input_memory_select_internal_4f44
    DW          input_memory_select_cartridge_4f46
    DW          input_compare_4fda
    DW          input_solo_50fa
    DW          input_tone_mix_5267
    DW          input_key_transpose_24bf
    DW          input_write_52a3
    DW          input_midi_5763
    DW          input_unknown_52c9
    DW          input_select_4f9d
    DW          return_4c35
    DW          input_patch_1_4e6e
    DW          input_patch_2_4e65
    DW          input_patch_3_4e67
    DW          input_patch_4_4e69
    DW          input_patch_5_4e6b
    DW          input_patch_6_4e6d
    DW          input_patch_7_4e6f
    DW          input_patch_8_4e71
    DW          input_value_down_2022
    DW          input_value_up_201e
    DW          input_cursor_left_58b8
    DW          input_cursor_right_58a2
    DW          input_env_step_down_248b
    DW          input_env_step_up_2475
    DW          input_env_point_sustain_2446
    DW          input_env_point_end_2429
    DW          return_4c35
    DW          input_vibrato_239d
    DW          input_dco1_waveform_20df
    DW          input_dco1_env_224d
    DW          input_dcw1_key_follow_230b
    DW          input_dcw1_env_21df
    DW          input_dca1_key_follow_22bb
    DW          input_dca1_env_214d
    DW          return_4c35
    DW          input_octave_237d
    DW          input_dco2_waveform_2110
    DW          input_dco2_env_2284
    DW          input_dcw2_key_follow_2333
    DW          input_dcw2_env_2216
    DW          input_dca2_key_follow_22e3
    DW          input_dca2_env_21a8
    DW          input_detune_235b
    DW          input_line_select_23c0
    DW          input_mod_ring_2408
    DW          input_mod_noise_23e7
    DW          input_master_tune_down_2004
    DW          input_master_tune_up_2000
    DW          return_4c35
    DW          return_4c35

_flags_80_set_4b96:
; Test if value down is set.
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))  ; Skip if bit is high.
    JR          _was_button_value_up_4b9e

; Test if button was value down.
    EQI         A,BUTTON_VALUE_DOWN                 ; Skip if A=byte.
    RET

    JRE         input_button_up_jumpoff_4bc2

_was_button_value_up_4b9e:
    EQI         A,BUTTON_VALUE_UP
    RET
    JRE         input_button_up_jumpoff_4bc2

LAB_4ba3:
; Test if value down is set.
    BIT         UI_FLAGS_BIT_VALUE_DOWN,(V_OFFSET(ui_flags_8038))
    JR          LAB_4bab

    EQI         A,BUTTON_TUNE_DOWN
    RET
    JRE         input_button_up_jumpoff_4bc2

LAB_4bab:
    EQI         A,BUTTON_TUNE_UP
    RET
    JRE         input_button_up_jumpoff_4bc2

; =============================================================================
input_button_up_4bb0:
    NEI         A,16h
    JRE         input_button_up_jumpoff_4bc2

    NEI         A,1Ah
    JRE         input_button_up_jumpoff_4bc2

    OFFIW       (V_OFFSET(ui_flags_8037)),FLAGS_8037_80  ; Skip if ((V.wa) & byte == 0)
    JRE         _flags_80_set_4b96

    OFFIW       (V_OFFSET(ui_flags_8037)),FLAGS_8037_40
    JRE         LAB_4ba3

input_button_up_jumpoff_4bc2:
    TABLE
    JB
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          input_released_write_52bb
    DW          return_4c35
    DW          input_released_unknown_52de
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          input_released_value_up_down_4c43
    DW          input_released_value_up_down_4c43
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          return_4c35
    DW          input_released_master_tune_up_down_4c36
    DW          input_released_master_tune_up_down_4c36
    DW          return_4c35
    DW          return_4c35

; =============================================================================
return_4c35:
    RET

; =============================================================================
input_released_master_tune_up_down_4c36:
    LXI         HL,input_group_kc16_818a
    MVI         C,5

_loop_4c3b:
    LDAX        (HL)
    ANI         A,11001111b
    STAX        (HL+)
    DCR         C
    JR          _loop_4c3b

    JRE         UNKNOWN_masks_flags_4c4e

; =============================================================================
input_released_value_up_down_4c43:
    LXI         HL,input_group_kc13_8178
    MVI         C,5

loop_4c48:
    LDAX        (HL)
    ANI         A,11111100b
    STAX        (HL+)
    DCR         C
    JR          loop_4c48

UNKNOWN_masks_flags_4c4e:
    ANIW        (V_OFFSET(ui_flags_8037)),00111111b
    ORI         MKL,MKL_MKT1
    RET

; =============================================================================
led_1_update_based_on_patch_4c55:
    ORIW        (V_OFFSET(led_1_state_801a)),00001111b
    LDAW        (V_OFFSET(UNKNOWN_patch_index_8027))

; Set the compare LED if the compare flag is set.
    OFFI        A,PATCH_FLAGS_MODIFIED
; LED = Compare
    ANIW        (V_OFFSET(led_1_state_801a)),11111110b

    ONI         A,PATCH_FLAGS_CARTRIDGE             ; Skip if A & ? != 0.
    JRE         _is_patch_internal_4c68

; LED = Cartridge
    ANIW        (V_OFFSET(led_1_state_801a)),11111101b
    JRE         led_1_update_4c74

_is_patch_internal_4c68:
    ONI         A,PATCH_FLAGS_INTERNAL
    JRE         _patch_is_preset_4c71

; LED = Internal
    ANIW        (V_OFFSET(led_1_state_801a)),11111011b
    JRE         led_1_update_4c74

_patch_is_preset_4c71:
; LED = Preset
    ANIW        (V_OFFSET(led_1_state_801a)),11110111b

; =============================================================================
led_1_update_4c74:
    LDAW        (V_OFFSET(led_1_state_801a))
    MOV         (led_1_b000),A
    RET

; =============================================================================
led_2_update_based_on_patch_index_4c7b:
    LDAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    ANI         A,00001111b
    LXI         HL,led_2_patch_index_mask_4c8c
    LDAX        (HL+A)
    STAW        (V_OFFSET(led_2_state_8019))
; Falls-through below.

; =============================================================================
led_2_update_4c85:
    LDAW        (V_OFFSET(led_2_state_8019))
    MOV         (led_2_a800),A
    RET

; =============================================================================
; Bitmasks for LED2, based on which patch is currently selected.
; =============================================================================
led_2_patch_index_mask_4c8c:
    DB          0E8h
    DB          0E4h
    DB          0E2h
    DB          0B2h
    DB          0D8h
    DB          0D4h
    DB          0D2h
    DB          0B4h
    DB          68h
    DB          64h
    DB          62h
    DB          32h
    DB          58h
    DB          54h
    DB          52h
    DB          34h

; =============================================================================
patch_update_leds_based_on_patch_4c9c:
    CALL        led_1_update_based_on_patch_4c55
    CALL        led_2_update_based_on_patch_index_4c7b
    RET

; =============================================================================
led_write_button_pressed_4ca3:
    ORIW        (V_OFFSET(led_1_state_801a)),00001110b
    CALL        led_1_update_4c74
    ORIW        (V_OFFSET(led_2_state_8019)),11110000b
    ANIW        (V_OFFSET(led_2_state_8019)),11110001b
    JRE         led_2_update_4c85

; =============================================================================
led_2_select_on_4cb1:
    ANIW        (V_OFFSET(led_2_state_8019)),(~LED_2_SELECT & 0FFh)
    JRE         led_2_update_4c85

; =============================================================================
led_2_select_off_4cb6:
    ORIW        (V_OFFSET(led_2_state_8019)),LED_2_SELECT
    JRE         led_2_update_4c85

; =============================================================================
led_1_portamento_on_compare_on_4cbb:
    MVI         L,(~LED_1_PORTA & 0FFh)

; =============================================================================
led_1_vibrato_on_compare_on_4cbd:
    MVI         L,~LED_1_VIBRATO
    MVI         L,~LED_1_COMPARE
    LDAW        (V_OFFSET(led_1_state_801a))
    ANA         A,L
    STAW        (V_OFFSET(led_1_state_801a))
    JRE         led_1_update_4c74

; =============================================================================
led_1_portamento_off_4cc9:
    MVI         L,LED_1_PORTA

; =============================================================================
led_1_vibrato_off_4ccb:
    MVI         L,LED_1_VIBRATO

; =============================================================================
led_1_solo_off_4ccd:
    MVI         L,LED_1_SOLO

; =============================================================================
led_1_tone_mix_off_4ccf:
    MVI         L,LED_1_TONE_MIX
    MVI         L,1
    LDAW        (V_OFFSET(led_1_state_801a))
    ORA         A,L
    STAW        (V_OFFSET(led_1_state_801a))
    JRE         led_1_update_4c74

; =============================================================================
; Solo Off / Tone Mix On.
; =============================================================================
led_1_tone_mix_on_solo_off_4cdb:
    ANIW        (V_OFFSET(led_1_state_801a)),~LED_1_TONE_MIX
    JR          led_1_solo_off_4ccd

; =============================================================================
; Solo On / Tone Mix Off.
; =============================================================================
led_1_tone_mix_off_solo_on_4cdf:
    ANIW        (V_OFFSET(led_1_state_801a)),~LED_1_SOLO
    JR          led_1_tone_mix_off_4ccf

; =============================================================================
led_4_power_on_4ce3:
    ANIW        (V_OFFSET(led_4_state_8017)),~LED_4_POWER

; =============================================================================
led_4_update_4ce6:
    LDAW        (V_OFFSET(led_4_state_8017))
    MOV         (led_4_9800),A
    RET

; Unreachable code?
    ORIW        (V_OFFSET(led_4_state_8017)),1
    JR          led_4_update_4ce6

; =============================================================================
led_3_dco_1_env_4cf1:
    MVI         A,00100111b

; =============================================================================
led_3_dco_1_waveform_4cf3:
    MVI         A,01000111b

; =============================================================================
led_3_dcw_1_env_4cf5:
    MVI         A,01001011b

; =============================================================================
led_3_dcw_1_key_follow_4cf7:
    MVI         A,00010111b

; =============================================================================
led_3_dca_1_env_4cf9:
    MVI         A,00011011b

; =============================================================================
led_3_dca_1_key_follow_4cfb:
    MVI         A,00101011b

; =============================================================================
led_3_dco_2_env_4cfd:
    MVI         A,00101101b

; =============================================================================
led_3_dco_2_waveform_4cff:
    MVI         A,01001101b

; =============================================================================
led_3_dcw_2_env_4d01:
    MVI         A,01001110b

; =============================================================================
led_3_dcw_2_key_follow_4d03:
    MVI         A,00011101b

; =============================================================================
led_3_dca_2_env_4d05:
    MVI         A,00011110b

; =============================================================================
led_3_dca_2_key_follow_4d07:
    MVI         A,00101110b

; =============================================================================
led_3_all_off_4d09:
    MVI         A,00001111b
    STAW        (V_OFFSET(led_3_state_8018))

; =============================================================================
led_3_update_4d0d:
    LDAW        (V_OFFSET(led_3_state_8018))
    MOV         (led_3_a000),A
    RET

; =============================================================================
led_4_noise_off_ring_on_4d14:
    ANIW        (V_OFFSET(led_4_state_8017)),~LED_4_RING
    JR          led_4_noise_off_4d18

; =============================================================================
led_4_ring_off_4d18:
    ORIW        (V_OFFSET(led_4_state_8017)),LED_4_RING
    JRE         led_4_update_4ce6

; =============================================================================
led_4_noise_on_ring_off_4d1d:
    ANIW        (V_OFFSET(led_4_state_8017)),~LED_4_NOISE
    JR          led_4_ring_off_4d18

; =============================================================================
led_4_noise_off_4d18:
    ORIW        (V_OFFSET(led_4_state_8017)),LED_4_NOISE
    JRE         led_4_update_4ce6

; =============================================================================
led_4_set_ring_noise_leds_based_on_waveform_4d26:
; Test whether a single line is selected based on the LED state.
; If so, disable the noise/ring LEDs.
    ONIW        (V_OFFSET(led_4_state_8017)),LED_4_LINE_1
    JRE         _single_line_selected_4d3e

    ONIW        (V_OFFSET(led_4_state_8017)),LED_4_LINE_2
    JRE         _single_line_selected_4d3e

    CALL        patch_load_waveform_1_4d43
    MOV         A,EAH
    ANI         A,00111000b
    NEI         A,18h
    JRE         led_4_noise_on_ring_off_4d1d

    NEI         A,20h
    JRE         led_4_noise_off_ring_on_4d14

_single_line_selected_4d3e:
    CALL        led_4_noise_off_4d18
    JRE         led_4_ring_off_4d18

; =============================================================================
patch_load_waveform_1_4d43:
    LXI         HL,patch_buffer_edit_8300
    LDEAX       (HL+PATCH_DCO1_WAVEFORM_1)
    RET

; =============================================================================
led_4_set_line_select_leds_from_pflags_4d4a:
; Load pflags.
    CALL        channel_get_selected_solo_channel_pflags_pointer_4d6f
    LDAX        (BC)
; Mask line select.
    ANI         A,00000011b
; Load the correct LED value based on the line select value.
    LXI         HL,pflags_to_line_select_led_conversion_table_4d5f
    LDAX        (HL+A)
    MOV         B,A
    LDAW        (V_OFFSET(led_4_state_8017))
    ORI         A,01111000b
    ANA         A,B
    STAW        (V_OFFSET(led_4_state_8017))
    JRE         led_4_update_4ce6

pflags_to_line_select_led_conversion_table_4d5f:
    DB          ~LED_4_LINE_1
    DB          ~LED_4_LINE_2
    DB          ~LED_4_LINE_1_1
    DB          ~LED_4_LINE_1_2

; =============================================================================
; Uses the pointer to the channel info table in HL to find the channel index,
; then uses this index to get a pointer to the flags for this channel.
;
; Arguments:
; HL: Pointer to channel info.
;
; Returns:
; BC: Pointer to channel flags.
; =============================================================================
channel_get_flags_ptr_from_info_ptr_4d63:
; D = Current channel index.
    CALL        channel_get_index_from_pointer_to_info_50c7
    MOV         A,D
    JRE         channel_get_flags_pointer_4d80

; =============================================================================
; Uses the pointer to the channel info table in HL to find the channel index,
; then uses this index to get a pointer to the pflags for this channel.
;
; Arguments:
; HL: Pointer to channel info.
;
; Returns:
; BC: Pointer to channel flags.
; =============================================================================
channel_get_pflags_ptr_from_info_ptr_4d69:
    CALL        channel_get_index_from_pointer_to_info_50c7
    MOV         A,D
    JRE         channel_get_pflags_pointer_4d71

; =============================================================================
; Returns:
; BC: Pointer to channel pflags.
; =============================================================================
channel_get_selected_solo_channel_pflags_pointer_4d6f:
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
; falls-through below.

; =============================================================================
; Arguments:
; A: Channel index.
;
; Returns:
; BC: Pointer to channel pflags.
; =============================================================================
channel_get_pflags_pointer_4d71:
    SLL         A
    TABLE
    RET
    DW          channel_pflags_0_801b
    DW          channel_pflags_1_801c
    DW          channel_pflags_2_801d
    DW          channel_pflags_3_801e

; =============================================================================
; Returns:
; BC: Pointer to channel flags.
; =============================================================================
channel_get_selected_solo_midi_channel_flags_4d7e:
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
; falls-through below.

; =============================================================================
; Arguments:
; A: Channel index.
;
; Returns:
; BC: Pointer to channel flags.
; =============================================================================
channel_get_flags_pointer_4d80:
    SLL         A
    TABLE
    RET
    DW          channel_flags_0_802d
    DW          channel_flags_1_802e
    DW          channel_flags_2_802f
    DW          channel_flags_3_8030

; =============================================================================
; Arguments:
; HL: Pointer to selected solo mode channel info.
;
; Returns:
; BC: Pointer to the patch index for the selected solo mode channel.
; =============================================================================
channel_get_ptr_to_solo_mode_patch_index_4d8d:
    CALL        channel_get_index_from_pointer_to_info_50c7
    MOV         A,D
    SLL         A
    TABLE
    RET
    DW          patch_index_channel_0_8029
    DW          patch_index_channel_1_802a
    DW          patch_index_channel_2_802b
    DW          patch_index_channel_3_802c

; =============================================================================
channel_get_current_solo_midi_channel_flags_and_UNKNOWN_4d9e:
    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)
    JRE         UNKNOWN_vibrato_4dc9

; =============================================================================
channel_clear_current_solo_midi_channel_vibrato_flag_4da4:
    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)
    ANI         A,~CHANNEL_FLAGS_VIBRATO
    STAX        (BC)
    RET

; =============================================================================
input_vibrato_lfo_depth_0_4dac:
    CALL        channel_clear_current_solo_midi_channel_vibrato_flag_4da4
    JR          UNKNOWN_vibrato_4dc9

; =============================================================================
voice_update_vibrato_4db0:
    CALL        channel_clear_current_solo_midi_channel_vibrato_flag_4da4
    MVIW        (V_OFFSET(ignore_sending_vibrato_enable_cc_8023)),1
; Fall-through below.

; =============================================================================
input_vibrato_4db6:
; Test whether LFO depth is above 0.
; Skips on return if above 0.
    CALL        patch_get_edit_buffer_lfo_depth_4e0d
    JR          input_vibrato_lfo_depth_0_4dac

; LFO depth > 0.
    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)

; Toggle the flag for vibrato.
    XRI         A,CHANNEL_FLAGS_VIBRATO
    STAX        (BC)

; Test whether to send the vibrato CC message.
    BIT         0,(V_OFFSET(ignore_sending_vibrato_enable_cc_8023))
    CALL        midi_send_cc_vibrato_3709
    MVIW        (V_OFFSET(ignore_sending_vibrato_enable_cc_8023)),0

; =============================================================================
; A: Voice Flags
; =============================================================================
UNKNOWN_vibrato_4dc9:
; D = Selected MIDI voice.
    PUSH        V
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    MOV         D,A
    POP         V

    MVI         B,0

    ONI         A,CHANNEL_FLAGS_VIBRATO               ; Skip if A & ? != 0.
    ORI         B,00000010b

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE ; Skip if ((V.wa) & byte == 0)
    ORI         B,00000100b

; Solo Off / Vibrato On  : 0000
; Solo Off / Vibrato Off : 0010
; Solo On  / Vibrato On  : 0100
; Solo On  / Vibrato Off : 0110

    MOV         A,B
    TABLE
    JB
    DW          _solo_off_vibrato_on_4de7
    DW          _solo_off_vibrato_off_4df1
    DW          _solo_on_vibrato_on_4dfb
    DW          _solo_on_vibrato_off_4e04

_solo_off_vibrato_on_4de7:
    CALL        patch_call_function_per_channel_7793
    CALL        FUN_796f

_enable_vibrato_led_and_exit_4ded:
    CALL        led_1_vibrato_on_compare_on_4cbd
    RET

_solo_off_vibrato_off_4df1:
    CALL        patch_call_function_per_channel_7793
    CALL        FUN_7974

_disable_vibrato_led_and_exit_4df7:
    CALL        led_1_vibrato_off_4ccb
    RET

_solo_on_vibrato_on_4dfb:
    PUSH        DE
    CALL        patch_called_per_channel_7776
    POP         DE
    CALL        FUN_7971
    JR          _enable_vibrato_led_and_exit_4ded

_solo_on_vibrato_off_4e04:
    PUSH        DE
    CALL        patch_called_per_channel_7776
    POP         DE
    CALL        voice_vibrato_on_off_UNKNOWN_0_7976
    JR          _disable_vibrato_led_and_exit_4df7

; =============================================================================
; Skips on return if LFO depth /= 0.
; =============================================================================
patch_get_edit_buffer_lfo_depth_4e0d:
    LXI         HL,patch_buffer_edit_8300

; =============================================================================
patch_get_lfo_depth_from_patch_buffer_in_h_4e10:
    LDAX        (HL+0bh)
    NEI         A,0                                ; Skip if A != 0.
    RET
    RETS

; Unreachable.
    RET

; =============================================================================
input_solo_4e17:
    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)
    PUSH        V
    JRE         set_leds_based_on_porta_solo_4e2f

; =============================================================================
input_portamento_4e1e:
    CALL        channel_get_selected_solo_midi_channel_flags_4d7e
    LDAX        (BC)

; Toggle portamento, and store.
    XRI         A,CHANNEL_FLAGS_PORTA
    STAX        (BC)

    PUSH        V
    CALL        midi_send_cc_portamento_36e2
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    CALL        resets_channel_flags_UNKNOWN_50a1

set_leds_based_on_porta_solo_4e2f:
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    MOV         D,A
    POP         V
    MVI         B,0

; Set flags according to Solo / Porta mode:
; Solo on   = 100
; Porta off = 010

; Solo off / Porta on  = 0
; Solo off / Porta off = 2
; Solo On / Porta On   = 4
; Solo On / Porta Off  = 6

    ONI         A,CHANNEL_FLAGS_PORTA                 ; Skip if A & ? != 0.
    ORI         B,00000010b

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE  ; Skip if ((V.wa) & byte == 0)
    ORI         B,00000100b

    MOV         A,B
    TABLE
    JB
    DW          _solo_off_porta_on_4e4c
    DW          _solo_off_porta_off_4e53
    DW          _solo_on_porta_on_4e5a
    DW          _solo_on_porta_off_4e5e

_solo_off_porta_on_4e4c:
    CALL        UNKNOWN_porta_on_792f

_set_portamento_led_on_and_exit_4e4f:
    CALL        led_1_portamento_on_compare_on_4cbb
    RET

_solo_off_porta_off_4e53:
    CALL        UNKNOWN_porta_off_7934

_set_portamento_led_off_and_exit_4e56:
    CALL        led_1_portamento_off_4cc9
    RET

_solo_on_porta_on_4e5a:
    CALL        UNKNOWN_porta_on_7931
    JR          _set_portamento_led_on_and_exit_4e4f

_solo_on_porta_off_4e5e:
    CALL        UNKNOWN_porta_off_7931
    JR          _set_portamento_led_off_and_exit_4e56

    RET

; =============================================================================
input_patch_1_4e6e:
    MVI         A,0

; =============================================================================
input_patch_2_4e65:
    MVI         A,1

; =============================================================================
input_patch_3_4e67:
    MVI         A,2

; =============================================================================
input_patch_4_4e69:
    MVI         A,3

; =============================================================================
input_patch_5_4e6b:
    MVI         A,4

; =============================================================================
input_patch_6_4e6d:
    MVI         A,5

; =============================================================================
input_patch_7_4e6f:
    MVI         A,6

; =============================================================================
input_patch_8_4e71:
    MVI         A,7
    MOV         B,A
    PUSH        BC

; Test if the 'Write' button is pressed.
; Skips if the button is INACTIVE.
    CALL        button_check_write_5000
    JRE         patch_save_4ec2

; Write button is INACTIVE.
; Test if tone mix active.
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX   ; Skip if ((V.wa) & byte = 0)
    JRE         input_patch_tone_mix_active_4f1c

; Tone mix inactive.
    POP         BC

; Load patch index, and check if already selected?
    LDAW        (V_OFFSET(patch_index_8026))
    ANI         A,10000111b
    NEA         A,B                                 ; Skip if (A ≠ r)
    RET

; Combine incoming patch index and existing patch index flags.
    LDAW        (V_OFFSET(patch_index_8026))
    ANI         A,01111000b
    ADD         A,B
; Fall-through below.

; =============================================================================
patch_load_send_prog_change_4e8d:
    CALL        midi_send_prog_change_369a

; =============================================================================
patch_load_validate_flags_4e90:
    CALL        patch_load_validate_flags_UNKNOWN_42a4

; =============================================================================
patch_load_4e93:
    CALL        patch_load_update_indexes_4eb7

    EQIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    CALL        ui_print_patch_or_tone_mix_5537

    CALL        led_3_all_off_4d09
    CALL        voice_update_vibrato_4db0
    RET

; =============================================================================
UNKNOWN_patch_4ea3:
    LDAW        (V_OFFSET(patch_index_8026))
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    JRE         patch_load_update_indexes_4eb7

; =============================================================================
patch_UNKNOWN_4eaa:
    LDAW        (V_OFFSET(patch_index_channel_0_8029))
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    STAW        (V_OFFSET(patch_index_channel_0_8029))
    JRE         patch_load_update_indexes_4eb7

; =============================================================================
MAYBE_patch_compare_restore_4eb3:
    LDAW        (V_OFFSET(patch_index_compare_8008))

; =============================================================================
patch_set_modified_flag_and_update_indexes_4eb5:
    ORI         A,PATCH_FLAGS_MODIFIED

; =============================================================================
patch_load_update_indexes_4eb7:
    STAW        (V_OFFSET(patch_index_8026))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    CALL        UNKNOWN_patch_compare_4ff9
    CALL        line_select_UNKNOWN_5039
    RET

; =============================================================================
; B: Patch Index?
; =============================================================================
patch_save_4ec2:
    POP         BC

; Test if the write button is being held?
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))   ; Skip if bit is high.
    RET

; Write button is ACTIVE.
    LDAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    ANI         A,01101000b
    ADD         A,B

; Is this testing the save location is set?
    ONI         A,01100000b                         ; Skip if A & ? != 0.
    RET

    PUSH        V

; Test if the protect switch is enabled.
; Skip if the switch is INACTIVE.
    CALL        button_check_protect_5003
    JRE         pop_va_and_return_4ef3

    POP         V

; Test the save flags/destination.
; Skips on return if valid.
    CALL        patch_test_save_memory_selected_429a
    JMP         print_string_write_select_memory_52e6

; Save flags valid.
; Store patch indexes?
    STAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    STAW        (V_OFFSET(patch_index_8026))
    CALL        voice_update_solo_voice_patch_index_4f02
    CALL        led_2_update_based_on_patch_index_4c7b
    CALL        patch_copy_from_edit_buffer_to_index_4ef5
    CALL        prints_str_write_save_ok_5746
    MVIW        (V_OFFSET(write_button_currently_pressed_8021)),0
    RET

_exit_4ef2:
    RET

; =============================================================================
pop_va_and_return_4ef3:
    POP         V
    RET

; =============================================================================
patch_copy_from_edit_buffer_to_index_4ef5:
    LDAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    CALL        patch_get_pointer_to_index_5072
    DMOV        DE,EA
    LXI         HL,patch_buffer_edit_8300
    MVI         C,7Fh
    BLOCK
    RET

; =============================================================================
; Tests to see which solo voice is currently selected, and updates its
; patch index.
; =============================================================================
voice_update_solo_voice_patch_index_4f02:
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    MOV         D,A

    LDAW        (V_OFFSET(patch_index_8026))
    NEI         D,0                                 ; Skip if (r≠byte)
    STAW        (V_OFFSET(patch_index_channel_0_8029))

    NEI         D,1
    STAW        (V_OFFSET(patch_index_channel_1_802a))

    NEI         D,2
    STAW        (V_OFFSET(patch_index_channel_2_802b))

    NEI         D,3
    STAW        (V_OFFSET(patch_index_channel_3_802c))
    RET

; =============================================================================
; B: Patch index + Flags?
; =============================================================================
input_patch_tone_mix_active_4f1c:
    POP         BC

; Test if patch index is the same.
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,10000111b
    NEA         A,B                                 ; Skip if (A ≠ r)
    RET

; Combine with current flags.
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,01111000b
    ADD         A,B

; =============================================================================
patch_send_midi_prog_change_and_load_4f2a:
    CALL        midi_send_prog_change_369a

; =============================================================================
midi_process_prog_change_solo_tone_mix_active_UNKNOWN_4f2d:
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    STAW        (V_OFFSET(patch_index_tone_mix_8007))

; =============================================================================
patch_load_tone_mix_UNKNOWN_4f32:
    LXI         HL,channel_info_0_8100
    CALL        UNKNOWN_patch_load_41d8
    CALL        initialise_channel_info_5094
    CALL        UNKNOWN_tone_mix_7626
    CALL        ui_print_patch_or_tone_mix_5537
    RET

; =============================================================================
input_memory_select_preset_4f42:
    MVI         A,010h

; =============================================================================
input_memory_select_internal_4f44:
    MVI         A,020h

; =============================================================================
input_memory_select_cartridge_4f46:
    MVI         A,PATCH_FLAGS_CARTRIDGE
    MOV         B,A
    PUSH        BC

; Skips if write INACTIVE.
    CALL        button_check_write_5000
    JR          _write_button_active_4f46

; Write button INACTIVE.
; Test if Tone Mix ACTIVE.
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX   ; Skip if ((V.wa) & byte = 0)
    JRE         _tone_mix_active_4f89

; Tone Mix INACTIVE.
    POP         BC

; Load the patch index.
; Mask the flags?
; Compare the flags against the selected memory?
    LDAW        (V_OFFSET(patch_index_8026))
    ANI         A,11110000b

; Test if this memory is already selected.
    NEA         A,B                                 ; Skip if (A ≠ r)
    RET

; Load the patch index.
; Mask the patch number.
; Apply the memory source flag.
    LDAW        (V_OFFSET(patch_index_8026))
    ANI         A,00001111b
    ORA         A,B
    CALL        patch_test_save_memory_selected_429a    ; Skips on return in some cases.
    RET
    JMP         patch_load_send_prog_change_4e8d

_write_button_active_4f46:
    POP         BC
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))
    RET

; Mask flag 08h, and add the memory source...
    LDAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    ANI         A,00001000b
    ADD         A,B
    OFFI        A,PATCH_FLAGS_10                    ; Skip if (A & byte = 0)
    RET

    PUSH        V

; Skip if...
    CALL        button_check_protect_5003
    JRE         pop_va_and_return_4ef3

    POP         V
    CALL        patch_test_save_memory_selected_429a
    JRE         _exit_4ef2

    STAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    CALL        led_1_update_based_on_patch_4c55
    RET

_tone_mix_active_4f89:
    POP         BC
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,11110000b
    NEA         A,B
    RET
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,00001111b
    ORA         A,B
    CALL        patch_test_save_memory_selected_429a
    RET
    JRE         patch_send_midi_prog_change_and_load_4f2a

; =============================================================================
input_select_4f9d:
; Skips on return if write button inactive.
    CALL        button_check_write_5000
    JR          _write_button_active_4faf

; Write Button Inactive.
; Is Tone Mix ACTIVE?
    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX
    JRE         _tone_mix_active_4fd2

    LDAW        (V_OFFSET(patch_index_8026))
; There appears to be a bug in the assembler, omitting the mask here
; will generate a 'range underflow' error.
    ANI         A,(~PATCH_FLAGS_MODIFIED & 0FFh)

; Toggle this bit to select between numbers
; 0-7, and 8-15...
    XRI         A,00001000b
    JMP         patch_load_send_prog_change_4e8d

; Test if the write button is pressed?
; Why is this tested twice?
; The following section updates the patch index
; prior to selecting a save index during saving a patch.
_write_button_active_4faf:
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))   ; Skip if bit is high.
    RET

; Load patch index.
; Check if in internal, or cartridge?
; Exit if internal?
    LDAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    ONI         A,60h                               ; Skip if A & ? != 0.
    RET

; Toggle this bit to select between numbers
; 0-7, and 8-15...
    XRI         A,00001000b
    PUSH        V

; Check if protect switch is enabled.
; Skips on return if protect DISABLED.
    CALL        button_check_protect_5003
    JRE         pop_va_and_return_4ef3

; Protect switch DISABLED.
    POP         V
    CALL        patch_test_save_memory_selected_429a
    JMP         print_string_write_select_memory_52e6

    STAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))

; Turn the SELECT LED on/off based on patch index.
    ONI         A,00001000b                         ; Skip if A & ? != 0.
    JMP         led_2_select_off_4cb6
    JMP         led_2_select_on_4cb1

_tone_mix_active_4fd2:
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,(~PATCH_FLAGS_MODIFIED & 0FFh)
    XRI         A,00001000b
    JRE         patch_send_midi_prog_change_and_load_4f2a

; =============================================================================
input_compare_4fda:
    CALL        button_check_write_5000
    RET

; Test if current patch modified.
    LDAW        (V_OFFSET(patch_index_8026))
    OFFI        A,PATCH_FLAGS_MODIFIED         ; Skip if ((V.wa) & byte = 0)
    JR          _patch_modified_4ff3

; Patch not modified.
    CALL        MAYBE_patch_compare_restore_4eb3
    CALL        voice_update_vibrato_4db0

    EQIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    CALL        ui_print_patch_or_tone_mix_5537
    CALL        led_3_all_off_4d09
    RET

_patch_modified_4ff3:
    ANI         A,(~PATCH_FLAGS_MODIFIED & 0FFh)
    CALL        patch_load_validate_flags_4e90
    RET

; =============================================================================
; Seems to test if patch index in 08026h is modified.
; If so, stores index in 08008h.
; =============================================================================
UNKNOWN_patch_compare_4ff9:
    LDAW        (V_OFFSET(patch_index_8026))

; Update this patch index if the patch is modified.
    OFFI        A,PATCH_FLAGS_MODIFIED              ; Skip if ((V.wa) & byte = 0)
    STAW        (V_OFFSET(patch_index_compare_8008))

    RET

; =============================================================================
; Skips on return if write button inactive.
; =============================================================================
button_check_write_5000:
    LXI         HL,0A08h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_protect_5003:
    LXI         HL,0a20h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_p_5006:
    LXI         HL,0a80h
    LXI         HL,0c02h
    LXI         HL,0c01h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_initialise_500f:
    LXI         HL,0E01h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_env_step_up_5012:
    LXI         HL,0c20h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_env_step_down_5015:
    LXI         HL,0c10h

; =============================================================================
; Skips on return if cartridge not inserted.
; =============================================================================
button_check_pack_detect_5018:
    LXI         HL,0D01h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_tune_up_501b:
    LXI         HL,0f20h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_tune_down_501e:
    LXI         HL,0f10h

; =============================================================================
; Skips on return if button inactive.
; =============================================================================
button_check_apo_5021:
    LXI         HL,0f40h

; =============================================================================
; Unused line according to service manual.
; From Devin Acker's CZ101 MAME Driver cz101.cpp:
;  Unused input matrix bits:
;  Bit 7 of KC15 is normally unused, but if pulled low using a diode, then
;  bits 2-5 of KC8 (also normally unused) become DIP switches that override
;  the normal MIDI "basic channel" setting from the front panel (possibly
;  planned for use on a screenless MIDI module).
;
; Skips on return if button inactive.
; =============================================================================
button_check_midi_channel_override_5024:
    LXI         HL,0F80h
    LXI         EA,switch_states_8134

; A = H * 3 * 2.
    MOV         A,H
    ADD         A,H
    ADD         A,H
    SLL         A

; DE = EA(08134h) + A
    EADD        EA,A
    DMOV        DE,EA
    LDAX        (DE)
    OFFA        A,L ; Skip if A & L = 0.
    RET
    RETS

; =============================================================================
line_select_UNKNOWN_5039:
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d

; Is Solo Mode enabled?
    BIT         FLAGS_8031_SOLO_MODE_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JR          _solo_mode_disabled_5055

; Solo Mode enabled.
    CALL        UNKNOWN_solo_mode_patch_load_41f5

LAB_5042:
    CALL        UNKNOWN_block_copies_patch_into_edit_buffer_5039
    CALL        initialise_channel_info_5094
    CALL        FUN_50e3
    CALL        patch_update_leds_based_on_patch_4c9c
    CALL        led_4_set_line_select_leds_from_pflags_4d4a
    CALL        led_4_set_ring_noise_leds_based_on_waveform_4d26
    RET

_solo_mode_disabled_5055:
    CALL        UNKNOWN_patch_load_41d8
    JR          LAB_5042

; =============================================================================
UNKNOWN_block_copies_patch_into_edit_buffer_5039:
    PUSH        HL
    LXI         DE,patch_buffer_edit_8300
    LDAW        (V_OFFSET(patch_index_8026))
    CALL        patch_get_pointer_to_index_5072
    DMOV        HL,EA
    MVI         C,7Fh
    BLOCK
    LXI         DE,patch_buffer_edit_8300

; Updates pflags?
    LDAX        (DE)
    PUSH        V
    CALL        channel_get_selected_solo_channel_pflags_pointer_4d6f
    POP         V
    STAX        (BC)
    POP         HL
    RET

; =============================================================================
; Is this gtting an offset to a patch buffer?
;
; A: Patch index?
;
; Returns pointer in EA?
; =============================================================================
patch_get_pointer_to_index_5072:
    OFFI        A,PATCH_FLAGS_MODIFIED              ; Skip if A & 80h == 0.
    JR          _patch_modified_5088

    OFFI        A,PATCH_FLAGS_CARTRIDGE             ; Skip if A & 40h == 0.
    JR          _patch_in_cartridge_508c

    OFFI        A,PATCH_FLAGS_INTERNAL              ; Skip if A & 20h == 0.
    JR          _patch_internal_5090

    LXI         EA,patch_rom_preset_6000

_get_patch_offset_507e:
; Create the offset to the selected patch index.
; Mask the patch number (0-15), and loop to get the offset to this patch.
    ANI         A,00001111b
    MVI         B,80h

_get_offset_loop_5082:
    SUINB       A,1
    RET

    EADD        EA,B
    JR          _get_offset_loop_5082

_patch_modified_5088:
    LXI         EA,patch_buffer_compare_8380
    RET

_patch_in_cartridge_508c:
    LXI         EA,cartridge_memory_9000
    JR          _get_patch_offset_507e

_patch_internal_5090:
    LXI         EA,patch_buffer_internal_8800
    JR          _get_patch_offset_507e

; =============================================================================
; Arguments:
; HL: Pointer to channel info.
; =============================================================================
initialise_channel_info_5094:
    CALL        resets_channel_flags_UNKNOWN_50a1
    CALL        UNKNOWN_writes_voice_index_to_hl_plus_1_50be
    CALL        channel_init_note_count_and_flags_50da
    CALL        MAYBE_voice_clears_data_in_voice_info_41b3
    RET

; =============================================================================
; This seems to set some channel flags based on various other flags...
;
; Arguments:
; HL: Pointer to channel info?
; =============================================================================
resets_channel_flags_UNKNOWN_50a1:
; Load channel flags pointer into BC.
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
; Load channel flags into B.
    LDAX        (BC)
    MOV         B,A

; Load channel info into A.
    LDAX        (HL)

    ANI         A,11111000b
    ORI         A,CHANNEL_INFO_FLAGS_80

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    ORI         A,CHANNEL_INFO_FLAGS_SOLO

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX
    ORI         A,CHANNEL_INFO_FLAGS_TONE_MIX

    OFFI        B,CHANNEL_FLAGS_PORTA
    ORI         A,CHANNEL_INFO_FLAGS_PORTA
    STAX        (HL)
    RET

; =============================================================================
; HL: Pointer to voice info?
; =============================================================================
UNKNOWN_writes_voice_index_to_hl_plus_1_50be:
    CALL        channel_get_index_from_pointer_to_info_50c7
    MOV         A,D

    SLL         A
    ADI         A,090h
    STAX        (HL+1)
    RET

; =============================================================================
; @COMPLETE
; Gets the channel index from a pointer to the channel info table.
;
; HL: Pointer to the current channel's info.
;
; Returns:
; D: Channel index.
; =============================================================================
channel_get_index_from_pointer_to_info_50c7:
    LXI         EA,channel_info_0_8100
    MVI         A,0Bh
    MVI         C,0

_find_channel_index_loop_50ce:
    DNE         EA,HL                               ; Skip if EA !== HL.
    JRE         _exit_50d7

    EADD        EA,A
    INR         C
    JR          _find_channel_index_loop_50ce

    RET

_exit_50d7:
    MOV         A,C
    MOV         D,A
    RET

; =============================================================================
; Arguments:
; HL: Pointer to channel info.
; =============================================================================
channel_init_note_count_and_flags_50da:
    LDAX        (HL)
    ANI         A,0F7h
    STAX        (HL)
    MVI         A,0
    STAX        (HL+CHANNEL_INFO_NOTE_COUNT)
    RET

; =============================================================================
FUN_50e3:
    PUSH        HL
    CALL        voice_update_solo_voice_patch_index_4f02

; Is Solo Mode Enabled?
; Skip if bit is high.
    BIT         FLAGS_8031_SOLO_MODE_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JR          _solo_mode_disabled_50ee

; Solo Mode.
    CALL        UNKNOWN_solo_mode_7620
    JR          _exit_50f8

_solo_mode_disabled_50ee:
; Is Tone Mix Enabled?
    BIT         FLAGS_8031_TONE_MIX_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JR          LAB_50f5

; Tone Mix Enabled.
    CALL        UNKNOWN_tone_mix_7646
    JR          _exit_50f8

LAB_50f5:
    CALL        FUN_7648

_exit_50f8:
    POP         HL
    RET

; =============================================================================
input_solo_50fa:
    CALL        button_check_write_5000 ; Skips on return if button inactive.
    RET

; Write button inactive.
    LXI         HL,channel_info_0_8100

; Load flags,
; Disable Tone Mix.
    LDAW        (V_OFFSET(UNKNOWN_flags_8031))
    ANI         A,~FLAGS_8031_TONE_MIX

; Toggle Solo Mode, and store.
    XRI         A,FLAGS_8031_SOLO_MODE
    STAW        (V_OFFSET(UNKNOWN_flags_8031))

    MVIW        (V_OFFSET(midi_solo_max_voice_index_8035)),3

; =============================================================================
midi_process_mode_change_poly_unknown_UNKNOWN_510c:
    CALL        UNKNOWN_patch_load_41d8
    CALL        initialise_channel_info_5094

; Test if solo mode now enabled.
; i.e. Moving from Poly to Solo mode.
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    JRE         midi_process_mode_change_poly_now_enabled_51ea

; Solo Mode now enabled.
    MVIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),0
    CALL        led_1_tone_mix_off_solo_on_4cdf
    CALL        midi_solo_mode_voice_switch_512d

; If already on the MIDI screen, reset the screen and cursor.
    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI
    JMP         ui_midi_solo_reset_cursor_57ac

    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_TONE_MIX
    CALL        ui_print_patch_or_tone_mix_5537
    RET

; =============================================================================
midi_solo_mode_voice_switch_512d:
; Test which voice is currently selected.
    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),0   ; Skip if ((V.wa)=byte)
    CALL        midi_solo_mode_voice_switch_0_5146

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),1
    CALL        midi_solo_mode_voice_switch_1_5149

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),2
    CALL        midi_solo_mode_voice_switch_2_514c

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),3
    CALL        midi_solo_mode_voice_switch_3_514f

    RET

midi_solo_mode_voice_switch_0_5146:
    LXI         HL,channel_info_0_8100

midi_solo_mode_voice_switch_1_5149:
    LXI         HL,channel_info_1_810b

midi_solo_mode_voice_switch_2_514c:
    LXI         HL,channel_info_2_8116

; =============================================================================
midi_solo_mode_voice_switch_3_514f:
    LXI         HL,channel_info_3_8121
    CALL        UNKNOWN_solo_mode_patch_load_41f5
    CALL        initialise_channel_info_5094
    CALL        solo_voice_load_UNKNOWN_517e
    CALL        UNKNOWN_midi_portamento_519b
    CALL        FUN_51d7
    RET

; =============================================================================
midi_sysex_UNKNOWN_voice_0_5162:
    LXI         HL,channel_info_0_8100

; =============================================================================
midi_sysex_UNKNOWN_voice_1_5165:
    LXI         HL,channel_info_1_810b

; =============================================================================
midi_sysex_UNKNOWN_voice_2_5168:
    LXI         HL,channel_info_2_8116

; =============================================================================
midi_sysex_UNKNOWN_voice_3_516b:
    LXI         HL,channel_info_3_8121

; =============================================================================
UNKNOWN_midi_solo_voice_516e:
    CALL        UNKNOWN_solo_mode_patch_load_41f5
    CALL        initialise_channel_info_5094
    CALL        solo_voice_load_UNKNOWN_517e
    CALL        UNKNOWN_midi_portamento_519b
    CALL        vibrato_on_51ae
    RET

; =============================================================================
solo_voice_load_UNKNOWN_517e:
    PUSH        HL
    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    LDAX        (BC)
    ONI         A,10000000b                         ; Skip if A & 80h !== 0.
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    STAX        (BC)
    PUSH        V
    CALL        FUN_761b
    POP         V
    CALL        patch_get_pointer_to_index_5072
    DMOV        HL,EA
    LDAX        (HL)
    POP         HL
    PUSH        V
    CALL        channel_get_pflags_ptr_from_info_ptr_4d69
    POP         V
    STAX        (BC)
    RET

; =============================================================================
UNKNOWN_midi_portamento_519b:
    PUSH        HL
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
    LDAX        (BC)
    OFFI        A,CHANNEL_FLAGS_PORTA                 ; Skip if (A & byte == 0)
    JRE         _porta_active_51a9

    CALL        UNKNOWN_porta_off_7931
    POP         HL
    RET

_porta_active_51a9:
    CALL        UNKNOWN_porta_on_7931
    POP         HL
    RET

; =============================================================================
vibrato_on_51ae:
    PUSH        HL
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
    PUSH        BC
    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    PUSH        DE
    LDAX        (BC)
    CALL        patch_get_pointer_to_index_5072
    DMOV        HL,EA
    CALL        patch_get_lfo_depth_from_patch_buffer_in_h_4e10
    JRE         LAB_51cc

    POP         DE
    POP         BC
    LDAX        (BC)
    ORI         A,010h
    STAX        (BC)
    CALL        FUN_7971
    POP         HL
    RET

LAB_51cc:
    POP         DE
    POP         BC
    LDAX        (BC)
    ANI         A,0EFh
    STAX        (BC)
    CALL        voice_vibrato_on_off_UNKNOWN_0_7976
    POP         HL
    RET

; =============================================================================
FUN_51d7:
    PUSH        HL
    CALL        channel_get_flags_ptr_from_info_ptr_4d63
    LDAX        (BC)
    OFFI        A,010h
    JRE         LAB_51e5

    CALL        voice_vibrato_on_off_UNKNOWN_0_7976
    POP         HL
    RET

LAB_51e5:
    CALL        FUN_7971
    POP         HL
    RET

; =============================================================================
; Called when POLY mode now enabled.
; i.e. Changed from SOLO mode to POLY mode.
; =============================================================================
midi_process_mode_change_poly_now_enabled_51ea:
    CALL        led_1_solo_off_4ccd

; A = Current_Solo_Voice.
; Current_Solo_Voice = 0.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    PUSH        V
    MVIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),0

    CALL        patch_UNKNOWN_4eaa
    CALL        input_solo_4e17
    CALL        channel_get_current_solo_midi_channel_flags_and_UNKNOWN_4d9e

    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    JRE         LAB_5208

    POP         V
    EQI         A,0
    CALL        ui_print_patch_or_tone_mix_5537
    RET

LAB_5208:
    POP         V
    CALL        ui_midi_basic_reset_cursor_577e
    RET

; =============================================================================
; Arguments:
; A:  Patch index.
; HL: Pointer to selected solo mode voice info.
; =============================================================================
midi_prog_change_solo_voice_520d:
    PUSH        V
; Get a pointer in BC to the index of the solo voice pointed to by HL.
    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    POP         V

; Test whether the selected voice already has the specified patch selected.
; If so, exit.
    NEAX        (BC)                                ; Skip if EA != *(BC).
    RET

    STAX        (BC)
    CALL        UNKNOWN_midi_solo_voice_516e
    RET

; =============================================================================
called_when_selected_solo_voice_updated_521a:
    CALL        channel_get_info_table_ptr_for_selected_solo_voice_479d
    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    LDAX        (BC)
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    CALL        patch_load_update_indexes_4eb7
    CALL        led_3_all_off_4d09
    CALL        channel_get_current_solo_midi_channel_flags_and_UNKNOWN_4d9e
    CALL        input_solo_4e17
    RET

; =============================================================================
reset_solo_mode_selected_voice_modified_UNKNOWN_5231:
    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),0
    CALL        reset_solo_mode_selected_voice_modified_0_524a

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),1
    CALL        reset_solo_mode_selected_voice_modified_1_524d

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),2
    CALL        reset_solo_mode_selected_voice_modified_2_5250

    EQIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),3
    CALL        reset_solo_mode_selected_voice_modified_3_5253
    RET

; =============================================================================
reset_solo_mode_selected_voice_modified_0_524a:
    LXI         HL,channel_info_0_8100

; =============================================================================
reset_solo_mode_selected_voice_modified_1_524d:
    LXI         HL,channel_info_1_810b

; =============================================================================
reset_solo_mode_selected_voice_modified_2_5250:
    LXI         HL,channel_info_2_8116

; =============================================================================
reset_solo_mode_selected_voice_modified_3_5253:
    LXI         HL,channel_info_3_8121

    CALL        channel_get_ptr_to_solo_mode_patch_index_4d8d
    LDAX        (BC)

; Exit if patch not modified?
    ONI         A,PATCH_FLAGS_MODIFIED              ; Skip if A & 0x80 != 0.
    RET

; Clear the modified flag bit.
    ANI         A,(~PATCH_FLAGS_MODIFIED & 0FFh)
    STAX        (BC)

    OFFIW       (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    CALL        UNKNOWN_midi_solo_voice_516e
    RET

; =============================================================================
input_tone_mix_5267:
; Test if write button active. Return early if so.
    CALL        button_check_write_5000
    RET

; Write button inactive.
    LXI         HL,channel_info_0_8100

; Disable solo mode, and toggle tone mix.
    LDAW        (V_OFFSET(UNKNOWN_flags_8031))
    ANI         A,~FLAGS_8031_SOLO_MODE
    XRI         A,FLAGS_8031_TONE_MIX
    STAW        (V_OFFSET(UNKNOWN_flags_8031))

; =============================================================================
patch_tone_mix_UNKNOWN_5276:
; Skip if A & ? != 0.
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_TONE_MIX
    JRE         _tone_mix_disabled_5295

    CALL        led_1_tone_mix_on_solo_off_4cdb
    MVIW        (V_OFFSET(currently_selected_solo_midi_channel_8025)),0
    CALL        patch_UNKNOWN_4eaa
    CALL        channel_get_current_solo_midi_channel_flags_and_UNKNOWN_4d9e
    CALL        input_solo_4e17
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    CALL        patch_load_validate_flags_UNKNOWN_42a4
    STAW        (V_OFFSET(patch_index_tone_mix_8007))
    CALL        patch_load_tone_mix_UNKNOWN_4f32
    RET

_tone_mix_disabled_5295:
    CALL        led_1_tone_mix_off_4ccf
    CALL        UNKNOWN_patch_4ea3
    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_TONE_MIX
    CALL        ui_print_patch_or_tone_mix_5537
    RET

; Unreachable.
    RET

; =============================================================================
input_write_52a3:
    MVIW        (V_OFFSET(write_button_currently_pressed_8021)),1
    MVI         A,0
    STAW        (V_OFFSET(MAYBE_patch_index_save_8028))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    CALL        led_write_button_pressed_4ca3
    CALL        led_3_all_off_4d09

; Check if write protect enabled.
; Skips on return if protect switch inactive.
    CALL        button_check_protect_5003
    JMP         prints_str_protect_switch_5732
    JMP         ui_set_screen_write_save_select_and_print_save_memory_5739

; =============================================================================
input_released_write_52bb:
    MVIW        (V_OFFSET(write_button_currently_pressed_8021)),0
    LDAW        (V_OFFSET(patch_index_8026))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))
    CALL        ui_print_patch_or_tone_mix_5537
    CALL        patch_update_leds_based_on_patch_4c9c
    RET

; =============================================================================
input_unknown_52c9:
; Test if the 'Write' button is pressed.
; Skips if the button is INACTIVE.
    CALL        button_check_write_5000
    JR          _write_button_pressed_52ce

    RET

_write_button_pressed_52ce:
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))
    RET
    CALL        prints_str_protect_switch_5732

LAB_52d4:
    CALL        led_write_button_pressed_4ca3
    CALL        led_2_select_off_4cb6
    MVIW        (V_OFFSET(MAYBE_patch_index_save_8028)),0
    RET

; =============================================================================
input_released_unknown_52de:
; Test if the 'Write' button is pressed.
; Skips if the button is INACTIVE.
    CALL        button_check_write_5000
    JR          _write_button_pressed_52e3

    RET

_write_button_pressed_52e3:
    BIT         0,(V_OFFSET(write_button_currently_pressed_8021))
    RET

print_string_write_select_memory_52e6:
    CALL        ui_set_screen_write_save_select_and_print_save_memory_5739
    JRE         LAB_52d4

; =============================================================================
UNKNOWN_called_when_patch_value_modified_0_52eb:
    MVI         A,0

; =============================================================================
UNKNOWN_called_when_patch_value_modified_1_52ed:
    MVI         A,1
    STAW        (V_OFFSET(ui_flag_set_when_editing_8024))
    CALL        patch_copy_from_edit_to_compare_531c

; Update patch flags.
    LDAW        (V_OFFSET(patch_index_8026))
    ORI         A,PATCH_FLAGS_MODIFIED

    STAW        (V_OFFSET(patch_index_8026))
    STAW        (V_OFFSET(patch_index_compare_8008))
    STAW        (V_OFFSET(UNKNOWN_patch_index_8027))

    CALL        patch_update_leds_based_on_patch_4c9c
    CALL        led_4_set_line_select_leds_from_pflags_4d4a
    CALL        led_4_set_ring_noise_leds_based_on_waveform_4d26

    EQIW        (V_OFFSET(ui_flag_set_when_editing_8024)),0
    JR          LAB_5318

; Flag is 0:
; Skips on return if:
; - Line select 2, and DCO1/DCW1/DCA1 screen active.
; - Line select 1, and DCO2/DCW2/DCA2 screen active.
; - Line select 1+2, and DCO2/DCW2/DCA2 screen active.
    CALL        skips_on_return_based_on_ui_screen_and_line_select_2185
    CALL        MAYBE_patch_compare_restore_4eb3

_exit_5311:
    CALL        reset_solo_mode_selected_voice_modified_UNKNOWN_5231
    MVIW        (V_OFFSET(ui_flag_set_when_editing_8024)),0
    RET

LAB_5318:
    CALL        FUN_50e3
    JR          _exit_5311

; =============================================================================
patch_copy_from_edit_to_compare_531c:
    LXI         HL,patch_buffer_edit_8300
    LXI         DE,patch_buffer_compare_8380
    MVI         C,7Fh
    BLOCK
    RET

; =============================================================================
lcd_update_5326:
    CALL        lcd_write_instruction_blink_off_cursor_off_53c2
    LXI         HL,lcd_contents_line_1_81b4
    MVI         A,0
    CALL        lcd_write_instruction_set_ddram_address_53da
    MVI         E,31

_write_character_5333:
    LDAX        (HL+)
    CALL        lcd_write_data_5373
    SUI         E,1
    SKN         CY
    RET

; Test if the subtraction has moved below 16?
    SK          HC
    JR          _write_character_5333

; Move to line 2.
    MVI         A,40h
    CALL        lcd_write_instruction_set_ddram_address_53da
    JR          _write_character_5333

; =============================================================================
lcd_update_set_cursor_off_blink_off_5346:
    CALL        lcd_update_5326
    CALL        lcd_write_instruction_blink_off_cursor_off_53c2
    RET

; =============================================================================
lcd_update_set_cursor_off_blink_off_and_update_cursor_534d:
    CALL        lcd_update_set_cursor_off_blink_off_5346
    CALL        lcd_set_cursor_5415
    RET

; =============================================================================
lcd_write_instruction_5354:
    CALL        lcd_wait_for_ready_537e

; E = HIGH
; RW = LOW = Write
; RS = LOW = Instruction
    ANI         PC,10011111b

; =============================================================================
lcd_write_byte_535a:
    ORI         PC,10000000b
    MOV         PA,A
    MVI         A,0
    ANI         PC,01111111b

; Set Port A mode?
    MOV         MA,A
    MOV         MA,A
    ORI         PC,10000000b
    MVI         A,0FFh

; Set R/W back to Read.
    ORI         PC,11100000b
    MOV         MA,A
    RET

; =============================================================================
lcd_write_data_5373:
    CALL        lcd_wait_for_ready_537e

; Prepare to write data byte.
; E = HIGH.
; R/W = LOW = Write.
; RS = HIGH = Data.
    ORI         PC,10100000b
    ANI         PC,10111111b
    JRE         lcd_write_byte_535a

; =============================================================================
lcd_wait_for_ready_537e:
    PUSH        V
    MVI         A,0FFh
    MOV         MA,A

; E = HIGH.
; R/W = HIGH = Read.
; RS = LOW = Instruction register (Read busy flag)
    ORI         PC,11000000b
    ANI         PC,11011111b
    ANI         PC,01111111b

; Test twice for ready?
    OFFI        PA,10000000b
    JR          delay

    OFFI        PA,10000000b
    JR          delay

exit_5394:
    POP         V

; E = HIGH.
; R/W = HIGH.
; RS = HIGH.
    ORI         PC,10000000b
    ORI         PC,11100000b
    RET
delay:
    MVI         A,0Fh
_delay_loop_539e:
    DCR         A
    JR          _delay_loop_539e

    JR          exit_5394

; =============================================================================
; @TODO
; =============================================================================
lcd_load_cgram_data_53a1:
    MVI         A,0
    CALL        lcd_write_instruction_set_cgram_address_53ce
    LXI         DE,lcd_cgrom_data_58c7
    MVI         C,63

_load_cgdata_loop_53ab:
    LDAX        (DE+)
    CALL        lcd_write_data_5373
    DCR         C
    JR          _load_cgdata_loop_53ab

    RET

; =============================================================================
lcd_write_instruction_clear_53b2:
    MVI         A,00000001b

; =============================================================================
; Unused?
; =============================================================================
lcd_write_instruction_return_home_53b4:
    MVI         A,00000010b

; =============================================================================
lcd_write_instruction_entry_mode_set_53b6:
    MVI         A,00000110b

; =============================================================================
; Unused?
; =============================================================================
lcd_write_instruction_dispay_shift_53b8:
    MVI         A,00010100b

; =============================================================================
lcd_write_instruction_data_length_lines_53ba:
    MVI         A,00111000b
    JRE         lcd_write_instruction_5354

; =============================================================================
lcd_set_write_position_blink_off_cursor_on_53be:
    CALL        lcd_set_write_position_53d4
    JR          lcd_write_instruction_blink_off_cursor_on_53c6

; =============================================================================
lcd_write_instruction_blink_off_cursor_off_53c2:
    MVI         A,00001100b

; =============================================================================
; Unused?
; =============================================================================
lcd_write_instruction_blink_on_cursor_off_53c4:
    MVI         A,00001101b

; =============================================================================
lcd_write_instruction_blink_off_cursor_on_53c6:
    MVI         A,00001110b

; =============================================================================
; Unused?
; =============================================================================
lcd_write_instruction_blink_on_cursor_on_53c8:
    MVI         A,00001111b

; =============================================================================
lcd_write_instruction_display_off_53ca:
    MVI         A,00001000b
    JRE         lcd_write_instruction_5354

; =============================================================================
; A: CGRAM Address.
; =============================================================================
lcd_write_instruction_set_cgram_address_53ce:
    ANI         A,00111111b
    ORI         A,01000000b
    JRE         lcd_write_instruction_5354

; =============================================================================
; A: Cursor Position in LCD buffer (0-31).
; =============================================================================
lcd_set_write_position_53d4:
    ANI         A,00011111b

; Does this move the cursor to the proper line 2 position
; if the parameter position in A >= 32?
    OFFI        A,00010000b                         ; Skip if A & 0b10000 == 0.
    XRI         A,01010000b

; =============================================================================
;  A = Position.
; =============================================================================
lcd_write_instruction_set_ddram_address_53da:
    ORI         A,10000000b
    JRE         lcd_write_instruction_5354

; =============================================================================
lcd_clear_buffer_and_copy_2_lines_53de:
    CALL        lcd_clear_buffer_and_load_cursor_indexes_549e
    MVI         C,31

; =============================================================================
lcd_copy_string_to_lcd_buffer_53e3:
    LXI         DE,lcd_contents_line_1_81b4

; =============================================================================
lcd_string_copy_53e6:
    CALL        lcd_string_copy_54e6
    RET

; =============================================================================
lcd_copy_2_lines_set_cursor_off_blink_off_53ea:
    CALL        lcd_clear_buffer_and_copy_2_lines_53de
    JRE         lcd_update_set_cursor_off_blink_off_5346

; =============================================================================
lcd_clear_buffer_and_copy_string_53ef:
    CALL        lcd_clear_buffer_and_load_cursor_indexes_549e
    MVI         C,0Fh
    JR          lcd_copy_string_to_lcd_buffer_53e3

; =============================================================================
; HL = Pointer to string.
; =============================================================================
lcd_copy_string_line_2_53f5:
    CALL        lcd_load_cursor_indexes_54b6
    MVI         C,0Fh
    LXI         DE,lcd_contents_line_2_81c4
    JR          lcd_string_copy_53e6

; =============================================================================
; HL = String to print to line 1?
; DE = String to print to line 2?
; =============================================================================
lcd_print_2_lines_53fe:
    PUSH        DE
    CALL        lcd_clear_buffer_and_copy_string_53ef
    POP         HL
    JR          lcd_copy_string_line_2_53f5

; =============================================================================
lcd_print_2_line_string_set_cursor_off_blink_off_5404:
    CALL        lcd_print_2_lines_53fe
    JRE         lcd_update_set_cursor_off_blink_off_5346

    MVI         A,0
    MVI         A,1
    MVI         A,2
    MVI         A,3
    MOV         (ui_cursor_index_8055),A

; =============================================================================
; Seems to return some kind of offset into the LCD buffer in A.
; Returns something else in B...
; =============================================================================
lcd_set_cursor_5415:
    LXI         HL,lcd_cursor_index_positions_81a2
    CALL        lcd_get_cursor_index_5502
    LDAX        (HL+A)

; Skips on return if the cursor should be enabled.
    CALL        ui_should_cursor_be_enabled_5497
    RET

; Cursor position is still in A?
    JRE         lcd_set_write_position_blink_off_cursor_on_53be

; =============================================================================
lcd_print_number_position_0_5422:
    MVI         A,0

; =============================================================================
lcd_print_number_position_1_5424:
    MVI         A,1
    MVI         A,2
    MVI         A,3
    JR          lcd_print_number_5436

; =============================================================================
; C = Char?
; =============================================================================
lcd_print_number_cursor_position_0_542b:
    MVI         A,0

; =============================================================================
lcd_print_number_cursor_position_1_542d:
    MVI         A,1

; =============================================================================
lcd_print_number_cursor_position_2_542f:
    MVI         A,2
    MVI         A,3

; =============================================================================
; @TODO
; =============================================================================
lcd_load_cursor_position_and_print_number_5433:
    LXI         HL,lcd_cursor_index_positions_81a2

; =============================================================================
; A:  Cursor index?
; HL: Pointer to LCD cursor position buffer.
; BC: The number to print as two ASCII characters.
; DE: ???
; =============================================================================
lcd_print_number_5436:
    LXI         HL,lcd_print_number_indexes_81a9

; Store ASCII values?
; What's the purpose of saving DE here?
; Is DE the 3rd/4th char?
; This value is directly after the print number ASCII var.
    SBCD        (lcd_print_number_ascii_81b0)
    SDED        (lcd_print_number_ascii_2_81b2)

; Load the print number offset?
    LDAX        (HL+A)

; Split A into two fields:
;  A = 0b00011111 = ???
;  C = 0b11100000 = ???
    MOV         C,A
    ANI         A,00011111b
    RLL         C
    RLL         C
    RLL         C
    RLL         C
    ANI         C,00000111b

; If C >= 6, add one to A?
    LTI         C,6                                 ; Skip next if C < 6.
    ADI         A,1
    ANI         C,00000011b

; Subtract C from the index?
    SUB         A,C
    LXI         EA,lcd_contents_line_1_81b4
    EADD        EA,A

    DMOV        DE,EA
    LXI         HL,lcd_print_number_ascii_81b0
    BLOCK

    RET

; =============================================================================
lcd_print_number_0_5465:
    MVI         A,0
    MVI         A,1
    MVI         A,2
    MVI         A,3
    CALL        lcd_print_number_5436

; =============================================================================
lcd_reset_and_update_5470:
    CALL        lcd_update_set_cursor_off_blink_off_and_update_cursor_534d
    RET

; =============================================================================
lcd_print_number_to_cursor_position_0_and_update_5474:
    MVI         A,0

; =============================================================================
lcd_print_number_to_cursor_position_1_and_update_5476:
    MVI         A,1

; =============================================================================
lcd_print_number_to_cursor_position_2_and_update_5478:
    MVI         A,2

; =============================================================================
lcd_print_number_to_cursor_position_3_and_update_547a:
    MVI         A,3

; =============================================================================
lcd_print_number_to_cursor_position_and_update_547c:
    CALL        lcd_load_cursor_position_and_print_number_5433
    JR          lcd_reset_and_update_5470

; Unreachable code?
    DB          40h
    DB          094h
    DB          054h
    DB          0B8h
    DB          60h
    DB          0BAh
    DB          0B8h
    DB          046h
    DB          001h
    DB          40h
    DB          011h
    DB          054h
    DB          0B9h
    DB          40h
    DB          094h
    DB          054h
    DB          0B8h
    DB          051h
    DB          0F6h
    DB          0B8h
    DB          40h
    DB          002h
    DB          055h

; =============================================================================
; Tests whether there is a valid cursor position?
; Skips on return if there should be a cursor?
; =============================================================================
ui_should_cursor_be_enabled_5497:
    MOV         B,(lcd_cursor_position_count_8053)
    DCR         B                                   ; Skip if B carries.
    RETS
    RET

; =============================================================================
lcd_clear_buffer_and_load_cursor_indexes_549e:
    MVI         A,0
    STAW        (V_OFFSET(lcd_cursor_position_count_8053))
    STAW        (V_OFFSET(lcd_print_number_position_count_8054))
    PUSH        HL
    PUSH        DE
    PUSH        BC
    PUSH        V

; Fill the LCD buffer with ASCII space (020h).
    MVI         A,20h
    LXI         HL,lcd_contents_line_1_81b4
    MVI         C,1Fh

_clear_lcd_buffer_loop_54af:
    STAX        (HL+)
    DCR         C
    JR          _clear_lcd_buffer_loop_54af

    POP         V
    POP         BC
    POP         DE
    POP         HL

; =============================================================================
; Load the cursor indexes contained at the start of a string.
; string[0]:
;   0b00000111 = Number of cursor indexes.
;   0b01110000 = ???
;
;  What follows is one byte each for the cursor indexes...
;
;  HL = Pointer to string.
; =============================================================================
lcd_load_cursor_indexes_54b6:
    LDAX        (HL+)

; Split A into two fields.
; A = 0b00000111 = No. of cursor indexes.
; B = 0b01110000.
    MOV         B,A
    ANI         A,00000111b
    MOV         C,A
    SLR         B
    SLR         B
    SLR         B
    SLR         B
    ANI         B,00000111b

; Set up the cursor indexes.
; Load a pointer to the array of individual indexes into EA.
    LXI         EA,lcd_cursor_index_positions_81a2

; Add the CURRENT number of cursor indexes to the pointer in EA.
; This is done because this method could be copying in the cursor positions for
; the second line of the LCD.
; e.g. If there were 2 indexes before, we're now copying to index 3.
    LDAW        (V_OFFSET(lcd_cursor_position_count_8053))
    EADD        EA,A

; Add A to the current cursor index number and save.
; This is done because line 2 might add additional
; cursor indexes to the number contained in line 1.
    ADD         A,C
    STAW        (V_OFFSET(lcd_cursor_position_count_8053))

; Copy the cursor index data.
    DMOV        DE,EA
    DCR         C
    BLOCK                                           ; Copy C+1 bytes HL -> DE.

; Add the B field to 0x8054, and save.
    LXI         EA,lcd_print_number_indexes_81a9
    LDAW        (V_OFFSET(lcd_print_number_position_count_8054))

; Add the current number to the offset.
; Then add the new number.
    EADD        EA,A
    ADD         A,B
    STAW        (V_OFFSET(lcd_print_number_position_count_8054))

; Copy...
    DMOV        DE,EA
    MOV         A,B
    MOV         C,A
    DCR         C
    BLOCK

; ...
    DMOV        EA,HL
    RET

; =============================================================================
; Copies a string to an arbitrary addess.
;
; Arguments:
;  HL = Pointer to source string.
;  DE = Pointer to destination buffer.
;  C  = Length.
; =============================================================================
lcd_string_copy_54e6:
    DMOV        HL,EA

_copy_char_loop_54e7:
    LDAX        (HL+)

; Test if the character is above 020h (ASCII space).
    OFFI        A,11100000b                         ; Skip if result is zero.
    JR          _store_char_and_increment_54e6

; Test if the current character is a control character.
; These are used to set the destination 'cursor' location
; within the destination string.
    OFFI        A,00010000b ; Skip if A & 010h == 0.
    JR          _set_destination_cursor_location_54f2

_store_char_and_increment_54e6:
    STAX        (DE+)
    DCR         C
    JR          _copy_char_loop_54e7

_exit_54f1:
    RET

_set_destination_cursor_location_54f2:
; 0x1F is used as a terminating character, as this indicates location 32.
    ANI         A,00001111b
    ADI         A,1
    SKN         HC                                  ; Skip if HC == 0.
    JR          _exit_54f1

; Add the location index to the destination pointer:
; Add the number to the lower-half of the destination pointer.
; If it carries, add the carry to the higher-half.
; Subtract A from the character count.
    ADD         E,A

    ACI         D,0
    SUBNB       C,A
    JR          _exit_54f1

    JR          _copy_char_loop_54e7

; =============================================================================
lcd_get_cursor_index_5502:
    MOV         A,(ui_cursor_index_8055)
    RET

; =============================================================================
ui_set_cursor_index_1_5507:
    MVI         A,1
    MVI         A,2
    MVI         A,3

; =============================================================================
ui_reset_cursor_index_550d:
    MVI         A,0
    MOV         (ui_cursor_index_8055),A
    RET

; Unreachable code?
    DB          043h
    DB          000h
    DB          042h
    DB          000h
    DB          074h
    DB          00Bh
    DB          00Fh
    DB          074h
    DB          00Ah
    DB          00Fh
    DB          074h
    DB          01Bh
    DB          30h
    DB          074h
    DB          01Ah
    DB          30h
    DB          0B8h
    DB          0A5h
    DB          00Ah
    DB          01Bh
    DB          009h
    DB          01Ah
    DB          0B8h
    DB          0B1h
    DB          40h
    DB          022h
    DB          054h
    DB          0A1h
    DB          40h
    DB          025h
    DB          055h
    DB          40h
    DB          067h
    DB          054h
    DB          0B8h

; =============================================================================
; Seems to cancel the current screen if the same button
; is pressed twice in succession.
; =============================================================================
ui_print_patch_or_tone_mix_5537:
    CALL        led_3_all_off_4d09

; Is tone mix active?
; Skip if bit 3 is set.
    BIT         FLAGS_8031_TONE_MIX_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JRE         ui_print_patch_5541

    JMP         ui_print_tone_mix_56a6

; =============================================================================
; Prints the patch location string, i.e. "*CARTRIDGE* NO. __"
; Falls-through to print the number.
; =============================================================================
ui_print_patch_5541:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_PATCH_MAYBE

; Load preset number?
    LDAW        (V_OFFSET(UNKNOWN_patch_index_8027))

; Skip if patch index >= 64.
    ONI         A,PATCH_FLAGS_CARTRIDGE
    JRE         _is_patch_internal_554f

; Cartridge patch.
    LXI         HL,str_cartridge
    JRE         _print_patch_5556

_is_patch_internal_554f:
; Skip if patch number >= 32.
    ONI         A,PATCH_FLAGS_INTERNAL
    JRE         ui_print_preset_5568

; Internal patch.
    LXI         HL,str_internal

_print_patch_5556:
    LXI         DE,str_no
    PUSH        V
    CALL        lcd_print_2_lines_53fe
    POP         V
    ANI         A,00001111b
; Falls-through below.

; =============================================================================
; Arguments:
; A: Patch number.
; =============================================================================
lcd_print_patch_number_5560:
    INR         A
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_0_5465
    RET

; =============================================================================
; Prints the name of the currently selected preset.
; =============================================================================
ui_print_preset_5568:
; Mask A so that it contains 0-15.
    ANI         A,00001111b
    PUSH        V

; Shift left so that indexes the pointer table.
    SLL         A
    LXI         HL,pointer_table_preset_names_5587
    LDEAX       (HL+A)
    DMOV        DE,EA
    LXI         HL,str_preset_no
    CALL        lcd_print_2_lines_53fe
    POP         V
    JRE         lcd_print_patch_number_5560

; Unreachable code?
    DB          037h
    DB          00Ah
    DB          054h
    DB          012h
    DB          02Dh
    DB          017h
    DB          30h
    DB          01Ah
    DB          06Bh
    DB          020h
    DB          0B8h

pointer_table_preset_names_5587:
    DW          str_preset_brass_ens
    DW          str_preset_trumpet
    DW          str_preset_violin
    DW          str_preset_string_ens
    DW          string_preset_elec_piano
    DW          string_preset_elec_organ
    DW          str_preset_flute
    DW          str_preset_synth_bass
    DW          str_preset_synth_brass_ens_2
    DW          str_preset_vibraphone
    DW          str_preset_xylophone
    DW          str_preset_synth_strings
    DW          str_preset_fairytale
    DW          str_preset_accordion
    DW          str_preset_whistle
    DW          str_preset_percussion
str_preset_no:
    DB          010h
    DB          02Fh
    DB          " *PRESET*  NO."
    DB          01Fh
str_internal:
    DB          00h
    DB          012h
    DB          "*INTERNAL*"
    DB          01Fh
str_cartridge:
    DB          00h
    DB          012h
    DB          "*CARTRIDGE*"
    DB          01Fh
str_no:
    DB          010h
    DB          039h
    DB          014h
    DB          "NO."
    DB          01Fh
str_preset_brass_ens:
    DB          00h
    DB          012h
    DB          "BRASS ENS.1"
    DB          01Fh
str_preset_trumpet:
    DB          000h
    DB          013h
    DB          "TRUMPET"
    DB          01Fh
str_preset_violin:
    DB          000h
    DB          014h
    DB          "VIOLIN"
    DB          01Fh
str_preset_string_ens:
    DB          000h
    DB          011h
    DB          "STRING ENS.1"
    DB          01Fh
string_preset_elec_piano:
    DB          000h
    DB          012h
    DB          "ELEC.PIANO"
    DB          01Fh
string_preset_elec_organ:
    DB          000h
    DB          012h
    DB          "ELEC.ORGAN"
    DB          01Fh
str_preset_flute:
    DB          000h
    DB          014h
    DB          "FLUTE"
    DB          01Fh
str_preset_synth_bass:
    DB          000h
    DB          012h
    DB          "SYNTH.BASS"
    DB          01Fh
str_preset_synth_brass_ens_2:
    DB          000h
    DB          011h
    DB          "BRASS ENS.2"
    DB          01Fh
str_preset_vibraphone:
    DB          000h
    DB          012h
    DB          "VIBRAPHONE"
    DB          01Fh
str_preset_xylophone:
    DB          000h
    DB          "CRISPY XYLOPHONE"
    DB          01Fh
str_preset_synth_strings:
    DB          000h
    DB          020h
    DB          "SYNTH.STRINGS"
    DB          01Fh
str_preset_fairytale:
    DB          000h
    DB          012h
    DB          "FAIRY TALE"
    DB          01Fh
str_preset_accordion:
    DB          000h
    DB          012h
    DB          "ACCORDION"
    DB          01Fh
str_preset_whistle:
    DB          000h
    DB          013h
    DB          "WHISTLE"
    DB          01Fh
str_preset_percussion:
    DB          000h
    DB          012h
    DB          "PERCUSSION"
    DB          01Fh

; =============================================================================
ui_print_tone_mix_56a6:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_TONE_MIX
    CALL        ui_reset_cursor_index_550d
    LXI         HL,str_tone_mix_level
    CALL        lcd_clear_buffer_and_copy_string_53ef

; Clamp at 1.
    NEIW        (V_OFFSET(tone_mix_UNKNOWN_8006)),0      ; Skip if ((V.wa)≠byte)
    MVIW        (V_OFFSET(tone_mix_UNKNOWN_8006)),1
    LDAW        (V_OFFSET(tone_mix_UNKNOWN_8006))

; Convert the tone-mix level (0-7) to ASCII.
    ORI         A,30h
    MOV         C,A
    CALL        lcd_print_number_cursor_position_0_542b

; Test whether the tone-mix patch is in the cartridge.
    OFFIW       (V_OFFSET(patch_index_tone_mix_8007)),40h
    JR          _tone_mix_patch_is_in_cartridge_56cd

; Test whether the tone-mix patch is a preset, or internal.
    OFFIW       (V_OFFSET(patch_index_tone_mix_8007)),020h
    LXI         HL,str_internal_no
    LXI         HL,str_preset_no_tone_mix

_tone_mix_patch_is_in_cartridge_56cd:
    LXI         HL,str_cartridge_no
    CALL        lcd_copy_string_line_2_53f5

; Load the patch index, clamp at 0-15, increment to index from 1, and print.
    LDAW        (V_OFFSET(patch_index_tone_mix_8007))
    ANI         A,00001111b
    INR         A
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_0_5465
    RET

str_tone_mix_level:
    DB          1h
    DB          0Fh
    DB          "TONE MIX LEVEL="
    DB          01Fh
str_preset_no_tone_mix:
    DB          010h
    DB          03Fh
    DB          013h
    DB          "PRESET NO."
    DB          01Fh
str_internal_no:
    DB          010h
    DB          03Fh
    DB          011h
    DB          "INTERNAL NO."
    DB          01Fh
str_cartridge_no:
    DB          010h
    DB          03Fh
    DB          020h
    DB          "CARTRIDGE NO."
    DB          01Fh

; =============================================================================
prints_midi_data_full_5720:
    LXI         HL,str_midi_data_full
    MVI         A,UI_SCREEN_19
; Falls-through below.

; =============================================================================
ui_set_screen_and_lcd_print_2_lines_5725:
    STAW        (V_OFFSET(ui_current_screen_8052))
    CALL        lcd_copy_2_lines_set_cursor_off_blink_off_53ea
    RET

; =============================================================================
print_str_not_ready_insert_cartridge_572b:
    LXI         HL,str_not_ready_insert_cartridge
    MVI         A,UI_SCREEN_1E
    JRE         ui_set_screen_and_lcd_print_2_lines_5725

; =============================================================================
prints_str_protect_switch_5732:
    LXI         HL,str_protect_switch_on
    MVI         A,UI_SCREEN_1F
    JRE         ui_set_screen_and_lcd_print_2_lines_5725

; =============================================================================
ui_set_screen_write_save_select_and_print_save_memory_5739:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_WRITE_SAVE_SELECT_MEMORY
    LXI         HL,str_write_save
    LXI         DE,str_select_memory
    CALL        lcd_print_2_line_string_set_cursor_off_blink_off_5404
    RET

; =============================================================================
prints_str_write_save_ok_5746:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_WRITE_SAVE_OK
    LXI         HL,str_write_save

; =============================================================================
ui_print_ok_to_line_2_574c:
    LXI         DE,str_ok
    CALL        lcd_print_2_line_string_set_cursor_off_blink_off_5404
    RET

; =============================================================================
ui_set_screen_write_save_and_print_save_ok_5753:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_WRITE_SAVE
    LXI         HL,str_save
    JRE         ui_print_ok_to_line_2_574c

; =============================================================================
ui_set_screen_write_load_and_print_load_ok_575b:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_WRITE_LOAD
    LXI         HL,str_load
    JRE         ui_print_ok_to_line_2_574c

; =============================================================================
input_midi_5763:
    CALL        button_check_write_5000
    RET
    CALL        led_3_all_off_4d09

; If the current screen is the MIDI screen, print the current patch or
; tone mix information.
    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI
    JMP         ui_print_patch_or_tone_mix_5537

    NEIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    JMP         ui_print_patch_or_tone_mix_5537

; Is solo mode active?
    BIT         FLAGS_8031_SOLO_MODE_BIT,(V_OFFSET(UNKNOWN_flags_8031))
    JMP         ui_midi_basic_reset_cursor_577e

    JMP         ui_midi_solo_reset_cursor_57ac

; =============================================================================
ui_midi_basic_reset_cursor_577e:
    CALL        ui_reset_cursor_index_550d

; =============================================================================
ui_midi_basic_5781:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI
    LXI         HL,str_midi_basic_ch
    LXI         DE,str_prog_change
    CALL        lcd_print_2_lines_53fe

; Load the MIDI channel and mask it to 0-15.
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    ANI         A,00001111b
; Increment to print the number starting from 1.
    INR         A
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_0_542b
    ONIW        (V_OFFSET(midi_prog_change_disabled_8036)),1    ; Skip if A & (V.wa) != 0.
    JR          _prog_change_enabled_57a5

; Program change disabled.
; These hex values correspond to the ASCII values for 'DI' and 'S'.
    LXI         BC,4944h
    MVI         E,53h

_exit_57a1:
    CALL        lcd_print_number_to_cursor_position_1_and_update_5476
    RET

_prog_change_enabled_57a5:
; These hex values correspond to the ASCII values for 'EN' and 'A'.
    LXI         BC,04e45h
    MVI         E,041h
    JRE         _exit_57a1

; =============================================================================
ui_midi_solo_reset_cursor_57ac:
    CALL        ui_reset_cursor_index_550d

; =============================================================================
ui_midi_solo_57af:
    MVIW        (V_OFFSET(ui_current_screen_8052)),UI_SCREEN_MIDI_SOLO_MODE
    LXI         HL,str_midi_ch_vo
    LXI         DE,str_prog_change
    CALL        lcd_print_2_lines_53fe
    LDAW        (V_OFFSET(midi_channel_basic_8000))
    ANI         A,00001111b
    INR         A
    PUSH        V
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_0_542b
    POP         V
    ADDW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    LTI         A,011h
    MVI         A,010h
    CALL        lcd_convert_2_digit_number_to_ascii_2d12
    CALL        lcd_print_number_cursor_position_1_542d
    ONIW        (V_OFFSET(midi_prog_change_disabled_8036)),1
    JRE         _prog_change_enabled_57e3

; Program change disabled.
; 'DI' is 0x44 0x49.
    LXI         BC,04944h
    MVI         E,053h

_print_program_change_setting_57df:
    CALL        lcd_print_number_to_cursor_position_2_and_update_5478
    RET

_prog_change_enabled_57e3:
; 'EN' is 0x45 0x4E.
    LXI         BC,04e45h
    MVI         E,041h
    JRE         _print_program_change_setting_57df

str_midi_basic_ch:
    DB          1h, 02Fh, "MIDI BASIC CH=", 01Fh

str_midi_ch_vo:
    DB          2h, 029h, 02Fh, "MIDI CH=  ,VO=", 01Fh

str_prog_change:
    DB          1h, 05Fh, " PROG CHANGE=", 01Fh

str_midi_data_full:
    DB          00h, 014h, "*MIDI*", 017h, "DATA FULL!", 01Fh

str_select_memory:
    DB          00h, " SELECT MEMORY!", 01Fh

str_not_ready_insert_cartridge:
    DB          00h, "---NOT READY----INSERT CARTRIDGE", 01Fh

str_protect_switch_on:
    DB          00h, " PROTECT SWITCH -------ON-------", 01Fh

str_write_save:
    DB          00h, 014h, "WRITE", 01Fh

str_save:
    DB          00h, 015h, "SAVE", 01Fh

str_load:
    DB          00h, 015h, "LOAD", 01Fh

str_ok:
    DB          00h, 16h, "OK!", 01Fh

; =============================================================================
input_cursor_right_58a2:
    LDAW        (V_OFFSET(lcd_cursor_position_count_8053))
    GTI         A,1                                 ; Skip if (r>byte)
    RET

    MOV         B,(ui_cursor_index_8055)

; Increment, and check if the cursor position is less than the maximum.
; If not, reset to 0.
    INR         B

    LTA         B,A
    MVI         B,0

input_cursor_save_58b0:
    MOV         (ui_cursor_index_8055),B
    CALL        lcd_set_cursor_5415
    RET

; =============================================================================
input_cursor_left_58b8:
; Load the number of cursor positions, and test if more than one.
    LDAW        (V_OFFSET(lcd_cursor_position_count_8053))
    GTI         A,1                                 ; Skip if (r>byte)
    RET

    MOV         B,(ui_cursor_index_8055)

; Check if the cursor position is equal to 0, if so set to the total number,
; and then decrement.
    NEI         B,0                                 ; Skip if (r≠byte)
    MOV         B,A
    DCR         B
    JR          input_cursor_save_58b0

lcd_cgrom_data_58c7:
    DB          0Ah
    DB          01Fh
    DB          0Ah
    DB          01Fh
    DB          0Ah
    DB          00h
    DB          00h
    DB          00h
    DB          08h
    DB          08h
    DB          0Eh
    DB          0Ah
    DB          0Ch
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          00h
    DB          01Ch
    DB          014h
    DB          014h
    DB          015h
    DB          01Dh
    DB          00h
    DB          014h
    DB          018h
    DB          013h
    DB          015h
    DB          017h
    DB          014h
    DB          03h
    DB          00h
    DB          014h
    DB          01Bh
    DB          015h
    DB          017h
    DB          014h
    DB          07h
    DB          00h
    DB          00h
    DB          1h
    DB          1h
    DB          01Dh
    DB          05h
    DB          01Dh
    DB          015h
    DB          01Dh
    DB          00h
    DB          010h
    DB          010h
    DB          010h
    DB          010h
    DB          010h
    DB          011h
    DB          01Dh
    DB          00h
    DB          015h
    DB          015h
    DB          017h
    DB          011h
    DB          01Dh
    DB          015h
    DB          015h
    DB          00h

    DS 1782
    JMP         RST0

patch_rom_preset_6000:
    BINCLUDE "preset_patch_rom.bin"
    DS 1024

    ORG 6c00h
; =============================================================================
; Called on device reset.
; =============================================================================
MAYBE_upd933_reset_6c00:
    PUSH        V
    PUSH        BC
    PUSH        DE
    PUSH        HL
    PUSH        EA
; Save MKL.
    MOV         A,MKL
    PUSH        V

; Mask all interrupts.
    ORI         MKL,0FFh

; Reset all envelopes.
; MSB = 07Fh = Direction Up, Max Rate.
; LSB = 80h = Maximum Level.
    MVIW        (V_OFFSET(upd933_pending_data_80e7 + 1)),7Fh
    MVIW        (V_OFFSET(upd933_pending_data_80e7 + 2)),80h

; Initialise the register address at 00h (DCA).
    LXI         BC,0

_reset_env_loop_6c14:
    MOV         A,C

; Store the register address in 080E7h.
    STAW        (V_OFFSET(upd933_pending_data_80e7))

_reset_env_voice_loop_6c17:
    LXI         HL,upd933_pending_data_80e7
    CALL        upd933_send_data_at_hl_voice_no_in_b_743a
    INR         B
    EQI         B,8                                 ; Skip if B == 08h.
    JR          _reset_env_voice_loop_6c17

; Reset the voice number to 0.
; If C is 0, jump to register 010h (DCO).
    MVI         B,0
    NEI         C,0                                 ; Skip if C != 0.
    JR          _move_to_next_env_MAYBE_6c3a

; If C is 010h, jump to 020h (DCW).
    NEI         C,10h                               ; Skip if C != 010h.
    JR          _move_to_next_env_MAYBE_6c3a

    EQI         C,20h                               ; Skip if C == 020h.
    JR          add_8_6c3f

; If C is 020h, clear 080E8h, and 080E9h,
; skip to register 60h (Pitch).
    MVIW        (V_OFFSET(upd933_pending_data_80e7 + 1)),0
    MVIW        (V_OFFSET(upd933_pending_data_80e7 + 2)),0

; If C was 020h, skip to 60h and restart.
    MVI         C,60h
    JRE         _reset_env_loop_6c14

_move_to_next_env_MAYBE_6c3a:
    ADI         C,10h
    JRE         _reset_env_loop_6c14

add_8_6c3f:
    ADI         C,8
    EQI         C,0C0h                              ; Skip if C == 0c0h.
    JRE         _reset_env_loop_6c14

    MVIW        (V_OFFSET(upd933_pending_data_80e7)),0C0h
    MVIW        (V_OFFSET(upd933_pending_data_80e7 + 1)),28h

    MVI         A,0
    LXI         HL,upd933_pending_data_80e7
    CALL        upd933_send_register_and_data_at_hl_743b

; Reset F2.
    SKIT        F2
    NOP
    DI

; Reset the internal UPD933 data buffers?
    LXI         HL,upd933_data_init_7dfe
    LXI         DE,MAYBE_pitch_bend_increment_80c0
    MVI         C,14
    BLOCK

    CALL        MAYBE_voice_data_reset_6c92
    MVI         B,0FFh
    CALL        voice_resets_8600_array_6d0e
    CALL        reset_adc_check_UNKNOWN_6d3b
    LXI         HL,patch_buffer_edit_8300
    MVI         D,0
    MVIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0FFh
    CALL        voice_UNKNOWN_7656

; 0x80 - pitch bend initial value.
; Skip if no borrow.
    MVI         A,80h
    SUBNBW      (V_OFFSET(pitch_bend_value_initial_80eb))
    NEGA
    STAW        (V_OFFSET(MAYBE_pitch_bend_initial_polarity_80f2))

; If the previous subtraction operation carried, set bit 7.
    SKN         CY
    ORIW        (V_OFFSET(MAYBE_pitch_bend_initial_polarity_80f2)),80h

    MVIW        (V_OFFSET(UNKNOWN_pitch_bend_80f1)),80h

; Restore MKL.
    POP         V
    MOV         MKL,A

    POP         EA
    POP         HL
    POP         DE
    POP         BC
    POP         V
    RET

; =============================================================================
MAYBE_voice_data_reset_6c92:
    LXI         HL,MAYBE_voice_data_8640
    LXI         DE,UNKNOWN_voice_data_pointers_7dde

; Reset voice number to 0 for loop.
    MVIW        (V_OFFSET(MAYBE_voice_number_80d3)),0

_reset_voice_loop_6c9b:
; Store the voice number in HL+0.
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    DW 00BFh   ;    STAX        (HL+00h)

    LDEAX       (DE++)
    STEAX       (HL+VOICE_INFO_8640_1_PTR_TO_OTHER_VOICE)
    LDEAX       (DE++)
    STEAX       (HL+VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE)

    LXI         EA,patch_buffer_edit_8300
    STEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)

    LXI         EA,unknown_voice_data_8600
    STEAX       (HL+VOICE_INFO_8640_7_PTR_TO_8600)

    MVI         A,1Dh
    STAX        (HL+VOICE_INFO_8640_9)
    STAX        (HL+VOICE_INFO_8640_a)
    STAX        (HL+VOICE_INFO_8640_b)
    STAX        (HL+VOICE_INFO_8640_d)

    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_C_WORD)
    STAX        (HL+VOICE_INFO_8640_e)
    STAX        (HL+22h)

    LXI         EA,0
    STEAX       (HL+VOICE_INFO_8640_F_WORD)
    STEAX       (HL+VOICE_INFO_8640_11_FREQUENCY)
    STEAX       (HL+VOICE_INFO_8640_1A_WORD_UNKNOWN)

    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    STAX        (HL+VOICE_INFO_8640_16)

    MVI         C,0

; @NOTE: Load patch buffer edit octave setting into A?
    MOV         A,(patch_buffer_edit_8300)
    ONI         A,2
    JR          LAB_6cf1

    MVI         C,80h
; Skip if A & 1 != 0.
    ONI         A,1
    JR          _store_c_in_hl_plus_15_6cf6

; Skip if voice number is odd.
    ONIW        (V_OFFSET(MAYBE_voice_number_80d3)),1
    JR          _store_c_in_hl_plus_15_6cf6

; Voice number is odd.
    ORI         C,VOICE_INFO_8640_15_40
    JR          _store_c_in_hl_plus_15_6cf6

LAB_6cf1:
    OFFI        A,1
    ORI         C,VOICE_INFO_8640_15_40

_store_c_in_hl_plus_15_6cf6:
    MOV         A,C
    STAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)

    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    STAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    STAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)

; Add 0x28 to L, if it carries, add 1 to H.
    ADINC       L,28h
    ADI         H,1

; Increment the voice number, then check if bit 3 is set, indicating
; that the next voice number after incrementing is 8, indicating
; the process is complete. If so, return.
    INRW        (V_OFFSET(MAYBE_voice_number_80d3))
    BIT         3,(V_OFFSET(MAYBE_voice_number_80d3))
    JRE         _reset_voice_loop_6c9b

    RET

; =============================================================================
; B: Unknown flag. 0xFF on reset, 0 otherwise.
; =============================================================================
voice_resets_8600_array_6d0e:
    LXI         HL,unknown_voice_data_8600

    MVI         C,3
_loop_6d13:
    DW 00AFh   ;    LDAX        (HL+00h)
    EQI         B,0
    JR          LAB_6d1c

; Check if this flag is set, if so, clear it below.
    OFFI        A,VOICE_DATA_8600_0_2
    JR          LAB_6d2d

LAB_6d1c:
    ANI         A,11111110b
    LDEAX       (HL+VOICE_DATA_8600_2)
    STEAX       (HL+VOICE_DATA_8600_8)
    LXI         EA,0
    STEAX       (HL+VOICE_DATA_8600_A)
    STEAX       (HL+VOICE_DATA_8600_C)

LAB_6d2d:
; Clear flag.
    ANI         A,~VOICE_DATA_8600_0_2
    DW 00BFh   ;    STAX        (HL+00h)

; Add 0x10 to move to the next entry.
; Add 1 to H if this carries.
    ADINC       L,10h
    ADI         H,1
    DCR         C
    JRE         _loop_6d13

    RET

; =============================================================================
; Reads all AD channels, and checks the total of the values.
; =============================================================================
reset_adc_check_UNKNOWN_6d3b:
; Save A/D channel mode.
    MOV         A,ANM
    PUSH        V

; Set A/D channel mode to 3.
    MVI         A,3
    MOV         ANM,A

; Save MKH.
    MOV         A,MKH
    PUSH        V

; Clear MKAD bit to unmask INTAD.
    MVI         A,110b
    MOV         MKH,A

; Save MKL.
    MOV         A,MKL
    PUSH        V

    MVI         A,0FFh
    MOV         MKL,A

; Wait until INTAD occurs.
    MVIW        (V_OFFSET(intein_intad_pending_flag_80ea)),1
    EI

_poll_until_intad_occurs_6d54:
    OFFIW       (V_OFFSET(intein_intad_pending_flag_80ea)),1
    JR          _poll_until_intad_occurs_6d54

; Wait until INTAD occurs.
    DI
    MVIW        (V_OFFSET(intein_intad_pending_flag_80ea)),1
    EI

_poll_until_intad_occurs_6d5d:
    OFFIW       (V_OFFSET(intein_intad_pending_flag_80ea)),1
    JR          _poll_until_intad_occurs_6d5d

    DI
    LXI         EA,0

; Read AN0 (Not connected?).
    MOV         A,CR0
    EADD        EA,A
; Read AN1 (Pitch bend).
    MOV         A,CR1
    EADD        EA,A
; Read AN2 (Battery level).
    MOV         A,CR2
    EADD        EA,A
; Read AN3 (Not connected?).
    MOV         A,CR3
    EADD        EA,A

; BC = EA >> 2.
    DSLR        EA
    DSLR        EA
    DMOV        BC,EA

    MOV         A,C
    LTI         A,077h        ; Skip if A < 077h
    JRE         _ad_source_total_above_119_6da2

; Total of the A/D sources is below 119.
LAB_6d7f:
    MVI         A,80h
    MVI         B,09h

LAB_6d83:
    STAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    STAW        (V_OFFSET(pitch_bend_input_80cc))
    STAW        (V_OFFSET(pitch_bend_value_current_80f0))
    STAW        (V_OFFSET(pitch_bend_value_new_80ef))
    ADD         A,B
    STAW        (V_OFFSET(pitch_bend_input_threshold_upper_80ec))
    SUB         A,B
    SUB         A,B
    STAW        (V_OFFSET(pitch_bend_input_threshold_lower_80ed))
    MOV         A,B
    STAW        (V_OFFSET(pitch_bend_input_threshold_range_80ee))

; Exit.
; Restore MKL.
    POP         V
    MOV         MKL,A
; Restore MKH.
    POP         V
    MOV         MKH,A
; Restore A/D channel mode.
    POP         V
    MOV         ANM,A
    RET

_ad_source_total_above_119_6da2:
    GTI         A,089h
    JR          _ad_source_total_less_than_137_6da7

    JRE         LAB_6d7f

_ad_source_total_less_than_137_6da7:
    MVI         B,07h
    JRE         LAB_6d83

; =============================================================================
called_during_irq_6dab:
    DI
    EXA
    EXX
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh
    MOV         A,PB
    ONI         A,10h
    CALL        upd933_check_irq_dca_6dc3
    POP         V
    DI
    MOV         MKL,A
    EXA
    EXX
    EI
    RETI

; =============================================================================
upd933_check_irq_dca_6dc3:
; Read the IRQ data from the UPD933.
; Check whether bit 1 is set, corresponding to an IRQ from the DCA.
    LXI         HL,upd933_c000
    CALL        upd933_read_byte_to_a_from_hl_00f8
    EI
; Skip if carry set after rotate left.
    SLRC        A
    JRE         upd933_check_irq_dcw_6e86

; Mask the voice number.
    ANI         A,111b
; @NOTE: Returns pointer to 0x8640[voice] in HL.
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_1
    RET

; Is this the current DCA env step?
    LDAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    MOV         C,A

; This seems to use 0x8640[voice]+15 to decide whether to load
; the DCA1 or DCA2 envelope step end value.
    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    MVI         B,PATCH_DCA1_ENV_STEP_END

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40
    MVI         B,PATCH_DCA2_ENV_STEP_END

; Load this value into A.
    EADD        EA,B
    DMOV        DE,EA
    LDAX        (DE)

; Does this subtract the current env step from the end?
    SUBNB       C,A
    JRE         irq_dca_update_env_step_maybe_6e73

    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ANI         A,~VOICE_INFO_8640_13_1
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)

    PUSH        HL
    DW 00AFh   ;    LDAX        (HL+00h)
    MOV         B,A
    LXI         HL,upd933_data_dcw_step_MAYBE_6ec5
    CALL        upd933_send_data_at_hl_voice_no_in_b_743a
    CALL        upd933_send_data_at_hl_voice_no_in_b_743a
    POP         HL
    SHLD        (unknown_pointer_80e1)
    SHLD        (unknown_pointer_80e3)

    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_8
    JRE         LAB_6e66

    ANI         A,0F7h
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    LDAX        (HL+9)
    STAX        (HL+0dh)

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          LAB_6e2e

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_13_1
    JRE         LAB_6e66

    DW 00AFh   ;    LDAX        (HL+00h)
    ONI         A,1
    SHLD        (unknown_pointer_80e1)

LAB_6e2e:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_TONE_MIX
    JRE         LAB_6e5e

; Test this voice number?
    LDEAX       (HL+VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE)
    DMOV        HL,EA
    DW 00AFh   ;    LDAX        (HL+00h)
    ONI         A,2
    JR          LAB_6e48

    PUSH        HL
    LDEAX       (HL+VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE)
    DMOV        HL,EA
    SHLD        (unknown_pointer_80e1)
    POP         HL
    JR          LAB_6e4c

LAB_6e48:
    SHLD        (unknown_pointer_80e1)

LAB_6e4c:
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_13_1
    JR          LAB_6e66

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          LAB_6e5e

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_13_1
    JR          LAB_6e66

LAB_6e5e:
    LHLD        (unknown_pointer_80e1)
    CALL        UNKNOWN_upd933_6f5f
    RET

LAB_6e66:
    LHLD        (unknown_pointer_80e3)
    DW 00AFh   ;    LDAX        (HL+00h)
    LXI         HL,upd933_data_UNKNOWN_6ecb
    CALL        upd933_send_register_and_data_at_hl_743b
    RET

; =============================================================================
; HL: 0x8640[voice]
; =============================================================================
irq_dca_update_env_step_maybe_6e73:
    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_1
    JR          _increment_current_env_step_6e7d

    ORI         A,VOICE_INFO_8640_16_DCA_ENV_STEP_FINISHED_MAYBE
    STAX        (HL+VOICE_INFO_8640_16)
    JR          LAB_6e82

_increment_current_env_step_6e7d:
    LDAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    INR         A
    STAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)

LAB_6e82:
    CALL        dca_UNKNOWN_71dc
    RET

; =============================================================================
upd933_check_irq_dcw_6e86:
    SLRC        A
    JR          upd933_check_irq_dco_UNKNOWN_6ea6

    ANI         A,00000111b
; @NOTE: Returns pointer to 0x8640[voice] in HL.
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_1
    RET

    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_2
    JR          _increment_current_env_step_6e9d

    ORI         A,VOICE_INFO_8640_16_DCW_ENV_STEP_FINISHED_MAYBE
    STAX        (HL+VOICE_INFO_8640_16)
    JR          LAB_6ea2

_increment_current_env_step_6e9d:
    LDAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    INR         A
    STAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)

LAB_6ea2:
    CALL        dcw_UNKNOWN_7253
    RET

; =============================================================================
upd933_check_irq_dco_UNKNOWN_6ea6:
    SLR         A
    ANI         A,00000111b
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_1
    RET

    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_4
    JR          _increment_envelope_step_6ebc

    ORI         A,VOICE_INFO_8640_16_DCO_ENV_STEP_FINISHED_MAYBE
    STAX        (HL+VOICE_INFO_8640_16)
    JR          LAB_6ec1

_increment_envelope_step_6ebc:
    LDAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)
    INR         A
    STAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)

LAB_6ec1:
    CALL        dco_UNKNOWN_72d4
    RET

upd933_data_dcw_step_MAYBE_6ec5:
    DB          020h
    DB          07Fh
    DB          80h

upd933_data_dco_step_MAYBE_6ec8:
    DB          010h
    DB          07Fh
    DB          80h

upd933_data_UNKNOWN_6ecb:
    DB          00h
    DB          0FFh
    DB          80h

; =============================================================================
; HL: ?
; D: Voice #?
; E:?
; =============================================================================
FUN_6ece:
    MVI         A,0
; Falls-through below.

; =============================================================================
; HL: ?
; D: Voice #?
; E:?
; =============================================================================
FUN_6ed0:
    MVI         A,010h
    STAW        (V_OFFSET(intein_intad_pending_flag_80ea))
    MOV         A,E
    STAW        (V_OFFSET(data_80D6))
    MOV         A,D
    STAW        (V_OFFSET(MAYBE_voice_number_80d3))
    ANI         A,00000111b
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    CALL        clear_80f5_at_index_d_7d83
    ANIW        (V_OFFSET(UNKNOWN_flags_80e5)),11110111b

; Mask all interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh

    CALL        upd933_UNKNOWN_6f22
    OFFIW       (V_OFFSET(MAYBE_voice_number_80d3)),1
    JRE         LAB_6f19

    LDAX        (HL+15h)
    ONI         A,80h
    JR          LAB_6f00

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        upd933_UNKNOWN_6f22
    POP         HL
LAB_6f00:
    LDAX        (HL+15h)
    ONI         A,2
    JR          LAB_6f19

    PUSH        HL
    LDEAX       (HL+3)
    DMOV        HL,EA
    CALL        upd933_UNKNOWN_6f22
    LDAX        (HL+15h)
    ONI         A,80h
    JR          LAB_6f18

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        upd933_UNKNOWN_6f22
LAB_6f18:
    POP         HL

LAB_6f19:
; Restore interrupt state.
    POP         V
    MOV         MKL,A
    BIT         3,(V_OFFSET(UNKNOWN_flags_80e5))
    CALL        UNKNOWN_upd933_6f5f
    RET

; =============================================================================
upd933_UNKNOWN_6f22:
    LDAX        (HL+13h)
    ANI         A,01111111b
    STAX        (HL+13h)
    OFFI        A,1
    JR          LAB_6f31

    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+0dh)
    JRE         LAB_6f5b

LAB_6f31:
    PUSH        HL
    ORIW        (V_OFFSET(UNKNOWN_flags_80e5)),8
    LDAX        (HL+13h)
    ORI         A,8
    STAX        (HL+13h)
    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+9)
    LDEAX       (HL+5)
    MVI         B,014h
    LDAX        (HL+15h)
    OFFI        A,40h
    MVI         B,04Dh
    EADD        EA,B
    DMOV        HL,EA
    LDAX        (HL)
    POP         HL
    PUSH        HL
    STAX        (HL+17h)
    DW 00AFh   ;    LDAX        (HL+00h)
    LXI         HL,upd933_data_UNKNOWN_6f5c
    CALL        upd933_send_register_and_data_at_hl_743b
    POP         HL
LAB_6f5b:
    RET

upd933_data_UNKNOWN_6f5c:
    DB          000h
    DB          0EBh
    DB          000h

; =============================================================================
; Called during DCA IRQ.
; HL: 0x8640[voice]
; =============================================================================
UNKNOWN_upd933_6f5f:
; Save MKL state, and mask all interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh

    ANIW        (V_OFFSET(UNKNOWN_flags_80e5)),11111000b
    SHLD        (UNKNOWN_pointer_to_voice_data_80d9)
    CALL        voice_frequency_UNKNOWN_7068
    CALL        upd933_write_voice_frequency_71d1

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          LAB_6f8a

    ORIW        (V_OFFSET(UNKNOWN_flags_80e5)),1
    PUSH        HL
    LDEAX       (HL+1)
    DMOV        HL,EA
    SHLD        (UNKNOWN_pointer_to_voice_data_80db)
    CALL        voice_frequency_UNKNOWN_7068
    CALL        upd933_write_voice_frequency_71d1
    POP         HL

LAB_6f8a:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_TONE_MIX
    JRE         LAB_6fb9

    ORIW        (V_OFFSET(UNKNOWN_flags_80e5)),2
    PUSH        HL
    LDEAX       (HL+3)
    DMOV        HL,EA
    SHLD        (UNKNOWN_pointer_to_voice_data_80dd)
    CALL        voice_frequency_UNKNOWN_7068
    CALL        upd933_write_voice_frequency_71d1
    LDAX        (HL+15h)
    ONI         A,80h
    JR          LAB_6fb8

    ORIW        (V_OFFSET(UNKNOWN_flags_80e5)),4
    LDEAX       (HL+1)
    DMOV        HL,EA
    SHLD        (UNKNOWN_pointer_80df)
    CALL        voice_frequency_UNKNOWN_7068
    CALL        upd933_write_voice_frequency_71d1

LAB_6fb8:
    POP         HL

LAB_6fb9:
    CALL        upd933_clear_register_98_71c9
    BIT         0,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_6fc6

    LHLD        (UNKNOWN_pointer_to_voice_data_80db)
    CALL        upd933_clear_register_98_71c9

LAB_6fc6:
    BIT         1,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_6fd0

    LHLD        (UNKNOWN_pointer_to_voice_data_80dd)
    CALL        upd933_clear_register_98_71c9
LAB_6fd0:
    BIT         2,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_6fda

    LHLD        (UNKNOWN_pointer_80df)
    CALL        upd933_clear_register_98_71c9
LAB_6fda:
    LHLD        (UNKNOWN_pointer_to_voice_data_80d9)
    CALL        voice_reset_envelope_flags_UNKNOWN_705d
    CALL        dca_UNKNOWN_71dc

    BIT         0,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_6ff1

    LHLD        (UNKNOWN_pointer_to_voice_data_80db)
    CALL        voice_reset_envelope_flags_UNKNOWN_705d
    CALL        dca_UNKNOWN_71dc
LAB_6ff1:
    BIT         1,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_6ffe

    LHLD        (UNKNOWN_pointer_to_voice_data_80dd)
    CALL        voice_reset_envelope_flags_UNKNOWN_705d
    CALL        dca_UNKNOWN_71dc
LAB_6ffe:
    BIT         2,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_700b

    LHLD        (UNKNOWN_pointer_80df)
    CALL        voice_reset_envelope_flags_UNKNOWN_705d
    CALL        dca_UNKNOWN_71dc
LAB_700b:
    LHLD        (UNKNOWN_pointer_to_voice_data_80d9)
    CALL        dcw_UNKNOWN_7253
    BIT         0,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_701c

    LHLD        (UNKNOWN_pointer_to_voice_data_80db)
    CALL        dcw_UNKNOWN_7253
LAB_701c:
    BIT         1,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_7026

    LHLD        (UNKNOWN_pointer_to_voice_data_80dd)
    CALL        dcw_UNKNOWN_7253
LAB_7026:
    BIT         2,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_7030

    LHLD        (UNKNOWN_pointer_80df)
    CALL        dcw_UNKNOWN_7253
LAB_7030:
    LHLD        (UNKNOWN_pointer_to_voice_data_80d9)
    CALL        dco_UNKNOWN_72d4
    BIT         0,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_7041

    LHLD        (UNKNOWN_pointer_to_voice_data_80db)
    CALL        dco_UNKNOWN_72d4
LAB_7041:
    BIT         1,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_704b

    LHLD        (UNKNOWN_pointer_to_voice_data_80dd)
    CALL        dco_UNKNOWN_72d4
LAB_704b:
    BIT         2,(V_OFFSET(UNKNOWN_flags_80e5))
    JR          LAB_7055

    LHLD        (UNKNOWN_pointer_80df)
    CALL        dco_UNKNOWN_72d4
LAB_7055:
    LHLD        (UNKNOWN_pointer_to_voice_data_80d9)

; Restore MKL.
    POP         V
    MOV         MKL,A
    RET

; =============================================================================
; HL: 0x8640[voice]
; =============================================================================
voice_reset_envelope_flags_UNKNOWN_705d:
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_13_1
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_16)
    RET

; =============================================================================
; HL: 0x8640[voice]
; =============================================================================
voice_frequency_UNKNOWN_7068:
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_80
    JR          LAB_7077

; Clear the flag.
    ANI         A,(~VOICE_INFO_8640_13_80 & 0FFh)
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)

    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ANI         A,~VOICE_INFO_8640_14_PORTA
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)

LAB_7077:
    CALL        FUN_70d8
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    MOV         B,A

    LDEAX       (HL+VOICE_INFO_8640_1E_PITCH_UNKNOWN)
    ONI         B,08h
    JR          LAB_7092

    LDED        (UNKNOWN_pitch_bend_word_80cf)
    BIT         FLAGS_80C8_BEND_POLARITY_NEGATIVE_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JR          LAB_708f

    CALL        subtract_de_from_ea_clamp_at_0_024b
    JR          LAB_7092

LAB_708f:
    CALL        add_de_to_ea_clamp_at_ffff_0245

LAB_7092:
    ONI         B,1
    JR          LAB_70ae

    PUSH        EA
    LDEAX       (HL+VOICE_INFO_8640_7_PTR_TO_8600)
    DMOV        DE,EA

    DI
    DW 00ABh   ;    LDAX        (DE+00h)
    LDEAX       (DE+0Ch)
    EI
    DMOV        DE,EA
    POP         EA
    OFFI        A,1
    JR          LAB_70ab

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          LAB_70ae

LAB_70ab:
    CALL        subtract_de_from_ea_clamp_at_0_024b

LAB_70ae:
; Clamp at max frequency?
    MOV         A,EAH
    LTI         A,071h
    LXI         EA,07100h

    DMOV        DE,EA
    CALL        add_de_to_ea_clamp_at_ffff_0245
    STEAX       (HL+VOICE_INFO_8640_11_FREQUENCY)

; Reset envelope steps?
    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    STAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    STAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)
    RET

; =============================================================================
; HL: Voice data (0x8640[voice]).
; =============================================================================
FUN_70c4:
    GTA         C,A
    JR          LAB_70d0

    SUB         C,A
    MOV         A,C
    STAX        (HL+0Ch)
    CALL        FUN_719b
    RET

LAB_70d0:
    SUB         A,C
    STAX        (HL+0Ch)
    CALL        FUN_71a1
    RET

; =============================================================================
FUN_70d8:
    OFFIW       (V_OFFSET(intein_intad_pending_flag_80ea)),010h
    JRE         LAB_712a
; Falls-through below.

; =============================================================================
; HL: Voice data (0x8640[voice]).
; =============================================================================
porta_UNKNOWN_70dd:
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_14_PORTA
    JRE         LAB_712a

; Portamento enabled?
    LDAX        (HL+VOICE_INFO_8640_a)
    STAX        (HL+VOICE_INFO_8640_b)
    MOV         C,A

    LDAX        (HL+VOICE_INFO_8640_d)
    STAX        (HL+VOICE_INFO_8640_a)
    CALL        FUN_70c4
    LDAX        (HL+VOICE_INFO_8640_C_WORD)
    LBCD        (portamento_freq_increment_80cd)
    PUSH        V
    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_e)
    STAX        (HL+VOICE_INFO_8640_F_WORD)
    STAX        (HL+VOICE_INFO_8640_10)
    POP         V
    LTI         A,7Fh
    MVI         A,7Fh
; Falls-through below.

; =============================================================================
; BC: Portamento increment?
; HL: Voice data (0x8640[voice]).
; =============================================================================
porta_UNKNOWN_7103:
    CALL        porta_multiply_a_by_bc_24_bit_71b4
    MVI         C,0

    SLR         A
    DRLR        EA
    RLR         C

    SLR         A
    DRLR        EA
    RLR         C

    SLR         A
    DRLR        EA
    RLR         C

    STEAX       (HL+023h)
    MOV         A,C
    STAX        (HL+22h)
    MOV         A,EAH
    MOV         D,A
    LDAX        (HL+0Ch)
    GTA         A,D
    JR          LAB_712a

    LDAX        (HL+0bh)
    JR          LAB_7133

LAB_712a:
    CALL        FUN_71a9
    LDAX        (HL+0dh)
    STAX        (HL+0ah)
    STAX        (HL+0bh)
LAB_7133:
    LDEAX       (HL+01ch)
    DMOV        DE,EA
    MOV         EAH,A
    MVI         A,0
    MOV         EAL,A
    LDAX        (HL+13h)
    OFFI        A,020h
    JR          LAB_7150

    CALL        add_de_to_ea_clamp_at_ffff_0245
    STEAX       (HL+01eh)
    LDAX        (HL+0dh)
    MOV         EAH,A
    MVI         A,0
    MOV         EAL,A
    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          LAB_715f

LAB_7150:
    CALL        subtract_de_from_ea_clamp_at_0_024b
    STEAX       (HL+01eh)
    LDAX        (HL+0dh)
    MOV         EAH,A
    MVI         A,0
    MOV         EAL,A
    CALL        subtract_de_from_ea_clamp_at_0_024b
LAB_715f:
    STEAX       (HL+020h)
    PUSH        HL
    LDAX        (HL+15h)
    OFFI        A,40h
    JR          LAB_7172

    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDAX        (HL+PATCH_11)
    MOV         C,A
    LDAX        (HL+PATCH_13)
    MOV         B,A
    JR          LAB_717b

LAB_7172:
    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDAX        (HL+PATCH_4A)
    MOV         C,A
    LDAX        (HL+PATCH_4C)
    MOV         B,A
LAB_717b:
    POP         HL
    PUSH        HL
    LDAX        (HL+021h)
    SUINB       A,01dh
    MVI         A,0
    LTI         A,03ch
    MVI         A,03ch
    LXI         HL,03c1h
    LDAX        (HL+A)
    MUL         B
    PUSH        V
    MOV         A,EAH
    MOV         B,A
    POP         V
    MUL         C
    MOV         A,EAH
    POP         HL
    STAX        (HL+026h)
    MOV         A,B
    STAX        (HL+027h)
    RET

; =============================================================================
FUN_719b:
    DI
    LDAX        (HL+13h)
    ORI         A,06h
    JR          LAB_71b0

; =============================================================================
FUN_71a1:
    DI
    LDAX        (HL+13h)
    ANI         A,0f9h
    ORI         A,04h
    JR          LAB_71b0

; =============================================================================
FUN_71a9:
    DI
    LDAX        (HL+13h)
    ANI         A,0f9h
    ORI         A,2
LAB_71b0:
    STAX        (HL+13h)
    EI
    RET

; =============================================================================
; Computes the full 24-bit product of A × BC.
; A:  Pitch distance (0x00–0x7F)?
; BC: Portamento increment.
; Returns:
; EA: Low 16 bits.
; A:  High 8 bits.
; =============================================================================
porta_multiply_a_by_bc_24_bit_71b4:
    PUSH        HL
; EA = A * C
    MUL         C
    PUSH        EA

; EA = A * B
    MUL         B

; Save EAH.
    MOV         A,EAH
    PUSH        V

; H  = low_byte(A * B)
    MOV         A,EAL
    MOV         H,A
    MVI         L,0

; Restore A  = high_byte(A * B)
    POP         V
; Restore EA = (A * C)
    POP         EA

; EA = (A * C) + low_byte(A * B) * 256
    DADD        EA,HL

; Increment A if the addition carried
    SKN         CY
    INR         A
    POP         HL
    RET

; =============================================================================
; From Devin Acker's CZ101 MAME Driver:
;   Unknown, but cz101 sets these to zero when starting a note, probably to
;   reset the oscillator
; =============================================================================
upd933_clear_register_98_71c9:
    LXI         EA,0
    MVI         C,UPD933_UNKNOWN
    JMP         upd933_load_voice_idx_from_hl_data_in_ea_733f

; =============================================================================
; Appears to load the current voice frequency, and write it?
;
; HL: Voice info 0x8640[voice]
; =============================================================================
upd933_write_voice_frequency_71d1:
    MVI         C,UPD933_PITCH
    LDAX        (HL+VOICE_INFO_8640_11_FREQUENCY)
    MOV         EAH,A
    LDAX        (HL+VOICE_INFO_8640_12_FREQUENCY_HIGH)
    MOV         EAL,A
    JMP         upd933_load_voice_idx_from_hl_data_in_ea_733f

; =============================================================================
; HL: Voice info 0x8640[voice]
; =============================================================================
dca_UNKNOWN_71dc:
    PUSH        DE
    LDAX        (HL+VOICE_INFO_8640_16)
    ANI         A,(~VOICE_INFO_8640_16_1)
    STAX        (HL+VOICE_INFO_8640_16)

    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    MVI         B,PATCH_DCA1_ENV_STEP_END

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40

    MVI         B,PATCH_DCA2_ENV_STEP_END
    EADD        EA,B

    LDAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    MOV         B,A
    PUSH        HL
    PUSH        HL
    POP         DE
    DMOV        HL,EA
    LDAX        (HL+)
    GTA         A,B
    MOV         B,A
    MVI         C,0
    NEA         A,B
    MVI         C,80h
    PUSH        BC
    MOV         A,B
    ADD         B,A
    LDAX        (HL+B)
    INR         B
    MOV         C,A
    PUSH        BC
    ANI         C,7Fh
    LDAX        (DE+026h)
    ADD         C,A
    OFFI        C,80h
    MVI         C,7Fh
    MOV         A,C
    POP         BC
    OFFI        C,80h
    ORI         A,10000000b
    MOV         EAL,A
    LDAX        (HL+B)
    MOV         C,A
    PUSH        BC
    ANI         C,7Fh
    LDAX        (DE+025h)
    SUBNB       C,A
    MVI         C,0
    MOV         A,C
    POP         BC
    ONI         C,80h
    JR          LAB_723e

    MOV         C,A
    LDAX        (DE+16h)
    ONI         A,010h
    JR          LAB_7239

    ORI         C,80h
    JR          LAB_723d

LAB_7239:
    ORI         A,1
    STAX        (DE+16h)
LAB_723d:
    MOV         A,C
LAB_723e:
    POP         BC
    ONI         C,80h
    JR          LAB_724f

    MOV         A,EAL
    ANI         A,01111111b
    LTI         A,066h
    MVI         A,066h
    ORI         A,10000000b
    MOV         EAL,A
    MVI         A,0
LAB_724f:
    MVI         C,0
    JRE         LAB_733c

; =============================================================================
; HL: Voice data (0x8640[voice]).
; =============================================================================
dcw_UNKNOWN_7253:
    PUSH        DE
; Clear flag.
    LDAX        (HL+VOICE_INFO_8640_16)
    ANI         A,(~VOICE_INFO_8640_16_2)
    STAX        (HL+VOICE_INFO_8640_16)

    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    MVI         B,PATCH_DCW1_ENV_STEP_END

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40

    MVI         B,PATCH_DCW2_ENV_STEP_END
; EA = Patch buffer edit[DCW1/2 env step end]
    EADD        EA,B
    LDAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    MOV         B,A
    PUSH        HL
    PUSH        HL
    POP         DE
    DMOV        HL,EA
    LDAX        (HL+)
    GTA         A,B
    MOV         B,A
    MVI         C,0
    NEA         A,B
    MVI         C,80h
    PUSH        BC
    MOV         A,B
    ADD         B,A
    LDAX        (HL+B)
    INR         B
    MOV         EAL,A
    LDAX        (HL+B)
    MOV         C,A
    PUSH        BC
    ANI         C,7Fh
    LDAX        (DE+027h)
    SUBNB       C,A
    MVI         C,0
    MOV         A,C
    POP         BC
    MOV         B,A
    LTI         B,07h
    JR          LAB_72a2

    LDAX        (DE+1Ah)
    ANI         A,0E0h
    NEI         A,0c0h
    MVI         B,07h
    LDAX        (DE+1Ah)
    ANI         A,01eh
    NEI         A,1Ah
    MVI         B,07h
LAB_72a2:
    MOV         A,B
    ONI         C,80h
    JR          LAB_72b6

    MOV         C,A
    LDAX        (DE+16h)
    ONI         A,020h
    JR          LAB_72b1

    ORI         C,80h
    JR          LAB_72b5

LAB_72b1:
    ORI         A,2
    STAX        (DE+16h)
LAB_72b5:
    MOV         A,C
LAB_72b6:
    POP         BC
    ONI         C,80h
    JR          LAB_72d0

    MOV         A,EAL
    ORI         A,10000000b
    MOV         EAL,A
    LDAX        (DE+1Ah)
    ANI         A,0E0h
    NEI         A,0c0h
    JR          LAB_72ce

    LDAX        (DE+1Ah)
    ANI         A,01eh
    EQI         A,1Ah
    MVI         A,80h
LAB_72ce:
    MVI         A,087h
LAB_72d0:
    MVI         C,020h
    JRE         LAB_733c

; =============================================================================
; HL: Voice Info (0x8640)
; =============================================================================
dco_UNKNOWN_72d4:
    PUSH        DE
; Clear flag.
    LDAX        (HL+VOICE_INFO_8640_16)
    ANI         A,(~VOICE_INFO_8640_16_4)
    STAX        (HL+VOICE_INFO_8640_16)

    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    MVI         B,PATCH_DCO1_ENV_STEP_END

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40

    MVI         B,PATCH_DCO2_ENV_STEP_END
; EA = Patch buffer edit[DCO1/2 env step end]
    EADD        EA,B
    LDAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)
    MOV         B,A

    PUSH        HL
    PUSH        HL
    POP         DE
; HL = pointer to DCO Env step 1 rate.
; A = DCO Env step end.
; B = Current step?
    DMOV        HL,EA
    LDAX        (HL+)
; Is End step > Current step?
    GTA         A,B
; Set step to the end.
    MOV         B,A
    MVI         C,0
; Is End step = Current step?
    NEA         A,B
    MVI         C,80h

    PUSH        BC
    MOV         A,B
    ADD         B,A
    LDAX        (HL+B)
    INR         B
    MOV         EAL,A
    LDAX        (HL+B)
    MOV         C,A
    PUSH        BC
    ANI         C,7Fh
    LDAX        (DE+021h)
    GTI         A,023h
    JR          LAB_731a

    LTI         A,071h
    MVI         A,071h
    SUI         A,024h
    PUSH        HL
    LXI         HL,data_044f
    LDAX        (HL+A)
    POP         HL
    LTA         C,A
    MOV         C,A

LAB_731a:
    MOV         A,C
    POP         BC
    ONI         C,80h
    JR          LAB_732f

    MOV         C,A
    LDAX        (DE+16h)
    ONI         A,40h
    JR          LAB_732a

    ORI         C,80h
    JR          LAB_732e

LAB_732a:
    ORI         A,04h
    STAX        (DE+16h)
LAB_732e:
    MOV         A,C
LAB_732f:
    POP         BC
    ONI         C,80h
    JR          LAB_733a

    MOV         A,EAL
    ORI         A,10000000b
    MOV         EAL,A
    MVI         A,80h
LAB_733a:
    MVI         C,10h

LAB_733c:
    MOV         EAH,A
    POP         HL
    POP         DE

; =============================================================================
; C:  Register number?
; HL: Voice info pointer?
; EA: Data to write?
; =============================================================================
upd933_load_voice_idx_from_hl_data_in_ea_733f:
    DW 00AFh   ;    LDAX        (HL+00h)
    ANI         A,111b
    PUSH        HL
    LXI         HL,upd933_c000
    CALL        upd933_write_register_in_c_voice_a_data_in_ea_0218
    POP         HL
    RET
    RET

; =============================================================================
FUN_734d:
    CALL        clear_80f5_at_index_d_7d83
    ORIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_10
    JR          FUN_736e

; =============================================================================
FUN_7354:
    CALL        clears_80f5_7d90
    ORIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_10
    MVIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0FFh
    MVIW        (V_OFFSET(MAYBE_voice_number_80d3)),0
    MVI         A,0
    JR          LAB_7376

; =============================================================================
note_off_UNKNOWN_7363:
    ONIW        (V_OFFSET(current_note_event_origin_8015)),KEYBOARD_NOTE_ON
    JR          FUN_736b

; Flag set?
    CALL        d_used_as_index_to_store_080_80f5_7da7h
    RET

; =============================================================================
FUN_736b:
    ANIW        (V_OFFSET(UNKNOWN_flags_80c9)),00001111b
; Falls-through below.

; =============================================================================
FUN_736e:
    MVIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),1
    MOV         A,D
    STAW        (V_OFFSET(MAYBE_voice_number_80d3))
    ANI         A,111b
LAB_7376:
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8

    PUSH        HL
LAB_737a:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JRE         LAB_73b3

    CALL        voice_process_envelopes_MAYBE_73d4
    CALL        FUN_73c7
    LDAX        (HL+15h)
    ONI         A,80h
    JR          LAB_7394

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        voice_process_envelopes_MAYBE_73d4
    CALL        FUN_73c7
    POP         HL
LAB_7394:
    LDAX        (HL+15h)
    ONI         A,2
    JR          LAB_73b3

    PUSH        HL
    LDEAX       (HL+3)
    DMOV        HL,EA
    CALL        voice_process_envelopes_MAYBE_73d4
    CALL        FUN_73c7
    LDAX        (HL+15h)
    ONI         A,80h
    JR          LAB_73b2

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        voice_process_envelopes_MAYBE_73d4
    CALL        FUN_73c7
LAB_73b2:
    POP         HL

LAB_73b3:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,028h
    ADI         H,1

    INRW        (V_OFFSET(MAYBE_voice_number_80d3))
    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQI         A,0
    JRE         LAB_737a

    POP         HL
    RET

; =============================================================================
FUN_73c7:
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE | FLAGS_8031_TONE_MIX
    RET
    DI
    LDAX        (HL+13h)
    ORI         A,050h
    STAX        (HL+13h)
    EI
    RET

; =============================================================================
; Increments and stores the current envelope stages.
; HL: Voice data (0x8640[voice])
; =============================================================================
voice_process_envelopes_MAYBE_73d4:
; Save interrupt mask state, and mask interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh

    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ANI         A,(~VOICE_INFO_8640_13_8)
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_1
    JR          _jump_to_exit_73f9

; Flag set.
    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    MVI         B,PATCH_DCA1_ENV_STEP_END
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40
    MVI         B,PATCH_DCA2_ENV_STEP_END
    EADD        EA,B

; DE = Pointer to Patch buffer edit[DCA1/2 env step end].
    DMOV        DE,EA
    ONIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_10
    JR          _flag_clear_73fb

; A = env step end.
    LDAX        (DE)
    CALL        UNKNOWN_upd933_7762

_jump_to_exit_73f9:
    JRE         _exit_7436

_flag_clear_73fb:
    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_DCA_ENV_STEP_FINISHED_MAYBE
    JR          _flag_clear_7408

; Clear flag.
    ANI         A,(~VOICE_INFO_8640_16_DCA_ENV_STEP_FINISHED_MAYBE)
    STAX        (HL+VOICE_INFO_8640_16)

    LDAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    INR         A
    JR          _store_current_env_step_7409

_flag_clear_7408:
; Load env step end.
    LDAX        (DE)

_store_current_env_step_7409:
    STAX        (HL+VOICE_INFO_8640_17_DCA_ENV_CURRENT_STEP_MAYBE)
    CALL        dca_UNKNOWN_71dc

    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_DCW_ENV_STEP_FINISHED_MAYBE
    JR          _flag_clear_741b

    ANI         A,(~VOICE_INFO_8640_16_DCW_ENV_STEP_FINISHED_MAYBE)
    STAX        (HL+VOICE_INFO_8640_16)

    LDAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    INR         A
    JR          _store_current_env_step_741d

_flag_clear_741b:
; DE + 0x11 is a pointer to the next envelope.
    LDAX        (DE+PATCH_DCW1_ENV_STEP_END - PATCH_DCA1_ENV_STEP_END)

_store_current_env_step_741d:
    STAX        (HL+VOICE_INFO_8640_18_DCW_ENV_CURRENT_STEP_MAYBE)
    CALL        dcw_UNKNOWN_7253
    LDAX        (HL+VOICE_INFO_8640_16)
    ONI         A,VOICE_INFO_8640_16_DCO_ENV_STEP_FINISHED_MAYBE
    JR          _flag_clear_742f

    ANI         A,(~VOICE_INFO_8640_16_DCO_ENV_STEP_FINISHED_MAYBE)
    STAX        (HL+VOICE_INFO_8640_16)

    LDAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)
    INR         A
    JR          _store_env_step_7431

_flag_clear_742f:
; DE + 0x22 is a pointer to the next next envelope.
    LDAX        (DE+PATCH_DCO1_ENV_STEP_END - PATCH_DCA1_ENV_STEP_END)

_store_env_step_7431:
    STAX        (HL+VOICE_INFO_8640_19_DCO_ENV_CURRENT_STEP_MAYBE)
    CALL        dco_UNKNOWN_72d4

_exit_7436:
; Restore interrupt state.
    POP         V
    MOV         MKL,A
    RET

; =============================================================================
upd933_send_data_at_hl_voice_no_in_b_743a:
    MOV         A,B

; =============================================================================
; HL: Pointer to data to send.
; A:  Voice number.
; =============================================================================
upd933_send_register_and_data_at_hl_743b:
    PUSH        BC
    PUSH        DE
    PUSH        V

; Mask voice number, and move to C.
    ANI         A,111b
    MOV         C,A

; Load register index from HL into A, then data into EAL/EAH.
    LDAX        (HL+)
    PUSH        V
    LDAX        (HL+)
    MOV         EAL,A
    LDAX        (HL+)
    MOV         EAH,A
    POP         V

    PUSH        HL
    LXI         HL,upd933_c000
    CALL        upd933_write_register_in_c_voice_a_data_in_ea_0218
    POP         HL

    POP         V
    POP         DE
    POP         BC
    RET

; =============================================================================
; =============================================================================
UNKNOWN_upd933_updates_waveform_7454:
    LDEAX       (HL+VOICE_INFO_8640_1A_WORD_UNKNOWN)
    DMOV        BC,EA
    PUSH        HL

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40
    JR          _gets_dco2_waveform_1_MAYBE_7465

    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDEAX       (HL+PATCH_DCO1_WAVEFORM_1)
    JR          LAB_746b

_gets_dco2_waveform_1_MAYBE_7465:
    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDEAX       (HL+PATCH_DCO2_WAVEFORM_1)

LAB_746b:
    DMOV        DE,EA
    POP         HL
    PUSH        HL

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_80
    JR          LAB_7478

    ANI         D,0c0h
    JRE         LAB_749b

LAB_7478:
    OFFIW       (V_OFFSET(MAYBE_voice_number_80d3)),1
    JR          LAB_749b

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_15_40
    JR          LAB_748c

    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDEAX       (HL+PATCH_DCO1_WAVEFORM_1)
    JR          LAB_7492

LAB_748c:
    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDEAX       (HL+PATCH_DCO2_WAVEFORM_1)

LAB_7492:
    MOV         A,EAH
    ANI         A,03ch
    POP         HL
    ANI         D,0c0h
    ORA         D,A
LAB_749b:
    BIT         0,(V_OFFSET(MAYBE_voice_number_80d3))
    JR          LAB_74a3

    ANI         D,0c0h
    JRE         LAB_7512

LAB_74a3:
    PUSH        DE
    PUSH        BC
    ANI         D,0c0h
    ANI         B,0c0h
    DMOV        EA,DE
    DSUB        EA,BC
    POP         BC
    POP         DE
    SKN         Z
    JR          LAB_74d1

    ANI         B,03ch
    MOV         A,D
    ANI         A,0c0h
    ORA         A,B
    MOV         EAH,A
    MOV         (upd933_data_waveform_lsb_80c4),A
    MOV         A,E
    MOV         EAL,A
    MOV         (upd933_data_waveform_msb_80c3),A
    STEAX       (HL+1Ah)
    LXI         HL,upd933_data_waveform_index_80c2
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    CALL        upd933_send_register_and_data_at_hl_743b

LAB_74d1:
    ANI         D,03ch

; Load the voice number, add 2, and mask to perform a modulo operation
; so that the voice number is clamped to 0-7.
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    ADI         A,2
    ANI         A,111b

; Get a pointer to the voice data structure for this voice.
    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    LDEAX       (HL+VOICE_INFO_8640_1A_WORD_UNKNOWN)
    MOV         A,EAH
    ANI         A,00111100b
    NEA         A,D
    JR          _pop_hl_and_exit_7504

    MOV         A,EAH
    MOV         B,A
    ANI         A,11000000b
    ORA         A,D
    MOV         EAH,A
    STEAX       (HL+VOICE_INFO_8640_1A_WORD_UNKNOWN)
    DMOV        DE,EA
    DW 00AFh   ;    LDAX        (HL+00h)

    SDED        (upd933_data_waveform_msb_80c3)
    LXI         HL,upd933_data_waveform_index_80c2
    CALL        upd933_send_register_and_data_at_hl_743b
    MOV         A,D
    XRA         A,B
    ANA         A,B
    ONI         A,010h

_pop_hl_and_exit_7504:
    JR          _pop_hl_and_exit_7511

; This seems to be reached when ring-mod enabled.
    LXI         HL,UNKNOWN_upd933_data_7527
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    ANI         A,111b
    SLR         A
    CALL        upd933_send_register_and_data_at_hl_743b

_pop_hl_and_exit_7511:
    JR          _pop_hl_and_exit_7525

LAB_7512:
    DMOV        EA,DE
    DNE         EA,BC
    JR          _pop_hl_and_exit_7525

    STEAX       (HL+VOICE_INFO_8640_1A_WORD_UNKNOWN)
    SDED        (upd933_data_waveform_msb_80c3)

    LXI         HL,upd933_data_waveform_index_80c2
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    CALL        upd933_send_register_and_data_at_hl_743b

_pop_hl_and_exit_7525:
    POP         HL
    RET

; What is the B8 register here?
UNKNOWN_upd933_data_7527:
    DB          0B8h
    DB          000h
    DB          000h

; =============================================================================
; Called on each voice.
;
; HL: Pointer to voice data?
; DE: ???
; =============================================================================
UNKNOWN_master_tune_called_per_voice_752a:
    PUSH        HL
    DW 00AFh   ;    LDAX        (HL+00h)

; Test if this is an event or odd numbered voice?
    ONI         A,1
    JR          _odd_numbered_voice_7536

; Voice is even?
    LBCD        (upd933_data_master_tune_80ca)
    DMOV        EA,BC
    JR          LAB_7540

_odd_numbered_voice_7536:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    LBCD        (upd933_data_master_tune_80ca)
    DMOV        EA,BC
    OFFI        A,VOICE_INFO_8640_15_80
    JR          LAB_7548

LAB_7540:
    MVI         H,20h
    BIT         FLAGS_80C8_20_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    MVI         H,0
    JRE         LAB_757e

LAB_7548:
    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    LDEAX       (HL+PATCH_DETUNE_FINE)
    MOV         A,EAH
    ANI         A,01111111b
    MOV         EAH,A
    LDAX        (HL+PATCH_DETUNE_POLARITY)
    MVI         H,0
; Test if detune polarity is negative?
    ONI         A,1
    JR          LAB_7567

    BIT         FLAGS_80C8_20_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JR          LAB_7560

    ORI         H,020h
    JR          LAB_7579

LAB_7560:
    DGT         EA,BC
    JR          LAB_7570

    ORI         H,020h
    JR          LAB_7576

LAB_7567:
    BIT         FLAGS_80C8_20_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JR          LAB_7579

    DLT         EA,BC
    JR          LAB_7576

    ORI         H,020h
LAB_7570:
    DMOV        DE,EA
    DMOV        EA,BC
    CALL        subtract_de_from_ea_clamp_at_0_024b
    JR          LAB_757e

LAB_7576:
    DSUB        EA,BC
    JR          LAB_757e

LAB_7579:
    DADDNC      EA,BC
    LXI         EA,0ffffh
LAB_757e:
    MOV         A,H
    MOV         B,A
    POP         HL
    PUSH        HL
    PUSH        EA
    CALL        MAYBE_get_pointer_to_edit_buffer_7d0a
    POP         EA
; Load patch PFLAG.
    DW 00AFh   ;    LDAX        (HL+00h)
    ANI         A,PATCH_PFLAG_OCTAVE_MASK
; Is octave setting 1?
    OFFI        A,04h
    JR          _octave_setting_is_1_7597

; Is octave setting -1?
    ONI         A,8
    JRE         LAB_75b3

; Octave setting is -1.
    ONI         B,020h
    JR          LAB_75a1

    JR          LAB_759b

_octave_setting_is_1_7597:
    OFFI        B,020h
    JR          LAB_75a1

LAB_759b:
    MOV         A,EAH
    ADINC       A,0Ch
    MVI         A,0FFh
    JR          LAB_75b2

LAB_75a1:
    MOV         A,EAH
    GTI         A,0bh
    JR          LAB_75a8

    SUI         A,0Ch
    JR          LAB_75b2

LAB_75a8:
    XRI         B,020h
    DMOV        DE,EA
    LXI         EA,0c00h
    DSUB        EA,DE
    JR          LAB_75b3

LAB_75b2:
    MOV         EAH,A
LAB_75b3:
    POP         HL
    DI
    STEAX       (HL+01ch)
    LDAX        (HL+13h)
    ANI         A,0dfh
    ORA         A,B
    STAX        (HL+13h)
    EI
    PUSH        EA
    DMOV        DE,EA
    MVI         A,0
    MOV         EAL,A
    LDAX        (HL+0bh)
    MOV         EAH,A
    OFFI        B,020h
    JR          LAB_75d1

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          LAB_75d4

LAB_75d1:
    CALL        subtract_de_from_ea_clamp_at_0_024b
LAB_75d4:
    STEAX       (HL+01eh)
    POP         DE
    MVI         A,0
    MOV         EAL,A
    LDAX        (HL+0dh)
    MOV         EAH,A
    OFFI        B,020h
    JR          LAB_75e6

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          LAB_75e9

LAB_75e6:
    CALL        subtract_de_from_ea_clamp_at_0_024b
LAB_75e9:
    STEAX       (HL+020h)
    DI
    LDAX        (HL+15h)
    ORI         A,020h
    STAX        (HL+15h)
    EI
    RET

; =============================================================================
; D: ?
; =============================================================================
UNKNOWN_loads_value_from_table_75f5:
    MOV         A,D
    TABLE
    JR          LAB_7600

;0010 0001
    DB          021h
;1000 0100
    DB          084h
;0001 0010
    DB          012h
;0100 1000
    DB          048h
    DB          0CCh
    DB          0FFh
    DB          033h

LAB_7600:
    MOV         A,C
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    MOV         A,D
    OFFI        A,00000100b
    RET
    RETS

; =============================================================================
FUN_7608:
    PUSH        V
    PUSH        EA
    PUSH        HL
    DW 00AFh   ;    LDAX        (HL+00h)
    OFFI        A,1
    JR          LAB_7617

    LDAX        (HL+0ah)
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    STAX        (HL+0ah)
LAB_7617:
    POP         HL
    POP         EA
    POP         V
    RET

; =============================================================================
FUN_761b:
    PUSH        DE
    ORIW        (V_OFFSET(data_80f3)),00100000b
    JR          voice_get_ptr_to_patch_indexes_7628

; =============================================================================
UNKNOWN_solo_mode_7620:
    PUSH        DE
    ORIW        (V_OFFSET(data_80f3)),00100000b
    JRE         LAB_764b

; =============================================================================
UNKNOWN_tone_mix_7626:
    MVI         D,4

; =============================================================================
voice_get_ptr_to_patch_indexes_7628:
    CALL        FUN_77a0
    MOV         A,D
    ADD         A,A
    TABLE
    JR          LAB_763b

    DW          patch_index_channel_0_8029
    DW          patch_index_channel_1_802a
    DW          patch_index_channel_2_802b
    DW          patch_index_channel_3_802c
    DW          patch_index_tone_mix_8007

LAB_763b:
    LDAX        (BC)
    CALL        patch_get_pointer_to_index_5072
    DMOV        HL,EA
    CALL        UNKNOWN_loads_value_from_table_75f5
    MVI         D,1
    JR          voice_UNKNOWN_7656

; =============================================================================
UNKNOWN_tone_mix_7646:
    MVI         A,6

; =============================================================================
FUN_7648:
    MVI         A,5
    MOV         D,A

LAB_764b:
    CALL        UNKNOWN_loop_over_voices_77aa
    CALL        UNKNOWN_loads_value_from_table_75f5
    MVI         D,0
    LXI         HL,patch_buffer_edit_8300
; Falls-through below.

; =============================================================================
; D: Voice index?
; HL: ???
; =============================================================================
voice_UNKNOWN_7656:
    SHLD        (UNKNOWN_pointer_to_patch_data_80d1)

; EA = D * 16.
    MOV         A,D
    MVI         B,10h
    MUL         B

    LXI         DE,unknown_voice_data_8600
    DADD        EA,DE
    DMOV        DE,EA
    SDED        (unknown_pointer_to_8600_array_80d7)

    MVIW        (V_OFFSET(MAYBE_voice_number_80d3)),0
    ANIW        (V_OFFSET(UNKNOWN_flags_80c9)),00011100b
    DW 00AFh   ;    LDAX        (HL+00h)
    ANI         A,3
    OFFI        A,2
    ORIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_1
    MVI         B,0
    ONI         A,1
    JR          LAB_7684

    MVI         B,2h
    OFFI        A,2
    JR          LAB_7684

    MVI         B,3

LAB_7684:
    MOV         A,B
    STAW        (V_OFFSET(data_80e6))
    OFFIW       (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_1
    JR          LAB_768f

    CALL        UNKNOWN_upd933_76da
    JR          LAB_76a7

LAB_768f:
    LDAW        (V_OFFSET(MAYBE_voice_number_80d3))
    PUSH        V
    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    PUSH        V
    ANI         A,0aah
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    CALL        UNKNOWN_upd933_76da
    POP         V
    ANI         A,055h
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    POP         V
    STAW        (V_OFFSET(MAYBE_voice_number_80d3))
    CALL        UNKNOWN_upd933_76da
LAB_76a7:
    OFFIW       (V_OFFSET(data_80f3)),020h
    JR          LAB_76be

    ONIW        (V_OFFSET(ui_flag_set_when_editing_8024)),1
    CALL        FUN_7354
LAB_76b1:
    ANIW        (V_OFFSET(data_80f3)),0
    MVI         B,03h
LAB_76b6:
    DCR         B
    JR          LAB_76b9

    RET
LAB_76b9:
    MVI         A,0FFh
LAB_76bb:
    DCR         A
    JR          LAB_76bb

    JR          LAB_76b6

LAB_76be:
    POP         DE
    OFFIW       (V_OFFSET(ui_flag_set_when_editing_8024)),1
    JR          LAB_76b1

    MOV         A,D
    ANI         A,3
    SLL         A
    STAW        (V_OFFSET(data_80f3))
    ADI         A,5
    ANI         A,7
    MOV         D,A
    CALL        FUN_734d
    LDAW        (V_OFFSET(data_80f3))
    MOV         D,A
    CALL        FUN_734d
    JRE         LAB_76b1

; =============================================================================
UNKNOWN_upd933_76da:
    LXI         HL,MAYBE_voice_data_8640

_voice_loop_76dd:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JRE         _move_to_next_voice_774f

; Store interrupt masking.
    MOV         A,MKL
    PUSH        V
; Mask all interrupts.
    ORI         MKL,0FFh

    LDED        (unknown_pointer_to_8600_array_80d7)
    DMOV        EA,DE
    STEAX       (HL+7)
    OFFIW       (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_2
    JR          LAB_7712

    ORIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_2

    PUSH        HL
    LHLD        (UNKNOWN_pointer_to_patch_data_80d1)
    LDAX        (HL+4)
    STAX        (DE+1)
    LDEAX       (HL+6)
    STEAX       (DE+2)
    LDEAX       (HL+9)
    STEAX       (DE+4)
    LDEAX       (HL+12)
    STEAX       (DE+6)
    POP         HL

LAB_7712:
    ANIW        (V_OFFSET(UNKNOWN_flags_80c9)),11110011b
    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    LDED        (UNKNOWN_pointer_to_patch_data_80d1)

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ANI         A,~VOICE_INFO_8640_15_40
    OFFI        A,VOICE_INFO_8640_15_80
    JR          LAB_772a

    BIT         0,(V_OFFSET(UNKNOWN_flags_80c9))
    JR          LAB_7730

    CALL        FUN_7608
    JR          LAB_772e

LAB_772a:
    OFFIW       (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_1
    JR          LAB_7730

LAB_772e:
    XRI         A,80h

LAB_7730:
    BIT         0,(V_OFFSET(MAYBE_voice_number_80d3))
    JR          LAB_7737

    BIT         0,(V_OFFSET(data_80e6))
    JR          LAB_773c

    JR          LAB_773a

LAB_7737:
    BIT         1,(V_OFFSET(data_80e6))
    JR          LAB_773c

LAB_773a:
    ORI         A,40h
LAB_773c:
    STAX        (HL+15h)
    LDED        (UNKNOWN_pointer_to_patch_data_80d1)
    DMOV        EA,DE
    STEAX       (HL+5)

; Restore original interrupt masking.
    POP         V
    MOV         MKL,A
    CALL        UNKNOWN_upd933_updates_waveform_7454
    CALL        UNKNOWN_master_tune_called_per_voice_752a

_move_to_next_voice_774f:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1
    INRW        (V_OFFSET(MAYBE_voice_number_80d3))
    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQI         A,0
    JRE         _voice_loop_76dd

    RET

; =============================================================================
; HL = ?
; =============================================================================
UNKNOWN_upd933_7762:
    STAX        (HL+17h)
    MVI         A,0
    STAX        (HL+16h)
    PUSH        HL
    DW 00AFh   ;    LDAX        (HL+00h)
    LXI         HL,upd933_data_UNKNOWN_7773
    CALL        upd933_send_register_and_data_at_hl_743b
    POP         HL
    RET

upd933_data_UNKNOWN_7773:
    DB          00h
    DB          0E5h
    DB          00h

; =============================================================================
; Called per channel(?) when changing patch, or starting a new note.
; D: Channel index?
; =============================================================================
patch_called_per_channel_7776:
    MOV         A,D

; Calculate an index into buffer at 0x8600.
; DE = Voice index * 16.
    MVI         B,10h
    MUL         B
    LXI         DE,unknown_voice_data_8600
    DADD        EA,DE
    DMOV        DE,EA

    DI

    LDEAX       (DE+VOICE_DATA_8600_2)
    STEAX       (DE+VOICE_DATA_8600_8)
    LXI         EA,0
    STEAX       (DE+VOICE_DATA_8600_A)
    STEAX       (DE+VOICE_DATA_8600_C)

    EI
    RET

; =============================================================================
patch_call_function_per_channel_7793:
    MVI         A,0

_channel_loop_7795:
    PUSH        V
    MOV         D,A
    CALL        patch_called_per_channel_7776
    POP         V

; Increment A.
; Return if A == 4.
    INR         A
    ONI         A,00000100b
    JR          _channel_loop_7795

    RET

; =============================================================================
FUN_77a0:
    MOV         A,D
    EQI         A,04h
    JR          LAB_77ae

    LDAW        (V_OFFSET(tone_mix_UNKNOWN_8005))
    CALL        UNKNOWN_loop_over_voices_780b
    JR          LAB_77b5

; =============================================================================
UNKNOWN_loop_over_voices_77aa:
    MOV         A,D
    NEI         A,6
    RET

LAB_77ae:
    MVI         A,0
    CALL        UNKNOWN_loop_over_voices_780b
    MVI         A,0

LAB_77b5:
    MVI         A,2
    MOV         C,A

    MVI         A,0FFh
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    LXI         HL,MAYBE_voice_data_8640

; Save interrupt mask state, and mask interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh

_voice_loop_77c5:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JRE         _move_to_next_voice_77f6

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    XRA         A,C
    ONI         A,2
    JRE         _move_to_next_voice_77f6

    DW 00AFh   ;    LDAX        (HL+00h)
    ANI         A,3
    EQI         A,0
    JR          LAB_77ee

    PUSH        HL
    PUSH        EA
    LDAX        (HL+VOICE_INFO_8640_a)
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    STAX        (HL+VOICE_INFO_8640_a)
    LDEAX       (HL+VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE)
    DMOV        HL,EA
    STAX        (HL+VOICE_INFO_8640_a)
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    STAX        (HL+VOICE_INFO_8640_a)
    POP         EA
    POP         HL

LAB_77ee:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ANI         A,~VOICE_INFO_8640_15_TONE_MIX
    ORA         A,C
    STAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)

_move_to_next_voice_77f6:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1

    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0
    JRE         _voice_loop_77c5

; Restore interrupt mask state.
    POP         V
    MOV         MKL,A
    RET

; =============================================================================
UNKNOWN_loop_over_voices_780b:
    MOV         C,A
    MVI         A,11001100b
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    LXI         HL,MAYBE_voice_data_8640

; Save interrupt mask state, and mask interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh

_voice_loop_7819:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JR          _move_to_next_voice_782d

    MOV         A,C
    STAX        (HL+VOICE_INFO_8640_25)
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          LAB_782c

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    MOV         A,C
    STAX        (HL+VOICE_INFO_8640_25)
    POP         HL
LAB_782c:
    EI

_move_to_next_voice_782d:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1

    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0
    JRE         _voice_loop_7819

; Restore interrupt mask state.
    POP         V
    MOV         MKL,A
    RET

; =============================================================================
; D: Voice number?
; E: ???
; =============================================================================
FUN_7842:
    MOV         A,E
    STAW        (V_OFFSET(data_80D6))

; Save MKL, mask interrupts.
    MOV         A,MKL
    PUSH        V
    ORI         MKL,0FFh
    MOV         A,D

    CALL        voice_get_pointer_to_voice_data_for_voice_number_7cf8
    CALL        UNKNOWN_voice_7878

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          LAB_785d

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        UNKNOWN_voice_7878

LAB_785d:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_TONE_MIX
    JR          _restore_interrupt_masking_and_exit_7874

    LDEAX       (HL+VOICE_INFO_8640_3_PTR_TO_OTHER_VOICE)
    DMOV        HL,EA
    CALL        UNKNOWN_voice_7878

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          _restore_interrupt_masking_and_exit_7874

    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        UNKNOWN_voice_7878

_restore_interrupt_masking_and_exit_7874:
    POP         V
    MOV         MKL,A
    RET

; =============================================================================
; HL: 0x8640[voice]
; =============================================================================
UNKNOWN_voice_7878:
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_13_8
    JR          LAB_788c

    LDAX        (HL+VOICE_INFO_8640_9)
    STAX        (HL+VOICE_INFO_8640_a)

    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+VOICE_INFO_8640_9)

    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_14_PORTA
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    RET

LAB_788c:
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    OFFI        A,VOICE_INFO_8640_14_PORTA
    JR          LAB_7899

; Porta flag not set?
; Sets porta flag?
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_14_PORTA
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    JRE         LAB_7921

LAB_7899:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_8
    JRE         LAB_7921

    LDAX        (HL+VOICE_INFO_8640_10)
    MOV         C,A
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_10
    JR          LAB_78ac

    LDAX        (HL+VOICE_INFO_8640_b)
    SUB         A,C
    JR          LAB_78b0

LAB_78ac:
    LDAX        (HL+VOICE_INFO_8640_b)
    ADD         A,C

LAB_78b0:
    STAX        (HL+VOICE_INFO_8640_a)
    LDAX        (HL+0Fh)
    EQI         A,0
    JR          LAB_78bd

    LDAX        (HL+VOICE_INFO_8640_e)
    NEI         A,0
    JRE         LAB_7921

LAB_78bd:
    LDAX        (HL+VOICE_INFO_8640_a)
    EQAW        (V_OFFSET(data_80D6))
    JR          LAB_78c9

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,010h
    JR          LAB_78e4

    JR          LAB_78d7

LAB_78c9:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,010h
    JR          LAB_78de

    LDAW        (V_OFFSET(data_80D6))
    MOV         C,A
    LDAX        (HL+0ah)
    GTA         C,A
    JRE         LAB_78ff

LAB_78d7:
    LDAX        (HL+0ah)
    SUI         A,1
    STAX        (HL+0bh)
    JR          LAB_78ea

LAB_78de:
    LDAX        (HL+0ah)
    GTAW        (V_OFFSET(data_80D6))
    JR          LAB_78ff

LAB_78e4:
    LDAX        (HL+0ah)
    ADI         A,1
    STAX        (HL+0bh)
LAB_78ea:
    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+0ah)
    LDEAX       (HL+14)
    DSLR        EA
    DMOV        DE,EA
    LXI         EA,8000h
    DSUB        EA,DE
    DSLL        EA
    STEAX       (HL+14)
    JR          LAB_7907

LAB_78ff:
    LDAX        (HL+0ah)
    STAX        (HL+0bh)
    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+0ah)
LAB_7907:
    MVI         A,0
    STAX        (HL+010h)
    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+0dh)
    LDAX        (HL+0bh)
    MOV         C,A
    LDAX        (HL+0ah)
    CALL        FUN_70c4
    LDAX        (HL+0Ch)
    LBCD        (portamento_freq_increment_80cd)
    CALL        porta_UNKNOWN_7103
    JR          LAB_7928

LAB_7921:
    LDAW        (V_OFFSET(data_80D6))
    STAX        (HL+0dh)
    CALL        porta_UNKNOWN_70dd

LAB_7928:
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_15_20
    STAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    RET

; =============================================================================
UNKNOWN_porta_on_792f:
    MVI         D,5

; =============================================================================
UNKNOWN_porta_on_7931:
    MVI         C,10h
    JR          UNKNOWN_porta_7938

; =============================================================================
UNKNOWN_porta_off_7934:
    MVI         D,5

; =============================================================================
UNKNOWN_porta_off_7931:
    MVI         C,0

UNKNOWN_porta_7938:
    MVI         B,9
    PUSH        BC
    CALL        UNKNOWN_loads_value_from_table_75f5
    NOP
    POP         BC
    LXI         HL,MAYBE_voice_data_8640

_voice_loop_7943:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JR          _move_to_next_voice_795d

    DI
    CALL        UNKNOWN_voice_portamento_79be

    DW 00AFh   ;    LDAX        (HL+00h)
    OFFI        A,1
    JR          _enable_interrupts_and_move_to_next_voice_795c

; Tone mix inactive.
    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          _enable_interrupts_and_move_to_next_voice_795c

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        UNKNOWN_voice_portamento_79be
    POP         HL

_enable_interrupts_and_move_to_next_voice_795c:
    EI

_move_to_next_voice_795d:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1

    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0
    JRE         _voice_loop_7943

    RET

; =============================================================================
FUN_796f:
    MVI         D,5

; =============================================================================
FUN_7971:
    MVI         C,1
    JR          voice_vibrato_on_off_UNKNOWN_7978

; =============================================================================
FUN_7974:
    MVI         D,5

; =============================================================================
voice_vibrato_on_off_UNKNOWN_0_7976:
    MVI         C,0

; =============================================================================
; C: ?
; =============================================================================
voice_vibrato_on_off_UNKNOWN_7978:
    MVI         B,11000b
    PUSH        BC
    CALL        UNKNOWN_loads_value_from_table_75f5
    NOP
    POP         BC
    LXI         HL,MAYBE_voice_data_8640

_voice_loop_7983:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JR          _move_to_next_voice_799d

    DI
    CALL        UNKNOWN_voice_info_vibrato_79af

; Is odd voice number?
    DW 00AFh   ;    LDAX        (HL+00h)
    OFFI        A,1
    JR          _enable_irq_move_to_next_voice_799c

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ONI         A,VOICE_INFO_8640_15_80
    JR          _enable_irq_move_to_next_voice_799c

    PUSH        HL
    CALL        return_pointer_to_voice_ptr_in_hl_plus_1_7d05
    CALL        UNKNOWN_voice_info_vibrato_79af
    POP         HL

_enable_irq_move_to_next_voice_799c:
    EI

_move_to_next_voice_799d:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1

    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    EQIW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4)),0
    JRE         _voice_loop_7983

    RET

; =============================================================================
; B: Flag bitmask to disable?
; C: Flag bitmask to enable?
; HL: 0x8640[voice]
; =============================================================================
UNKNOWN_voice_info_vibrato_79af:
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ANA         A,B
    ORA         A,C
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)

    LDAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_15_20
    STAX        (HL+VOICE_INFO_8640_15_FLAGS_UNKNOWN)
    RET

; =============================================================================
; B: Flag bitmask to clear.
; C: Flag bitmask to set.
; HL: Pointer to voice info.
; =============================================================================
UNKNOWN_voice_portamento_79be:
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ANA         A,B
    ORA         A,C
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)

    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    NEI         C,0
    ORI         A,VOICE_INFO_8640_13_40
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    RET

; =============================================================================
pitch_bend_range_modified_79d0:
    LDAW        (V_OFFSET(pitch_bend_range_8003))
    NEI         A,0                                 ; Skip if (r≠byte)
    JR          _bend_range_zero_79ec

; Clamp at 12.
    LTI         A,12                                ; Skip if (r<byte)
    MVI         A,12
    LXI         HL,pitch_bend_curve_03a9
    DCR         A
    ADD         A,A
    LDEAX       (HL+A)
    DMOV        DE,EA

_store_and_exit_79e2:
    DI
    SDED        (MAYBE_pitch_bend_increment_80c0)
    ORIW        (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_8
    EI
    RET

_bend_range_zero_79ec:
    LXI         DE,0
    JR          _store_and_exit_79e2

; =============================================================================
UNKNOWN_master_tune_79f0:
    DMOV        DE,EA
    MOV         A,D
    ANI         D,7Fh
    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_20
    OFFI        A,FLAGS_80C8_80
    ORIW        (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_20
    SDED        (upd933_data_master_tune_80ca)

; Loops over each voice?
    MVIW        (V_OFFSET(MAYBE_voice_number_80d3)),0
    LXI         HL,MAYBE_voice_data_8640

_process_voice_loop_7a07:
    CALL        UNKNOWN_master_tune_called_per_voice_752a

; Add 0x28 to L to move to next voice?
; If this carries, add 1 to H.
    ADINC       L,28h
    ADI         H,1

; Increment, and test whether the voice number index has reached 8 (bit 3).
    INRW        (V_OFFSET(MAYBE_voice_number_80d3))
    BIT         3,(V_OFFSET(MAYBE_voice_number_80d3))
    JR          _process_voice_loop_7a07

    RET

; =============================================================================
portamento_time_calculate_final_value_7a16:
    LDAW        (V_OFFSET(portamento_time_8004))
    LTI         A,5                                 ; Skip if (r<byte)
    JR          _value_above_5_7a24

; Portamento time < 5.
    ADD         A,A
    LXI         HL,portamento_data_time_less_than_5_7a32
    LDEAX       (HL+A)
    DMOV        BC,EA
    JR          _store_value_7a2d

_value_above_5_7a24:
; A = (99 - portamento_time) + 1.
    MOV         B,A
    MVI         A,99
    SUB         A,B
    INR         A
    CALL        portamento_time_modified_create_freq_increment_0287

_store_value_7a2d:
    SBCD        (portamento_freq_increment_80cd)
    RET

portamento_data_time_less_than_5_7a32:
    DW          0800h
    DW          0400h
    DW          0380h
    DW          0300h
    DW          0280h

; =============================================================================
called_during_irq_updates_upd933_pitch_7a3c:
    PUSH        V
    MOV         A,MKL
; Mask all interrupts.
    PUSH        V
    ORI         MKL,0FFh

    PUSH        EA
    PUSH        BC
    PUSH        DE
    PUSH        HL
    EI

    LDAW        (V_OFFSET(data_80f4))
    INR         A
    ONI         A,2
    JR          LAB_7a55

    CALL        loops_over_80f5_UNKNOWN_7db2

    MVIW        (V_OFFSET(data_80f4)),0
    JR          LAB_7a5d

LAB_7a55:
    STAW        (V_OFFSET(data_80f4))
    CALL        loops_over_80f5_UNKNOWN_7db2
    JMP         _exit_7ced

LAB_7a5d:
; A = 5 if not in solo mode.
; Otherwise currently selected solo midi voice.
    LDAW        (V_OFFSET(currently_selected_solo_midi_channel_8025))
    ONIW        (V_OFFSET(UNKNOWN_flags_8031)),FLAGS_8031_SOLO_MODE
    MVI         A,5
    MOV         D,A

    CALL        UNKNOWN_called_during_irq_7d1d

; Load last pitch bend value into A.
    LXI         EA,0
    LDAW        (V_OFFSET(pitch_bend_input_80cc))
    MOV         EAL,A

; Read latest pitch bend value.
; Add to EA, then halve.
; Is this an averaging mechanism?
    MOV         A,CR1
    EADD        EA,A
    DSLR        EA
    MOV         A,EAL
    STAW        (V_OFFSET(pitch_bend_input_80cc))

; Test to see whether any input represents a spurious electrical signal.
; Then check whether it's changed from its default value.
    CALL        pitch_bend_filter_spurious_input_7d4e
    STAW        (V_OFFSET(pitch_bend_value_new_80ef))
    NEAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    JR          _pitch_bend_wheel_inactive_7a9d

; Pitch bend wheel is active, value has changed from its initial value.
    ORIW        (V_OFFSET(MAYBE_pitch_bend_wheel_active_flag_80fe)),1
    MOV         B,A
; Reset the incoming MIDI pitch bend value.
    MVI         A,0
    STAW        (V_OFFSET(midi_pitch_bend_incoming_value_804b))

; Test whether the pitch bend wheel has changed by more than 2?
; This will filter out any spurious signals.
    LDAW        (V_OFFSET(pitch_bend_value_current_80f0))
    MOV         C,A
    MOV         A,B
    CALL        pitch_bend_active_filter_spurious_input_7d69

; Test whether this flag is set, indicating a valid change.
    OFFIW       (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_PITCH_BEND_ACTIVE
    JRE         _UNKNOWN_calculate_new_pitch_bend_7ac9

; Pitch bend change was invalid.
    BIT         FLAGS_80C8_8_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JRE         LAB_7b41

; Clear this bit, if set.
; This bit is set when bend range is changed?
    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_8
    JRE         LAB_7b09

_pitch_bend_wheel_inactive_7a9d:
    BIT         0,(V_OFFSET(MAYBE_pitch_bend_wheel_active_flag_80fe))
    JR          _reset_pitch_bend_value_7aa5

; Clear the flag.
    ANIW        (V_OFFSET(MAYBE_pitch_bend_wheel_active_flag_80fe)),0
    JRE         _UNKNOWN_calculate_new_pitch_bend_7ac9

_reset_pitch_bend_value_7aa5:
; Is the pitch bend already at its initial value?
    LDAW        (V_OFFSET(pitch_bend_value_current_80f0))
    NEAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    JR          _convert_incoming_midi_pitch_bend_value_7ab0

; Reset to initial value.
    LDAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    STAW        (V_OFFSET(pitch_bend_value_current_80f0))
    JR          _UNKNOWN_calculate_new_pitch_bend_7ac9

_convert_incoming_midi_pitch_bend_value_7ab0:
; Convert the incoming MIDI pitch bend value to its internal representation.
    MVI         A,7Fh
    ANAW        (V_OFFSET(midi_pitch_bend_incoming_value_804b))
    MVI         B,064h
    MUL         B
    MVI         B,7Fh
    DIV         B
    MOV         A,EAL

    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_BEND_POLARITY_NEGATIVE
    ; Set this flag if the bend polarity is negative.
    OFFIW       (V_OFFSET(midi_pitch_bend_incoming_value_804b)),10000000b
    ORIW        (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_BEND_POLARITY_NEGATIVE

    JRE         LAB_7b1f

_UNKNOWN_calculate_new_pitch_bend_7ac9:
; Does this add the current/previous values, and average?
    LDAW        (V_OFFSET(pitch_bend_value_new_80ef))
    LXI         EA,0
    MOV         EAL,A
    LDAW        (V_OFFSET(pitch_bend_value_current_80f0))
    EADD        EA,A
    DSLR        EA

    MOV         A,EAL
    STAW        (V_OFFSET(pitch_bend_value_current_80f0))

    MOV         B,A
    OFFIW       (V_OFFSET(MAYBE_pitch_bend_initial_polarity_80f2)),10000000b
    JR          LAB_7ae1

    ADDW        (V_OFFSET(MAYBE_pitch_bend_initial_polarity_80f2))
    JR          LAB_7aea

LAB_7ae1:
    MVI         A,7Fh
    ANAW        (V_OFFSET(MAYBE_pitch_bend_initial_polarity_80f2))
    MOV         C,A
    MOV         A,B
    SUB         A,C

LAB_7aea:
; Skip if > 0x1B.
; Clamp at 0x1B (27).
    GTI         A,01bh
    MVI         A,01bh

    SUI         A,01bh

; Skip if less than 0xC9 (201).
; Clamp at 0xC9.
    LTI         A,0c9h
    MVI         A,0c9h


    MVI         B,7Fh
    MUL         B
    MVI         B,064h
    DIV         B
    MOV         A,EAL
    MOV         B,A

    LDAW        (V_OFFSET(UNKNOWN_pitch_bend_80f1))
    NEA         A,B
    JR          LAB_7b09

    MOV         A,B
    STAW        (V_OFFSET(UNKNOWN_pitch_bend_80f1))
    CALL        midi_send_pitch_bend_36bd

LAB_7b09:
    LDAW        (V_OFFSET(pitch_bend_value_current_80f0))
    MOV         B,A
    GTAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    JR          LAB_7b18

    SUBW        (V_OFFSET(pitch_bend_value_initial_80eb))
    DCR         A
    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_BEND_POLARITY_NEGATIVE
    JR          LAB_7b1f

LAB_7b18:
    LDAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    SUB         A,B
    ORIW        (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_BEND_POLARITY_NEGATIVE

LAB_7b1f:
    LTI         A,064h
    MVI         A,064h
    NEI         A,064h
    JR          LAB_7b3b

    LBCD        (MAYBE_pitch_bend_increment_80c0)
    CALL        multiply_a_by_bc_0236
    DSLR        EA
    DSLR        EA
    DSLR        EA
    DSLR        EA
    DMOV        BC,EA

LAB_7b36:
    SBCD        (UNKNOWN_pitch_bend_word_80cf)
    JR          LAB_7b41

LAB_7b3b:
    LDAW        (V_OFFSET(pitch_bend_range_8003))
    MOV         B,A
    MVI         C,0
    JR          LAB_7b36

LAB_7b41:
; Mask INT1.
    ANI         MKL,~MKL_MK1
    MVI         B,0
    CALL        voice_resets_8600_array_6d0e

; @NOTE: Is this the beginning of the voice frequency processing?
    MVIW        (V_OFFSET(voice_number_80d5)),0
    LXI         HL,MAYBE_voice_data_8640
_MAYBE_voice_pitch_loop_7b4f:
    DI
    LDAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    MOV         D,A
    OFFI        A,VOICE_INFO_8640_13_1
    JR          _process_voice_7b5e

    ANI         A,(~VOICE_INFO_8640_13_40)
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    EI
    JMP         _move_to_next_voice_7ce0

_process_voice_7b5e:
    LDEAX       (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
; C = HL+14, B = HL+15.
    DMOV        BC,EA
    ANI         A,110b
    NEI         A,0
    JR          LAB_7b7a

    EQI         A,2
    JR          LAB_7b6e

    ANI         B,~VOICE_INFO_8640_15_8
    JR          LAB_7b7a

LAB_7b6e:
    ANI         B,~VOICE_INFO_8640_15_10
    ORI         B,VOICE_INFO_8640_15_8

    NEI         A,4
    JR          LAB_7b7a

    ORI         B,VOICE_INFO_8640_15_10

LAB_7b7a:
    MOV         A,D
    ANI         A,10111001b
    STAX        (HL+VOICE_INFO_8640_13_FLAGS_UNKNOWN)
    EI
    ONI         B,VOICE_INFO_8640_15_8
    JRE         LAB_7bd3

    ONI         D,40h
    JR          LAB_7b8c

    LDAX        (HL+VOICE_INFO_8640_C_WORD)
    JR          LAB_7bab

LAB_7b8c:
    LDAX        (HL+VOICE_INFO_8640_22)
    MOV         D,A
    LDAX        (HL+VOICE_INFO_8640_e)
    ADD         A,D
    STAX        (HL+VOICE_INFO_8640_e)
    LDEAX       (HL+VOICE_INFO_8640_23)
    DMOV        DE,EA
    SKN         CY
    INX         DE
    LDEAX       (HL+VOICE_INFO_8640_F_WORD)
    DADD        EA,DE
    STEAX       (HL+VOICE_INFO_8640_F_WORD)
    MOV         A,EAH
    MOV         D,A
    LDAX        (HL+VOICE_INFO_8640_C_WORD)
    SUBNB       D,A
    JR          LAB_7bba

LAB_7bab:
    ANI         B,0F7h
    STAX        (HL+VOICE_INFO_8640_10)
    MVI         A,0
    STAX        (HL+VOICE_INFO_8640_e)
    STAX        (HL+VOICE_INFO_8640_F_WORD)
    LDAX        (HL+VOICE_INFO_8640_d)
    STAX        (HL+VOICE_INFO_8640_b)

; This is reached when portamento enabled, and multiple notes active.
LAB_7bba:
    LDEAX       (HL+VOICE_INFO_8640_F_WORD)
    DMOV        DE,EA
; Is this loading the pitch?
    LDEAX       (HL+VOICE_INFO_8640_1E_PITCH_UNKNOWN)

    OFFI        B,VOICE_INFO_8640_15_10
    JR          LAB_7bc9

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          LAB_7bcc

LAB_7bc9:
    CALL        subtract_de_from_ea_clamp_at_0_024b

LAB_7bcc:
    ONI         B,VOICE_INFO_8640_15_8
    STEAX       (HL+VOICE_INFO_8640_1E_PITCH_UNKNOWN)
    JR          LAB_7bea

LAB_7bd3:
    LDEAX       (HL+VOICE_INFO_8640_1E_PITCH_UNKNOWN)
    ONI         C,VOICE_INFO_8640_14_8
    JR          LAB_7bdb

    JR          LAB_7bee

LAB_7bdb:
    OFFI        C,VOICE_INFO_8640_14_VIBRATO_ENABLED
    JRE         LAB_7c01

    ONI         B,VOICE_INFO_8640_15_20
    JRE         _move_to_next_voice_7ce0

    ANI         B,~VOICE_INFO_8640_15_20
    JRE         _prepare_pitch_value_for_upd933_7cbc

LAB_7bea:
    ONI         C,VOICE_INFO_8640_14_8
    JR          LAB_7bfc

LAB_7bee:
    LDED        (UNKNOWN_pitch_bend_word_80cf)
    BIT         FLAGS_80C8_BEND_POLARITY_NEGATIVE_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JR          _pitch_bend_polarity_is_positive_7bf9

; Pitch bend polarity is negative.
    CALL        subtract_de_from_ea_clamp_at_0_024b
    JR          LAB_7bfc

_pitch_bend_polarity_is_positive_7bf9:
    CALL        add_de_to_ea_clamp_at_ffff_0245

LAB_7bfc:
    ONI         C,VOICE_INFO_8640_14_VIBRATO_ENABLED
    JRE         _prepare_pitch_value_for_upd933_7cbc

LAB_7c01:
    ANI         B,~VOICE_INFO_8640_15_20
    PUSH        EA
    PUSH        HL
    PUSH        BC
; HL = 0x8600.
    LDEAX       (HL+VOICE_INFO_8640_7_PTR_TO_8600)
    DMOV        HL,EA

    DW 00AFh   ;    LDAX        (HL+00h)
    OFFI        A,VOICE_DATA_8600_0_2
    JRE         LAB_7caa

    ORI         A,VOICE_DATA_8600_0_2
    DW 00BFh   ;    STAX        (HL+00h)

    LDEAX       (HL+VOICE_INFO_8640_8_WORD)
    LXI         DE,0
    DNE         EA,DE
    JR          LAB_7c2f

    MVI         E,1
    DSUB        EA,DE
    STEAX       (HL+VOICE_INFO_8640_8_WORD)
    DI
    LXI         EA,0
    STEAX       (HL+VOICE_DATA_8600_C)
    EI
    JRE         LAB_7caa

LAB_7c2f:
; HL = 0x8600[voice].
    LDEAX       (HL+VOICE_DATA_8600_A)
    DMOV        DE,EA
    LDEAX       (HL+VOICE_DATA_8600_4)

; Is this testing the polarity of something?
    OFFI        D,80h
    JR          LAB_7c44

    DADD        EA,DE
    DMOV        DE,EA
    OFFI        D,80h
    LXI         DE,8000h
    JR          LAB_7c4d

LAB_7c44:
    DADD        EA,DE
    DMOV        DE,EA
    ONI         D,80h
    LXI         DE,0

LAB_7c4d:
    DMOV        EA,DE
    STEAX       (HL+VOICE_DATA_8600_A)
    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_1
    DADD        EA,DE
    SKN         CY
    ORIW        (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_1
    MOV         A,EAH
    MOV         C,A

    LDAX        (HL+VOICE_DATA_8600_1)
    ONI         A,2
    JR          _7c6f

    MVI         C,0
    BIT         FLAGS_80C8_1_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JRE         LAB_7c8e

    MVI         C,0FFh
    ANIW        (V_OFFSET(UNKNOWN_flags_80c8)),~FLAGS_80C8_1
    JRE         LAB_7c8e

_7c6f:
; Is the number of this other voice above 4?
    ONI         A,100b
    JR          _7c76

    BIT         FLAGS_80C8_1_BIT,(V_OFFSET(UNKNOWN_flags_80c8))
    JR          LAB_7c8e

    JR          LAB_7c7b

_7c76:
    ONI         A,020h
    JR          LAB_7c7f

    BIT         FLAGS_80C8_1_BIT,(V_OFFSET(UNKNOWN_flags_80c8))

LAB_7c7b:
    XRI         C,0FFh
    JR          LAB_7c8e

LAB_7c7f:
    DMOV        DE,EA
    ONI         D,80h
    JR          LAB_7c8a

    LXI         EA,0ffffh
    DSUB        EA,DE
    DMOV        DE,EA

LAB_7c8a:
    DADD        EA,DE
    MOV         A,EAH
    MOV         C,A

LAB_7c8e:
    MOV         A,C

; BC = 8600[6]
; EA = A * BC.
; EA = EA << 2.
    LDEAX       (HL+VOICE_DATA_8600_6)
    DMOV        BC,EA
    CALL        multiply_a_by_bc_022b
    DSLL        EA
    DSLL        EA
    DI
    STEAX       (HL+VOICE_DATA_8600_C)

    DW 00AFh   ;    LDAX        (HL+00h)
    ANI         A,0FEh
    OFFIW       (V_OFFSET(UNKNOWN_flags_80c8)),FLAGS_80C8_1
    ORI         A,1
    DW 00BFh   ;    STAX        (HL+00h)
    EI

LAB_7caa:
    LDEAX       (HL+VOICE_DATA_8600_C)
    POP         BC
    DMOV        DE,EA
    POP         HL
    POP         EA
; Skips based on polarity?
    CALL        UNKNOWN_irq_pitch_7d0f
    JR          LAB_7cb9

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          _prepare_pitch_value_for_upd933_7cbc

LAB_7cb9:
    CALL        subtract_de_from_ea_clamp_at_0_024b

_prepare_pitch_value_for_upd933_7cbc:
; EA = EA * 2.
; If EA is above 0x7100, clamp at the upper limit of 0xE200
; without doubling.
    DMOV        DE,EA
    LTI         D,071h
    JR          _clamp_at_upper_limit_7cc5

    CALL        add_de_to_ea_clamp_at_ffff_0245
    JR          _write_pitch_to_upd933_7cc8

_clamp_at_upper_limit_7cc5:
    LXI         EA,0e200h

_write_pitch_to_upd933_7cc8:
    MOV         A,EAL
    MOV         (upd933_data_pitch_lsb_80c7),A
    MOV         A,EAH
    MOV         (upd933_data_pitch_msb_80c6),A

    PUSH        HL
    LXI         HL,upd933_data_pitch_index_80c5
    LDAW        (V_OFFSET(voice_number_80d5))
    CALL        upd933_send_register_and_data_at_hl_743b
    POP         HL

    DMOV        EA,BC
    STEAX       (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)

_move_to_next_voice_7ce0:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,028h
    ADI         H,1

; Test if all 8 voices have been processed.
    INRW        (V_OFFSET(voice_number_80d5))
    BIT         3,(V_OFFSET(voice_number_80d5))
    JMP         _MAYBE_voice_pitch_loop_7b4f

_exit_7ced:
    POP         HL
    POP         DE
    POP         BC
    POP         EA
    POP         V
    DI
    MOV         MKL,A
    POP         V
    EI
    RETI

; =============================================================================
; Gets a pointer to the voice entry in the array at 0x8640.
; A: Voice number?
;
; Returns pointer in HL.
; =============================================================================
voice_get_pointer_to_voice_data_for_voice_number_7cf8:
    PUSH        BC
    MVI         B,28h
    MUL         B
    LXI         HL,MAYBE_voice_data_8640
    DADD        EA,HL
    DMOV        HL,EA
    POP         BC
    RET

; =============================================================================
; HL: Voice info structure (0x8640[v])
; =============================================================================
return_pointer_to_voice_ptr_in_hl_plus_1_7d05:
    LDEAX       (HL+VOICE_INFO_8640_1_PTR_TO_OTHER_VOICE)
    DMOV        HL,EA
    RET

; =============================================================================
; HL: Voice info structure (0x8640[v])
; Returns:
; HL: Pointer to edit buffer.
; =============================================================================
MAYBE_get_pointer_to_edit_buffer_7d0a:
    LDEAX       (HL+VOICE_INFO_8640_5_PTR_TO_PATCH_BFR_EDIT)
    DMOV        HL,EA
    RET

; =============================================================================
; HL: Voice info pointer?
; Returns:
; Skips based on 0x8600?
; =============================================================================
UNKNOWN_irq_pitch_7d0f:
    PUSH        DE
    PUSH        EA
    LDEAX       (HL+VOICE_INFO_8640_7_PTR_TO_8600)
    DMOV        DE,EA
    DW 00ABh   ;    LDAX        (DE+00h)
    POP         EA
    POP         DE
    OFFI        A,1
    RET
    RETS

; =============================================================================
; D: In one case this is the currently selected MIDI solo voice number.
; Otherwise 5 if not in solo mode?
; =============================================================================
UNKNOWN_called_during_irq_7d1d:
    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    PUSH        V
    CALL        UNKNOWN_loads_value_from_table_75f5
    NOP
    MVI         C,0
    LXI         HL,MAYBE_voice_data_8640

_voice_loop_7d29:
    BIT         0,(V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    JR          LAB_7d47

    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ORI         A,VOICE_INFO_8640_14_8
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)

_move_to_next_voice_7d32:
; Add 0x28 to L to move to next voice.
; Add 1 to H if this carries.
    ADINC       L,28h
    ADI         H,1

    INR         C
    LDAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    SLR         A
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))

; Once all 8 voices have been looped over, exit.
    ONI         C,1000b
    JR          _voice_loop_7d29

    POP         V
    STAW        (V_OFFSET(UNKNOWN_voice_number_bitmask_80D4))
    RET

LAB_7d47:
    LDAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    ANI         A,00010001b
    STAX        (HL+VOICE_INFO_8640_14_FLAGS_UNKNOWN)
    JR          _move_to_next_voice_7d32

; =============================================================================
; @COMPLETE
; Checks the pitch bend input value to see whether it's a spurious input by
; testing whether it falls within a threshold of its initial value.
; If it's outside of the filter threshold, the value is adjusted by the size
; of the filter threshold, and returned.
;
; A: Pitch-bend analog input value.
; Returns:
; A: The adjusted pitch bend input value.
; =============================================================================
pitch_bend_filter_spurious_input_7d4e:
    MOV         B,A
    LDAW        (V_OFFSET(pitch_bend_input_threshold_range_80ee))
    MOV         C,A

; Skip if Pitch bend value < Upper threshold.
    LDAW        (V_OFFSET(pitch_bend_input_threshold_upper_80ec))
    GTA         A,B
    JR          _subract_range_7d60

; Skip if Pitch bend value > Lower threshold.
    LDAW        (V_OFFSET(pitch_bend_input_threshold_lower_80ed))
    LTA         A,B
    JR          _add_range_7d64

; If the pitch bend value read from the ADC is within this threshold,
; just return the initial value.
    LDAW        (V_OFFSET(pitch_bend_value_initial_80eb))
    MOV         B,A
    JR          _return_b_7d67

_subract_range_7d60:
; Return Pitch bend value - threshold range.
    MOV         A,C
    SUB         B,A
    JR          _return_b_7d67

_add_range_7d64:
; Return Pitch bend value + threshold range.
    MOV         A,C
    ADD         B,A

_return_b_7d67:
    MOV         A,B
    RET

; =============================================================================
; Is this testing whether the pitch bend value has changed by more than 2?
; A: Pitch bend current input value.
; C: Pitch bend previous input value?
; =============================================================================
pitch_bend_active_filter_spurious_input_7d69:
; Test whether the current value is higher than the previous?
; Skip if A > C.
    GTA         A,C
    JR          _value_lower_7d73

; Value is higher than the previous value.
; Test whether the value is greater by more than 2.
; If so, set the flag and exit.
    ADI         C,2
    GTA         A,C
    JR          _exit_flag_off_7d7f

    JR          _exit_flag_on_7d7b

_value_lower_7d73:
; Value is lower than the previous value.
; Test whether the value is lower by more than 2.
; If so, set the flag and exit.
    SUI         C,2
    LTA         A,C
    JR          _exit_flag_off_7d7f

    INRW        (V_OFFSET(pitch_bend_value_new_80ef))

_exit_flag_on_7d7b:
    ORIW        (V_OFFSET(UNKNOWN_flags_80c9)),FLAGS_80C9_PITCH_BEND_ACTIVE
    RET

_exit_flag_off_7d7f:
    ANIW        (V_OFFSET(UNKNOWN_flags_80c9)),(~FLAGS_80C9_PITCH_BEND_ACTIVE & 0FFh)
    RET

; =============================================================================
; Clears the entry at 0x80f5[D].
; D: Voice#?
; =============================================================================
clear_80f5_at_index_d_7d83:
    PUSH        HL
; B = D & 111b.
; Index clamped at 0-7.
    MOV         A,D
    ANI         A,111b
    MOV         B,A
    LXI         HL,voice_array_80f5
    MVI         A,0
    STAX        (HL+B)
    POP         HL
    RET

; =============================================================================
; Clears the array at 0x80f5
; =============================================================================
clears_80f5_7d90:
    LXI         HL,voice_array_80f5

    MVI         A,0
    STAW        (V_OFFSET(index_into_80f5_array_80fd))

_clear_array_loop_7d97:
    DI
    LDAW        (V_OFFSET(index_into_80f5_array_80fd))
    MOV         B,A
    MVI         A,0
    STAX        (HL+B)
    EI
    MOV         A,B
    INR         A
    STAW        (V_OFFSET(index_into_80f5_array_80fd))
    ONI         A,1000b
    JR          _clear_array_loop_7d97

    RET

; =============================================================================
d_used_as_index_to_store_080_80f5_7da7h:
    MOV         A,D
    ANI         A,7
    MOV         B,A
    LXI         HL,voice_array_80f5
    MVI         A,80h
    STAX        (HL+B)
    RET

; =============================================================================
loops_over_80f5_UNKNOWN_7db2:
    LXI         HL,voice_array_80f5
    MVI         A,0
    STAW        (V_OFFSET(index_into_80f5_array_80fd))

LAB_7db9:
    DI

; Load 0x80f5[A].
    LDAW        (V_OFFSET(index_into_80f5_array_80fd))
    MOV         B,A
    LDAX        (HL+B)

; Increment A, and see if it's 0x80.
    INR         A
    ONI         A,80h   ; Skip if A & ? != 0.
    JR          _reset_value_7dd0

    ONI         A,04h   ; Skip if A & ? != 0.
    JR          _store_byte_7dd2

    MOV         A,B
    PUSH        HL
    PUSH        BC
    MOV         D,A
    EI
    CALL        FUN_736b
    DI
    POP         BC
    POP         HL

_reset_value_7dd0:
    MVI         A,0

_store_byte_7dd2:
    STAX        (HL+B)
    EI

; Increment index. Exit if reached 8.
    LDAW        (V_OFFSET(index_into_80f5_array_80fd))
    INR         A
    STAW        (V_OFFSET(index_into_80f5_array_80fd))
    ONI         A,8
    JRE         LAB_7db9

    RET

; =============================================================================
; These pointers are stored in the individual voice data entries.
; The first pair are stored in voice#0, the second in voice#1, etc.
; Does this have something to do with the order that voices are processed?
; =============================================================================
UNKNOWN_voice_data_pointers_7dde:
    DW          MAYBE_voice_data_entry_5_8708
    DW          MAYBE_voice_data_entry_2_8690

    DW          MAYBE_voice_data_entry_4_86e0
    DW          MAYBE_voice_data_entry_6_8730

    DW          MAYBE_voice_data_entry_7_8758
    DW          MAYBE_voice_data_8640

    DW          MAYBE_voice_data_entry_6_8730
    DW          MAYBE_voice_data_entry_4_86e0

    DW          MAYBE_voice_data_entry_1_8668
    DW          MAYBE_voice_data_entry_6_8730

    DW          MAYBE_voice_data_8640
    DW          MAYBE_voice_data_entry_2_8690

    DW          MAYBE_voice_data_entry_3_86b8
    DW          MAYBE_voice_data_entry_4_86e0

    DW          MAYBE_voice_data_entry_2_8690
    DW          MAYBE_voice_data_8640

upd933_data_init_7dfe:
    DB          028h
    DB          00h
    DB          68h
    DB          00h
    DB          00h
    DB          60h
    DB          00h
    DB          00h
    DB          020h
    DB          00h
    DB          00h
    DB          00h
    DB          80h
    DB          08h
    DS 497
    JMP         RST0
