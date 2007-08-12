7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 1 of 4]:
vga=[res]
  Examples:
  vga=795 (1280x1024x24)   vga=792 (1024x768x24)   vga=789 (800x600x24)
  vga=794 (1280x1024x16)   vga=791 (1024x768x16)   vga=788 (800x600x16)

  NOTE: This is for the framebuffer console and has nothing to do with X
  server resolution. Also, it causes some X video drivers (e.g., "s3virge") to
  malfunction. X server bug reports will be ignored if you use this option.

TZ=[timezone]
  Examples:  TZ=EDT-4    TZ=America/New_York

  The first example means that the timezone is named "EDT"
  and is 4 hours behind (west) of UTC.

UTC=[0,1]
  Use UTC=1 if the hardware clock is set to UTC or
  use UTC=0 (default) if the hardware clock is set to local time.

LANG=[locale]
  Example: LANG=fr_FR.UTF-8

If you don't specify your timezone or locale at the boot prompt,
a configuration dialog will appear later during boot.

