# LFS-Bootscripts Makefile

NM= lfs-bootscripts
VRS= 3.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 6de412b717ae09fbaf701ec9485b60f496f173aa

FILE1= console
URL-$(FILE1)= http://www.linuxfromscratch.org/~alexander/patches/$(FILE1)
SHA-$(FILE1)= 2c9c97b6576af6dddedca75cfadf431d5aa53fda

# Targets

include $(ROOT)/scripts/functions

$(FILE1):
	$(call download,$@,$(URL-$@),$(SHA-$@))

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)
	cp $(SRC)/{$(FILE),$(FILE1)} $(LFSSRC)

compile-stage2:
	sed -i s/sane/cooked/ lfs/init.d/functions
	make install-livecd
	install -m 755 lfs/init.d/mountkernfs /etc/rc.d/init.d
	ln -sf ../init.d/mountkernfs /etc/rc.d/rcsysinit.d/S00mountkernfs
	install -m 755 ../udev /etc/rc.d/init.d/
	ln -sf ../init.d/udev /etc/rc.d/rcsysinit.d/S10udev
	install -m 755 ../mountfs /etc/rc.d/init.d/
	ln -sf ../init.d/mountfs /etc/rc.d/rcsysinit.d/S40mountfs
	install -m 755 ../clkconf /etc/rc.d/init.d/
	ln -sf ../init.d/clkconf /etc/rc.d/rcsysinit.d/S59clkconf
	install -m 755 ../langconf /etc/rc.d/init.d/
	ln -sf ../init.d/langconf /etc/rc.d/rcsysinit.d/S69langconf
	mkdir -p /etc/langconf
	install -m 644 ../*.dat /etc/langconf
	install -m 755 ../console.livecd /etc/rc.d/init.d/console
	rm -f /etc/rc.d/rc0.d/S99halt
	rm -f /etc/rc.d/rc6.d/S99reboot
	rm -f /etc/rc.d/*/*mountsqfs /etc/rc.d/*/*startup

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
