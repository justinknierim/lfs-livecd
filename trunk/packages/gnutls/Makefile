# gnutls Makefile

NM= gnutls
VRS= 1.6.3
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 7553b9f7ddd4982c0759b814bc6d9bf892cf7347

# There is also version 1.7.8 at http://www.gnu.org/software/gnutls/releases/
# but it is a development version

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr
	make
	make install
	install -v -m755 -d /usr/share/doc/$(DIR)/reference
	install -v -m644 doc/reference/html/* /usr/share/doc/$(DIR)/reference
	install -v -m644 doc/*.{html,png,eps,pdf,ps} /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
