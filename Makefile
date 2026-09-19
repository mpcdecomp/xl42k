MOUNTPOINT ?= /Volumes/XL42K

OPTS = MUTE_GROUPS TUNE_LIMIT COPY_NOTE_PARAMS SKIP_DRUM_SELECT 2KXL
DEFSYM = $(foreach o,$(OPTS),$($(o):%=-Wa,--defsym,OPT_$(o)=%))

ifeq ($(2KXL),1)
EXE = MPC2KXL.EXE
else
EXE = MPC2000.EXE
endif

all: $(EXE) MPC2KXL.BIN

$(EXE): XL42K.O
	dd if=$< of=$@ bs=1 skip=52 count=3584

%.O: %.S
	clang -target i386-unknown-none-elf $(DEFSYM) -c $< -o $@

MPC2KXL.BIN: MPC2KXL.ZIP
	unzip -qoj $< && test -s $@

MPC2KXL.ZIP:
	curl -sSLo $@ https://cdn.inmusicbrands.com/akai/mpc2000xl/mpc2kxl.zip_1114805f0243a1492c5f249c71889b96.zip

format:
	@test -n "$(DISK)" || { echo "usage: make format DISK=/dev/diskN"; exit 1; }
	@test "$$(diskutil info -plist "$(DISK)" 2>/dev/null | plutil -extract Size raw - 2>/dev/null)" = 1474560 || { echo "$(DISK): not a 1.44M floppy"; exit 1; }
	sudo newfs_msdos -F 12 -f 1440 -v XL42K $(DISK)
	diskutil mount $(DISK)

copy: MPC2KXL.BIN
	cp $(EXE) MPC2KXL.BIN "$(MOUNTPOINT)/"
	sync

clean:
	rm -f MPC2000.EXE MPC2KXL.EXE MPC2KXL.BIN

.PHONY: all format copy clean
.INTERMEDIATE: XL42K.O MPC2KXL.ZIP
