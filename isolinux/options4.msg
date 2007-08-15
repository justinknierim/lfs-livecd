7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 4 of 4]:
nomsi noapic nolapic pci=noacpi acpi=off blacklist=yenta-socket ide=nodma
  These options work around various chipset bugs. Try them one-by-one in the
  order given above and in various combinations if the CD does not boot, or if
  a device does not work correctly or fails after hibernating and resuming.

brltty=drv[,dev[,tbl]]
  Example: brltty=bm,usb:

  Enables a refreshable Braille display supported by driver drv, connected to
  device dev, with a translation table tbl. The example specifies a BAUM
  SuperVario 40 Braille display connected by USB with default Braille table.
