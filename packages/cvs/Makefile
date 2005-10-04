# cvs Makefile

NM= cvs
VRS= 1.11.20
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/A-C/$(FILE)
SHA-$(FILE)= 47f51a96b5a73e18c96f431f3c494735aa9c0236

PATCH1= $(DIR)-zlib-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/A-C/$(PATCH1)
SHA-$(PATCH1)= facc13bda7cc912db51f3994a5fe9f8374837394

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) $(PATCH1)
	$(std_build)

compile-stage2:
	patch -Np1 -i ../$(PATCH1)
	./configure --prefix=/usr
	make $(PM)
	make install
	install -m755 -d /usr/share/doc/$(DIR)
	install -m644 doc/cvs{,client}.ps /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
