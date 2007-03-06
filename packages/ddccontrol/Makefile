# DDCControl Makefile

NM= ddccontrol
VRS= 0.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://easynews.dl.sourceforge.net/sourceforge/$(NM)/$(FILE)
SHA-$(FILE)= fd5c53286315a61a18697a950e63ed0c8d5acff1

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --disable-gnome-applet
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
