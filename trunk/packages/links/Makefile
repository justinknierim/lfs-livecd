# Links Makefile

NM= links
VRS= 2.1pre17
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/L/$(FILE)
SHA-$(FILE)= 2f89de8b8ea797834444f933222ecf7bd2cea84b

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifeq ($(LFS-ARCH),sparc)
	./configure --prefix=/usr
else
	./configure --prefix=/usr --enable-graphics
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
