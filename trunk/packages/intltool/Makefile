# intltool Makefile

NM= intltool
VRS= 0.40.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 5121f74e3ffa5d167fd0ace3270afed98bb24c25

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
	install -v -m644 -D doc/I18N-HOWTO /usr/share/doc/$(DIR)/I18N-HOWTO

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
