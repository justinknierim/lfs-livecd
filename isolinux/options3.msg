7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 3 of 4]:
pata
  Uses new libata-based drivers for IDE controllers. This option may be
  required for controller detection or recommended for optimal performance
  on computers manufactured in year 2006 and later.

  Caution: new drivers are safe to use only with IDE chipsets from AMD, Intel,
  ITE, JMicron, Marvell, Netcell, NVIDIA, Serverworks, Promise, Silicon Image,
  VIA, or Winbond. Drivers for other chipsets are likely to contain bugs that
  lead to data loss.

load=module1,module2,...
  Loads the specified modules unconditionally from initramfs. Use if your SCSI
  or IDE controller is not autodetected. If you don't specify this parameter
  and the CD doesn't detect your SCSI or IDE controller, you will be dropped
  into a debugging shell where you can load the needed module manually.

blacklist=module1,module2,...
  Prevents the specified modules from being autoloaded.

module.option=value
  Sets arbitrary module options.

