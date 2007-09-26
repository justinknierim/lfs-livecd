7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 4 of 4]:
new_firewire
  Uses the new FireWire stack.

nomsi noapic nolapic pci=noacpi acpi=off blacklist=yenta-socket ide=nodma
  These options work around various chipset bugs. Try them one-by-one in the
  order given above and in various combinations if the CD does not boot, or if
  a device does not work correctly or fails after hibernating and resuming.

brltty=drv[,dev[,tbl]]
  Example: brltty=bm,usb:
  Enables a refreshable Braille display supported by driver drv, connected to
  device dev, with a translation table tbl. The example specifies a BAUM
  SuperVario 40 Braille display connected by USB with default Braille table.

vga=[resolution]
  Examples:
  vga=795 (1280x1024x24)   vga=792 (1024x768x24)   vga=789 (800x600x24)
  vga=794 (1280x1024x16)   vga=791 (1024x768x16)   vga=788 (800x600x16)

  Enables the framebuffer console. This has nothing to do with X
  server resolution. Also, it causes some X video drivers (e.g., "s3virge") to
  malfunction. X server bug reports will be ignored if you use this option.
