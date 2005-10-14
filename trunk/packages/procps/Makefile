# Procps Makefile

NM= procps
VRS= 3.2.5
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTP)/$(NM)/$(FILE)
SHA-$(FILE)= 188d0ccd6c7a655ae556fe1078c346cda1aca164

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-post-bash) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
ifndef CROSS
	make $(PM)
	make install
else
	make CC="gcc $(64FLAGS)"
	make install lib64=lib64
endif

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
