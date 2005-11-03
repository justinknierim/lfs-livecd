# GPM Makefile

NM= gpm
VRS= 1.20.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= c48d937e62abb438c2f6439b34ef3332c89af8d1

PATCH1= $(DIR)-segfault-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 85434264c6b790dcc16eb6f01c7ff53184b3f70a

PATCH2= $(DIR)-silent-1.patch
URL-$(PATCH2)= $(HTTPBLFS)/$(NM)/$(PATCH2)
SHA-$(PATCH2)= 24422000764febc4049eb091d475c9751e1771f9

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: Makefile $(FILE) $(PATCH1) $(PATCH2)
	$(std_build)

compile-stage2:
ifneq ($(LFS-ARCH),sparc64)
	patch -Np1 -i ../$(PATCH1)
	patch -Np1 -i ../$(PATCH2)
	./configure --prefix=/usr --sysconfdir=/etc --without-curses
	LDFLAGS="-lm" make
	make install
	cp conf/gpm-root.conf /etc
	/sbin/ldconfig
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
