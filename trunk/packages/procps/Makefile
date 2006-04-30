# Procps Makefile

NM= procps
VRS= 3.2.6
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.gz
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 91f44180eb50a94eb945c2598c0e849879e65893

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
