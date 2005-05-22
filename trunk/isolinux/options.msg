To use a framebuffer console, type "linux vga=xxx"
where xxx denotes a screen resolution and color depth.

Examples:

795 = 1280x1024x24   794 = 1280x1024x16
792 = 1024x768x24    791 = 1024x768x16
789 = 800x600x24     788 = 800x600x16

To enable expert mode type "expert" anywhere after
"linux". This will disable module loading and will
not attempt to bring up your network.

To set your timezone, add TZ=your_timezone anywhere
after "linux". For example, TZ=EDT+4 means that the timezone
is named "EDT" and is 4 hours behind (west) of UTC.
Specifications like TZ=America/New_York also work.

Also, add UTC=1 if the hardware clock in your computer
is set to UTC instead of local time.

