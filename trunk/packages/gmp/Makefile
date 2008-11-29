# gmp Makefile

NM= gmp
VRS= 4.2.4
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= bb721f94fbeeb8c609104540b408da6707c370ec

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-pre-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-pre-bash)'

stage2: $(FILE)
	$(std_build)

compile-stage2:
	./configure --prefix=/usr --enable-cxx --enable-mpbsd
	make
	-make -k check
	make install
	mkdir -v /usr/share/doc/$(DIR)
	cp -v doc/{isa_abi_headache,configuration} doc/*.html /usr/share/doc/$(DIR)

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
