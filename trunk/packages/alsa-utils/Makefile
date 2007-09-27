# alsa-utils Makefile

NM= alsa-utils
VRS= 1.0.14
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://gd.tuwien.ac.at/opsys/linux/alsa/utils/$(FILE)
SHA-$(FILE)= 767e71805ee606a4589bda9e95babbca61f9e92f

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure
	make
	make install
	install -m755 ../set-alsa-volume /lib/udev
	echo 'KERNEL=="controlC[0-9]*", ACTION=="add", RUN+="set-alsa-volume %n"' >/etc/udev/rules.d/40-alsa.rules

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
