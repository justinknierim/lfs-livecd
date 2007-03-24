# recode Makefile

NM= recode
VRS= 3.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= http://ftp.gnu.org/gnu/recode/$(FILE)
SHA-$(FILE)= 2de90cd2ba553bc07d75a29913ea4424dd9e616b

PATCH1= $(DIR)-fixes-1.patch
URL-$(PATCH1)= http://www.linuxfromscratch.org/patches/downloads/recode/$(PATCH1)
SHA-$(PATCH1)= 852d654c1b138dfbff3ed202d06e94d0a49f79ee

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr --without-included-gettext
	make
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
