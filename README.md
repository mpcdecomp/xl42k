# xl42k

MPC2000 classic floppy/scsi bootloader for MPC2000XL OS

`XL42K.S` replaces the .EXE loader to read v1.20 XL flash image, patch it, and run it.

## BUILD

```
make                            # build MPC2000.EXE, fetch MPC2KXL.BIN
make format DISK=/dev/diskN     # format FAT12 "XL42K"
make copy                       # copy .EXE and .BIN, sync
```

## NOTES

The `PAD BANK A` handler is patched to cycle banks like on the classic. As such, expect sending MIDI "Bank A" CC to cycle banks, too.

The `SHIFT`-during-playback handler is extended for the XL's panel:
`SHIFT` + `FULL LEVEL` = `TRACK MUTE`, `SHIFT` + `GO TO` = `NEXT SEQ`

The 2k's "digit wheel" drives the XL's `SHIFT` + `LEFT`/`RIGHT` cursor movement in numeric fields.

## OPTIONS

The default build options focus on hardware compatiblity and parity.

`TUNE_LIMIT=480` -- widen `Tune:` limits past the stock +/-240

`MUTE_GROUPS=1` -- add mute group choking to the `Mute Assign` window

`COPY_NOTE_PARAMS=1` -- adds `PARAMS` copying to the `Copy Note Parameters` window, copy params to all

## 2KXL

`2KXL=1` produces an `MPC2KXL.EXE` patching bootloader for the XL instead.

On the XL, hold `REC` + `OVER DUB` while switching on to boot. Nothing is written to flash.

## LICENSE

[PolyForm Noncommercial License 1.0.0](LICENSE.txt)

Fork it, don't sell it. Keep the `xl42k | brockrockman` credit.

`MPC2KXL.BIN` is fetched from Akai's CDN.
