# Fontconfig Makefile

NM= fontconfig
VRS= 2.4.2
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://www.fontconfig.org/release/$(FILE)
SHA-$(FILE)= cd5e30625680a0435563b586275156eaf8d0d34a

FILE1= 65-firefly.conf
FILE2= 66-ttf-thai.conf

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --disable-docs
	make
	make install
	cp -v ../$(FILE1) ../$(FILE2) /etc/fonts/conf.avail
	ln -sfv ../conf.avail/$(FILE1) ../conf.avail/$(FILE2) /etc/fonts/conf.d
	cp -v ../local.conf /etc/fonts

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
