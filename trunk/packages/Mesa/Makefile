# Mesa Makefile

NM= Mesa
VRS= 7.2
DIR= $(NM)-$(VRS)

FILE= MesaLib-$(VRS).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= a6dce814cc56a562890ab79cf4e205f62459a29c

FILE1= MesaDemos-$(VRS).tar.bz2
URL-$(FILE1)= $(HTTPBLFS)/$(NM)/$(FILE1)
SHA-$(FILE1)= 3d7b9b3ee84ed3637849f7598faf3d60c5a2a9fd

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(FILE1)
	$(std_build)

compile-stage2:
	unpack ../$(FILE1) --strip-components=1
	sed 's@FLAGS=\"-g@FLAGS=\"@' -i configure
	./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --localstatedir=/var
	make
	make install
	install -v -m755 progs/xdemos/glx{info,gears} /usr/bin

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
