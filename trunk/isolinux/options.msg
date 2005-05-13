To use a framebuffer console, type "linux vga=xxx"
where xxx denotes a screen resolution and color depth.

Examples:

795 = 1280x1024x24   794 = 1280x1024x16
792 = 1024x768x24    791 = 1024x768x16
789 = 800x600x24     788 = 800x600x16

To enable expert mode type "expert" anywhere after
"linux". This will disable module loading and will
not attempt to bring up your network.

To set your timezone, add TZ=your/timezone (e.g.
TZ=America/New_York or TZ=UTC+4) anywhere after "linux".
Also, add UTC=1 if the hardware clock in your computer
is set to GMT instead of local time.

