# For languages that can't be displayed on Linux console, we have, e.g.:
# LC_ALL=C, LANG=zh_CN.UTF-8
# Remove LC_ALL now so that LANG takes effect
unset LC_ALL
if xrandr | grep -q '\*0.*640 x 480.*\*60'
then
xmessage \
"The X server could not obtain the allowed synchronization
frequencies from the monitor because your monitor is not
Plug-n-Play compatible.  Thus, a default resolution of
640 x 480 @ 60 Hz has been used.  This can hurt your eyes.

To fix the problem, press Ctrl + Alt + Backspace, and then
specify the allowed frequency ranges in /etc/X11/xorg.conf
manually.  See /root/README for details."
fi
scim -d
exec startxfce4
