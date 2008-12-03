# giflib Makefile

NM= giflib
VRS= 4.1.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= 95068775508599e61bfda1de255281440e11d763

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
	install -v -m755 -d /usr/share/doc/$(DIR)/html
	install -v -m644 doc/*.{png,html} /usr/share/doc/$(DIR)/html
	install -v -m644 doc/*.txt /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
