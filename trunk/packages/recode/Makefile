# recode Makefile

NM= recode
VRS= 3.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/recode/$(FILE)
SHA-$(FILE)= 2de90cd2ba553bc07d75a29913ea4424dd9e616b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --sysconfdir=/etc --without-included-gettext
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
