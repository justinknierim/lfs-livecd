NM= X.org
VRS= X11R7.0
URLBASE= http://xorg.freedesktop.org/releases/$(VRS)/src/everything/

LIBDRM_VRS= 2.0
FILE1= libdrm-$(LIBDRM_VRS).tar.gz
DIR1= libdrm-$(LIBDRM_VRS)
SHA-$(FILE1)= 679d4b74b93a429bfd28ab4a01b0c80ffdc9ab1c
URL-$(FILE1)= http://dri.freedesktop.org/libdrm/$(FILE1)

MESA_VRS= 6.4.1
FILE2= MesaLib-$(MESA_VRS).tar.bz2
DIR2= Mesa-$(MESA_VRS)
SHA-$(FILE2)= efb70276ccd9cd13dbd7d5e581213a5ca3e4ef25
URL-$(FILE2)= http://easynews.dl.sourceforge.net/sourceforge/mesa3d/$(FILE2)

include $(ROOT)/scripts/functions

download: SHA1SUMS $(FILE1) $(FILE2)
	awk '/^[^#]/{print $$2}' SHA1SUMS | ( cd $(SRC) ; wget -c -nc -B $(URLBASE) -i /dev/stdin )
	cat SHA1SUMS | ( cd $(SRC) ; sha1sum -c - ) >download.log
	ln -sf `awk '/^[^#]/{print "/$(SRC)/"$$2 }' SHA1SUMS` .
	@touch $@

stage2: Makefile download symlinks utils proto lib apps drv
	@touch $@

symlinks: Makefile
	mkdir -p /usr/lib/X11 /etc/X11
	for dir in app-defaults rstart xinit xkb xserver xsm ; do \
		mkdir -p /etc/X11/$$dir ; ln -sf /etc/X11/$$dir /usr/lib/X11 ; \
	done
	@touch $@

utils: Y-util-macros
	@touch $@

proto:	N-applewmproto Y-bigreqsproto \
	Y-compositeproto Y-damageproto Y-dmxproto Y-evieext Y-fixesproto \
	Y-fontcacheproto Y-fontsproto Y-glproto \
	Y-inputproto Y-kbproto N-printproto Y-randrproto Y-recordproto \
	Y-renderproto Y-resourceproto Y-scrnsaverproto Y-trapproto \
	Y-videoproto N-windowswmproto Y-xcmiscproto Y-xextproto \
	Y-xf86bigfontproto Y-xf86dgaproto Y-xf86driproto Y-xf86miscproto \
	Y-xf86rushproto Y-xf86vidmodeproto Y-xineramaproto \
	Y-xproto Y-xproxymanagementprotocol
	@touch $@

lib:	Y-xtrans Y-libXau Y-libXdmcp Y-libX11 Y-libXext N-libAppleWM \
	N-libWindowsWM Y-libdmx Y-libfontenc Y-libFS Y-libICE Y-liblbxutil \
	Y-liboldX Y-libSM Y-libXt Y-libXmu Y-libXpm N-libXp Y-libXaw \
	Y-libXfixes Y-libXcomposite Y-libXrender Y-libXdamage Y-libXcursor \
	Y-libXevie Y-libXfont Y-libXfontcache Y-libXft Y-libXi Y-libXinerama \
	Y-libxkbfile Y-libxkbui N-libXprintUtil N-libXprintAppUtil \
	Y-libXrandr Y-libXres Y-libXScrnSaver Y-libXTrap Y-libXtst Y-libXv \
	Y-libXvMC Y-libXxf86dga Y-libXxf86misc Y-libXxf86vm \
	Y-libdrm Y-mesa
	@touch $@

apps:	Y-xbitmaps \
	N-appres Y-bdftopcf N-beforelight N-bitmap N-editres N-fonttosfnt \
	N-fslsfonts N-fstobdf Y-iceauth N-ico N-lbxproxy N-listres N-luit \
	N-mkcfm Y-mkfontdir Y-mkfontscale N-oclock N-pclcomp N-proxymngr \
	Y-rgb N-rstart Y-scripts Y-sessreg Y-setxkbmap N-showfont Y-smproxy \
	N-twm N-viewres N-x11perf Y-xauth N-xbiff Y-xcalc N-xclipboard \
	N-xclock N-xcmsdb N-xconsole Y-xcursorgen N-xdbedizzy N-xditview \
	N-xdm Y-xdpyinfo Y-xdriinfo N-xedit N-xev N-xeyes N-xf86dga N-xfd \
	N-xfindproxy N-xfontsel N-xfs N-xfsinfo N-xfwp Y-xgamma N-xgc \
	Y-xhost Y-xinit Y-xkbcomp N-xkbevd N-xkbprint Y-xkbutils Y-xkill \
	N-xload N-xlogo N-xlsatoms Y-xlsclients Y-xlsfonts Y-xmag N-xman \
	N-xmessage N-xmh Y-xmodmap N-xmore N-xphelloworld N-xplsprinters \
	N-xpr N-xprehashprinterlist N-xprop Y-xrandr Y-xrdb Y-xrefresh \
	N-xrx Y-xset Y-xsetmode Y-xsetpointer Y-xsetroot N-xsm N-xstdcmap \
	N-xtrap Y-xvidtune N-xvinfo Y-xwd N-xwininfo Y-xwud \
	Y-xcursor-themes Y-xkbdata
	@touch $@

drv:	Y-xorg-server N-xf86-input-aiptek Y-xf86-input-evdev N-xf86-input-ur98 \
	N-xf86-input-acecad N-xf86-input-calcomp N-xf86-input-citron \
	N-xf86-input-digitaledge N-xf86-input-dmc N-xf86-input-dynapro \
	N-xf86-input-elo2300 N-xf86-input-elographics N-xf86-input-fpit \
	N-xf86-input-jamstudio N-xf86-input-joystick Y-xf86-input-keyboard \
	N-xf86-input-magellan N-xf86-input-magictouch N-xf86-input-microtouch \
	Y-xf86-input-mouse N-xf86-input-mutouch N-xf86-input-palmax \
	N-xf86-input-penmount N-xf86-input-spaceorb N-xf86-input-summa \
	N-xf86-input-tek4957 N-xf86-input-void \
	N-xf86-video-wsfb N-xf86-video-sunffb N-xf86-video-sisusb \
	N-xf86-video-v4l Y-xf86-video-apm Y-xf86-video-ark Y-xf86-video-ati \
	Y-xf86-video-chips Y-xf86-video-cirrus Y-xf86-video-cyrix \
	N-xf86-video-dummy Y-xf86-video-fbdev \
	Y-xf86-video-glint Y-xf86-video-i128 Y-xf86-video-i740 \
	Y-xf86-video-i810 Y-xf86-video-imstt Y-xf86-video-mga \
	Y-xf86-video-neomagic Y-xf86-video-newport Y-xf86-video-nsc \
	Y-xf86-video-nv Y-xf86-video-rendition Y-xf86-video-s3 \
	Y-xf86-video-s3virge Y-xf86-video-savage Y-xf86-video-siliconmotion \
	Y-xf86-video-sis N-xf86-video-sunbw2 N-xf86-video-suncg14 \
	N-xf86-video-suncg3 N-xf86-video-suncg6 N-xf86-video-sunleo \
	N-xf86-video-suntcx Y-xf86-video-tdfx Y-xf86-video-tga \
	Y-xf86-video-trident Y-xf86-video-tseng Y-xf86-video-vesa \
	Y-xf86-video-vga Y-xf86-video-via Y-xf86-video-vmware \
	Y-xf86-video-voodoo
	@touch $@

N-%:
	@$(call echo_message, NOT building)
	@grep '^$*' EXCUSES
	@touch $@

Y-%: SHA1SUMS
	@$(call echo_message, Building)
	@make y-$* FILE=`awk '/ $*-/{print $$2}' SHA1SUMS` >$@.log 2>&1
	@touch $@

y-%:
	unpack $(FILE)
	make CROSSVARS=../$(CROSSVARS) -C `basename $(FILE) .tar.bz2` -f ../Makefile compile-$@
	rm -rf `basename $(FILE) .tar.bz2`

Y-libdrm:
	@$(call echo_message, Building)
	@unpack $(FILE1) >$@.log 2>&1
	@make CROSSVARS=../$(CROSSVARS) -C $(DIR1) -f ../Makefile compile-y-libdrm >$@.log 2>&1
	@rm -rf $(DIR1)
	@touch $@

Y-mesa:
	@$(call echo_message, Building)
	@unpack $(FILE2) >$@.log 2>&1
	@make CROSSVARS=../$(CROSSVARS) -C $(DIR2) -f ../Makefile compile-y-mesa >$@.log 2>&1
	@rm -rf $(DIR2)
	@touch $@

compile-y-%:
	# Extra safety measure, due to "test: too many arguments" messages
	# May well be just an unnecessary precaution
	autoreconf --force --install --verbose
	./configure --help
	./configure --prefix=/usr --localstatedir=/var
	make $(PM)
	make DESTDIR=$(ROOT)/debug/$* install
	make install

compile-y-mesa:
	# FIXME x86_64
	make linux-dri-x86 OPT_FLAGS="$(CFLAGS) -DDEFAULT_DRIVER_DIR=\\\"/usr/lib/xorg/modules/dri\\\"" MKDEP="gcc -M" MKDEP_OPTIONS="-MF depend"
	bin/installmesa /usr
	mkdir -p /usr/lib/xorg/modules/dri
	install -v lib/*dri* /usr/lib/xorg/modules/dri

compile-y-xorg-server:
	unpack ../$(FILE2)
	# Extra safety measure, due to "test: too many arguments" messages
	# May well be just an unnecessary precaution
	autoreconf --force --install --verbose
	# Fix build failure
	sed -i -e '1i#include <linux/types.h>' hw/xfree86/os-support/linux/lnx_agp.c
	# 100 dpi is more appropriate for today's displays as a guess
	sed -i -e '/DPI/s,75,100,' hw/xfree86/common/xf86Priv.h hw/dmx/dmxinit.c
	./configure --help
	./configure --prefix=/usr --localstatedir=/var --with-mesa-source=`pwd`/$(DIR2)
	make $(PM)
	make DESTDIR=$(ROOT)/debug/xorg-server install
	make install

