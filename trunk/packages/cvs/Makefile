# cvs Makefile

NM= cvs
VRS= 1.11.21
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= http://ftp.gnu.org/non-gnu/cvs/source/stable/$(VRS)/$(FILE)

PATCH1= $(DIR)-zlib-1.patch
URL-$(PATCH1)= $(HTTPBLFS)/$(NM)/$(PATCH1)
SHA-$(PATCH1)= 0d20bab8a6b6e419a8c900d082b487ad6a3aec38

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
	install -m644 doc/*.pdf /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
