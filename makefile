.POSIX:
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

BIN_ORIGINAL   := casio_cz101_v2.bin
BIN_OUTPUT     := casio_cz101_v2_rebuild.bin
INPUT_ASM      := casio_cz101_v2.asm
ROM_CHECKSUM   := "d31cb89013579188fad4f53fdc2d04dd"

all: ${BIN_OUTPUT}

clean:
	rm -f ${BIN_OUTPUT}

${BIN_OUTPUT}:
	asl -w -cpu 7810 ${INPUT_ASM} -o casio_cz101_v2.p
	p2bin -l 0 casio_cz101_v2.p ${BIN_OUTPUT}

compare: ${BIN_OUTPUT}
# Compares the checksum of the rebuilt ROM with the original ROM.
# If the original ROM is present, it will also show the differences between the original and rebuilt ROM.
	@if [ "$$(md5sum ${BIN_OUTPUT} | awk '{print $$1}')" = "${ROM_CHECKSUM}" ]; then \
		echo "Build is correct!"; \
	else \
		echo "Build is not correct!"; \
		echo "Differences:"; \
		if [ -f ${BIN_ORIGINAL} ]; then \
			cmp -l ${BIN_ORIGINAL} ${BIN_OUTPUT} | gawk '{printf "Offset: '0x%04X' Original: '0x%02X' Rebuild: '0x%02X'\n", $$1, strtonum(0$$2), strtonum(0$$3)}'; \
		fi; \
		exit 1; \
	fi
