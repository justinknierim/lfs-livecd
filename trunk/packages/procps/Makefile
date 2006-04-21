# Procps Makefile

NM= procps
VRS= 3.2.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 74fe5e5fdb84d6dad6688d007a276c5c1e18a0be

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
	make $(PM)
	make install
else
	make $(PM) CC="gcc $(64FLAGS)"
	make install lib64=$(LIB_LAYBE64)
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
