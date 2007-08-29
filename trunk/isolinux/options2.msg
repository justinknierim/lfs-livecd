7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 2 of 4]:

toram
  Loads the whole CD contents (except sources and proprietary video
  drivers) to RAM.

  Note: this needs at least 512 MB of RAM, and you also need
  to enable swap if you have less than 768 MB of RAM.

rootdelay=X
  Waits X seconds before attempting to find the CD. Required (with X=20)
  for booting from USB or FireWire CD-ROMs.

all_generic_ide
  Attempts to support unknown PCI IDE and SATA controllers (slow).
  For SATA support to work with this option, the SATA controller
  must be put into "Legacy" (as opposed to "Native") mode in the BIOS.

resume=/dev/XXX
  Uses /dev/XXX for software suspending (AKA hibernation) and resuming.
  See /root/README for details.


