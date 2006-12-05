# cvs Makefile

NM= cvs
VRS= 1.11.22
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= http://ftp.gnu.org/non-gnu/cvs/source/stable/$(VRS)/$(FILE)
SHA-$(FILE)= 5dfa11da84a890d7d61516fd450c001dc24bcc0d

PATCH1= $(NM)-1.11.21-zlib-1.patch
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
	./configure --prefix=/usr --with-rsh=ssh
	make $(PM)
	make install
	# install -m755 -d /usr/share/doc/$(DIR)
	# install -m644 doc/*.pdf /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
