# popt Makefile

NM= popt
VRS= 1.10.4
DIR= $(NM)-$(VRS)

FILE= $(NM)-$(VRS).tar.gz
URL-$(FILE)= http://rpm.net.in/mirror/rpm-4.4.x/$(FILE)
SHA-$(FILE)= 10e6649c4c37ecfb6fb4296aeca609b5fdd5e34d

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	sed -i -e "/*origOptString ==/c 0)" popt.c
	autoreconf -f -i -v
	./configure --prefix=/usr
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
