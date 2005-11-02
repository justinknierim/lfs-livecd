# CDRTools Makefile

NM= cdrtools
VRS= 2.01
DIR= $(NM)-$(VRS)

FILE= $(DIR).tar.bz2
URL-$(FILE)= $(HTTPBLFS)/$(NM)/$(FILE)
SHA-$(FILE)= f94cfe51dd512d4e0b9106b986bde12d4f7967ce

# Targets

include $(ROOT)/scripts/functions

chroot:
	chroot "$(MP)" $(chenv-blfs) \
	'cd $(ROOT) && make ch-$(NM) $(chbash-post-bash)'

stage2: Makefile $(FILE)
	$(std_build)

compile-stage2:
	make $(PM) INS_BASE=/usr DEFINSUSR=root DEFINSGRP=root
	make INS_BASE=/usr DEFINSUSR=root DEFINSGRP=root install

clean:
	-rm -rf $(DIR)

.PHONY: clean chroot compile-stage2
