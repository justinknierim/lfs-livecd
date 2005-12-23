NM= X.org
VRS= X11R7.0
URLBASE= http://xorg.freedesktop.org/releases/$(VRS)/src/everything/

include $(ROOT)/scripts/functions

download: SHA1SUMS
	awk '/^[^#]/{print $$2}' SHA1SUMS | ( cd $(SRC) ; wget -c -nc -B $(URLBASE) -i /dev/stdin )
	cat SHA1SUMS | ( cd $(SRC) ; sha1sum -c - ) >download.log
	ln -sf `awk '/^[^#]/{print "/$(SRC)/"$$2 }' SHA1SUMS` .
	@touch $@

stage2: Makefile download symlinks utils proto lib
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
	Y-libXvMC Y-libXxf86dga Y-libXxf86misc Y-libXxf86vm
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

compile-y-%:
	# Extra safety measure, due to "test: too many arguments" messages
	# May well be just an unnecessary precaution
	autoreconf --force --install --verbose
	./configure --help
	./configure --prefix=/usr --localstatedir=/var
	make $(PM)
	make DESTDIR=$(ROOT)/debug/$* install
	make install
