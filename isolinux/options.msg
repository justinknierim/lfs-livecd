7007To use a framebuffer console, type "linux vga=xxx"
where xxx denotes a screen resolution and color depth.
This has nothing to do with X server resolution, and bug reports
about X window system will be ignored if you pass this parameter.

Examples:

795 = 1280x1024x24   794 = 1280x1024x16
792 = 1024x768x24    791 = 1024x768x16
789 = 800x600x24     788 = 800x600x16

A 64-bit kernel for use with CLFS is available as "linux64"

To set your timezone, add TZ=your_timezone anywhere
after "linux" or "linux.ata". For example, TZ=EDT+4 means that the
timezone is named "EDT" and is 4 hours behind (west) of UTC.
Specifications like TZ=America/New_York also work.
Also, add UTC=1 if the hardware clock in your computer
is set to UTC instead of local time.

Set your locale by adding LANG=your_locale anywhere after "linux".

If you don't specify your timezone or locale at the boot prompt,
a configuration dialog will appear later during boot.

More information is available in /root/README on this CD.

