7007To specify options at boot time, type [kernel] [options]
Available kernels:
linux - The default 32-bit kernel
linux64 - A 64-bit kernel for use with CLFS

Options [page 1 of 4]:

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

nodhcp
  Prevents the CD from attempting to obtain an IP address automatically.
  May be required for wireless networking, because the WEP or WPA key
  needs to be set up first.

