# Module-Init-Tools Makefile

NM= module-init-tools
VRS= 3.2.1
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= f982949eaba759b28ec2cccec9a3625b2c58a299

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE) 
	$(std_build)
	cp $(SRC)/$(FILE) $(LFSSRC)

compile-stage2:
ifndef CROSS
	./configure --prefix="" --enable-zlib --mandir=/usr/share/man
else
	CC="gcc $(64FLAGS)" ./configure --prefix=/ --enable-zlib
endif
	make $(PM)
	make install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
